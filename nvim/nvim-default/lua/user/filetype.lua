-- if a file is a .env or .envrc file, set the filetype to sh
vim.filetype.add({
  filename = {
    [".env"] = "conf",
    [".envrc"] = "conf",
    ["*.env"] = "conf",
    ["*.envrc"] = "conf"
  }
})

