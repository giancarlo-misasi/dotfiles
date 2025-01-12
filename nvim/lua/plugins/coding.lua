local keymaps = require("config.keymaps")

return {
  {
    "gbprod/cutlass.nvim",
    lazy = false,
    opts = {
      override_del = true
    }
  },
  {
    "numtostr/comment.nvim",
    lazy = false,
    opts = {
      opleader = keymaps.comment_operator,
      toggler = keymaps.comment_toggler,
      mappings = { extra = false },
    },
  },
  {
    "kylechui/nvim-surround",
    lazy = false,
    opts = {
      keymaps = keymaps.surround,
    },
  },
  {
    "johmsalas/text-case.nvim",
    lazy = true,
    cmd = {
      "ToUpperCase",
      "ToLowerCase",
      "ToSnakeCase",
      "ToDashCase",
      "ToConstantCase",
      "ToDotCase",
      "ToCommaCase",
      "ToPhraseCase",
      "ToCamelCase",
      "ToPascalCase",
      "ToTitleCase",
      "ToPathCase",
    },
    config = function()
      require("textcase").setup({ default_keymappings_enabled = false })
      require("telescope").load_extension("textcase")
    end,
  },
}
