--=============================================================
--  GUMMY BEAR BLOXSTRIKE CHEAT v1.0
--  Отдельное меню, запускается из loader.lua
--=============================================================

if _G.__BEAR_BS_LOADED then
    warn("[BS] Уже загружено")
    return
end
_G.__BEAR_BS_LOADED = true

-- Проверка игры
if game.PlaceId ~= 114234929420007 then
    warn("[BS] Этот чит только для BloxStrike!")
    return
end

--=============================================================
--  СЕРВИСЫ
--=============================================================
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

--=============================================================
--  КОНФИГ
--=============================================================
local CFG = {
    Title = "🧸 Bear BloxStrike",
    NeonPink = Color3.fromRGB(255, 40, 160),
    NeonPurple = Color3.fromRGB(150, 70, 255),
    NeonBlue = Color3.fromRGB(60, 180, 255),
    CardDark = Color3.fromRGB(32, 24, 52),
    TextMain = Color3.fromRGB(245, 240, 255),
    TextSub = Color3.fromRGB(170, 160, 200),
    Keybind = Enum.KeyCode.RightControl,
}

--=============================================================
--  УТИЛИТЫ
--=============================================================
local function new(cls, props)
    local o = Instance.new(cls)
    for k, v in pairs(props or {}) do o[k] = v end
    return o
end
local function corner(p, r)
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r or 10); c.Parent = p; return c
end
local function stroke(p, c, th, tr)
    local s = Instance.new("UIStroke"); s.Color = c or CFG.NeonPurple; s.Thickness = th or 1.5; s.Transparency = tr or 0.4; s.Parent = p; return s
end
local function tween(o, t, props)
    TweenService:Create(o, TweenInfo.new(t or 0.2), props):Play()
end

--=============================================================
--  GUI
--=============================================================
for _, g in pairs(PG:GetChildren()) do
    if g.Name == "BearBloxStrike_" then g:Destroy() end
end

local ScreenGui = new("ScreenGui", {
    Name = "BearBloxStrike_",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    Parent = PG,
})

local Main = new("Frame", {
    Parent = ScreenGui,
    BackgroundColor3 = Color3.fromRGB(12, 8, 22),
    BorderSizePixel = 0,
    Size = UDim2.new(0, 400, 0, 340),
    Position = UDim2.new(1, -420, 0.5, -170),
    Active = true,
})
corner(Main, 16)
stroke(Main, CFG.NeonPink, 2, 0.2)

-- Заголовок
local TopBar = new("Frame", {
    Parent = Main,
    BackgroundColor3 = Color3.fromRGB(22, 16, 38),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 44),
})
corner(TopBar, 16)
new("Frame", {
    Parent = TopBar,
    BackgroundColor3 = Color3.fromRGB(22, 16, 38),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 14),
    Position = UDim2.new(0, 0, 1, -14),
})
new("Frame", {
    Parent = TopBar,
    BackgroundColor3 = CFG.NeonPink,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 
