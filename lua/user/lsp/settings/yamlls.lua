local M = {}

M.settings = {
  yaml = {
    schemas = {
      ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
    },
  },
}

return M
