from libqtile.widget.textbox import TextBox

def lower_left_triangle(bg_color, fg_color):
    return TextBox(
        text='\u25e2',
        padding=-2,
        fontsize=55,
        background=bg_color,
        foreground=fg_color)
