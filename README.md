# Installation
This installation guide requires WSL**2**.
## Install a WSL distribution
1. Run  `cmd`,`powershell` or `pwsh` and install a distro using scoop
    - `scoop install archwsl`
2. Go to `~\scoop\apps\archwsl\current` and run
    - `Arch.exe`

## Set up root and default user
3. Set root password
    - `passwd`
>For Arch continue here. For Manjaro skip to step `5`
4. Enable `wheel` group by uncommenting the line below
    - `echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel`
5. Create user
    - `useradd -m -G wheel -s /bin/bash <username>`
6. Set user password
    - `passwd <username>`
>For WSL continue with the steps below
7. Exit WSL environment
    - `exit`
8. From the location of the WSL distribution (`~\scoop\apps\archwsl\current`) use `cmd`,`powershell` or `pwsh` and run
    - `Arch.exe config --default-user <username>`

## Configure pacman
>For Arch start here. For Manjaro skip to step `14`
9. Open pacman config file
    - `sudo vi /etc/pacman.conf`
10. Comment out the line below
    - `IgnorePkg   = fakeroot`
11. Initialize keyring
    - `sudo pacman-key --init`
    - `sudo pacman-key --populate`
12. Set up your choice of pacman mirrors by uncommenting the mirrors of your country in the file below
    - `sudo vi /etc/pacman.d/mirrorlist`
13. Force update Arch keyring (Circumstantial)
    - `sudo pacman -Syy archlinux-keyring`
>**ONLY** For Manjaro
14. Pick country using the following command
    - `sudo pacman-mirrors --country <name>`

## Use deploy script
`bash -c "$(curl -#fL raw.githubusercontent.com/petrosAth/scripts/master/deploy/linux/install.sh)"`

## Conflict
If the following conflicting packages message appears
>`:: fakeroot and fakeroot-tcp are in conflict. Remove fakeroot-tcp? [y/N]`
You can press `y`

## Configure github ssh
1. Authenticate to the GitHub CLI
    - `gh auth login`
2. Generate a new SSH key
    - `ssh-keygen -t ed25519 -C "github_email"`
3. Start the ssh-agent in the background
    - `eval "$(ssh-agent -s)"`
4. Add the SSH private key to the ssh-agent
    - `ssh-add ~/.ssh/id_ed25519`
5. Add the SSH public key to my GitHub account
    - `gh ssh-key add ~/.ssh/id_ed25519.pub --title "key title"`
6. Test SSH connection
    - `ssh -T git@github.com`
