return {
    "tpope/vim-commentary",
    "tpope/vim-surround",
    "neovim/nvim-lspconfig",
    "Exafunction/codeium.vim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.3",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
            "sharkdp/fd",
            "BurntSushi/ripgrep",
        },
    },
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = { "ibhagwan/fzf-lua" },
        config = function()
            require('neoclip').setup()
        end,
    },
    {
        "bluz71/vim-moonfly-colors",
        name = "moonfly",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme moonfly]])
            vim.cmd([[highlight LineNr guifg=#ffff00 gui=NONE]])
            vim.cmd([[highlight CursorLineNr guifg=#ffff00 gui=NONE]])
        end
    },
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
	    lazy = false,
	    priority = 999,
	    -- config = function()
	    -- vim.cmd([[colorscheme tokyonight-night]])
	    -- vim.cmd([[highlight LineNr guifg=#ffff00 gui=NONE]])
	    -- vim.cmd([[highlight CursorLineNr guifg=#ffff00 gui=NONE]])
	    -- end,
    },

}
