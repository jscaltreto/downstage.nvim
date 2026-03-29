local M = {}
local state = {
  lsp = false,
  cmp = false,
  cmp_autocmd = false,
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
  local compare = require("cmp.config.compare")

  cmp.setup.filetype("downstage", {
    completion = {
      autocomplete = {
        cmp.TriggerEvent.InsertEnter,
        cmp.TriggerEvent.TextChanged,
      },
      keyword_length = 0,
    },
    sources = {
      {
        name = "nvim_lsp",
        keyword_length = 0,
      },
    },
    sorting = {
      priority_weight = 1,
      comparators = {
        compare.sort_text,
        compare.order,
      },
    },
  })

  if state.cmp_autocmd then
    return
  end

  local group = vim.api.nvim_create_augroup("DownstageCmp", { clear = true })
  vim.api.nvim_create_autocmd({ "InsertEnter", "TextChangedI" }, {
    group = group,
    callback = function(args)
      if vim.bo[args.buf].filetype ~= "downstage" then
        return
      end

      local line = vim.api.nvim_get_current_line()
      if line ~= "" then
        return
      end

      vim.schedule(function()
        if vim.api.nvim_get_current_buf() ~= args.buf then
          return
        end
        if vim.bo[args.buf].filetype ~= "downstage" then
          return
        end
        if vim.api.nvim_get_current_line() ~= "" then
          return
        end
        cmp.complete()
      end)
    end,
  })
  state.cmp_autocmd = true
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
