return {
  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { right = 0, left = 1 },
          },
          {
            'filename',
            file_status = true,    -- Displays file status (readonly status, modified status)
            newfile_status = true, -- Display new file status (new file means no write after created)
            path = 1,              -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory

            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = ' ❗❗❗', -- Text to show when the buffer is modified
              readonly = ' 🔒',    -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]',
            },
          }
        },
        lualine_x = {
          {
            function()
              return vim.fn["codeium#GetStatusString"]()
            end
          }

        }
      },
    },
  },
}
