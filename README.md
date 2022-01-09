### Installation (for Manjaro)
1. Update OS
    `sudo pacman -Syu`
2. Install `git`
    `sudo pacman -Syu git`
3. Install `yay`
    `pacman -Syu --needed git base-devel yay`
4. Clone `linux-config` repo
    `git clone --recurse-submodules https://github.com/petrosAth/linux-config.git`
5. Install `oh-my-posh`
    `sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh`
    `sudo chmod +x /usr/local/bin/oh-my-posh`
6. Install `starship`
    `sudo pacman -Syu starship`
7.
8. Install `zsh`
    - Change config location using .zshenv
    `echo -e "#Path to your zsh config files \nexport ZDOTDIR='$HOME/.config/zsh'" >> $HOME/.zshenv1`
    - Source new config
    `source $HOME/.zshenv`
    - Make `zsh` the default shell
        - List all installed shells
        `chsh -l`
        - Set zsh as default
        `chsh -s full-path-to-zsh`
9. Install `powershell`
    `yay -S powershell-bin`
10. Install `Neovim`
    `pacman -S neovim`
    `pacman -S python-pynvim`
11. Install `alacritty`
    `pacman -S alacritty`
