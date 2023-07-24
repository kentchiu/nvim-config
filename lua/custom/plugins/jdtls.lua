return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      -- local JDTLS_LOCATION = "/home/kent/.local/share/nvim/mason/bin/jdtls"
      local JDTLS_LOCATION = vim.fn.stdpath "data" .. "/mason/bin/jdtls"
      local config = {
        cmd = { JDTLS_LOCATION},
        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
      }
      require('jdtls').start_or_attach(config)
    end
  },
}
