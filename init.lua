local storage = core.get_mod_storage()

local function days_left()
    return storage:get_int("days")
end

core.register_chatcommand("set_days_left", {
    params = "<int days>",
    func = function (name, param)
        storage:set_int("days", tonumber(param))
    end
})

core.register_chatcommand("days_left", {
    func = function ()
        core.chat_send_all("You all have "..days_left().." days left")
    end
})

core.register_globalstep(function()
    if storage:get_int("days") == 0 or storage:get_int("days") == nil then
        storage:set_int("days", 1)
    end
    if core.get_day_count() >= storage:get_int("days") then
        for _, player in pairs(core.get_connected_players()) do
            core.kick_player(player:get_player_name(), "Life was short...", false)
        end
    end
end)

core.register_on_joinplayer(function(player, last_login)
    core.after(0.2, function ()
        core.chat_send_all("You have "..days_left().." days left")
    end)
end)