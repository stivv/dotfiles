from libqtile.widget.textbox import TextBox

def textbox_triangle(bg_color, fg_color, type = 'left'):
    icon = '' if type is 'left' else '' 
    return TextBox(
        text= icon,
        padding=-6,
        fontsize=38,
        background=bg_color,
        foreground=fg_color)
