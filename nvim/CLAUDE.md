# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this directory.

## Overview

This is the minimal, **zero third-party plugin** sibling of `~/.config/nvim` (the separate
`arkottke/kickstart.nvim` git repo, which stays plugin-based via `vim.pack`). It uses only Neovim builtins (the
0.11+ default LSP client, native completion, native diagnostics, native treesitter, netrw, quickfix,
`vim.ui.select`/`vim.ui.input`) plus a handful of small hand-written Lua modules that wrap those builtins (and,
where unavoidable, the `git`/`rg`/`fd` CLIs) to approximate a plugin's UX under the *same keymaps* as
`~/.config/nvim`. There is no plugin manager and no lockfile.

This copy is kept in the dotfiles repo as a maintained reference and is **not currently symlinked or deployed**
to `~/.config/nvim` or anywhere else — see the root `README.rst` for how Neovim is actually deployed. Keep it in
sync with `~/.config/nvim` by hand when the two diverge in ways that aren't dotfiles-specific.

Because there's no auto-installer, LSP servers (`lua-language-server`, `pyright-langserver`, `marksman`) and CLI
formatters (`stylua`, `ruff`, `prettier`, `latexindent`) must be installed via the system package manager and be
on `$PATH`.

## Formatting

All Lua files must be formatted with **StyLua** before committing. The `.stylua.toml` config specifies:
- 160-column width, 2-space indent, single quotes, always-collapse simple statements

Check formatting: `stylua --check .`
Fix formatting: `stylua .`

## Architecture

### Entry point

`init.lua` is the single configuration file, organized into 9 numbered `do...end` blocks:

1. **Foundation** — options, leader key, base keymaps, autocmds, diagnostics (all builtin); also sets
   `PYENV_VERSION` from `pyenv version` for pyright's interpreter discovery
2. **UI** — hand-rolled `catppuccin-frappe` colorscheme (see below), netrw config, `custom.statusline`,
   `custom.todo_highlight`
3. **Search & Navigation** — `custom.pickers` (grep/wildmenu setup + all `<leader>s*` keymaps)
4. **LSP** — native `vim.lsp` client; `lua_ls`, `pyright`, and `marksman` configured manually (no
   nvim-lspconfig, so each server's `cmd`/`filetypes`/`root_markers` is spelled out). Most `gr*` keymaps are
   Neovim's own >=0.11 defaults (`:help lsp-defaults`); only the gaps (`grd`, `grD`, `gW`) are added here.
5. **Formatting** — `custom.format` (`<leader>f`)
6. **Autocomplete & Snippets** — native `vim.lsp.completion` (enabled per-buffer on `LspAttach`) + `vim.snippet`
7. **Treesitter** — attaches to whatever parsers are bundled with the Neovim build (no auto-installer); folding
   via the builtin `vim.treesitter.foldexpr()`
8. **Editing enhancements** — `custom.surround`, `custom.leap`, `custom.whichkey`, `custom.gitsigns`,
   `custom.tmux_nav`
9. **Custom** — loads `custom.keymaps`

### Hand-rolled modules (`lua/custom/*.lua`)

Each replaces one plugin, using only builtin APIs (extmarks, `getcharstr()`, `searchpairpos()`, `vim.system()`,
`vim.ui.select`/`vim.ui.input`, the quickfix list):

| File | Replaces | Notes |
|---|---|---|
| `statusline.lua` | mini.statusline | mode/git branch/diagnostics via `statusline` option |
| `surround.lua` | mini.surround | `sa`/`sd`/`sr`; quote matching is same-line only, brackets use `searchpairpos()` |
| `leap.lua` | leap.nvim | `s`/`S`; 2-char search + label overlay, visible-window only |
| `whichkey.lua` | which-key.nvim | bound to bare `<leader>`; shows continuations by scanning `nvim_get_keymap()` |
| `gitsigns.lua` | gitsigns.nvim | shells out to `git diff -U0`/`apply`/`blame`/`show`; no word-diff toggle or repo-wide qflist |
| `tmux_nav.lua` | nvim-tmux-navigation | `<C-hjkl>` crosses into tmux panes via `tmux select-pane` |
| `todo_highlight.lua` | todo-comments.nvim | highlight-only, via `matchadd()` |
| `format.lua` | conform.nvim / null-ls | LSP formatting by default; `ruff`/`prettier`/`latexindent` via `vim.system()` for python/markdown/tex |
| `pickers.lua` | telescope.nvim | `vim.ui.select`/`vim.ui.input` + quickfix (via `getqflist({lines=...})`, no file needed) |
| `keymaps.lua` | (was already builtin) | `<leader>rr`/`<F5>` run-current-file in a terminal split |

### Colorscheme (`colors/catppuccin-frappe.lua`)

Hand-written Catppuccin Frappé colorscheme using the published hex palette and `nvim_set_hl`, since there's no
plugin manager to pull in `catppuccin/nvim`. Matches the flavour `~/.config/nvim` uses via the real plugin.
Covers core UI, syntax, diagnostic/LSP, git-sign and spelling highlight groups.

### `ftplugin/`

Filetype-local settings that predate this rewrite and have no plugin dependency: `python.vim` (textwidth 88),
`rst.vim` (textwidth 80, spell), `tex.vim` (textwidth 100, spell), `markdown.lua` (textwidth 80 — the old
zk.nvim-backed backlink/note keymaps were dropped along with that plugin, same treatment as telekasten below).

### Dropped entirely (no builtin equivalent, not reimplemented)

Copilot (AI completion), codecompanion/zk.nvim (AI chat / Zettelkasten notes), vimtex (LaTeX editing), aerial.nvim
(symbol outline), neogen (docstring generation), nvim-tree (tree file explorer — netrw covers this), mini.pairs
(autopairs), indent-blankline, trouble.nvim (diagnostic list — `<leader>q` / `vim.diagnostic.setloclist` covers
the common case), fugitive (full git porcelain), mini.ai (extra textobjects — Neovim's builtin textobjects like
`i"`, `i(`, `ip` still work).

## Key conventions

- **Leader**: `<Space>`; **LocalLeader**: `<Space>` (matches `~/.config/nvim`)
- Adding a new capability: prefer a builtin API first; if none exists, add a small module under `lua/custom/`
  wrapping `vim.system()`/`vim.ui.*`/extmarks, `require()`'d from the relevant numbered section in `init.lua`
- LSP servers are configured by hand in the `servers` table in Section 4 — no Mason, so add `cmd`/`filetypes`/
  `root_markers` explicitly and make sure the binary is actually installed
- Search/grep keymaps (`<leader>s*`) live in `lua/custom/pickers.lua`; extend that file rather than adding a new
  picker module
