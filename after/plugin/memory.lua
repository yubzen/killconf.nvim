-- Aggressive memory management settings
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Limit LSP memory usage
vim.lsp.set_log_level("ERROR") -- Reduce logging

-- Reduce Neovim's own memory usage
vim.opt.updatetime = 1000 -- Increase update time
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10
vim.opt.lazyredraw = true -- Don't redraw during macros
vim.opt.ttyfast = true
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = false -- Disable undo file to save memory

-- Limit completion and other memory-intensive features
vim.opt.completeopt = { 'menu', 'noselect' } -- Remove 'menuone' and 'preview'
vim.opt.pumheight = 10                     -- Limit popup menu height

-- Optimize diagnostics for memory
vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        severity = vim.diagnostic.severity.ERROR, -- Only show errors in virtual text
    },
    signs = true,
    update_in_insert = false, -- Don't update diagnostics in insert mode
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "if_many", -- Show source only when there are multiple
        header = "",
        prefix = "",
        max_width = 80,  -- Limit popup width
        max_height = 15, -- Limit popup height
    },
})

-- Memory cleanup (less aggressive, only on save)
vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
        collectgarbage("collect") -- Only cleanup after saving files
    end,
})

-- LSP restart command for memory cleanup
vim.api.nvim_create_user_command('LspRestart', function()
    vim.cmd('LspStop')
    vim.defer_fn(function() vim.cmd('LspStart') end, 1000)
end, {})

