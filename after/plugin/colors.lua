function ColorMyPencils(color)
    vim.cmd.colorscheme("github_dark")

    -- Example overrides, without breaking normal background:
    vim.api.nvim_set_hl(0, "@variable", { fg = "#FFA500" })
    vim.api.nvim_set_hl(0, "@tag.attribute", { fg = "#7851a9" })
    vim.api.nvim_set_hl(0, "@tag", { fg = "#fe6f5e" })
    vim.api.nvim_set_hl(0, "@character.special", { fg = "#2e2eff" })

    -- Do NOT override Normal bg unless you really want a custom background
    vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
