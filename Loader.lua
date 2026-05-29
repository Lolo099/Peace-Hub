-- [[ Peace Hub - Official Loader ]]
-- هذا الملف يتعرف على اللعبة تلقائياً ويجلب السكربت المناسب من حسابك

local script_mode = "PVP" -- الخيارات المتوفرة: "PVP" أو "FARM"

local scripts = {
    [6765805766] = { -- معرف لعبة Block Spin
        PVP  = "https://raw.githubusercontent.com/Lolo099/Peace-Hub/main/BlockSpin_PVP.lua",
        FARM = "https://raw.githubusercontent.com/Lolo099/Peace-Hub/main/BlockSpin_PVP.lua", -- مؤقتاً يفتح نفس الملف
    }
}

local cfg = scripts[game.GameId]
if not cfg then
    game:GetService("Players").LocalPlayer:Kick("Peace Hub: هذه اللعبة غير مدعومة حالياً!")
    return
end

-- جلب وتشغيل السكربت المناسب من حسابك على جيتهاب
local targetScript = cfg[(script_mode or "PVP"):upper()] or cfg.PVP
loadstring(game:HttpGet(targetScript))()
