from libqtile.bar import Bar
from libqtile.layout import Max, Columns, Floating 
from libqtile.widget import GroupBox, Battery, CurrentLayout, WindowName, Clock, CPU, Memory, PulseVolume, Backlight
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from unicodes import textbox_triangle
from colors import color_scheme

mod = "mod4"
terminal = "kitty"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "c", lazy.layout.up(), desc="Move focus"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Launch apps
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "space", lazy.spawn("rofi -show run"), desc="Launch rofi"),
    
    # Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 2")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 2")),

    # Volume
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -1%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +1%")),
]

groups= [Group(i, label=' ', layout='max') for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key(
            [mod],
            i.name,
            lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name),
        ),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key(
            [mod, "shift"],
            i.name,
            lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name),
        ),
    ])

layouts = [ 
    Columns(border_width=0,margin=2), 
    Max(), 
]

widget_defaults = dict( font="Comic Shanns Regular", fontsize=14, padding=3, )
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=Bar(
            [
                GroupBox(
                    borderwidth=0,
                    active=color_scheme['magenta'],
                    inactive=color_scheme['yellow'],
                    disable_drag=True,
                    block_highlight_text_color=color_scheme['red'],
                    highlight_color=color_scheme['bg'],
                    highlight_method='line',
                ),

                textbox_triangle(color_scheme['yellow'], color_scheme['bg'], 'right'),
                CurrentLayout(background=color_scheme['yellow']),
                textbox_triangle(color_scheme['bg'], color_scheme['yellow'], 'right'),

                WindowName(),
                
                textbox_triangle(color_scheme['bg'], color_scheme['yellow']),
                CPU(background=color_scheme['yellow'], format=' {load_percent}%'),
                textbox_triangle(color_scheme['yellow'], color_scheme['bg']),
                
                Memory(background= color_scheme['bg'], measure_mem='G', format='﬙{MemUsed: .0f}{mm} /{MemTotal: .0f}{mm}'),

                textbox_triangle(color_scheme['bg'], color_scheme['magenta']),
                PulseVolume(background=color_scheme['magenta'], fmt=" {}"),
                textbox_triangle(color_scheme['magenta'], color_scheme['bg']),

                Backlight(backlight_name="intel_backlight", fmt=" {} "),
                # Battery(format='{char} {percent:2.0%}   {watt:.0f}W', discharge_char="", charge_char='', notify_below=60),
                
                textbox_triangle(color_scheme['bg'], color_scheme['red']),
                Clock(background=color_scheme['red'], format=" %a,%m/%d %H:%M"),
            ],
            size=24,
            background=color_scheme['bg'],
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # Set static wallpaper
        wallpaper = '~/Pictures/wallpapers/tropic_island_evening.jpg',
        # Set wallpaper mode to 'fill'/'stretch'
        wallpaper_mode = 'fill'
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

