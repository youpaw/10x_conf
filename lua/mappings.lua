require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")


local wk = require("which-key")

wk.add({
  { "<leader>d", group = "Debug" },
  { "<leader>db", function() require'dap'.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
  { "<leader>dc", function() require'dap'.continue() end, desc = "Continue" },
  { "<leader>do", function() require'dap'.step_over() end, desc = "Step Over" },
  { "<leader>di", function() require'dap'.step_into() end, desc = "Step Into" },
  { "<leader>dt", function() require'dap'.terminate() end, desc = "Terminate" },
  { "<leader>du", function() require'dapui'.toggle() end, desc = "Toggle UI" },
})
