-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"

local neoscroll = require "neoscroll"
local keymap = {
  ["<C-u>"] = function() neoscroll.ctrl_u { duration = 250 } end,
  ["<C-d>"] = function() neoscroll.ctrl_d { duration = 250 } end,
  ["<C-b>"] = function() neoscroll.ctrl_b { duration = 450 } end,
  ["<C-f>"] = function() neoscroll.ctrl_f { duration = 450 } end,
  ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 }) end,
  ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor = false, duration = 100 }) end,
  ["zt"] = function() neoscroll.zt { half_win_duration = 250 } end,
  ["zz"] = function() neoscroll.zz { half_win_duration = 250 } end,
  ["zb"] = function() neoscroll.zb { half_win_duration = 250 } end,
}
local modes = { "n", "v", "x" }
for key, func in pairs(keymap) do
  vim.keymap.set(modes, key, func)
end

require("nvim-toggler").setup()
local wk = require "which-key"

-- Mini Nvim
require("mini.indentscope").setup()
require("mini.surround").setup()
require("mini.cursorword").setup()
require("mini.map").setup()

-- Mini Nvim Keymap
wk.add {
  { mode = "n" },
  { "<leader>m", group = "MiniMap" },
  { "<leader>mo", function() MiniMap.open() end, desc = "Open" },
  { "<leader>mc", function() MiniMap.close() end, desc = "Close" },
  { "<leader>mf", function() MiniMap.toggle_focus() end, desc = "Toggle Focus" },
  { "<leader>mr", function() MiniMap.open() end, desc = "Refesh" },
  { "<leader>ms", function() MiniMap.open() end, desc = "Toggle Side" },
  { "<leader>mt", function() MiniMap.open() end, desc = "Toggle" },
}

-- CodeSnap Keymap
wk.add {
  {
    mode = "v",
    { "<leader>c", group = "CodeSnap" },
    { "<leader>cc", "<cmd>sleep 100m<cr><cmd>CodeSnap<cr>", desc = "Save selected code snapshot into clipboard" },
    { "<leader>cs", "<cmd>CodeSnapSave<cr>", desc = "Save selected code snapshot in ~/Pictures" },
  },
}
