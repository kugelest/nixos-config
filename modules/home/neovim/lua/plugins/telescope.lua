local custom_sorter = function(opts)
	local score = require('telescope.sorters').get_fzy_sorter(opts)
	return function(entry)
		local basename = vim.fn.fnamemodify(entry.value, ':t')
		local dirname = vim.fn.fnamemodify(entry.value, ':h')
		return score({ ordinal = basename .. ' ' .. dirname, entry = entry })
	end
end

require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				['<esc>'] = require('telescope.actions').close
			}
		},
		path_display = {
			"filename_first",
			truncate = 1,
		}
	},
	pickers = {
		find_files = {
			-- theme = "dropdown",
			sorters = custom_sorter {}
		}
	},
}
