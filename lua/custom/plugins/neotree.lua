-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

vim.keymap.set('n', '<leader>n', '<cmd>Neotree toggle<cr>', { desc = 'Toggle Explorer' })

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      commands = {
        copy_selector = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local vals = {
            ['BASENAME'] = modify(filename, ':r'),
            ['EXTENSION'] = modify(filename, ':e'),
            ['FILENAME'] = filename,
            ['PATH (CWD)'] = modify(filepath, ':.'),
            ['PATH (HOME)'] = modify(filepath, ':~'),
            ['PATH'] = filepath,
            ['URI'] = vim.uri_from_fname(filepath),
          }

          local options = vim.tbl_filter(function(val)
            return vals[val] ~= ''
          end, vim.tbl_keys(vals))
          if vim.tbl_isempty(options) then
            vim.notify('No values to copy', vim.log.levels.WARN)
            return
          end
          table.sort(options)
          vim.ui.select(options, {
            prompt = 'Choose to copy to clipboard:',
            format_item = function(item)
              return ('%s: %s'):format(item, vals[item])
            end,
          }, function(choice)
            local result = vals[choice]
            if result then
              vim.notify(('Copied: `%s`'):format(result))
              vim.fn.setreg('+', result)
            end
          end)
        end,
      },
      window = {
        mappings = {
          Y = 'copy_selector',
          l = 'open',
          h = 'close_node',
        },
      },
    }
  end,
}
