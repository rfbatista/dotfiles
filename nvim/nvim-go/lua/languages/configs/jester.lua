local status_ok, jester = pcall(require, "jester")
if not status_ok then
  return
end

jester.setup({
  dap = {
    cmd = "'$path_to_jest' '$file' -t '$result' ",
    console = "externalTerminal",
    path_to_jest_run = './node_modules/bin/jest',
    path_to_jest_debug = './node_modules/bin/jest'
  }
})
