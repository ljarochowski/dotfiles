local root_dir = vim.fs.dirname(vim.fs.find({
    '.git',
    'pom.xml',
    'build.gradle',
    'package.json'
}, { upward = true })[1]) or vim.fn.expand('%:p:h')

vim.lsp.start({
    name = "lemminx", -- lub "xml-language-server" zależnie co zainstalowałeś
    cmd = { "lemminx" },
    root_dir = root_dir,
    settings = {
        xml = {
            format = {
                enabled = true,
                splitAttributes = false,
                joinContentLines = false,
                spaceBeforeEmptyCloseTag = true,
            },
            validation = {
                enabled = true,
            },
        },
    },
})
