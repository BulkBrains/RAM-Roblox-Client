local HttpService = game:GetService("HttpService")

local URL = "https://ram.bulkbrains.com/api/fetchPlayer"

game:GetService("Players").PlayerAdded:Connect(function(player)
	local id = player.UserId
	local data = "player=" .. id
	
	local response
	local success, err = pcall(function()
		response = HttpService:PostAsync(URL, data, Enum.HttpContentType.ApplicationUrlEncoded)
	end)
	
	if success then
		if response == "found" then
			player:Kick("You have been kicked by BulkBrains RAM")
		end
	else
		warn("BulkBrains RAM Error: " .. err)
	end
end)
