return {
  {
    "rcarriga/nvim-notify",
    config = function()
      local nvim_notify = require("notify")
      nvim_notify.setup({
        top_down = false,
      })
    end,
  },
}
