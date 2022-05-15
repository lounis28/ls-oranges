local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('ls-oranges:server:ApanharLaranjas', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local quantity = Config.OrangesPickQuantity
    local item = Config.OrangeSpawnName

    Player.Functions.AddItem(item, quantity)
end)


RegisterNetEvent('ls-oranges:server:ProcessarLaranjas', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local oranges = Player.Functions.GetItemByName(Config.OrangeSpawnName)
    local ojitem = Config.OrangeJuiceSpawnName
    if oranges ~= nil then

    if oranges.amount >= 1 then
        Player.Functions.RemoveItem(Config.OrangeSpawnName, 1)
        Player.Functions.AddItem(ojitem, 5)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[ojitem], "add")
    else
        TriggerClientEvent("QBCore:Notify", src, "You do not have any oranges...", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "You do not have any oranges...", "error")
    end
end)


local ItemList = {
    [Config.OrangeJuiceSpawnName] =  Config.JuiceSellPrice,
}

RegisterNetEvent('ls-oranges:server:VenderSumo', function()
    local src = source
    local price = 0
    local Player = QBCore.Functions.GetPlayer(src)
    
    local xItem = Player.Functions.GetItemsByName(ItemList)
    if xItem ~= nil then
        for k, v in pairs(Player.PlayerData.items) do
            if Player.PlayerData.items[k] ~= nil then
                if ItemList[Player.PlayerData.items[k].name] ~= nil then
                    price = price + (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)

        Player.Functions.AddMoney("cash", price, "sold-fish")
            TriggerClientEvent('QBCore:Notify', src, "You earn $"..price)
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont/'t have anything to sell..")
    end
end)