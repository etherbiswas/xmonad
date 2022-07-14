# xmonad
![](https://github.com/etherrorcode404/xmonad/blob/master/images/screenshot1.png)

- Colorscheme: [Gruvbox-Material](https://github.com/sainnhe/gruvbox-material)

## Requirements
- xmonad >= 0.17

Component | Description
------------- | -------------
WM | xmonad
Compositor | yshui/picom
Systray | trayer
Bar | xmobar
Shell | bash & fish
Editor | neovim
Widget | Conky
GTK-theme | [gruvbox-gtk-material](https://github.com/etherrorcode404/gruvbox-material-gtk)
Icon theme | [gruvbox-gtk-material](https://github.com/etherrorcode404/gruvbox-material-gtk) 
App launcher | rofi & demenu
UI font | monospace
Terminal | alacritty
Terminal font | monospace
FileManager | pcmanfm

### Manually Installation

1. Clone this repository
2. Copy to ~/.config
3. Follow [xmoand docs](https://xmonad.org/INSTALL.html)

# Help

1. This config focuses on making things easier and faster for the user
2. Keybinds used are based on [vim keys](https://neovim.io/) (hjkl)
3. Implements [Nav2d](https://hackage.haskell.org/package/xmonad-contrib-0.17.0/docs/XMonad-Actions-Navigation2D.html), Unfortunately Nav2d does not 
remeber last focused window but it does implement directional navigation

## Fixes

1. Uses [XMonad.Hooks.ManageDocks](https://hackage.haskell.org/package/xmonad-contrib-0.17.0/docs/XMonad-Hooks-ManageDocks.html) (checkDock) to fix conky
