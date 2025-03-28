local go_tests = require("user.tests.golang")
local node_tests = require("user.tests.node")

function Unit_test()
  local type = vim.bo.filetype
  if type == "go" then
    return go_tests.unit_test()
  end
  return node_tests.unit_test()
end

function Benchmark_test()
  local type = vim.bo.filetype
  if type == "go" then
    return go_tests.benchmark_test()
  end
  return node_tests.benchmark_test()
end

function Integration_test()
  local type = vim.bo.filetype
  if type == "go" then
    return go_tests.integration_test()
  end
  return node_tests.integration_test()
end

local vim_notify = require("notify")
function RUN_UNIT()
  require("neotest").run.run({
    jestCommand = require("neotest-jest.jest-util").getJestCommand(vim.fn.expand("%:p:h")) .. " --watch",
    jestConfigFile = function()
      local configFile = vim.fn.getcwd() .. "jest.config.js"
      vim_notify(configFile)
      return configFile
    end,
  })
end

local M = {
  keymap = {
    name = "Tests",
    a = { "<cmd>lua RUN_UNIT()<cr>", "Run current unit test file [WATCH MODE]" },
    b = { '<cmd>lua require("neotest").run.run()<cr>', "Run the nearest test" },
    c = { "<cmd>lua Benchmark_test()<cr>", "Run benchmark test" },
    d = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug the nearest test" },
    s = {
      function()
        neotest = require("neotest")
        neotest.summary.toggle()
      end,
      "Show summary",
    },
    i = { "<cmd>lua Integration_test()<cr>", "Run current integration test file" },
  },
}

return M
