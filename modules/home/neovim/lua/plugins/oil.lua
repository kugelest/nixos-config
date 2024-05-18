require("oil").setup({
	skip_confirm_for_simple_edits = true,
	columns = {"icons"},
	git = {
		-- Return true to automatically git add/mv/rm files
		add = function(path)
			return false
		end,
		mv = function(src_path, dest_path)
			return true
		end,
		rm = function(path)
			return true
		end,
	}
})


