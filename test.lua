local Players = cloneref(game:GetService("Players"))
local MarketplaceService = cloneref(game:GetService("MarketplaceService"))
local HttpService = cloneref(game:GetService("HttpService"))
local lp = Players.LocalPlayer

-- 1. Gather Info
local gameInfo = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
local gameName = (typeof(gameInfo) == "table" and gameInfo.Name) or "Unknown"

local device = "PC"
if game:GetService("UserInputService").TouchEnabled then
    device = game:GetService("UserInputService").KeyboardEnabled and "iOS/Tablet" or "Mobile"
end

local executor = (identifyexecutor and identifyexecutor()) or "Unknown"

-- 2. Build the Payload (No Webhook URL here!)
local payload = {
    embeds = {
        {
            title = "🛡️ Tampering / Execution Log",
            description = string.format(
                "**User:** @%s (%s)\n**ID:** %d\n**Device:** %s\n**Executor:** %s\n**Game:** %s",
                lp.Name, lp.DisplayName, lp.UserId, device, executor, gameName
            ),
            color = 0xff4d4d -- Red
        }
    }
}

-- 3. Send to Worker
local workerUrl = "http://coding-ai.mirbekaskarbek6.workers.dev" -- REPLACE WITH YOUR WORKER URL
local request = (syn and syn.request) or (http and http.request) or http_request or request

local success, response = pcall(function()
    return request({
        Url = workerUrl,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json",
            ["authKey"] = "tywann-log-azh"
        },
        Body = HttpService:JSONEncode(payload)
    })
end)

-- 4. Execute the returned script (The GitHub content)
if success and response.StatusCode == 200 then
    local load = loadstring(response.Body)
    if load then
        task.spawn(load)
    end
else
    warn("Failed to verify authentication.")
end
