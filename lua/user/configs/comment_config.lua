local status_ok, comment = pcall(require, "Comment")
if not status_ok then
    print("Missing Comment plugin")
    return
end

comment.setup {
    pre_hook = function(ctx)
        local U = require "Comment.utils"

        local status_utils_ok, utils = pcall(require, "ts_context_commentstring.utils")
        if not status_utils_ok then
            print("Missing ts_context_commentstring.utils")
            return
        end

        local location = nil
        if ctx.ctype == U.ctype.block then
            location = utils.get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = utils.get_visual_start_location()
        end

        local status_internals_ok, internals = pcall(require, "ts_context_commentstring.internals")
        if not status_internals_ok then
            print("Missing ts_context_commentstring")
            return
        end

        return internals.calculate_commentstring {
            key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
            location = location,
        }
    end,
}

-- TODO fix ts_context_commentstring error message when opening up lua files
--[[ Error detected while processing /Users/ger/.config/nvim/init.lua:
E5113: Error while calling lua chunk: ...e/nvim/site/pack/packer/start/packer.nvim/lua/packer.lua:1026: ...ua/neorg/modules/core/integrations/treesitter/module.lua
:50: Unable to load nvim-treesitter.ts_utils :(
stack traceback:
        [C]: in function 'error'
        ...e/nvim/site/pack/packer/start/packer.nvim/lua/packer.lua:1026: in function 'startup'
        /Users/ger/.config/nvim/lua/user/plugins.lua:265: in function 'setup'
        /Users/ger/.config/nvim/init.lua:4: in main chunk
Error detected while processing /Users/ger/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring/plugin/ts_context_commentstring.vim:
line    1:
E5108: Error executing lua [string ":lua"]:1: attempt to index a boolean value
stack traceback:
        [string ":lua"]:1: in main chunk
[packer.nvim] [ERROR 22:32:02] packer.lua:1025: Failure running setup function: "...ua/neorg/modules/core/integrations/treesitter/module.lua:50: Unable to load nvi
m-treesitter.ts_utils :(" ]]


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
