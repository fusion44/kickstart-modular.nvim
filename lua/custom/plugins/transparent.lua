return {
  'xiyaowong/transparent.nvim',
  config = function()
    require('transparent').setup {
      extra_groups = {
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NormalFloat",
      },
    }

    require('transparent').clear_prefix('lualine')
  end,
}
