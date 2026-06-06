# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration using **lazy.nvim** as the plugin manager. All plugins are lazy-loaded by default. The config is managed via GNU Stow — `nvim/` maps to `~/.config/nvim/`.

## Formatting

Lua files use **stylua** with 2-space indentation (`nvim/.stylua.toml`). Format with:

```bash
stylua nvim/lua/
```

## Architecture

### Entry point & load order

`nvim/init.lua` bootstraps lazy.nvim then loads in order:
1. `config.options` — vim options, leader key (`<Space>`), global settings
2. `config.usercommands` — user-defined commands
3. `config.lazy` — plugin specs and lazy.nvim configuration
4. `config.autocmds` — autocommands
5. `config.keymaps` + `config.highlightgroup` — loaded on `VeryLazy` event

### Plugin spec layout

`config/lazy.lua` imports plugin specs from these namespaces:

| Import path | Purpose |
|---|---|
| `plugins` | Core plugins (snacks.nvim, mini.nvim, trouble, flash, etc.) |
| `plugins.colorscheme` | Colorschemes (catppuccin is active via `vim.cmd.colorscheme`) |
| `plugins.vcs` | Git tools (gitsigns, neogit, diffview, fugitive) |
| `plugins.lsp` | LSP setup, mason, conform.nvim formatting |
| `plugins.completion` | nvim-cmp + luasnip + sources |
| `plugins.extras.lang` | Language-specific configs (rust, typescript, python, bash, etc.) |
| `plugins.extras.ui` | UI enhancements (colors, editor, highlight, movement, search) |
| `plugins.extras.ai` | AI integrations (claudecode.nvim, copilot) |
| `plugins.extras.db` | Database (vim-dadbod + UI + completion) |
| `plugins.extras.pde` | PDE extras (harpoon, hydra, notes/markdown, ufo folding) |

### LSP setup pattern

`plugins/lsp/servers.lua` wires mason → mason-lspconfig → lspconfig. To add a new LSP server, add it to `opts.servers` in `plugins/lsp/init.lua`. Servers not available via mason get `mason = false`. Formatting is handled separately by **conform.nvim** (format on save, `<leader>cf` to format manually).

To add a new language: create `extras/lang/<lang>.lua` that extends `nvim-treesitter` opts and adds servers to `nvim-lspconfig` opts — see `extras/lang/rust.lua` or `extras/lang/typescript.lua` as reference.

### Key design decisions

- **Picker**: `folke/snacks.nvim` (not Telescope) is the primary picker for files, grep, LSP, git. Telescope still exists but most workflows use Snacks.
- **Diagnostics**: `tiny-inline-diagnostic.nvim` renders ghost-text style; default virtual text is disabled.
- **Keymaps**: `;` and `:` are swapped. `<C-hjkl>` navigate splits/tmux panes via `vim-tmux-navigator`.
- **DB connections**: Connection strings loaded from `~/.config/nvim/DBUI.env` via `vim-dotenv`. Saved queries go to `~/Google Drive/My Drive/VScode/SQL-Queries/DBUI/`.
- **Claude Code**: `coder/claudecode.nvim` with snacks terminal provider, opens on the right at 40% width. Keys under `<leader>a`.
- **Session management**: Both `folke/persistence.nvim` (`<leader>bs/bl/bt`) and `rmagatti/auto-session` are present.

### Key utility modules

- `lua/utils/init.lua` — `open_term()`, `toggle_copilot()`, `find_files()`, `has(plugin)`
- `lua/utils/coding.lua` — `QuickFixToggle()` (`<c-q>`)
- `lua/utils/searchtool.lua` — search tool helpers
- `lua/config/icons.lua` — shared icon definitions used by LSP, completion, statusline

### Notable keymaps

| Key | Action |
|---|---|
| `<leader><space>` | Smart file picker (Snacks) |
| `<leader>/` | Grep (Snacks) |
| `<leader>gg` | LazyGit |
| `<leader>gs` | Neogit (tab) |
| `<leader>et` | Toggle DBUI |
| `<leader>aT` | Toggle Claude Code |
| `<leader>zz` | Lazy plugin manager |
| `<leader>cm` | Mason |
| `<leader>cf` | Format file/range |
| `<leader>fc` | Find config files |

## Neovim 0.11 Key Features (vs 0.10)

### Built-in LSP — now first-class, no plugins needed for basics

- **`vim.lsp.enable('server_name')`** — declarative server config; replaces manual lspconfig setup for simple cases
- **`vim.lsp.is_enabled()`** — check if a config is enabled
- **`vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })`** — built-in insert-mode LSP completion; potential future replacement for nvim-cmp
- **`vim.lsp.completion.get()`** — manual trigger; also backs the default omnicompletion (`<C-x><C-o>`)

Minimal zero-plugin LSP + completion setup:
```lua
vim.lsp.enable('lua_ls')
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})
```

### New API

| API | What it does |
|---|---|
| `nvim_buf_set_extmark()` `conceal_lines` | Conceal entire lines (not just inline text) |
| `nvim_buf_set_extmark()` `hl_group` array | Layered highlight groups on an extmark |
| `nvim_buf_set_extmark()` `virt_text_pos = "eol_right_align"` | Right-align virtual text at EOL |
| `nvim_open_win()` `mouse` field | Configure mouse interaction per float |
| `nvim_open_win()` `relative = "laststatus"/"tabline"` | Float relative to statusline or tabline |
| `nvim_echo()` `err` field | Print error-styled messages via the API |
| `nvim__ns_set()` | Set properties on a highlight namespace |
| `vim.secure.read()` | Returns `true` for trusted directories |

### Deprecated in 0.11

- `vim.lsp.buf.completion` → use `vim.lsp.completion.get()`
