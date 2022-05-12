
ESX = nil
local PlayerData = {}
local group 

kick = 1800
kickostrzezenie = true

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    PlayerData = ESX.GetPlayerData()
end)






RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)


function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function Display(mePlayer, text, offset)
    local displaying = true
    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
            DrawText3D(coords['x'], coords['y'], coords['z']+offset, text)
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end


local zawiadamia = false
local zawiadamia2 = false


--Szpitale
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local Gracz = GetPlayerPed(-1)
        local PozycjaGracza = GetEntityCoords(Gracz)
        local Dystans = GetDistanceBetweenCoords(PozycjaGracza, 305.2769, -594.5262, 42.2841, true) 
        if Dystans <= 6 then
            local PozycjaTekstu= {
                ["x"] = 305.2769,
                ["y"] = -594.5262,
                ["z"] = 43.2841
            }
		DrawMarker(6, 305.2769, -594.5262, 42.2841, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 2.0, 2.0, 2.0, 252, 16, 12, 100,false, false, 2, false, false)			
           ESX.Game.Utils.DrawText3D(PozycjaTekstu, "NACIŚNIJ [~r~E~s~] ABY WEZWAĆ MEDYKA", 0.45, 1.0, "~b~DZWONEK", 0.7)
		   
            if IsControlJustPressed(0, 38) and Dystans <= 1.5 and zawiadamia2 == false then
                TriggerEvent('pNotify:SendNotification', {text = 'Wysłano zawiadomienie!'})
                TriggerEvent('pNotify:SendNotification', {text = 'Następny raz będziesz mógł/mogła użyć dzwonka za dwie minuty.'})

                zawiadamia2 = true			
				if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
					TriggerEvent('chat:addMessage', {
						template = '<div style="padding: 0.4vw; margin: 0.5vw;transform: skewX( -9deg ); font-size: 15px; background-color: rgba(140, 14, 8, 1.0); border-radius: 3px;"><i class="fas fa-bullhorn"></i>&nbsp;[{0}] Ktoś wzywa medyka na szpital</div>',
						args = { 'Szpital', message }
					})
				end
                Citizen.Wait(120 * 1000)
                zawiadamia2 = false
            end
        end
    end
end)



--Komenda

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local Gracz = GetPlayerPed(-1)
        local PozycjaGracza = GetEntityCoords(Gracz)
        local Dystans = GetDistanceBetweenCoords(PozycjaGracza, 441.17, -983.1, 29.69, true) 
        if Dystans <= 6 then
            local PozycjaTekstu= {
                ["x"] = 441.17,
                ["y"] = -983.1,
                ["z"] = 30.69
            }
		DrawMarker(6, 441.17, -983.1, 29.69, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 2.0, 2.0, 2.0, 0, 223, 162, 162,false, false, 2, false, false)				
           ESX.Game.Utils.DrawText3D(PozycjaTekstu, "NACIŚNIJ [~b~E~s~] ABY WEZWAĆ POLICJANTA", 0.75, 1.0, "~b~DZWONEK", 0.7)
            if IsControlJustPressed(0, 38) and Dystans <= 1.5 and zawiadamia2 == false then
                TriggerEvent('pNotify:SendNotification', {text = 'Wysłano zawiadomienie!'})
                TriggerEvent('pNotify:SendNotification', {text = 'Następny raz będziesz mógł/mogła użyć dzwonka za dwie minuty.'})

                zawiadamia2 = true			
				if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
					TriggerEvent('chat:addMessage', {
						template = '<div style="padding: 0.4vw; margin: 0.5vw;transform: skewX( -9deg ); font-size: 15px; background-color: rgba(140, 14, 8, 1.0); border-radius: 3px;"><i class="fas fa-bullhorn"></i>&nbsp;[{0}] Ktoś wzywa policjanta na komende</div>',
						args = { 'Komenda', message }
					})
				end
                Citizen.Wait(120 * 1000)
                zawiadamia2 = false
            end
        end
    end
end)




