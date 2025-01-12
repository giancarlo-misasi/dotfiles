-- this all gets loaded when StartLsp is called
-- but needs to get registered with lazy
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
    },
    lazy = true,
  },
  {
    "mrcjkb/rustaceanvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    version = '^5',
    lazy = true,
  },
  {
    "nvim-java/nvim-java",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    lazy = true,
  },
}
