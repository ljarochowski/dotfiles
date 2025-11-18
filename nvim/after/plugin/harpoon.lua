local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
-- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

-- basic telescope configuration
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            local delete_harpoon_entry = function()
                local selection = action_state.get_selected_entry()
                if not selection then return end

                local index_to_remove = nil
                for i, item in ipairs(harpoon:list().items) do
                    if item.value == selection.value then
                        index_to_remove = i
                        break
                    end
                end

                if index_to_remove then
                    table.remove(harpoon:list().items, index_to_remove)
                end

                local current_picker = action_state.get_current_picker(prompt_bufnr)
                local new_results = {}
                for _, item in ipairs(harpoon:list().items) do
                    table.insert(new_results, item.value)
                end

                current_picker:refresh(
                    require("telescope.finders").new_table({
                        results = new_results,
                    }),
                    { reset_prompt = false }
                )
            end

            map('i', '<C-d>', delete_harpoon_entry)
            map('n', '<C-d>', delete_harpoon_entry)
            return true
        end,
    }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
