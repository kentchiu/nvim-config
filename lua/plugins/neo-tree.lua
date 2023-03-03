return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        commands = {
          -- copy file name to system clipboard
          -- copy full path to register 1
          -- copy relative path to register 2
          copy_path = function(state)
            local node = state.tree:get_node()
            local full_path = node.path
            local relative_path = full_path:sub(#state.path + 2)
            vim.fn.setreg("*", node.name)
            vim.fn.setreg("1", full_path)
            vim.fn.setreg("2", relative_path)
          end,
        },
        window = {
          mappings = {
            ["Y"] = "copy_path",
          },
        },
      },
    },
  },
}
