return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
        typescript = { "prettierd" },
        markdown = { "prettierd" },
      },
      default_format_opts = {
        lsp_format = "first",
      },
      format_on_save = {
        timeout_ms = 500
      },
    },
  }
}
