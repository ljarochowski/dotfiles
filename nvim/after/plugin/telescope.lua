local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>pb', '<cmd>Telescope buffers<cr>', { desc = 'Find buffers' })
require('telescope').setup({
    pickers = {
        buffers = {
            mappings = {
                i = {
                    ['<C-d>'] = require('telescope.actions').delete_buffer,
                },
                n = {
                    ['<C-d>'] = require('telescope.actions').delete_buffer,
                },
            },
        }
    },
})
