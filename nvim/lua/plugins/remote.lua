return {
    {
      "amitds1997/remote-nvim.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("remote-nvim").setup()
      end,
    },
    {
      "ojroques/nvim-osc52",
      config = function()
        require("osc52").setup()
      end,
    },
  }

--[[

sudo apt update
sudo apt install docker.io
sudo systemctl enable docker
sudo systemctl start docker
curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64"
sudo install -c -m 0755 devpod /usr/local/bin
rm -f devpod
devpod provider add docker


]]