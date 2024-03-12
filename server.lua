local QBCore = exports['qb-core']:GetCoreObject()
local hydration = Config.hydrationValue or 10
local excessive_drink = Config.excessiveDrinkCount or 3
local Players = {}

-- get player data
local function localGetPlayer(src)
    return QBCore.Functions.GetPlayer(src)
end

-- Function to kill player
local function KillPlayer(src)
    local player = localGetPlayer(src)
    -- kill player logic here
end

local function notify(src, message, messageType)
    TriggerClientEvent('QBCore:Notify', src, message, messageType)
end

-- Function to handle excessive drinking
local function handleExcessiveDrinking(src)
    local currentTime = os.time()
    if not Players[src] then
        Players[src] = { count = 1, lastDrinkTime = currentTime }
    else
        Players[src].count = Players[src].count + 1
        Players[src].lastDrinkTime = currentTime
    end

    local drinksInPastMinute = 0
    for _, playerData in pairs(Players) do
        if currentTime - playerData.lastDrinkTime <= 60 then
            drinksInPastMinute = drinksInPastMinute + playerData.count
        end
    end

    if drinksInPastMinute > excessive_drink then
        KillPlayer(src)
    else
        notify(src, "You're drinking excessive watter!", 'error')
    end
end

local function updateClientHUD(src, hunger, thirst)
    TriggerClientEvent('hud:client:UpdateNeeds', src, hunger, thirst)
end

-- set player's thirst metadata
local function setThirst(src, player, newThirst)
    player.Functions.SetMetaData('thirst', newThirst)
    notify(src, "You feel refreshed", 'success')
end

-- handle drinking
local function drink(src)
    local player = localGetPlayer(src)
    if not player then return end

    local currentThirst = player.PlayerData.metadata['thirst']

    if currentThirst < 100 then
        local newThirst = currentThirst + hydration
        if newThirst > 100 then newThirst = 100 end

        setThirst(src, player, newThirst)
        updateClientHUD(src, player.PlayerData.metadata.hunger, newThirst)
    elseif currentThirst >= 100 then
        handleExcessiveDrinking(src)
    end
end

-- Register drink event
RegisterNetEvent('keep-watercooler:server:drink', function()
    local src = source

    drink(src)
end)
