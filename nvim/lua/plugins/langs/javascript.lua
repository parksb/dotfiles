return {
  conform = Workspace.conform("javascript") or {
    "biome",
    "prettier",
    stop_after_first = true,
  },
  linter = Workspace.linter("javascript") or {
    "eslint",
  },
}
