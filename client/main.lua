ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

CreateThread(function()
    while true do
        -- draw every frame
        Wait(0)

        local pedCoords = GetEntityCoords(PlayerPedId())
        DrawMarker(27, Config.LocalizationX, Config.LocalizationY, Config.LocalizationZ + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
    end
end)

local important = "dc: discord.gg/exus"
print(important)



Citizen.CreateThread(function()


	while true do
		Citizen.Wait(10)

		local ped = GetPlayerPed(-1)
		local vector = vector3(Config.LocalizationX, Config.LocalizationY, Config.LocalizationZ)
		local playercoord = GetEntityCoords(ped)
		--TriggerServerEvent('basia:x')
		

		if Vdist2(vector, playercoord) < 5 then

			ESX.ShowHelpNotification(Config.notifywelcome)

			if IsControlJustPressed(1, Config.ActiveButton) then


				OpenPayMenu()

			end
		end
	end
end)

function OpenPayMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'plc', {
		title = "metody płatności",
		align = "bottom-right",
		elements = {
			{label = "Gotowka", value = '10'},
			{label = "Karta", value = '20'}
		}
	}, function(data, menu)

			if data.current.value == '10' then
				TriggerEvent('basia:heal', 10)
				FreezeEntityPosition(GetPlayerPed(-1), true)
			elseif data.current.value == '20' then
				TriggerEvent('basia:heal', 20)
				FreezeEntityPosition(GetPlayerPed(-1), true)
			end
		
	end, function(data, menu)
		menu.close()
	end)
end

AddEventHandler('basia:heal', function(data)
	FreezeEntityPosition(ped, true)

	local ped = GetPlayerPed(-1)


	exports['mythic_notify']:DoHudText('inform', Config.healing1)

	Citizen.Wait(Config.Wait)

	exports['mythic_notify']:DoHudText('inform', Config.healing2)

	Citizen.Wait(Config.Wait)

	exports['mythic_notify']:DoHudText('inform', Config.healing3)

	Citizen.Wait(Config.Wait)

	exports['mythic_notify']:DoHudText('success', Config.success)

	Citizen.Wait(1000)

	TriggerServerEvent('basia:revive')

	Citizen.Wait(1000)

	FreezeEntityPosition(ped, false)

	--TriggerServerEvent('basia:pay')

	if GetEntityHealth(ped) == 0 then
		TriggerServerEvent('basia:revivepay', data)
	elseif GetEntityHealth(ped) >= 20 then
		TriggerServerEvent('basia:pay', data)
	end
end)