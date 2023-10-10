# ssh conifg with github
chmod 600 ~/.ssh/config
: '
```~/.ssh/config
Host github.com
    Hostname ssh.github.com
    Port 443
    User git
```
'

# Nvim installation
cd ~/installations
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz
cd nvim-linux64
sudo cp -r * /usr/
cd ~

# Nvim copy config to this repo
rsync -av ~/.config/nvim/ ubuntu/copy/.config/nvim/

