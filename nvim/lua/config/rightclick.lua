local function setup_right_click_menu()
	vim.cmd([[
		augroup _popup_menu
		  aunmenu PopUp
		  nnoremenu PopUp.Split\ Right      :SplitRight<CR>
		  nnoremenu PopUp.Split\ Down       :SplitDown<CR>
		  nnoremenu PopUp.New\ Tab          :NewTab<CR>
		  anoremenu PopUp.-1-               <Nop>
		  nnoremenu PopUp.Code\ Actions     :CodeActions<CR>
		augroup end
	]])
end

setup_right_click_menu()
