local keymaps = require("modules.keymaps")

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
        version = "*",
        event = "VeryLazy",
        opts = {
            keymaps = keymaps.surround,
        },
    },
    {
        "johmsalas/text-case.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("textcase").setup({ default_keymappings_enabled = false })
            require("telescope").load_extension("textcase")
        end,
    },
}
