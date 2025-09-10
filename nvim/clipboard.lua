
-- change current working dir
vim.keymap.set("n", "<leader>.", function()
  vim.cmd("cd %:h")
  print("Changing directory to: " .. vim.fn.getcwd())
end, { desc = "Change CWD to current file directory" })

-- change CWD to parent
vim.keymap.set("n", "<leader>,", function()
  local current_file_dir = vim.fn.expand("%:p:h")
  local parent_dir = vim.fn.fnamemodify(current_file_dir, ":h")
  if parent_dir ~= "" and parent_dir ~= "." then -- Avoid changing to root or current dir unnecessarily
    print("Changing directory to: " .. parent_dir)
    vim.cmd("cd " .. parent_dir)
  end
end, { desc = "Change CWD to parent directory of current file" })
