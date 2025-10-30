-- load NvChad defaults (for default on_attach, capabilities, etc)
require("nvchad.configs.lspconfig").defaults()

-- Define your server list and optional overrides
local servers = {
  { "clangd", {
      cmd = { "clangd", "--background-index", "--clang-tidy" },
      -- override on_attach so it disables formatting from clangd itself
      on_attach = function(client, bufnr)
        -- disable formatting if you want none-ls to handle it
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        -- You can also call the default on_attach behavior after customizing
        require("nvchad.configs.lspconfig").on_attach(client, bufnr)
      end,
    }
  },
  -- you could list others similarly:
  -- { "html", { ¿ } },
  -- { "cssls", { ¿ } }
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

