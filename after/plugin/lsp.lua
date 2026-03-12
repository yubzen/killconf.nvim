local lsp_zero = require('lsp-zero')
require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = {
        "ts_ls",
        'jsonls',
        'lua_ls',
        'html',
        'tailwindcss',
        'rust_analyzer',
        'gopls',
        'cssls',
        'oxlint',
        'intelephense' },
    -- automatic_enable=true,
    automatic_enable = {
        "ts_ls",
        "lua_ls",
        "oxlint",
        "cssls",
        "html",
        "rust_analyzer",
        "gopls",
        "tailwindcss",
        "jsonls",
        "intelephense"
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
        rust_analyzer = function()
            require('rust-tools').setup({})
        end,

        -- Tailwind CSS configuration
        tailwindcss = function()
            require('lspconfig').tailwindcss.setup({
                -- ... your existing config ...

                settings = {
                    tailwindCSS = {
                        classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
                        lint = {
                            -- DISABLE heavy linting but keep critical errors:
                            cssConflict = "ignore",             -- Disable - not critical
                            invalidApply = "error",             -- KEEP - this is important
                            invalidConfigPath = "error",        -- KEEP - this is important
                            invalidScreen = "ignore",           -- Disable - not critical
                            invalidTailwindDirective = "error", -- KEEP - this is important
                            invalidVariant = "ignore",          -- Disable - not critical
                            recommendedVariantOrder = "ignore"  -- Disable - just style preference
                        },
                        validate = true,                        -- KEEP enabled for completions and basic validation
                        completions = {
                            includeConfig = true,               -- KEEP for custom config completions
                            includeVariants = true,             -- KEEP for variant completions
                        }
                    }
                },

                -- MODERATE debounce time:
                flags = {
                    debounce_text_changes = 800, -- Balanced for CSS completions
                },
            })
        end,
        -- Lua language server configuration
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            }
                        }
                    }
                },
                flags = {
                    debounce_text_changes = 500,
                },
            })
        end
    },


})


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
lsp_zero.defaults.cmp_mappings({
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
})

cmp.setup({
    performance = {
        fetching_timeout = 500, -- Reduce timeout for faster response
        max_view_entries = 8,   -- Limit displayed entries
    },
})
lsp_zero.set_preferences({
    sign_icons = {}
})

lsp_zero.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.lsp.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.lsp.buf.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.lsp.buf.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)
lsp_zero.setup()

-- -- Global LSP settings for better performance
-- local signs = {
--     { name = "DiagnosticSignError", text = "" },
--     { name = "DiagnosticSignWarn",  text = "" },
--     { name = "DiagnosticSignHint",  text = "" },
--     { name = "DiagnosticSignInfo",  text = "" },
-- }
--
-- for _, sign in ipairs(signs) do
--     vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
-- end
