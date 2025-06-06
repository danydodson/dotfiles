local scales = {0.5, 0.75, 1, 1.25, 1.5, 2} -- choose menu values
local keyword = 'window-scale'

-- menu_window_scale.lua mpv script,
-- by butterw (2024-01-18)
--
-- Simple custom dynamic menu example using mpv-menu-plugin v2.1 with dyn_menu.lua, req mpv0.37 on windows.
-- Adds a Scale menu populated with window-scale values (configured in scales variable), this script ensures the current value is checked.
-- input.conf: _ ignore #menu: Scale #@window-scale
-- Screenshot: https://github.com/butterw/bShaders/commit/2484df7cfcdedfa1be8d513ab603ed92e83d275f

local utils = require('mp.utils')
local function printd(pre, x) print(pre, utils.to_string(x)) end --printd("x:", x)

-- initial menu setup
local submenu={}
for _, elt in ipairs(scales) do
    local pre = elt==1 and '=' or '' --adds '=' menu accelerator for the value 1.0
    submenu[#submenu + 1] = {
        title = pre..elt ..'x',
        cmd = string.format('set fullscreen no; set window-scale %s', elt), -- the command that will be applied. 
        state = {}
    }
end

-- wait until the menu is ready, then get menu info for desired keywords 
mp.register_script_message('menu-ready', function()
    -- print('menu-ready');
    mp.commandv('script-message-to', 'dyn_menu', 'get', keyword, mp.get_script_name())
end)

-- if keyword is present (in input.conf), observe property window-scale 
mp.register_script_message('menu-get-reply', function(data)
    local reply = utils.parse_json(data)
    -- printd("reply:", reply)
    -- printd("error:", reply.error)
    if not reply.error and reply.keyword == keyword then mp.observe_property(keyword, 'native', window_scale_checklist_cb) end
end)

-- update checked state of submenu entries based on window-scale value
function window_scale_checklist_cb(_, value)
    -- print(_, value)
    if value == nil then return end

    for i, elt in ipairs(scales) do
        local state = elt==value and {'checked'} or {}
        submenu[i].state = state
    end
    local item = {type='submenu'}
    item.submenu = submenu
    -- printd("item:", item)
    mp.commandv('script-message-to', 'dyn_menu', 'update', keyword, utils.format_json(item))
end
