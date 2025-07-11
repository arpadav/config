-- Mapleader
vim.g.mapleader = " "

-- Lua configs
local loader = require("arpad.loader")
require("arpad.lazy")

-- Vim script (using loader)
loader.load__vimscripts()

-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {
    -- Server-specific settings. See `:help lspconfig-setup`
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "basic",
                stubPath = "/home/vorosaa1/.local/share/nvim/lspinstall/python/node_modules/typeshed/stdlib"
            }
        }
    }
}

lspconfig.rust_analyzer.setup({
    settings = {
        ['rust-analyzer'] = {
            check = {
                command = "clippy",
                extraArgs = {
                    "--", "-Dclippy::unwrap_used", "-Dclippy::expect_used",
                    "-Dclippy::panic"
                }
            },
            checkOnSave = true
        }
    }
})

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup()

require("formatter").setup({
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
        python = {require("formatter.filetypes.python").black},
        sh = {require("formatter.filetypes.sh").shfmt},
        cpp = {require("formatter.filetypes.cpp").clangformat},
        lua = {
            function()
                return {
                    exe = vim.fn.stdpath("data") .. "/mason/bin/lua-format",
                    args = {},
                    stdin = true
                }
            end
        },
        rust = {
            function()
                return {
                    exe = vim.env.HOME .. "/.cargo/bin/rustfmt",
                    args = {},
                    stdin = true
                }
            end
        }
    }
})

-- local null_ls = require("null-ls")
-- null_ls.setup({
--     sources = {
--         null_ls.builtins.formatting.lua_format,
--     }
-- })

-- Global mappings.
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = {buffer = ev.buf}
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
                       opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'v'}, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f',
                       function() vim.lsp.buf.format {async = true} end, opts)
    end
})
