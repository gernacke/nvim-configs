local action_set = require("telescope.actions.set")
local transform_mod = require("telescope.actions.mt").transform_mod

local bdelete = transform_mod({
	buffer_delete = function(prompt_bufnr)
		return action_set.edit(prompt_bufnr, "Bdelete")
		-- Enter your function logic here. You can take inspiration from lua/telescope/actions.lua
	end,
})
