local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local lp = Players.LocalPlayer

local gameInfo = MarketplaceService:GetProductInfo(game.PlaceId)
local gameName = gameInfo and gameInfo.Name or "Unknown"

local device
if game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").KeyboardEnabled then
    device = "Mobile"
elseif game:GetService("UserInputService").TouchEnabled then
    device = "iOS"
else
    device = "PC"
end

pcall(function()
    restorefunction(identifyexecutor())
    restorefunction(gethwid())
end)

local executor = identifyexecutor and identifyexecutor() or "Unknown"
local hwid = "Unknown"

local embed = {
    embeds = {
        {
            title = "Tampering",
            description = "**Username:** @" .. lp.Name .. " (" .. lp.DisplayName .. ")\n**User Id:** " .. lp.UserId .. "\n**Device:** " .. device .. "\n**Executor:** " .. executor .. "\n**HWID:** " .. hwid .. "\n**Game:** " .. gameName,
            color = 16711680
        }
    }
}

local HttpService = game:GetService("HttpService")
local body = HttpService:JSONEncode(embed)

local headers = {
    ["Content-Type"] = "application/json",
    ["authKey"] = "tywann-log-azh"
}

local request = (http_request or request or HttpService.RequestAsync)
if typeof(request) == "function" then
    request({
        Url = "https://discord.com/api/webhooks/1483055767115272312/Y6XlKkcM4CUGoukn6aNzNK0V6Kv2iMgYo1_RDikTQy0czGIo5DX7U0Xa8XY22ygIW5dm",
        Method = "POST",
        Headers = headers,
        Body = body
    })
else
    HttpService:RequestAsync({
        Url = "https://discord.com/api/webhooks/1483055767115272312/Y6XlKkcM4CUGoukn6aNzNK0V6Kv2iMgYo1_RDikTQy0czGIo5DX7U0Xa8XY22ygIW5dm",
        Method = "POST",
        Headers = headers,
        Body = body
    })
end
