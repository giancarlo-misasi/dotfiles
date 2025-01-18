vim.cmd([[
	augroup _popup_menu
	  aunmenu PopUp
	  nnoremenu PopUp.Split\ Right      :vsplit<CR>
	  nnoremenu PopUp.Split\ Down       :split<CR>
	  nnoremenu PopUp.New\ Tab          :tabnew<CR>
	augroup end
]])