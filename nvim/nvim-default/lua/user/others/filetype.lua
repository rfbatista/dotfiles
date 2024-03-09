-- if a file is a .env or .envrc file, set the filetype to sh
vim.filetype.add({
  filename = {
    [".env"] = "sh",
    [".envrc"] = "sh",
    ["*.env"] = "sh",
    ["*.envrc"] = "sh"
  }
})

--[[ local status_ok = pcall(require, "filetype") ]]
--[[ if not status_ok then ]]
--[[ 	return ]]
--[[ end ]]
--[[]]
--[[ vim.g.did_load_filetypes = 1 ]]
