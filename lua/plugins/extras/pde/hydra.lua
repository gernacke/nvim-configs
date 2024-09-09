local function gitsigns_menu()
  local gitsigns = require("gitsigns")

  local hint = [[
 _J_: Next hunk   _s_: Stage Hunk        _d_: Show Deleted   _b_: Blame Line
 _K_: Prev hunk   _u_: Undo Last Stage   _p_: Preview Hunk   _B_: Blame Show Full 
 _r_: Reset Hunk  _S_: Stage Buffer      ^ ^                 _/_: Show Base File
 ^
 ^ ^              _<Enter>_: Neogit              _q_: Exit
]]

  return {
    name = "Git",
    hint = hint,
    config = {
      color = "pink",
      invoke_on_body = true,
      hint = {
        float_opts = {
          border = "rounded",
        },
        position = "bottom",
      },
      on_enter = function()
        vim.cmd("mkview")
        vim.cmd("silent! %foldopen!")
        vim.bo.modifiable = true
        gitsigns.toggle_signs(true)
        gitsigns.toggle_linehl(true)
      end,
      on_exit = function()
        -- local cursor_pos = vim.api.nvim_win_get_cursor(0)
        -- vim.cmd("loadview")
        -- vim.api.nvim_win_set_cursor(0, cursor_pos)
        -- vim.cmd("normal zv")
        gitsigns.toggle_signs(true)
        gitsigns.toggle_linehl(false)
        gitsigns.toggle_deleted(false)
      end,
    },
    body = "<A-i>",
    heads = {
      {
        "J",
        function()
          local opts = {
            navigation_message = true,
          }
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gitsigns.nav_hunk("next", opts)
          end)
          return "<Ignore>"
        end,
        { expr = true, desc = "Next Hunk" },
      },
      {
        "K",
        function()
          local opts = {
            navigation_message = true,
          }
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gitsigns.nav_hunk("prev", opts)
          end)
          return "<Ignore>"
        end,
        { expr = true, desc = "Prev Hunk" },
      },
      { "s", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "Stage Hunk" } },
      { "u", gitsigns.undo_stage_hunk, { desc = "Undo Last Stage" } },
      { "S", gitsigns.stage_buffer, { desc = "Stage Buffer" } },
      { "r", gitsigns.reset_hunk, { desc = "Reset Hunk" } },
      { "p", gitsigns.preview_hunk, { desc = "Preview Hunk" } },
      { "d", gitsigns.toggle_deleted, { nowait = true, desc = "Toggle Deleted" } },
      { "b", gitsigns.blame_line, { desc = "Blame" } },
      {
        "B",
        function()
          gitsigns.blame_line({ full = true })
        end,
        { desc = "Blame Show Full" },
      },
      { "/", gitsigns.show, { exit = true, desc = "Show Base File" } }, -- show the base of the file
      { "<Enter>", "<Cmd>Neogit<CR>", { exit = true, desc = "Neogit" } },
      { "q", nil, { exit = true, nowait = true, desc = "Exit" } },
    },
  }
end

local function window_resize()
  return {
    name = "Side scroll",
    config = {
      color = "pink",
      invoke_on_body = true,
      hint = {
        float_opts = {
          border = "rounded",
        },
        position = "bottom",
      },
    },
    mode = "n",
    body = "<A-d>",
    heads = {
      { "h", "5zh" },
      { "l", "5zl", { desc = "←/→" } },
      { "H", "zH" },
      { "L", "zL", { desc = "half screen ←/→" } },
      { "<ESC>/q", nil, { exit = true, nowait = true, desc = "Exit" } },
      { "<ESC>", nil, { exit = true, nowait = true, desc = false } },
    },
  }
end

local function dap_menu()
  local dap = require("dap")
  local dapui = require("dapui")
  local dap_widgets = require("dap.ui.widgets")

  local hint = [[
 _t_: Toggle Breakpoint             _R_: Run to Cursor
 _s_: Start                         _E_: Evaluate Input
 _c_: Continue                      _C_: Conditional Breakpoint
 _b_: Step Back                     _U_: Toggle UI
 _d_: Disconnect                    _S_: Scopes
 _e_: Evaluate                      _X_: Close 
 _g_: Get Session                   _i_: Step Into 
 _h_: Hover Variables               _o_: Step Over 
 _r_: Toggle REPL                   _u_: Step Out
 _x_: Terminate                     _p_: Pause     
 ^ ^               _q_: Quit 
]]

  return {
    name = "Debug",
    hint = hint,
    config = {
      color = "pink",
      invoke_on_body = true,
      hint = {
        float_opts = {
          border = "rounded",
        },
        position = "middle-right",
      },
    },
    mode = "n",
    -- body = "<A-d>",
    -- stylua: ignore
    heads = {
      { "C", function() dap.set_breakpoint(vim.fn.input "[Condition] > ") end, desc = "Conditional Breakpoint", },
      { "E", function() dapui.eval(vim.fn.input "[Expression] > ") end, desc = "Evaluate Input", },
      { "R", function() dap.run_to_cursor() end, desc = "Run to Cursor", },
      { "S", function() dap_widgets.scopes() end, desc = "Scopes", },
      { "U", function() dapui.toggle() end, desc = "Toggle UI", },
      { "X", function() dap.close() end, desc = "Quit", },
      { "b", function() dap.step_back() end, desc = "Step Back", },
      { "c", function() dap.continue() end, desc = "Continue", },
      { "d", function() dap.disconnect() end, desc = "Disconnect", },
      { "e", function() dapui.eval() end, mode = {"n", "v"}, desc = "Evaluate", },
      { "g", function() dap.session() end, desc = "Get Session", },
      { "h", function() dap_widgets.hover() end, desc = "Hover Variables", },
      { "i", function() dap.step_into() end, desc = "Step Into", },
      { "o", function() dap.step_over() end, desc = "Step Over", },
      { "p", function() dap.pause.toggle() end, desc = "Pause", },
      { "r", function() dap.repl.toggle() end, desc = "Toggle REPL", },
      { "s", function() dap.continue() end, desc = "Start", },
      { "t", function() dap.toggle_breakpoint() end, desc = "Toggle Breakpoint", },
      { "u", function() dap.step_out() end, desc = "Step Out", },
      { "x", function() dap.terminate() end, desc = "Terminate", },
      { "q", nil, { exit = true, nowait = true, desc = "Exit" } },
    },
  }
end

local function lsp_menu()
  local cmd = require("hydra.keymap-util").cmd
  return {
    name = "LSP Mode",
    mode = { "n" },
    config = {
      color = "pink",
      invoke_on_body = true,
      hint = {
        type = "window",
        position = "bottom",
        float_opts = {
          border = "rounded",
        },
        show_name = true,
      },
    },
    hint = [[
    LSP
^
Common Actions
- _h_: Show Hover Doc
- _f_: Format Buffer
- _a_: Code Actions
- _s_: Jump to Definition
- _d_: Show Diagnostics
^
Help
- _e_: Show Declarations
- _D_: Show Type Definition
- _j_: Show Sig Help
- _o_: Show Implementation
- _r_: Show References
^
_;_/_q_/_<Esc>_: Exit Hydra
]],
    body = "<A-m>",
    heads = {
      { "s", cmd("Trouble lsp_definitions"), { desc = "Jump to Definition", silent = true } },
      { "h", cmd("Lspsaga hover_doc"), { desc = "Show Hover Doc", silent = true } },
      { "o", cmd("Trouble lsp_implementations"), { desc = "Show Implementations", silent = true } },
      { "j", vim.lsp.buf.signature_help, { desc = "Show Sig Help", silent = true } },
      { "r", cmd("Trouble lsp_references"), { desc = "Show References", silent = true } },
      {
        "f",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        { desc = "Format Buffer", silent = true },
      },
      { "a", vim.lsp.buf.code_action, { desc = "Show Code Actions", silent = true } },
      { "d", cmd("Trouble diagnostics"), { desc = "Show Diagnostics", silent = true } },
      { "D", cmd("Trouble lsp_definitions"), { desc = "Show Type Definition", silent = true } },
      { "e", vim.lsp.buf.declaration, { desc = "Show Declaration", silent = true } },
      { ";", nil, { desc = "quit", exit = true, nowait = true } },
      { "q", nil, { desc = "quit", exit = true, nowait = true } },
      { "<Esc>", nil, { desc = "quit", exit = true, nowait = true } },
    },
  }
end

local function quick_menu()
  local cmd = require("hydra.keymap-util").cmd
  return {
    name = "Quick Menu",
    mode = { "n" },
    hint = [[
        Quick Menu
^
_v_: Open Terminal (vertical)
_h_: Open Terminal (horizontal)

_x_: Explains Codes
_e_: Coding with Instructions
_s_: Summarize Code
_g_: Grammar Correction

_b_: Buffer Fuzzy Search
_o_: Open Symbols Outline

_k_: Show Keymaps
_c_: Show Vim Commands
_m_: Show Man Pages
^
^ ^  _q_/_<Esc>_: Exit Hydra
    ]],
    config = {
      color = "teal",
      invoke_on_body = true,
      hint = {
        type = "window",
        position = "bottom",
        float_opts = {
          border = "rounded",
        },
        show_name = true,
      },
    },
    body = "<A-b>",
    heads = {
      { "k", ":lua require('telescope.builtin').keymaps()<CR>", { desc = "Open Neovim Keymaps", silent = true } },
      { "c", cmd("Telescope commands"), { desc = "Open Available Telescope Commands", silent = true } },
      { "m", cmd("Telescope man_pages"), { desc = "Opens Man Pages", silent = true } },

      {
        "b",
        cmd("Telescope current_buffer_fuzzy_find skip_empty_lines=true"),
        { desc = "Fuzzy find in current buffer", silent = true },
      },
      {
        "o",
        cmd('lua require("nvim-navbuddy").open()'),
        { desc = "Opens Symbols Outline", exit = true, silent = true },
      },

      { "x", cmd("ChatGPTRun explain_code"), { desc = "Explains Code", silent = true } },
      {
        "e",
        cmd(":lua require'chatgpt'.edit_with_instructions()<cr>"),
        { desc = "Edit Codes With Instructions", silent = true },
      },
      { "s", cmd("ChatGPTRun summarize"), { desc = "Summarize Codes", silent = true } },
      { "g", cmd("ChatGPTRun grammar_correction"), { desc = "Grammar Correction", silent = true } },

      { "v", cmd("ToggleTerm size=85 direction=vertical"), { desc = "Vertical Terminal", silent = true } },
      { "h", cmd("ToggleTerm direction=horizontal"), { desc = "Horizontal Terminal", silent = true } },

      { "q", nil, { desc = "quit", exit = true, nowait = true } },
      { "<Esc>", nil, { desc = "quit", exit = true, nowait = true } },
    },
  }
end

return {
  {
    "nvimtools/hydra.nvim",
    event = "VeryLazy",
    config = function(_, _)
      local hydra = require("hydra")
      hydra(gitsigns_menu())
      hydra(dap_menu())
      hydra(quick_menu())
      hydra(lsp_menu())
      hydra(window_resize())
    end,
  },
}
