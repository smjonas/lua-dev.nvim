local M = {}

--- @class LuaApiOptions
local default_opts = {
  library = {
    vimruntime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify a list of plugins to make available as a workspace library
    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
  runtime_path = false, -- enable this to get completion in require strings. Slow!
}

function M.setup(args)
  args = args or {}
  local opts = vim.tbl_deep_extend("force", {}, default_opts, args.opts or {})
  local lsp_config = require("lua-dev.sumneko").make_lsp_config(opts)
  lsp_config = vim.tbl_deep_extend("keep", {}, lsp_config, args.lsp_config or {})
  return lsp_config
end

return M
