if not script_key or script_key == "" or script_key == nil then
    error("Script key pls?")
    return
end

local Players               = game:GetService("Players")
local player                = Players.LocalPlayer
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

local StarterGui = game:GetService("StarterGui")

do
    -- check key baru coy
    --[[local httpKeyWoi = (syn and syn.request) or (http and http.request) or request or http_request

    if not httpKeyWoi then
        player:Kick("Executor doesnt have request function")
        return
    end

    if not script_key or script_key == "" then
        player:Kick("script_key not found.")
        return
    end

    local HttpService = game:GetService("HttpService")

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
    end]]

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

        --[[DataUser.DiscordUsername = data.discordUsername
        DataUser.DiscordId = data.discordId]]

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
            local regSuccess, regResponse = pcall(function()
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
            end

            Notify("Welcome", "Key verified. HWID registered.")

        else
            if hwidData.hwid ~= hwid then
                player:Kick("HWID mismatch. Use the correct device or reset your HWID.")
                return
            end

            Notify("Welcome back", data.discordUsername)
        end
    end
end

if not identifyexecutor or identifyexecutor == "" or identifyexecutor == nil then
    error("Error 1 pls")
    return
end 

if not game:IsLoaded() then
    game.Loaded:Wait()
end

if identifyexecutor then
    local execName = tostring(identifyexecutor()):lower()
    if execName:find("solara") or execName:find("xeno") then
        game:GetService("Players").LocalPlayer:Kick("Sorry, SannSunner doesnt support Xeno and Solara executor :)")
        return
    end
else
    error("Error 2 pls")
    return
end

local loaderTar = 'https://www.sannsunner.my.id/api/loader?code='

local games = {
    [5177284] = "Eagle Nation",
    [11378976] = "Drag Drive Simulator",
    [10884667] = "Car Driving Indonesia",
}

local gamePlace = {
    -- Eagle Nation
    [129118369937980]       = "eaglenation", -- Eagle Nation
    -- [74423336467047]        = "", -- JAPAN
    -- [96406930226950]        = "", -- AFK

    -- Drag Drive Simulator
    [131378148336503]       = "dds", -- EVENT x LIMITED UPDATE
    [122318572211216]       = "dds", -- Pettarani Track
    [114862923457266]       = "dds", -- Mandalika Circuit
    [114069860751320]       = "dds", -- Sentul Circuit
    [115335745596349]       = "dds", -- Bandung

    -- Car Driving Indonesia
    [6911148748]            = "cdid", -- Main Menu
    [79488788685813]        = "cdid", -- Bandung
    [110369730911937]       = "cdid", -- Jawa Timur
    [118108582994420]       = "cdid", -- Bali
    [14005966837]           = "cdid", -- Jakarta
    [9508940498]            = "cdid", -- Jawa Tengah
    [9233343468]            = "cdid", -- Jawa Barat
    [132986577553100]       = "cdid", -- Seasonal
}

local gameName = games[game.CreatorId]

if not gameName then
    return print("Sorry, SannSunner doesnt have this place or maybe suggest it?")
end

local file = gamePlace[game.PlaceId]

if not file then
    return print("Sorry, SannSunner doesnt have this place or maybe suggest it??")
end

if file == "" then
    return print("Sorry, SannSunner doesnt have this place script, please wait next update!")
end

print("Loading " .. gameName)

if file then
    task.wait(math.random())
    -- loadstring(game:HttpGet(loaderTar..file))()
    --[[local success, err = pcall(function()
        getgenv().script_key = script_key
        local loadScript = string.format('script_key = "%s";\n%s', script_key, game:HttpGet(loaderTar..file))
        loadstring(loadScript)()
    end)]]
    local success, err = pcall(function()
        getgenv().script_key = script_key

        local HWID_player
        pcall(function()
            HWID_player = game:GetService("RbxAnalyticsService"):GetClientId()
        end)

        local rawScript = httpKeyWoi({
            Url = loaderTar .. file .. "&key=" .. game:GetService("HttpService"):UrlEncode(script_key),
            Method = "GET",
            Headers = {
                ["x-hwid"] = HWID_player or ""
            }
        })

        local body = rawScript.Body or rawScript.body
        if not body or body == "" then
            error("Empty response from loader")
        end

        local loadScript = string.format('script_key = "%s";\n%s', script_key, body)
        loadstring(loadScript)()
    end)
    if not success then
        return print("Failed to execute script")
    end
end
