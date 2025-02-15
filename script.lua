local BlacklistModule = {}

BlacklistModule.BlacklistedUserIds = {}

BlacklistModule.BlacklistedGroupIds = {}

function BlacklistModule:IsUserBlacklisted(player)
    for _, userId in ipairs(self.BlacklistedUserIds) do
        if player.UserId == userId then
            return true
        end
    end
    return false
end

function BlacklistModule:IsPlayerInBlacklistedGroup(player)
    for _, groupId in ipairs(self.BlacklistedGroupIds) do
        local success, isInGroup = pcall(function()
            return player:IsInGroup(groupId)
        end)
        if success and isInGroup then
            return true
        end
    end
    return false
end

function BlacklistModule:CheckPlayer(player)
    if self:IsUserBlacklisted(player) then
        player:Kick("You, as a user, is blacklisted from this game. Please appeal by joining our discord server and making a ticket. discord.gg/eduhub.")
    elseif self:IsPlayerInBlacklistedGroup(player) then
        player:Kick("You are in a blacklisted group, please leave that group to be able to join this game. - EDUHUB BLACKLIST)")
    end
end

game.Players.PlayerAdded:Connect(function(player)
    BlacklistModule:CheckPlayer(player)
end)

return BlacklistModule
