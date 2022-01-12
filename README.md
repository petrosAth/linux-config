### Installation
1. Update OS
    >`sudo pacman -Syu`
3. Install `yay`
    >`pacman -Syu --needed git base-devel yay`
4. Clone `linux-config` repo
    >`git clone --recurse-submodules https://github.com/petrosAth/linux-config.git`
5. Install `oh-my-posh`
    >`sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh`
    >`sudo chmod +x /usr/local/bin/oh-my-posh`
6. Install `starship`
    >`sudo pacman -Syu starship`
7.
8. Install `zsh`
    - Change config location using .zshenv
    `echo -e "#Path to your zsh config files \nexport ZDOTDIR='$HOME/.config/zsh'" >> $HOME/.zshenv1`
    - Source new config
    `source $HOME/.zshenv`
    - Make `zsh` the default shell
        - List all installed shells
        >`chsh -l`
        - Set zsh as default
        >`chsh -s full-path-to-zsh`
9. Install `powershell`
    >`yay -S powershell-bin`
11. Install `alacritty`
    >`pacman -S alacritty`
10. Install `Neovim`
    >`pacman -S neovim`
    >`pacman -S python-pynvim`
12. Install package list
    >`pacman -Syu`

13. Configure github ssh
    1. Authenticate to the GitHub CLI
    >`gh auth login`
    2. Generate a new SSH key
    >`ssh-keygen -t ed25519 -C "github_email"`
    3. Start the ssh-agent in the background
    >`eval "$(ssh-agent -s)"`
    4. Add the SSH key to my GitHub account
    >`gh ssh-key add "path to key_file.pub" --title "key_name"`
    5. Test SSH connection
    >`ssh -T git@github.com`
