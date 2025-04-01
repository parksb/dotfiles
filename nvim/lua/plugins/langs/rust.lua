return {
  conform = Workspace.conform("rust") or {
    "rustfmt",
    lsp_format = "fallback",
  },
  linter = Workspace.linter("rust") or {
    "clippy",
  },
}
