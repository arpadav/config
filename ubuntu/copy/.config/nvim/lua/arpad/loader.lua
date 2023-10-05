local M = {}

M.load__vimscripts = function()
    local scripts = {}
    local p = io.popen("ls ~/.config/nvim/lua/arpad/")
    for filename in p:lines() do
    -- if the file ends in .vim, append to scripts
	if filename:match("%.vim$") then
            table.insert(scripts, "~/.config/nvim/lua/arpad/".. filename)
        end
    end
    -- add script to source
    for _, script in ipairs(scripts) do
        vim.cmd("source " .. script)
    end
end

return M

