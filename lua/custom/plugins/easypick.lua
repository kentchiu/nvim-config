return {
  'axkirillov/easypick.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim'
  },
  config = function()
    local easypick = require("easypick")

    -- only required for the example to work
    local base_branch = "develop"

    local list_make_targets = [[
make -qp |
awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}' |
grep -wv Makefile
]]

    -- a list of commands that you want to pick from
    local list = [[
<< EOF
:PackerInstall
:Telescope find_files
:Git blame
EOF
]]
    easypick.setup({
      pickers = {
        -- add your custom pickers here
        -- below you can find some examples of what those can look like

        -- list files inside current folder with default previewer
        {
          -- name for your custom picker, that can be invoked using :Easypick <name> (supports tab completion)
          name = "ls",
          -- the command to execute, output has to be a list of plain text entries
          command = "ls",
          -- specify your custom previwer, or use one of the easypick.previewers
          previewer = easypick.previewers.default()
        },

        -- diff current branch with base_branch and show files that changed with respective diffs in preview
        {
          name = "changed_files",
          command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
          previewer = easypick.previewers.branch_diff({ base_branch = base_branch })
        },

        -- list files that have conflicts with diffs in preview
        {
          name = "conflicts",
          command = "git diff --name-only --diff-filter=U --relative",
          previewer = easypick.previewers.file_diff()
        },
        {
          name = "make_targets",
          command = list_make_targets,
          action = easypick.actions.nvim_command("!make"),
          opts = require('telescope.themes').get_dropdown({})
        },
        {
          name = "command_palette",
          command = "cat " .. list,
          -- pass a pre-configured action that runs the command
          action = easypick.actions.nvim_command(),
          -- you can specify any theme you want, but the dropdown looks good for this example =)
          opts = require('telescope.themes').get_dropdown({})
        }
      }
    })
  end,
}
