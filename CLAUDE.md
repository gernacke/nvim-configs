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

## nvim-dev Instance

This directory is the **nvim-dev** isolated config — launched via `NVIM_APPNAME=nvim-dev`. The alias is:

```sh
alias v11='NVIM_APPNAME=nvim-dev ~/.local/share/bob/v0.11.7/nvim-macos-arm64/bin/nvim'
```

Data/state lives in `~/.local/share/nvim-dev/`, cache in `~/.cache/nvim-dev/`.

### Neovim 0.11 compatibility decisions

This config is **pinned to Neovim 0.11.x** (currently 0.11.7 via bob). Several plugins and compatibility shims are intentionally set up for 0.11 — do not upgrade them to branches that require 0.12+.

#### Plugin branch pins

| Plugin | Branch / Version | Reason |
|---|---|---|
| `nvim-treesitter/nvim-treesitter` | `branch = "master"` | `main` branch is a 0.12+ rewrite; `master` locks the old `nvim-treesitter.configs` API |
| `nvim-treesitter/nvim-treesitter-textobjects` | `branch = "master"` | Same split — `main` requires 0.12; `master` uses the nested `textobjects` table inside `configs.setup()` |
| `mrcjkb/rustaceanvim` | `version = "^8.0.5"` | v9.0.0 (2026-04-03) dropped Neovim 0.11; v8.0.5 (commit `f69c85a`, branch `main`) is the last 0.11-compatible release |

After changing branch pins, run `:Lazy restore` to reconcile on-disk plugin checkouts with `lazy-lock.json`, then `:TSUpdate` to rebuild parsers.

#### 0.11 compatibility shims and fixes

**`vim.lsp.buf.hover` / `signature_help` border** (`plugins/lsp/servers.lua`):
Neovim 0.11 no longer routes `vim.lsp.buf.hover()` through `vim.lsp.handlers["textDocument/hover"]`, making `vim.lsp.with()` a no-op for border styling. The functions are wrapped directly to inject `float_opts`. Note: noice.nvim (`lsp.hover.enabled = true`) actually owns the K hover render when active — the wrapper is a harmless fallback.

**`make_position_params` encoding shim** (`config/autocmds.lua`):
0.11 made `position_encoding` a required argument. Several plugins (lspsaga, vim-illuminate, trouble, telescope, inc-rename) omit it. A global wrapper shim defaults to the buffer's first client encoding, suppressing the warning.

**vim-matchup treesitter disabled** (`plugins/treesitter.lua`):
The vim-matchup treesitter bridge calls `_node_id` on a nil node with the `master` branch on Neovim 0.11, crashing on every `CursorMoved`. Fix: `matchup = { enable = false }` inside nvim-treesitter opts. The regexp engine fallback preserves all matchup functionality (%, g%, [%/]%, a%/i%, offscreen match indicator).

**noice hover padding** (`plugins/noice.lua`):
noice.nvim intercepts `vim.lsp.buf.hover` when `lsp.hover.enabled = true` (default) + `presets.lsp_doc_border = true`. Its nui popup supports `border.padding`, so hover content padding is set via `views.hover.border.padding = { 1, 2 }`.

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
