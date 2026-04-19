-- LSP Java extensions.
return {
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    -- I only need this on Mac.
    enabled = function()
      return vim.uv.os_uname().sysname == 'Darwin'
    end,
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'java',
        callback = function()
          local mason_bin = vim.fn.stdpath 'data' .. '/mason/bin/jdtls'
          local cmd = { mason_bin }

          -- Configure the data (workspace) directory for the project.
          local root_dir = vim.fs.root(0, { 'gradlew', '.git', 'pom.xml', 'build.gradle' })
          local project_name = root_dir and vim.fs.basename(root_dir)
          if project_name then
            vim.list_extend(cmd, {
              '-data',
              vim.fn.stdpath 'cache' .. '/jdtls/' .. project_name .. '/workspace',
            })
          end

          require('jdtls').start_or_attach {
            cmd = cmd,
            root_dir = root_dir,
            settings = {
              java = {
                inlayHints = {
                  parameterNames = { enabled = 'all' },
                },
              },
            },
          }
        end,
      })
    end,
  },
}
