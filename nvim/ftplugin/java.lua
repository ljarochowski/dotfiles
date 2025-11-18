local home = os.getenv('HOME')
local jdtls = require('jdtls')

-- File types that signify a Java project's root directory. This will be
-- used by eclipse to determine what constitutes a workspace
local root_markers = { 'gradlew', 'mvnw', '.git' }
local root_dir = require('jdtls.setup').find_root(root_markers)

-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- The on_attach function is used to set key maps after the language server
-- attaches to the current buffer
local on_attach = function(client, bufnr)
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    --  require('dap.ext.vscode').load_launchjs()

    -- Java extensions provided by jdtls
    vim.keymap.set("n", "<C-o>", jdtls.organize_imports,
        { noremap = true, silent = true, buffer = bufnr, desc = "Organize imports" })
    vim.keymap.set("n", "<leader>ev", jdtls.extract_variable,
        { noremap = true, silent = true, buffer = bufnr, desc = "Extract variable" })
    vim.keymap.set("n", "<leader>ec", jdtls.extract_constant,
        { noremap = true, silent = true, buffer = bufnr, desc = "Extract constant" })
    vim.keymap.set('v', "<leader>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
        { noremap = true, silent = true, buffer = bufnr, desc = "Extract method" })

    -- nvim-dap
    vim.keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Set breakpoint" })
    vim.keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Set conditional breakpoint" })
    vim.keymap.set("n", "<leader>bl",
        "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Set log point" })
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
        { noremap = true, silent = true, buffer = bufnr, desc = "Open REPL" })
    vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Run last" })
    vim.keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end,
        { noremap = true, silent = true, buffer = bufnr, desc = "Variables" })
    vim.keymap.set("n", '<leader>d?',
        function()
            local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
        end, { noremap = true, silent = true, buffer = bufnr, desc = "Scopes" })
    vim.keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>',
        { noremap = true, silent = true, buffer = bufnr, desc = "List frames" })
    vim.keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>',
        { noremap = true, silent = true, buffer = bufnr, desc = "List commands" })
    vim.keymap.set("n", "<leader>vc", jdtls.test_class,
        { noremap = true, silent = true, buffer = bufnr, desc = "Test class (DAP)" })
    vim.keymap.set("n", "<leader>vm", jdtls.test_nearest_method,
        { noremap = true, silent = true, buffer = bufnr, desc = "Test method (DAP)" })
end

local bundles = {
    vim.fn.glob(home ..
    '/Documents/Projects/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/Documents/Projects/vscode-java-test/server/*.jar", true), "\n"))

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local config = {
    flags = {
        debounce_text_changes = 80,
    },
    capabilities = capabilities,
    on_attach = on_attach, -- We pass our on_attach keybindings to the configuration map
    root_dir = root_dir, -- Set the root directory to our found root_marker
    init_options = {
        bundles = bundles
    },
    -- Here you can configure eclipse.jdt.ls specific settings
    -- These are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            format = {
                settings = {
                    -- Use Google Java style guidelines for formatting
                    -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
                    -- and place it in the ~/.local/share/eclipse directory
                    url = "~/.local/share/eclipse/eclipse-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' }, -- Use fernflower to decompile library code
            -- Specify any completion options
            completion = {
                favoriteStaticMembers = {
                    -- "org.hamcrest.MatcherAssert.assertThat",
                    -- "org.hamcrest.Matchers.*",
                    -- "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*", "sun.*",
                },
            },
            -- Specify any options for organizing imports
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            -- How code generation should act
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
            -- If you are developing in projects with different Java versions, you need
            -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            -- And search for `interface RuntimeOption`
            -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-21",
                        path = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home/"
                    },
                }
            }
        }
    },
    -- cmd is the command that starts the language server. Whatever is placed
    -- here is what is passed to the command line to execute jdtls.
    -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    -- for the full list of options
    cmd = {
        "/opt/homebrew/opt/openjdk@21/bin/java",
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        -- If you use lombok, download the lombok jar and place it in ~/.local/share/eclipse
        '-javaagent:' .. home .. '/.local/share/eclipse/lombok.jar',

        -- The jar file is located where jdtls was installed. This will need to be updated
        -- to the location where you installed jdtls
        '-jar', vim.fn.glob('/opt/homebrew/Cellar/jdtls/1.50.0/libexec/plugins/org.eclipse.equinox.launcher_*.jar'),

        -- The configuration for jdtls is also placed where jdtls was installed. This will
        -- need to be updated depending on your environment
        '-configuration', '/opt/homebrew/Cellar/jdtls/1.50.0/libexec/config_mac',

        -- Use the workspace_folder defined above to store data for this project
        '-data', workspace_folder,
    },
}

-- Finally, start jdtls. This will run the language server using the configuration we specified,
-- setup the keymappings, and attach the LSP client to the current buffer
jdtls.start_or_attach(config)
