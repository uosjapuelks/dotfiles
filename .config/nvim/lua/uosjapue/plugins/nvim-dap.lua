vim.g.mapleader = " "
local dap_ok, dap = pcall(require, "dap")
if not (dap_ok) then
  print("nvim-dap not installed!")
  return
end
require('dap').set_log_level('INFO') -- Helps when configuring DAP, see logs with :DapShowLog
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
dap.adapters.codelldb = {
  name = "codelldb server",
  type = 'server',
  port = "${port}",
  executable = {
      command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
      args = { "--port", "${port}" },
  }
}

dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = {"dap", "-l", "127.0.0.1:${port}"},
  }
}
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages 
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  }
}

local dap_ui_ok, dap_ui = pcall(require, "dapui")
if not (dap_ok and dap_ui_ok) then
  require("notify")("dap-ui not installed!", "warning")
  return
end
dap.listeners.before.attach.dapui_config = function()
  dap_ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dap_ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dap_ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dap_ui.close()
end
dap_ui.setup({
  icons = { expanded = "?", collapsed = "?" },
  mappings = {
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {
      elements = {
        "scopes",
      },
      size = 0.3,
      position = "right"
    },
    {
      elements = {
        "repl",
        "breakpoints"
      },
      size = 0.3,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil,
  },
})

vim.fn.sign_define('DapBreakpoint', { text = '•' })
-- -- Start debugging session
-- vim.keymap.set("n", "<localleader>dr", function()
--   dap.continue()
--   ui.toggle({})
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
-- end)
-- -- -- Set breakpoints, get variable values, step into/out of functions, etc.
-- vim.keymap.set("n", "<leader>dl", require("dap.ui.widgets").hover)
-- vim.keymap.set("n", "<leader>dc", dap.continue)
-- vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
-- vim.keymap.set("n", "<leader>dn", dap.step_over)
-- vim.keymap.set("n", "<leader>di", dap.step_into)
-- vim.keymap.set("n", "<leader>do", dap.step_out)
-- vim.keymap.set("n", "<leader>dC", function()
--   dap.clear_breakpoints()
--   require("notify")("Breakpoints cleared", "warn")
-- end)
-- -- -- Close debugger and clear breakpoints
-- vim.keymap.set("n", "<localleader>de", function()
--   dap.clear_breakpoints()
--   ui.toggle({})
--   dap.terminate()
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
--   require("notify")("Debugger session ended", "warn")
-- end)


