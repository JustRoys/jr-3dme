local Core = exports.vorp_core:GetCore()

local T = Translation.Langs[Config.Language]

RegisterServerEvent('jr-3dme:shareDisplay')
AddEventHandler('jr-3dme:shareDisplay', function(text)
	TriggerClientEvent('jr-3dme:triggerDisplay', -1, text, source)

	if Config.Logs.Enable then
		local Webhook = Config.Logs.Webhook
		local Title = T.Me
		local Message = "**"..GetPlayerName(source) .. "** "..T.Said.. " "..text..""

		SendWebhookMessage(Webhook, Title, Message, text)
	end
end)

--------------------------------------------------------------------------------------------------
function SendWebhookMessage(Webhook, Title, Message, text)
    PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({
        embeds = {
            {
                ["color"] = Config.Logs.Color,
                ["author"] = {
                    ["name"] = Config.Logs.Name,
                    ["icon_url"] = Config.Logs.Logo
                },
                ["title"] = Title,
                ["description"] = Message,
                ["footer"] = {
                    ["text"] = ""..Config.Logs.FooterText.." " .. " • " .. os.date("%x %X %p"),
                    ["icon_url"] = Config.Logs.FooterLogo,
                },
            },
        },
        avatar_url = Config.Logs.Avatar
    }), {
        ['Content-Type'] = 'application/json'
    })
end