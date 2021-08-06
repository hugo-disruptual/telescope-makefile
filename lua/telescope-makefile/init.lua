print("Hello world")


function get_root_path()
    if lvim.builtin.rooter.active then
    vim.cmd "let root_dir = FindRootDirectory()"
    return vim.api.nvim_get_var "root_dir"
  end
end

local function makefile_exists()
   local f=io.open(get_root_path().."/Makefile","r")
   if f~=nil then io.close(f) return true else return false end
end

local function is_command(line)
  local tab = "\t"
  local semicolon = ":"
  return line:sub(1, #tab) ~= tab and line:sub(-#semicolon) == semicolon
end

local function get_makefile_commands()
  if not makefile_exists() then return {} end
  local makefile_path = get_root_path().."/Makefile"
  local commands = {}
  for line in io.lines(makefile_path) do
    if is_command(line) then
      commands[#commands+1] = line:sub(1, -2)
    end
  end
end

return {
  get_makefile_commands = get_makefile_commands,
  makefile_exists = makefile_exists
}
