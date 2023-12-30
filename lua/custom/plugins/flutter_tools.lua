return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  opts = function()
    return {
      -- https://github.com/akinsho/flutter-tools.nvim/issues/178
      settings = {
        lineLength = (function()
          return vim.fn.expand('%:p'):find '^/home/f44/dev/stuff/jaspr/' and 120 or 80
        end)(),
      },
      debugger = {
        enabled = true,
        run_via_dap = true,
        register_configurations = function(_)
          require('dap').configurations.dart = {}
          require('dap.ext.vscode').load_launchjs()
        end,
      },
    }
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = true,
}
