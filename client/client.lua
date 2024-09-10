RegisterCommand(Config.Command.Command, function(source, args)
    local text = '*'

    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end

    text = text .. ' * '
    TriggerServerEvent('jr-3dme:shareDisplay', text)
end, false)

RegisterNetEvent('jr-3dme:triggerDisplay')
AddEventHandler('jr-3dme:triggerDisplay', function(text, source)
    Display(GetPlayerFromServerId(source), text)
end)

function Display(mePlayer, text)
    local displaying = true

    Citizen.CreateThread(function()
    	Wait(Config.Command.DisplayTime)
        displaying = false
    end)

    Citizen.CreateThread(function()
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)

            if dist < Config.Command.Distance then
                DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z'] + 1.0, text)
            end
        end
    end)
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    local factor = (string.len(text)) / 225

    if onScreen then
    	SetTextScale(0.30, 0.30)
  		SetTextFontForCurrentCommand(1)
    	SetTextColor(255, 143, 0, 100)
    	SetTextCentre(1)
    	DisplayText(str, _x, _y)
        DrawSprite("feeds", "toast_bg", _x, _y + 0.0125, 0.015 + factor, 0.03, 0.1, 20, 20, 20, 200, 0)
    end
end