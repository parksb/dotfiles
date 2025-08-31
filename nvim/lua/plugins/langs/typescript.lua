return {
  lsp = {
    vtsls = {
      settings = {
        vtsls = {},
        typescript = {},
      },
      before_init = function(_, config)
        local yarnPnpFile = vim.fs.find({ ".pnp.cjs" }, { upward = true })[1]
        if yarnPnpFile then
          config.settings.typescript.tsdk = vim.fs.dirname(yarnPnpFile) .. "/.yarn/sdks/typescript/lib"
          config.settings.vtsls.autoUseWorkspaceTsdk = true
        end
      end,
      root_dir = function(_, callback)
        local root_dir = vim.fs.root(0, { "tsconfig.json", "jsconfig.json", "package.json" })
        local deno_dir = vim.fs.root(0, { "deno.json", "deno.jsonc" })
        if root_dir and deno_dir == nil then
          callback(root_dir)
        end
      end,
      root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
    },
    denols = {
      root_dir = function(_, callback)
        local root_dir = vim.fs.root(0, { "deno.json", "deno.jsonc" })
        if root_dir then
          callback(root_dir)
        end
      end,
      root_markers = { "deno.json", "deno.jsonc" },
    },
  },
  conform = Workspace.conform("typescript") or {
    "biome",
    "prettier",
    stop_after_first = true,
  },
  linter = Workspace.linter("typescript") or {
    "eslint",
  },
}
