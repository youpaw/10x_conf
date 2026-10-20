-- load NvChad defaults (for default on_attach, capabilities, etc)
require("nvchad.configs.lspconfig").defaults()

-- Define your server list and optional overrides
local servers = {
  { "clangd", {
      cmd = { "clangd", "--background-index", "--completion-style=detailed", "--header-insertion=never", "--pch-storage=memory", },

      -- override on_attach so it disables formatting from clangd itself
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        require("nvchad.configs.lspconfig").on_attach(client, bufnr)
      end,
    }
  },
}

-- Register + enable them
for _, srv in ipairs(servers) do
  local name = srv[1]
  local cfg = srv[2]
  if cfg then
    vim.lsp.config(name, cfg)
  end
  vim.lsp.enable(name)
end

