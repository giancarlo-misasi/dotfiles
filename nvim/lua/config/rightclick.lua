local function setup_right_click_menu()
	vim.cmd([[
		augroup _popup_menu
		  aunmenu PopUp
		  nnoremenu PopUp.Split\ Right      :SplitRight<CR>
		  nnoremenu PopUp.Split\ Down       :SplitDown<CR>
		  nnoremenu PopUp.New\ Tab          :NewTab<CR>
		  anoremenu PopUp.-1-               <Nop>
		  nnoremenu PopUp.Close\ Split      :q!<CR>
		  nnoremenu PopUp.Close\ Tab        :CloseTab<CR>
		  anoremenu PopUp.-2-               <Nop>
		  nnoremenu PopUp.Rename     		:Rename<CR>
		  nnoremenu PopUp.Format\ Code      :FormatCode<CR>
		  nnoremenu PopUp.Code\ Actions     :CodeActions<CR>
		  nnoremenu PopUp.Hover  			:Hover<CR>
		  nnoremenu PopUp.Show\ References  :ShowReferences<CR>
		  nnoremenu PopUp.Show\ Signature   :ShowSignature<CR>
		  nnoremenu PopUp.Goto\ Definition  :GotoDefinition<CR>
		augroup end
	]])
end

setup_right_click_menu()
