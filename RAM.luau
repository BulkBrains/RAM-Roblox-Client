local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local URL = "https://ram.bulkbrains.com/api/fetchPlayer"

Players.PlayerAdded:Connect(function(player)
	local id = player.UserId
	local key = script:GetAttribute("ConnectionKey")
	
	local data = "player=" .. id .. "&key=" .. key
	
	local response
	local success, err = pcall(function()
		response = HttpService:PostAsync(URL, data, Enum.HttpContentType.ApplicationUrlEncoded)
	end)
	
	if success then
		if response == "found" then
			local config: BanConfigType = {
				UserIds = {id},
				Duration = -1,
				DisplayReason = "BulkBrains RAM has banned your account for behaviour that is against Roblox's ToS",
				PrivateReason = "BulkBrains RAM",
				ExcludeAltAccounts = true,
				ApplyToUniverse = true
			}
			
			Players:BanAsync(config)
		end
	else
		warn("BulkBrains RAM Error: " .. err)
	end
end)
