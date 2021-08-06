local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_set = require("telescope.actions.set")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local telescope_makefile = require("telescope-makefile")

local telescope_makefile = function(opts)
  pickers.new(opts, {
    prompt_title = "Makefile",
    finder = finders.new_table(telescope_makefile.get_makefile_commands()),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(_, map)
      map('i', '<cr>', actions.set_command_line)
      return true
    end
  }):find()
end

return require("telescope").register_extension(
  {
    exports = {
      telescope_makefile = telescope_makefile,
    }
  }
)
