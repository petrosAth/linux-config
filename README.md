# Installation
## Install a WSL distribution
1. Run  `cmd`,`powershell` or `pwsh` and install a distro using scoop
    - `scoop install manjarowsl`
2. Go to `~\scoop\apps\manjarowsl\current` and run
    - `Manjaro.exe`
## Create user
1. Set root password
    - `passwd`
2. Create user
    - `useradd -m -G wheel -s /bin/bash <username>`
3. Set user password
    - `passwd <username>`
4. Exit
5. From the location of the WSL distribution (`~\scoop\apps\manjarowsl\current`) use `cmd`,`powershell` or `pwsh` and run
    - `Manjaro.exe config --default-user <username>`
## Configure pacman
- Pick country using the following command
    - `sudo pacman-mirrors --country <name>`
## Use deploy script
`bash -c "$(curl -#fL raw.githubusercontent.com/petrosAth/scripts/master/deploy/linux/install.sh)"`

## Configure github ssh
1. Authenticate to the GitHub CLI
    - `gh auth login`
2. Generate a new SSH key
    - `ssh-keygen -t ed25519 -C "github_email"`
3. Start the ssh-agent in the background
    - `eval "$(ssh-agent -s)"`
4. Add the SSH private key to the ssh-agent
    - `ssh-add <path to key_file>`
5. Add the SSH public key to my GitHub account
    - `gh ssh-key add <path to key_file.pub> --title "key_name"`
6. Test SSH connection
    - `ssh -T git@github.com`
