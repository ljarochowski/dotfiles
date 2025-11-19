local home = os.getenv('HOME')
local jdtls = require('jdtls')

-- Get dotfiles directory dynamically
local dotfiles_dir = home .. '/dotfiles'
-- Check if dotfiles is in different location (e.g., ~/Documents/Projects/dotfiles)
if vim.fn.isdirectory(home .. '/Documents/Projects/dotfiles') == 1 then
    dotfiles_dir = home .. '/Documents/Projects/dotfiles'
end

local java_tools_dir = dotfiles_dir .. '/java-tools'

-- Java debug and test bundles (dynamic paths)
local bundles = {
    vim.fn.glob(java_tools_dir ..
    '/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(java_tools_dir .. "/vscode-java-test/server/*.jar", true), "\n"))

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- On attach function with keybindings
local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- Java specific (jdtls)
    vim.keymap.set("n", "<C-o>", jdtls.organize_imports,
        { noremap = true, silent = true, buffer = bufnr, desc = "Organize imports" })
    vim.keymap.set("n", "<leader>ev", jdtls.extract_variable,
        { noremap = true, silent = true, buffer = bufnr, desc = "Extract variable" })
    vim.keymap.set("n", "<leader>ec", jdtls.extract_constant,
        { noremap = true, silent = true, buffer = bufnr, desc = "Extract constant" })
    vim.keymap.set('v', "<leader>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
        { noremap = true, silent = true, buffer = bufnr, desc = "Extract method" })

    -- nvim-dap (debugging)
    vim.keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Conditional breakpoint" })
    vim.keymap.set("n", "<leader>bl",
        "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Log point" })
    vim.keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Clear breakpoints" })
    vim.keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>',
        { noremap = true, silent = true, buffer = bufnr, desc = "List breakpoints" })

    vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Continue" })
    vim.keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Step over" })
    vim.keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Step into" })
    vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Step out" })
    vim.keymap.set("n", '<leader>dd', "<cmd>lua require'dap'.disconnect()<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Disconnect" })
    vim.keymap.set("n", '<leader>dt', "<cmd>lua require'dap'.terminate()<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Terminate" })
    vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Toggle REPL" })
    vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Run last" })
    vim.keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end,
        { noremap = true, silent = true, buffer = bufnr, desc = "Hover variables" })
    vim.keymap.set("n", '<leader>d?',
        function()
            local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
        end,
        { noremap = true, silent = true, buffer = bufnr, desc = "Scopes" })
    vim.keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>',
        { noremap = true, silent = true, buffer = bufnr, desc = "List frames" })
    vim.keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>',
        { noremap = true, silent = true, buffer = bufnr, desc = "List commands" })
    vim.keymap.set("n", "<leader>vc", jdtls.test_class,
        { noremap = true, silent = true, buffer = bufnr, desc = "Test class (DAP)" })
    vim.keymap.set("n", "<leader>vm", jdtls.test_nearest_method,
        { noremap = true, silent = true, buffer = bufnr, desc = "Test method (DAP)" })

    -- Setup DAP with jdtls
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end

local config = {
    flags = {
        debounce_text_changes = 80,
    },
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
        bundles = bundles
    },
    settings = {
        java = {
            format = {
                settings = {
                    url = java_tools_dir .. "/eclipse-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = home .. "/.asdf/installs/java/corretto-17.0.4.9.1",
                    },
                    {
                        name = "JavaSE-11",
                        path = home .. "/.asdf/installs/java/corretto-11.0.16.9.1",
                    },
                    {
                        name = "JavaSE-1.8",
                        path = home .. "/.asdf/installs/java/corretto-8.352.08.1"
                    },
                }
            }
        }
    },
    cmd = {
        home .. "/.asdf/installs/java/corretto-17.0.4.9.1/bin/java",
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-javaagent:' .. java_tools_dir .. '/lombok.jar',
        '-jar', vim.fn.glob('/opt/homebrew/Cellar/jdtls/1.50.0/libexec/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration', '/opt/homebrew/Cellar/jdtls/1.50.0/libexec/config_mac',
        '-data', home .. '/.local/share/eclipse/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t'),
    },
}

jdtls.start_or_attach(config)
