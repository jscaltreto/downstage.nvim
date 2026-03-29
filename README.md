# downstage.nvim

Neovim plugin for the [Downstage](https://github.com/jscaltreto/downstage)
stage play markup language. Provides filetype detection, buffer settings, and
LSP integration for `.ds` files.

Requires Neovim 0.11+ and the `downstage` binary on your `PATH`.

## Installation

### lazy.nvim

```lua
{ "jscaltreto/downstage.nvim", ft = "downstage" }
```

To limit `nvim-cmp` suggestions for Downstage buffers to LSP results only:

```lua
{
  "jscaltreto/downstage.nvim",
  ft = "downstage",
  opts = {
    cmp = true,
  },
}
```

### Manual

Copy the contents of this repo into your Neovim config directory
(`~/.config/nvim/`).

## What's included

| File | Purpose |
|---|---|
| `ftdetect/downstage.lua` | Registers `.ds` as the `downstage` filetype |
| `ftplugin/downstage.lua` | Buffer settings: soft wrap, spell check, comment format |
| `plugin/downstage.lua` | Auto-initializes the plugin with default settings |
| `lua/downstage/init.lua` | Setup API and optional `nvim-cmp` integration |

## Installing Downstage

The `downstage` CLI must be installed separately:

```
go install github.com/jscaltreto/downstage@latest
```

Or via Homebrew:

```
brew tap jscaltreto/tap
brew install downstage
```

## LSP Features

- Semantic syntax highlighting
- Document outline (acts, scenes, characters)
- Hover info on character names
- Go-to-definition (jump to dramatis personae entry)
- Diagnostics (parse errors, unknown character warnings)

## Configuration

Call `require("downstage").setup()` to configure the plugin explicitly.

If your plugin manager does not infer the main module correctly from the repo
name, set `main = "downstage"` in your plugin spec.

Options:

- `cmp = true`: if `nvim-cmp` is installed, limit Downstage completion sources
  to `nvim_lsp` for `downstage` buffers

## License

[MIT](https://github.com/jscaltreto/downstage/blob/main/LICENSE)
