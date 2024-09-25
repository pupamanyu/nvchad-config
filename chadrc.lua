local M = {}

M.plugins = {
  user = {
    -- File Explorer
    ["kyazdani42/nvim-tree.lua"] = {
      requires = "kyazdani42/nvim-web-devicons", -- optional, for file icons
      config = function()
        require('nvim-tree').setup()
      end,
    },

    -- Fuzzy Finder
    ["nvim-telescope/telescope.nvim"] = {
      requires = { { 'nvim-lua/plenary.nvim' } },
      config = function()
        require('telescope').setup()
      end,
    },

    -- Git Integration
    ["lewis6991/gitsigns.nvim"] = {
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('gitsigns').setup()
      end,
    },

    -- Statusline Enhancements
    ["nvim-lualine/lualine.nvim"] = {
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('lualine').setup {
          options = {
            icons_enabled = true,
            theme = 'auto',
          },
        }
      end,
    },

    -- Debugger (DAP)
    ["mfussenegger/nvim-dap"] = {
      config = function()
        local dap = require('dap')
        -- DAP configuration goes here
      end,
    },

    -- Autocompletion Enhancements
    ["hrsh7th/nvim-cmp"] = {
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
      },
      config = function()
        local cmp = require('cmp')
        cmp.setup {
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
          }),
        }
      end,
    },
  }
}

M.configs = function()
  -- Font Configuration
  vim.opt.guifont = { 'Source Code Pro Nerd Font', ':h18' }

  -- LSP Configuration
  local lspconfig = require('lspconfig')
  lspconfig.bashls.setup{}
  lspconfig.rust_analyzer.setup{}
  lspconfig.clangd.setup{}
  lspconfig.jdtls.setup{}
  lspconfig.pyright.setup{}
  lspconfig.hls.setup{}
  lspconfig.zls.setup{}
  lspconfig.metals.setup{}
  lspconfig.clojure_lsp.setup{}
  lspconfig.sumneko_lua.setup{}  -- Lua LSP for Lua development
  lspconfig.texlab.setup{}  -- LaTeX LSP support with texlab
end

return M
