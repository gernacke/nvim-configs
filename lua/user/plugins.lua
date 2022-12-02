local M = {}

-- local packer_bootstrap = false

local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        PACKER_BOOTSTRAP = fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        vim.cmd([[packadd packer.nvim]])
    end
    vim.cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")
end

packer_init()

function M.setup()
    local conf = {
        compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "rounded" })
            end,
        },
    }

    local function plugins(use)
        use({
            "lewis6991/impatient.nvim",
            config = function()
                require("user.configs.impatient_config")
            end,
        })

        use({ "wbthomason/packer.nvim" })

        use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
        use({ "williamboman/mason-lspconfig.nvim" })
        use({ "williamboman/mason.nvim" })

        -- Keymapping: whichkey
        use({
            "folke/which-key.nvim",
            config = function()
                require("user.configs.whichkey_config")
            end,
        })

        -- Terminal
        use({
            "akinsho/toggleterm.nvim",
            keys = { [[<c-\>]] },
            event = "VimEnter",
            cmd = { "ToggleTerm", "TermExec" },
            config = function()
                require("user.configs.toggleterm_config")
            end,
        })

        use({ "nvim-lua/popup.nvim" })
        use({ "nvim-lua/plenary.nvim" })
        use({
            "ahmedkhalf/project.nvim",
            config = function()
                require("user.configs.project_config")
            end,
        })
        -- Telescope
        -- use({ "nvim-telescope/telescope-project.nvim" })
        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                -- "nvim-telescope/telescope-project.nvim",
                "nvim-telescope/telescope-frecency.nvim",
                "nvim-telescope/telescope-file-browser.nvim",
            },
            branch = "0.1.x",
            config = function()
                require("user.configs.telescope_config").setup()
            end,
        })
        use({
            "nvim-telescope/telescope-fzf-native.nvim",
            requires = { "nvim-telescope/telescope.nvim" },
            run = "make",
        })
        use({
            "dhruvmanila/telescope-bookmarks.nvim",
            tag = "*",
            requires = { "kkharji/sqlite.lua" },
        })
        --
        -- }
        -- use({ "matbme/JABS.nvim", require("user.configs.jabs_config") })

        -- Navigation Tree
        use({
            "kyazdani42/nvim-tree.lua",
            event = "BufWinEnter",
            config = function()
                require("user.configs.nvim-tree_config")
            end,
        })
        use({ "moll/vim-bbye" })

        -- Treesitter
        use({
            "nvim-treesitter/nvim-treesitter",
            as = "nvim-treesitter",
            event = "BufRead",
            -- opt = true,
            run = ":TSUpdate",
            config = function()
                require("user.configs.treesitter_config").setup()
            end,
            requires = {
                { "JoosepAlviste/nvim-ts-context-commentstring" },
                { "nvim-treesitter/nvim-treesitter-textobjects" },
            },
        })
        -- Status line
        use({
            "nvim-lualine/lualine.nvim",
            config = function()
                require("user.configs.lualine_config")
            end,
        })
        use({
            "SmiteshP/nvim-navic",
            config = function()
                require("user.configs.winbar_config")
            end,
        })
        -- Notes taking
        use({
            "nvim-neorg/neorg",
            run = ":Neorg sync-parsers",
            config = require("user.configs.neorg_config").setup(),
            -- after = "nvim-treesitter",
            requires = { "nvim-neorg/neorg-telescope" },
        })

        -- LSP
        use("christianchiarulli/lua-dev.nvim")
        use({ "neovim/nvim-lspconfig" }) -- enable LSP
        use({
            "RRethy/vim-illuminate",
            config = function()
                require("user.configs.illuminate_config")
            end,
        })
        use({
            "folke/trouble.nvim",
            cmd = "TroubleToggle",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup({})
            end,
        })
        use({
            "simrat39/symbols-outline.nvim",
            config = function()
                require("user.configs.symbols-outline_config")
            end,
        })

        -- Miscellaneous
        -- use("tpope/vim-repeat")
        use("mortepau/codicons.nvim")
        use({ "wellle/targets.vim" })
        use({
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("user.configs.indent_config")
            end,
        })
        use({
            "nacro90/numb.nvim",
            config = function()
                require("user.configs.numb_config")
            end,
        })
        -- "p" toggle quickfix preview window
        -- <c-f/b> for scrolling up and down preview.
        -- "zo" go back to original preview position
        -- "zp" toggle between max and min preview window size
        -- "<tab>", "z<tab>" toggle and clear the signs
        -- "zn", "zN": create a new list for signed items, unsigned items
        use({
            "kevinhwang91/nvim-bqf",
            ft = "qf",
            disable = false,
            config = function()
                require("bqf").setup({
                    auto_resize_height = true,
                })
            end,
        })
        use({ "junegunn/vim-easy-align" })
        use({
            "windwp/nvim-autopairs",
            run = "make",
            config = function()
                require("user.configs.autopairs_config")
            end,
        })
        use({
            "andymass/vim-matchup",
            setup = function()
                vim.g.matchup_matchparen_offscreen = { method = nil }
            end,
        })
        -- Rainbow braces
        use("p00f/nvim-ts-rainbow")
        -- use({
        --   "andymass/vim-matchup",
        -- config = function()
        --   require("user.configs.matchup_cofig")
        -- end,
        -- })
        use({
            "onsails/lspkind-nvim",
            config = function()
                require("lspkind").init()
            end,
        })
        use({
            "kylechui/nvim-surround",
            tag = "*",
            config = function()
                require("nvim-surround").setup({})
            end,
        })
        use({
            "numToStr/Comment.nvim",
            -- keys = { "gc", "gcc", "gbc" },
            event = "VimEnter",
            config = function()
                require("user.configs.comment_config")
            end,
            after = "nvim-treesitter",
        })
        use({ "kyazdani42/nvim-web-devicons" })
        use({ "rajasegar/vim-search-web" })

        -- tmux related
        -- use({ "christoomey/vim-sort-motion" })
        use({ "christoomey/vim-tmux-navigator" })
        use({ "christoomey/vim-tmux-runner" })

        -- Text Jumps
        -- use({
        --   "phaazon/hop.nvim",
        --   config = function()
        --     require("hop").setup()
        --   end,
        -- })
        use({
            "ggandor/leap.nvim",
            event = "VimEnter",
            config = function()
                require("user.configs.leap_config")
            end,
        })
        -- cmp completion
        use({ "L3MON4D3/LuaSnip" })
        use({
            "hrsh7th/vim-vsnip",
            event = "VimEnter",
            requires = { "rafamadriz/friendly-snippets" },
        })
        use({
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            opt = true,
            requires = {
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-nvim-lsp",
                -- "quangnguyen30192/cmp-nvim-ultisnips",
                "hrsh7th/cmp-nvim-lua",
                "saadparwaiz1/cmp_luasnip",
                "octaltree/cmp-look",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-calc",
                "f3fora/cmp-spell", -- "hrsh7th/cmp-emoji",
                -- "ray-x/cmp-treesitter",
                "hrsh7th/cmp-cmdline",
                -- "hrsh7th/cmp-nvim-lsp-document-symbol",
            },
            config = function()
                require("user.configs.cmp_config").setup()
            end,
        })

        -- Git
        use({
            "lewis6991/gitsigns.nvim",
            config = function()
                require("user.configs.gitsigns_config")
            end,
        })

        -- Colorscheme
        use({
            "NvChad/nvim-colorizer.lua",
            config = function()
                require("user.configs.colorizer_config")
            end,
        })
        use({
            "lunarvim/darkplus.nvim",
            commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83",
        })
        use({
            "ellisonleao/gruvbox.nvim",
            config = function()
                require("user.configs.gruvbox_config")
            end,
        })
        -- use({ "morhetz/gruvbox" })
    end

    if PACKER_BOOTSTRAP then
        print("Setting up Neovim. Restart required after installation!")
        require("packer").sync()
    end

    pcall(require, "impatient")
    pcall(require, "packer_compiled")
    require("packer").init(conf)
    require("packer").startup(plugins)
end

return M
