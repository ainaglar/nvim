return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
	exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
    config = function()
        require("ibl").setup()
    end,
}
