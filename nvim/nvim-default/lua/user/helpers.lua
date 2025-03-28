local vim_notify = require("notify")
function _FORMAT_CODE()
  vim_notify("Formatando codigo...", "info")
  vim.lsp.buf.format()
  vim_notify("Codigo formatado", "info")
end
