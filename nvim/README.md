# neovim
# INstall
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /usr/local -xzf nvim-linux-x86_64.tar.gz
sudo ln -s /usr/local/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

# clean config
rm -fr ~/.config/nvim/*
rm -fr ~/.local/share/nvim/*
rm -fr ~/.local/state/nvim/*
rm -fr ~/.cache/nvim/*
