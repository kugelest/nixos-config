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
	-- pickers = {
	-- 	find_files = {
	-- 		-- theme = "dropdown",
	-- 		sorters = custom_sorter {}
	-- 	}
	-- },
	extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  },
}

require('telescope').load_extension('fzf')
