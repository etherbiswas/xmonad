# xmonad

![](https://github.com/etherrorcode404/xmonad/blob/master/images/screenshot1.png)

- Colorscheme: [Gruvbox-Material](https://github.com/sainnhe/gruvbox-material)

## Requirements & Used components

- xmonad >= 0.17
- [dotfiles](https://github.com/etherrorcode404/dotfiles) (highly recommended)

| Component     | Description                                                                     |
| ------------- | ------------------------------------------------------------------------------- |
| WM            | xmonad                                                                          |
| Compositor    | picom                                                                           |
| SysTray       | trayer                                                                          |
| Bar           | xmobar                                                                          |
| Shell         | bash, dash, fish                                                                |
| Editor        | neovim                                                                          |
| Widget        | conky                                                                           |
| GTK-Theme     | [gruvbox-gtk-material](https://github.com/etherrorcode404/gruvbox-material-gtk) |
| Icon-Theme    | [gruvbox-gtk-material](https://github.com/etherrorcode404/gruvbox-material-gtk) |
| AppLauncher   | rofi & demenu                                                                   |
| UI Font       | monospace                                                                       |
| Terminal      | alacritty                                                                       |
| Terminal Font | monospace & FiraCode NerdFont                                                   |
| FileManager   | pcmanfm                                                                         |

# Manual Installation

1. Clone this repository
2. Copy to ~/.config
3. Follow [xmoand docs](https://xmonad.org/INSTALL.html)

# Help

1. This config focuses on making things easier and faster for the user
2. Keybinds used are based on [vim keys](https://neovim.io/) (hjkl)

## Fixes implemented

1. Uses [XMonad.Hooks.ManageDocks](https://hackage.haskell.org/package/xmonad-contrib-0.17.0/docs/XMonad-Hooks-ManageDocks.html) (checkDock) to fix conky
1. Uses [XMonad.Hooks.DynamicProperty](https://hackage.haskell.org/package/xmonad-contrib-0.17.0/docs/XMonad-Hooks-ManageDocks.html) (onXPropertyChange) to do shift spotify to target workspace
