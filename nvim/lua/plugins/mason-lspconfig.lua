return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "lemminx", -- XML
                "yamlls",  -- YAML
                "jsonls",  -- JSON
                "pyright", -- Python
                "eslint",  -- JavaScript/TypeScript
                "sqlls",
                "efm",
                "cucumber_language_server",
                "marksman",
                "bashls",
            },
            automatic_installation = true,
        })

        vim.lsp.config.efm = {
            init_options = { documentFormatting = true },
            filetypes = { "sql", "css", "md" },
            settings = {
                rootMarkers = { ".git/" },
                languages = {
                    markdown = { { formatCommand = "prettier --parser markdown", formatStdin = true } },
                    css = { { formatCommand = "prettier --parser css", formatStdin = true } },
                    sql = {
                        {
                            formatCommand = "sql-formatter --language sql",
                            formatStdin = true,
                        },
                    },
                    cucumber = {
                        {
                            formatCommand = "reformat-gherkin",
                            formatStdin = true,
                        },
                    },
                    sh = {
                        {
                            formatCommand = "shfmt -i 2 -bn -ci -sr",
                            formatStdin = true,
                        },
                        {
                            lintCommand = "shellcheck -f gcc -x -",
                            lintStdin = true,
                            lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
                        },
                    },
                },
            },
        }
    end,
}
