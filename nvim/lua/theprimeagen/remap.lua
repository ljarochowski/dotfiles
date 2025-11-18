vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- In visual mode: J moves selected lines DOWN
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- In visual mode: K moves selected lines UP

vim.keymap.set("n", "J", "mzJ`z")            -- J joins lines but keeps cursor position
vim.keymap.set("n", "=ap", "ma=ap'a")        -- Format paragraph and return cursor to original position

vim.keymap.set("n", "<C-d>", "<C-d>zz")      -- Ctrl+d scrolls down and centers cursor
vim.keymap.set("n", "<C-u>", "<C-u>zz")      -- Ctrl+u scrolls up and centers cursor
vim.keymap.set("n", "n", "nzzzv")            -- Next search result, center and open folds
vim.keymap.set("n", "N", "Nzzzv")            -- Previous search result, center and open folds
-- Space+y copies to system clipboard (works in normal and visual mode)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]]) -- Space+Y copies whole line to system clipboard

-- Space+d deletes to void register (doesn't overwrite clipboard)
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- Space+s: search and replace word under cursor in entire file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Copy entire file to system clipboard without affecting vim's clipboard
vim.keymap.set("n", "<leader>yf", function()
    -- Save current unnamed register content
    local save_reg = vim.fn.getreg('"')
    local save_regtype = vim.fn.getregtype('"')

    -- Copy entire file to system clipboard
    vim.cmd(':%y +')

    -- Restore the unnamed register (so 'p' works as before)
    vim.fn.setreg('"', save_reg, save_regtype)

    local lines = vim.api.nvim_buf_line_count(0)
    print("Copied " .. lines .. " lines to system clipboard (vim clipboard preserved)")
end, { desc = "Yank entire file to system clipboard only" })

-- snake_case → camelCase
vim.keymap.set({ 'n', 'v' }, '<leader>cc', function()
    local text
    local mode = vim.fn.mode()

    if mode == 'v' or mode == 'V' then
        vim.cmd('noau normal! "vy"')
        text = vim.fn.getreg('v')
    else
        text = vim.fn.expand('<cWORD>')
    end

    local camel = text:gsub("_(%w)", function(letter)
        return letter:upper()
    end)

    camel = camel:gsub("^%u", string.lower)

    if mode == 'v' or mode == 'V' then
        vim.cmd('noau normal! gv"_c' .. camel)
    else
        vim.cmd('normal! ciW' .. camel)
    end

    print(text .. ' → ' .. camel)
end, { desc = 'Convert to camelCase' })

-- camelCase → snake_case
vim.keymap.set({ 'n', 'v' }, '<leader>cs', function()
    local text
    local mode = vim.fn.mode()

    if mode == 'v' or mode == 'V' then
        vim.cmd('noau normal! "vy"')
        text = vim.fn.getreg('v')
    else
        text = vim.fn.expand('<cWORD>')
    end

    local snake = text:gsub("(%u)", function(letter)
        return "_" .. letter:lower()
    end):gsub("^_", "")

    if mode == 'v' or mode == 'V' then
        vim.cmd('noau normal! gv"_c' .. snake)
    else
        vim.cmd('normal! ciW' .. snake)
    end

    print(text .. ' → ' .. snake)
end, { desc = 'Convert to snake_case' })

-- snake_case → PascalCase
vim.keymap.set({ 'n', 'v' }, '<leader>cp', function()
    local text
    local mode = vim.fn.mode()

    if mode == 'v' or mode == 'V' then
        vim.cmd('noau normal! "vy"')
        text = vim.fn.getreg('v')
    else
        text = vim.fn.expand('<cWORD>')
    end

    local pascal = text:gsub("_(%w)", function(letter)
        return letter:upper()
    end):gsub("^%w", string.upper)

    if mode == 'v' or mode == 'V' then
        vim.cmd('noau normal! gv"_c' .. pascal)
    else
        vim.cmd('normal! ciW' .. pascal)
    end

    print(text .. ' → ' .. pascal)
end, { desc = 'Convert to PascalCase' })

-- Duplikuj linię/zaznaczenie w dół
vim.keymap.set('n', '<leader>j', 'yyp', { desc = 'Duplicate line below' })
vim.keymap.set('v', '<leader>j', 'y`>p', { desc = 'Duplicate selection below' })

-- Duplikuj linię/zaznaczenie w górę  
vim.keymap.set('n', '<leader>k', 'yyP', { desc = 'Duplicate line above' })
vim.keymap.set('v', '<leader>k', 'y`<P', { desc = 'Duplicate selection above' })

