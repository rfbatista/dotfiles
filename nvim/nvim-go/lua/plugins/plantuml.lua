return {
  "https://gitlab.com/itaranto/plantuml.nvim",
  version = "*",
  config = function()
    require("plantuml").setup({
      renderer = {
        type = "image",
        options = {
          prog = "feh",
          dark_mode = true,
          format = nil, -- Allowed values: nil, 'png', 'svg'.
        },
      },
      render_on_write = true,
    })
  end,
}
