-- [[ Peace Hub - Ultimate White Edition ]]
-- المطور: أنت (يمكنك تعديل اسم المطور أدناه)

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- إنشاء النافذة الرئيسية باسم Peace Hub باللون الأبيض
local Window = Fluent:CreateWindow({
    Title = "Peace Hub",
    SubTitle = "v1.0 - Clean & Fast",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- تأثير الخلفية الضبابية الفاخرة
    Theme = "Dark", -- الخلفية مظلمة لكي يبرز اللون الأبيض بوضوح
    MinimizeKey = Enum.KeyCode.RightControl -- زر إخفاء وإظهار القائمة
})

-- تخصيص عناصر الواجهة للون الأبيض النقي والأنيق
Fluent:SetTheme("Dark") -- تفعيل الثيم الأساسي
-- تعديل الألوان البرمجية ليصبح التحديد والتفاعل باللون الأبيض
Window.Root.TitleBar.Title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- إنشاء الأقسام الجانبية (Tabs) مع أيقونات متناسقة
local Tabs = {
    General = Window:AddTab({ Title = "General", Icon = "settings" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "swords" }),
    WeaponMod = Window:AddTab({ Title = "Weapon Mod", Icon = "zap" }),
    Cosmetic = Window:AddTab({ Title = "Cosmetic", Icon = "sparkles" }),
    Esp = Window:AddTab({ Title = "Esp", Icon = "eye" }),
    Vehicle = Window:AddTab({ Title = "Vehicle", Icon = "car" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "component" }),
    Server = Window:AddTab({ Title = "Server", Icon = "server" }),
    Config = Window:AddTab({ Title = "Config", Icon = "settings-2" })
}

-- ==========================================
-- [ قسم الإعدادات العامة - General ]
-- ==========================================

-- صندوق المعلومات المالي
Tabs.General:AddParagraph({
    Title = "Information:",
    Content = "💵 Hand: $0\n🏦 Bank: $24,265"
})

-- ميزة الاختفاء (Invisible)
local InvisibleToggle = Tabs.General:AddToggle("InvisibleToggle", {
    Title = "Invisible", 
    Description = "Invisible from another player.",
    Default = false,
    Callback = function(Value)
        _G.Invisible = Value
        if Value then
            print("[Peace Hub] Invisible Activated")
            -- ضع كود الاختفاء المخصص للعبتك هنا
        else
            print("[Peace Hub] Invisible Deactivated")
        end
    end
})

-- ميزة المغناطيس (Magneto Range) عبر شريط تمرير أبيض
local MagnetoSlider = Tabs.General:AddSlider("MagnetoRange", {
    Title = "Magneto Range",
    Description = "Select range for Magneto",
    Default = 250,
    Min = 10,
    Max = 1000,
    Rounding = 0,
    Callback = function(Value)
        _G.MagnetoRangeValue = Value
        print("[Peace Hub] Magneto Range: " .. Value)
    end
})

-- زر تفعيل المغناطيس
local MagnetoToggle = Tabs.General:AddToggle("MagnetoToggle", {
    Title = "Magneto",
    Default = false,
    Callback = function(Value)
        _G.MagnetoActive = Value
        if Value then
            task.spawn(function()
                while _G.MagnetoActive do
                    task.wait(0.1)
                    -- كود جلب العملات أو الأدوات المحيطة باللاعب تلقائياً
                end
            end)
        end
    end
})

-- ميزة إخفاء الاسم فوق الشخصية
local HideNameToggle = Tabs.General:AddToggle("HideNameToggle", {
    Title = "Hide Name",
    Default = true,
    Callback = function(Value)
        _G.HideName = Value
        -- كود إخفاء النيم تاق (NameTag)
    end
})

-- ==========================================
-- [ نظام حفظ الإعدادات تلقائياً ]
-- ==========================================
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("PeaceHubConfigs")
SaveManager:SetFolder("PeaceHubConfigs/configs")
SaveManager:BuildConfigSection(Tabs.Config)

-- فتح السكربت تلقائياً على القسم الأول عند التشغيل
Window:SelectTab(1)

print("[Peace Hub] Loaded Successfully! White Edition.")
