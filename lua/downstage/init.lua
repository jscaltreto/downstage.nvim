local M = {}
local state = {
  lsp = false,
  cmp = false,
}

local function setup_lsp()
  vim.lsp.config("downstage", {
    cmd = { "downstage", "lsp" },
    filetypes = { "downstage" },
    root_markers = { ".git" },
  })
  vim.lsp.enable("downstage")
end

local function setup_cmp()
  local ok, cmp = pcall(require, "cmp")
  if not ok then
    return
  end

  cmp.setup.filetype("downstage", {
    sources = {
      { name = "nvim_lsp" },
    },
  })
end

function M.setup(opts)
  opts = opts or {}

  if not state.lsp then
    setup_lsp()
    state.lsp = true
  end

  if opts.cmp and not state.cmp then
    setup_cmp()
    state.cmp = true
  end
end

return M
