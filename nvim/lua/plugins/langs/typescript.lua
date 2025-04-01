return {
  conform = Workspace.conform("typescript") or {
    "biome",
    "prettier",
    stop_after_first = true,
  },
  linter = Workspace.linter("typescript") or {
    "eslint",
  },
}
