local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	print("Missing Comment plugin")
	return
end
-- comments fix Chris@machine, start from 1:44:00 here: https://www.youtube.com/watch?v=HNQpLyRIreA&t=5162s
comment.setup({
	padding = true, ---Add a space b/w comment and the line
	sticky = true, ---Whether the cursor should stay at its position
	ignore = "^$", ---Lines to be ignored while (un)comment
	toggler = { ---LHS of toggle mappings in NORMAL mode
		line = "gcc", ---Line-comment toggle keymap
		block = "gbc", ---Block-comment toggle keymap
	},
	opleader = { ---LHS of operator-pending mappings in NORMAL and VISUAL mode
		line = "gc", ---Line-comment keymap
		block = "gb", ---Block-comment keymap
	},
	---LHS of extra mappings
	extra = {
		above = "gcO", ---Add comment on the line above
		below = "gco", ---Add comment on the line below
		eol = "gcA", ---Add comment at the end of line
	},
	---Enable keybindings
	---NOTE: If given `false` then the plugin won't create any mappings
	mappings = {
		basic = true, ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
		extra = true, ---Extra mapping; `gco`, `gcO`, `gcA`
	},
	---Function to call before (un)comment
	-- pre_hook = nil,
	---Function to call after (un)comment
	post_hook = nil,

	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	-- pre_hook = function(ctx)
	--        local U = require "Comment.utils"
	--        local status_utils_ok, utils = pcall(require, "ts_context_commentstring.utils")
	--        if not status_utils_ok then
	--            print("Missing ts_context_commentstring.utils")
	--            return
	--        end
	--        local location = nil
	--        if ctx.ctype == U.ctype.block then
	--            location = utils.get_cursor_location()
	--        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
	--            location = utils.get_visual_start_location()
	--        end
	--        local status_internals_ok, internals = pcall(require, "ts_context_commentstring.internals")
	--        if not status_internals_ok then
	--            print("Missing ts_context_commentstring")
	--            return
	--        end
	--        return internals.calculate_commentstring {
	--            key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
	--            location = location,
	--        }
	--    end,
})
-- https://github.com/numToStr/Comment.nvim
--[[ 
`gcc` - Toggles the current line using linewise comment
`gbc` - Toggles the current line using blockwise comment
`[count]gcc` - Toggles the number of line given as a prefix-count using linewise
`[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
`gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
`gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
    VISUAL mode
`gc` - Toggles the region using linewise comment
`gb` - Toggles the region using blockwise comment
Extra mappings
These mappings are enabled by default. (config: mappings.extra)
    NORMAL mode
`gco` - Insert comment to the next line and enters INSERT mode
`gcO` - Insert comment to the previous line and enters INSERT mode
`gcA` - Insert comment to end of the current line and enters INSERT mode
Examples
# Linewise
`gcw` - Toggle from the current cursor position to the next word
`gc$` - Toggle from the current cursor position to the end of line
`gc}` - Toggle until the next blank line
`gc5j` - Toggle 5 lines after the current cursor position
`gc8k` - Toggle 8 lines before the current cursor position
`gcip` - Toggle inside of paragraph
`gca}` - Toggle around curly brackets
# Blockwise
`gb2}` - Toggle until the 2 next blank line
`gbaf` - Toggle comment around a function (w/ LSP/treesitter support)
`gbac` - Toggle comment around a class (w/ LSP/treesitter support) 
]]
