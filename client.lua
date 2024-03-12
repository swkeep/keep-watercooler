local IneractionMenu = exports.interactionMenu
local isDrinking = false
local model = `prop_watercooler`

local function setDrinkingFlag(v)
    isDrinking = v
end

local function drink(entity)
    if isDrinking then return end

    TriggerServerEvent('keep-watercooler:server:drink', GetEntityCoords(entity))
    TriggerEvent('keep-watercooler:client:emote', entity, setDrinkingFlag)
end

local function createInteractionMenuForInteractionMenu()
    IneractionMenu:Create {
        model = model,
        offset = vec3(0, 0, 0.8),
        maxDistance = 2.0,
        indicator = {
            prompt   = 'E',
            keyPress = {
                padIndex = 0,
                control = 38
            },
        },
        options = {
            {
                label = 'Drink',
                icon = 'fa fa-faucet-drip',
                action = {
                    func = function(entity)
                        drink(entity)
                    end
                }
            }
        }
    }
end

local function createInteractionMenuForQBTarget()
    exports['qb-target']:AddTargetModel(model, {
        options = {
            {
                num = 1,
                icon = 'fa fa-faucet-drip',
                label = 'Drink',
                targeticon = 'fa fa-faucet-drip',
                action = function(entity)
                    drink(entity)
                end
            }
        },
        distance = 2.5,
    })
end

local function createInteractionMenuForOxTarget()
    exports.ox_target:addModel(model, {
        {
            name = 'police',
            icon = 'fa fa-faucet-drip',
            label = 'Drink',
            onSelect = function(data)
                local ent = data.entity

                drink(ent)
            end
        }
    })
end

local function createInteractionMenu()
    local t = Config.target

    if t == 'interactionMenu' then
        createInteractionMenuForInteractionMenu()
    elseif t == 'qb-target' then
        createInteractionMenuForQBTarget()
    elseif t == 'ox_target' then
        createInteractionMenuForOxTarget()
    end
end

CreateThread(function()
    Wait(1000)

    createInteractionMenu()
end)
