local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local ui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")

-- Dap Virtual Text
dap_virtual_text.setup()


mason_dap.setup({
  ensure_installed = { "cppdbg" },
  automatic_installation = true,
  handlers = {
    function(config)
      require("mason-nvim-dap").default_setup(config)
    end,
  },
})

dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = false,
    args = function()
      local input = vim.fn.input("Args: ")
      return vim.split(input, " +")
    end,
  },
  {
    name = 'Attach to gdbserver lh:5678',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:5678',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}

dap.configurations.c = dap.configurations.cpp

-- Dap UI

ui.setup()

vim.fn.sign_define("DapBreakpoint", {
  text = "●",
  texthl = "DapBreakpoint",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = "◌",
  texthl = "DapBreakpointRejected",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapStopped", {
  text = "→",
  texthl = "DapStopped",
  linehl = "DapStoppedLine",
  numhl = "",
})

vim.api.nvim_set_hl(0, "DapBreakpoint",        { fg = "#ff5555" })   -- Red
vim.api.nvim_set_hl(0, "DapBreakpointRejected",{ fg = "#ffaa00" })   -- Orange
vim.api.nvim_set_hl(0, "DapStopped",           { fg = "#00ff99" })   -- Green arrow

dap.listeners.before.attach.dapui_config = function()
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	ui.close()
end

