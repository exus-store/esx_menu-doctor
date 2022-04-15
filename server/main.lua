ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('basia:revive')
AddEventHandler('basia:revive', function()
    TriggerClientEvent('esx_ambulancejob:revive', source)
end)


RegisterServerEvent('basia:pay')
AddEventHandler('basia:pay', function(data)
    xPlayer = ESX.GetPlayerFromId(source)

    if Config.removeMoneyheal then
        if data == 10 then
            xPlayer.removeMoney(Config.priceHeal)
        elseif data == 20 then
            xPlayer.removeAccountMoney('bank', Config.priceHeal)
        end
    else
        return
    end
end)

RegisterServerEvent('basia:revivepay')
AddEventHandler('basia:revivepay', function(data)
    xPlayer = ESX.GetPlayerFromId(source)
    if Config.removeMoneyrevive then
        if Config.revivefee then
            if data == 10 then
                xPlayer.removeMoney(Config.priceRevive)
            elseif data == 20 then
                xPlayer.removeAccountMoney('bank', Config.priceRevive)
            end
        else
            if data == 10 then
                xPlayer.removeMoney(Config.priceHeal)
            elseif data == 20 then
                xPlayer.removeAccountMoney('bank', Config.priceHeal)
            end
        end
    else
        return
    end
end)