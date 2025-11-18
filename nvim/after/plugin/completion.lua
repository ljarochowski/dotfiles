local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup {
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'vsnip' },
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- because we are using the vsnip cmp plugin
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            before = function(_, vim_item)
                return vim_item
            end
        })
    }
}

vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
vim.keymap.set("n", 'gD', vim.lsp.buf.declaration, { noremap = true, silent = true, desc = "Go to declaration" })
vim.keymap.set("n", 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
vim.keymap.set("n", 'gi', vim.lsp.buf.implementation, { noremap = true, silent = true, desc = "Go to implementation" })
vim.keymap.set("n", 'K', vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Hover text" })
vim.keymap.set("n", '<C-k>', vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = "Show signature" })
vim.keymap.set("n", '<leader>wa', vim.lsp.buf.add_workspace_folder,
    { noremap = true, silent = true, desc = "Add workspace folder" })
vim.keymap.set("n", '<leader>wr', vim.lsp.buf.remove_workspace_folder,
    { noremap = true, silent = true, desc = "Remove workspace folder" })
vim.keymap.set("n", '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { noremap = true, silent = true, desc = "List workspace folders" })
vim.keymap.set("n", '<leader>D', vim.lsp.buf.type_definition,
    { noremap = true, silent = true, desc = "Go to type definition" })
vim.keymap.set("n", '<leader>rn', vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename" })
vim.keymap.set("n", '<leader>ca', vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code actions" })
vim.keymap.set('v', "<leader>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
    { noremap = true, silent = true, desc = "Code actions" })
vim.keymap.set("n", '<leader>f', function() vim.lsp.buf.format { async = true } end,
    { noremap = true, silent = true, desc = "Format file" })
