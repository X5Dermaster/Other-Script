local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

local StarterGui = game:GetService("StarterGui")
local function Notify(title, message, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = message,
        Duration = duration or 5
    })
end

do
    local httpKeyWoi = request or http_request or syn.request

    if not httpKeyWoi then
        player:Kick("Executor doesnt have request function")
        return
    end

    if not script_key or script_key == "" or script_key == nil then
        player:Kick("script_key not found.")
        return
    end

    local success, response = pcall(function()
        return httpKeyWoi({
            Url = "https://www.sannsunner.my.id/api/check-validate-key?key=" .. HttpService:UrlEncode(script_key),
            Method = "GET"
        })
    end)

    if not success then
        player:Kick("Failed connect to API " .. tostring(response))
        return
    end

    local body = response.Body or response.body
    if not body then
        player:Kick("Server response nil")
        return
    end

    local ok, data = pcall(function()
        return HttpService:JSONDecode(body)
    end)

    if not ok then
        player:Kick("Something went wrong " .. tostring(data))
        return
    end

    if not data.valid then
        player:Kick("Key not valid.")
        return
    end

    DataUser.DiscordUsername = data.discordUsername
    DataUser.DiscordId = data.discordId

    local hwid = nil

    pcall(function()
        hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    end)

    if not hwid or hwid == "" or hwid == nil then
        player:Kick("Failed to get HWID from executor.")
        return
    end

    local hwidSuccess, hwidResponse = pcall(function()
        return httpKeyWoi({
            Url = "https://www.sannsunner.my.id/api/read-hwid?key=" .. HttpService:UrlEncode(script_key),
            Method = "GET"
        })
    end)

    if not hwidSuccess then
        player:Kick("Failed to connect to HWID API.")
        return
    end

    local hwidBody = hwidResponse.Body or hwidResponse.body
    if not hwidBody then
        player:Kick("HWID server response nil.")
        return
    end

    local hwidOk, hwidData = pcall(function()
        return HttpService:JSONDecode(hwidBody)
    end)

    if not hwidOk then
        player:Kick("HWID response parse error.")
        return
    end

    if hwidData.hwid == nil or hwidData.hwid == HttpService.null then
        --[[local regSuccess, regResponse = pcall(function()
            return httpKeyWoi({
                Url = "https://www.sannsunner.my.id/api/register-hwid",
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode({
                    key = script_key,
                    hwid = hwid
                })
            })
        end)

        if not regSuccess then
            player:Kick("Failed to register HWID.")
            return
        end

        local regBody = regResponse.Body or regResponse.body
        local regOk, regData = pcall(function()
            return HttpService:JSONDecode(regBody)
        end)

        if not regOk or not regData.ok then
            player:Kick("HWID registration failed.")
            return
        end]]

        Notify("Welcome", "Key verified. HWID registered.")

    else
        if hwidData.hwid ~= hwid then
            player:Kick("HWID mismatch. Use the correct device or reset your HWID.")
            return
        end

        Notify("Welcome back", data.discordUsername)
    end
end
