curl -LO https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.tar.gz
sudo tar -C /usr/local -xzf nvim-linux-x86_64.tar.gz
sudo ln -s /usr/local/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
nvvim -v
