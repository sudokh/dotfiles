# dotfiles for sudokh

# Installation
## For Linux or Mac OS
### Using Git
```
cd $HOME \
&& git clone https://github.com/sudokh/.dotfiles.git \
&& source $HOME/.dotfiles/install.sh
```
### Git-free install

# Contents

dotfiles/
 |-nvim/
 |  |-dein.toml
 |  `-init.vim
 |-others/
 |  |-Gvim/
 |  |  |-gvimrc_local.vim
 |  |  `-vimrc_local.vim
 |  |-Karabiner-Elements/
 |  |  |-install.sh
 |  |  |-README.md
 |  |  `-sudo_karabiner_rules.json
 |  `-vimium/
 |     `-Vimium_options.txt
 |-scripts/
 |  |-check_color/
 |  |  |-color16.sh
 |  |  `-colour_palette.sh
 |  `-tmux/
 |     |-change_tmux_mode.sh
 |     `-get_battery_tmux
 |-install.sh
 |-README.md
 |-tmux.conf
 |-vimrc
 `-zshrc
