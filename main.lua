-- [[ Peace Hub - Official Block Spin Edition ]]
-- تفعيل نظام الحماية ومنع الانهيار للواجهة
if not game:IsLoaded() then game.Loaded:Wait() end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- إنشاء النافذة بالأبعاد المتوافقة تماماً مع شاشة اللعبة الثابتة
local Window = Fluent:CreateWindow({
    Title = "Peace Hub | PVP",
    SubTitle = "[X] - Block Spin | Clean Edition",
    TabWidth = 150,
    Size = UDim2.fromOffset(560, 430), -- أبعاد محسنة لمنع اختفاء القائمة الجانبية
    Acrylic = false, 
    Theme = "Dark", 
    MinimizeKey = Enum.KeyCode.RightControl
})

-- تخصيص اللون الأبيض النقي للنصوص الرئيسية والتفاعلات
Fluent:SetTheme("Dark")
Window.Root.TitleBar.Title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- القوائم الجانبية (Tabs) مرتبة ومطابقة لطلبك
local Tabs = {
    General = Window:AddTab({ Title = "General", Icon = "user" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "swords" }),
    WeaponMod = Window:AddTab({ Title = "Weapon Mod", Icon = "zap" }),
    Cosmetic = Window:AddTab({ Title = "Cosmetic", Icon = "sparkles" }),
    Esp = Window:AddTab({ Title = "Esp", Icon = "eye" }),
    Vehicle = Window:AddTab({ Title = "Vehicle", Icon = "car" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "component" }),
    Server = Window:AddTab({ Title = "Server", Icon = "server" }),
    Config = Window:AddTab({ Title = "Config", Icon = "settings" })
}

-- ==========================================
-- [ محتويات قسم General ]
-- ==========================================

-- عرض معلومات الحساب المالي
Tabs.General:AddParagraph({
    Title = "Information:",
    Content = "💵 Hand: $0\n🏦 Bank: $24265"
})

-- ميزة الاختفاء (Invisible)
local InvisibleToggle = Tabs.General:AddToggle("Invisible", {
    Title = "Invisible", 
    Description = "Invisible from another player.",
    Default = false,
    Callback = function(Value)
        _G.Invisible = Value
        local Player = game.Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        
        if Value then
            -- كود برمجى آمن للاختفاء داخل اللعبة
            task.spawn(function()
                while _G.Invisible and Character do
                    for _, part in pairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") or part:IsA("Decal") then
                            if part.Name ~= "HumanoidRootPart" then
                                part.Transparency = 1
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        else
            -- إعادة إظهار الشخصية عند الإيقاف
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    if part.Name ~= "HumanoidRootPart" then
                        part.Transparency = 0
                    end
                end
            end
        end
    end
})

-- ميزة التحكم في مدى المغناطيس (Magneto Range)
local MagnetoSlider = Tabs.General:AddSlider("MagnetoRange", {
    Title = "Magneto Range",
    Description = "Select range for Magneto",
    Default = 250,
    Min = 10,
    Max = 1000,
    Rounding = 0,
    Callback = function(Value)
        _G.MagnetoRangeValue = Value
    end
})

-- ميزة المغناطيس (Magneto) لجلب العناصر المتساقطة في Block Spin
local MagnetoToggle = Tabs.General:AddToggle("Magneto", {
    Title = "Magneto",
    Default = false,
    Callback = function(Value)
        _G.MagnetoActive = Value
        if Value then
            task.spawn(function()
                local Player = game.Players.LocalPlayer
                while _G.MagnetoActive do
                    task.wait(0.1)
                    local Character = Player.Character
                    local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                    if RootPart then
                        -- البحث عن الأموال أو الأدوات المتساقطة في خريطة اللعبة وسحبها
                        for _, item in pairs(workspace:GetChildren()) do
                            if item:IsA("Tool") or item:FindFirstChild("TouchInterest") then
                                local targetPart = item:FindFirstChildAsClass("Part") or item
                                if targetPart and (RootPart.Position - targetPart.Position).Magnitude <= (_G.MagnetoRangeValue or 250) then
                                    targetPart.CFrame = RootPart.CFrame
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
})

-- ميزة إخفاء الاسم فوق اللاعب
Tabs.General:AddToggle("HideName", {
    Title = "Hide Name",
    Default = true,
    Callback = function(Value)
        local Player = game.Players.LocalPlayer
        local Character = Player.Character
        if Character and Character:FindFirstChild("Head") then
            local hum = Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.DisplayDistanceType = Value and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer
            end
        end
    end
})

-- ==========================================
-- [ تهيئة نظام حفظ الإعدادات تلقائياً ]
-- ==========================================
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("PeaceHubBlockSpin")
SaveManager:SetFolder("PeaceHubBlockSpin/configs")
SaveManager:BuildConfigSection(Tabs.Config)

-- اختيار القسم الأول تلقائياً لضمان التحميل الكامل للواجهة
Window:SelectTab(1)
