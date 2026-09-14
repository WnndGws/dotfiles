return {
	"zbirenbaum/neodim",
	lazy = true,
	event = "LspAttach",
	config = function()
		require("neodim").setup()
	end,
}
