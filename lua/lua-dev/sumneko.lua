local M = {}

function M.library(opts)
  local ret = {}

  if opts.library.types then
    table.insert(ret, M.types())
  end

  local function add(lib, filter)
    for _, p in pairs(vim.fn.expand(lib .. "/lua", false, true)) do
      p = vim.loop.fs_realpath(p)
      if p and (not filter or filter[vim.fn.fnamemodify(p, ":h:t")]) then
        table.insert(ret, p)
      end
    end
  end

  if opts.library.vimruntime then
    add("$VIMRUNTIME")
  end

  if opts.library.plugins then
    local filter
    if type(opts.library.plugins) == "table" then
      filter = {}
      for _, p in pairs(opts.library.plugins) do
        filter[p] = true
      end
    end
    for _, site in pairs(vim.split(vim.o.packpath, ",")) do
      add(site .. "/pack/*/opt/*", filter)
      add(site .. "/pack/*/start/*", filter)
    end
  end

  return ret
end

function M.path(opts)
  local path = {} --vim.split(package.path, ";")
  table.insert(path, "?.lua")
  table.insert(path, "?/init.lua")
  -- if opts and opts.runtime_path then
  --   for lib, _ in pairs(M.library()) do
  --     table.insert(path, lib .. "/?.lua")
  --     table.insert(path, lib .. "/?/init.lua")
  --   end
  -- end
  return path
end

function M.config_path()
  return vim.loop.fs_realpath(vim.fn.stdpath("config"))
end

function M.types()
  local f = debug.getinfo(1, "S").source:sub(2)
  return vim.loop.fs_realpath(vim.fn.fnamemodify(f, ":h:h:h") .. "/types")
end

function M.make_lsp_config(opts)
  return {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = M.path(),
        },
        completion = { callSnippet = "Replace" },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = M.library(opts),
        },
      },
    },
  }
end

return M
