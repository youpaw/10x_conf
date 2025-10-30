local none_ls = require("null-ls")

none_ls.setup({
  sources = {
    -- Formatter
    none_ls.builtins.formatting.clang_format,

    -- Linters
    -- none_ls.builtins.diagnostics.cpplint,
  },
})

