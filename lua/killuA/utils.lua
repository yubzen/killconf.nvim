-- Helper command for find and replace
vim.api.nvim_create_user_command('Rp', function()
    local find = vim.fn.input("Find: ")
    local replace = vim.fn.input("Replace with: ")
    if find ~= "" and replace ~= "" then
        vim.cmd(string.format("%%s/%s/%s/gc", vim.pesc(find), replace))
    end
end, {})

vim.api.nvim_create_user_command('Vimreg', function()
    vim.cmd('help regmap')
end, {})

