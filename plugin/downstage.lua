if vim.g.loaded_downstage == 1 then
  return
end

vim.g.loaded_downstage = 1

require("downstage").setup()
