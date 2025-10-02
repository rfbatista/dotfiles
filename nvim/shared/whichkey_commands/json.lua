return {
  {
    "<leader>j",
    group = "JSON",
    nowait = true,
    remap = false,
  },
  {
    "<leader>ja",
    "<cmd>%!jq .<cr>",
    desc = "JSON formart",
    nowait = true,
    remap = false,
  },
  {
    "<leader>jo",
    "<cmd>%! jq -c .<cr>",
    desc = "JSON One line",
    nowait = true,
    remap = false,
  },
}
