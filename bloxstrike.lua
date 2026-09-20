--=============================================================
--  BLOXSTRIKE CHEAT — отдельный модуль
--  Автор: Gummy Bear Hub
--  Загружается из loader.lua
--=============================================================

-- Защита от повторного запуска
if _G.__BLOXSTRIKE_CHEAT_LOADED then
    warn("[BloxStrike] Уже загружено!")
    return
end
_G.__BLOXSTRIKE_CHEAT_LOADED = true

--=============================================================
--  1. ПРОВЕРКА ИГРЫ
--=============================================================
local BLOXSTRIKE_ID = 114234929420007
if game.PlaceId ~= BLOXSTRIKE_ID then
    warn("[BloxStrike] Этот чит только для BloxStrike!")
    return
end

--=============================================================
--  2. СЕРВИСЫ
--=============================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LP = Players.LocalPlayer

--=============================================================
--  3. КОНФИГ
--=============================================================
local CONFIG = {
    Title = "🧸 Gummy Bear BloxStrike",
    Version = "v1.0",
    NeonPink = Color3.fromRGB(255, 40, 160),
    NeonPurple = Color3.fromRGB(150, 70, 255),
    NeonBlue = Color3.fromRGB(60, 180, 255),
    CardDark = Color3.fromRGB(32, 24, 52),
    TextMain = Color3.fromRGB(245, 240, 255),
    TextSub = Color3.fromRGB(170, 160, 200),
    Keybind = Enum.KeyCode.RightControl, -- отдельный хоткей от главной панели
}

--=============================================================
--  4. УТИЛИТЫ
--=============================================================
local function new(cls, props)
    local o = Instance.new(cls)
    for k, v in pairs(props or {}) do o[k] = v end
    return o
end

local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = p
    return c
end

local function stroke(p, c, th, tr)
    local s = Instance.new("UIStroke")
    s.Color = c or CONFIG.NeonPurple
    s.Thickness = th or 1.5
    s.Transparency = tr or 0.4
    s.Parent = p
    return s
end

local function tween(o, t, props)
    TweenService:Create(o, TweenInfo.new(t or 0.2), props):Play()
end

--=============================================================
--  5. СОЗДАНИЕ МЕНЮ
--=============================================================
local PG = LP:WaitForChild("PlayerGui")
for _, g in pairs(PG:GetChildren()) do
    if g.Name == "BearBloxStrike_" then g:Destroy() end
end

local ScreenGui = new("ScreenGui", {
    Name = "BearBloxStrike_",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    Parent = PG,
})

-- Главный фрейм
local Main = new("Frame", {
    Parent = ScreenGui,
    BackgroundColor3 = Color3.fromRGB(12, 8, 22),
    BorderSizePixel = 0,
    Size = UDim2.new(0, 400, 0, 320),
    Position = UDim2.new(1, -420, 0.5, -160), -- справа, чтобы не перекрывать главную панель
    Active = true,
})
corner(Main, 16)
stroke(Main, CONFIG.NeonPink, 2, 0.2)

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
    BackgroundColor3 = CONFIG.NeonPink,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 2),
    Position = UDim2.new(0, 0, 1, -2),
})

new("TextLabel", {
    Parent = TopBar,
    BackgroundTransparency = 1,
    Text = CONFIG.Title,
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextColor3 = CONFIG.TextMain,
    TextXAlignment = Enum.TextXAlignment.Left,
    Size = UDim2.new(1, -60, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
})

-- Кнопка закрытия
local CloseBtn = new("TextButton", {
    Parent = TopBar,
    BackgroundColor3 = CONFIG.NeonPink,
    BorderSizePixel = 0,
    Text = "✕",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextColor3 = CONFIG.TextMain,
    Size = UDim2.new(0, 26, 0, 26),
    Position = UDim2.new(1, -34, 0.5, -13),
    AutoButtonColor = false,
})
corner(CloseBtn, 8)

-- Контент
local Content = new("ScrollingFrame", {
    Parent = Main,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, -20, 1, -60),
    Position = UDim2.new(0, 10, 0, 52),
    CanvasSize = UDim2.new(0, 0, 0, 500),
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = CONFIG.NeonPink,
    BorderSizePixel = 0,
})
new("UIListLayout", {
    Parent = Content,
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
})

--=============================================================
--  6. ЭЛЕМЕНТЫ UI
--=============================================================
local function makeToggle(text, default, cb)
    local state = default or false
    local wrap = new("TextButton", {
        Parent = Content,
        BackgroundColor3 = CONFIG.CardDark,
        BorderSizePixel = 0,
        Text = "",
        Size = UDim2.new(1, 0, 0, 38),
        AutoButtonColor = false,
    })
    corner(wrap, 10)
    stroke(wrap, CONFIG.NeonPurple, 1.5, 0.4)

    new("TextLabel", {
        Parent = wrap,
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextColor3 = CONFIG.TextMain,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, -70, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
    })

    local switch = new("Frame", {
        Parent = wrap,
        BackgroundColor3 = state and CONFIG.NeonPink or Color3.fromRGB(60, 50, 90),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 36, 0, 20),
        Position = UDim2.new(1, -48, 0.5, -10),
    })
    corner(switch, 999)

    local knob = new("Frame", {
        Parent = switch,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 14, 0, 14),
        Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 3, 0.5, -7),
    })
    corner(knob, 999)

    local function setState(v)
        state = v
        tween(switch, 0.2, { BackgroundColor3 = state and CONFIG.NeonPink or Color3.fromRGB(60, 50, 90) })
        tween(knob, 0.2, {
            Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        })
        if cb then
            local ok, err = pcall(cb, state)
            if not ok then warn("[BloxStrike] " .. tostring(err)) end
        end
    end

    wrap.MouseButton1Click:Connect(function() setState(not state) end)
    return { set = setState, get = function() return state end }
end

local function makeButton(text, cb)
    local wrap = new("Frame", {
        Parent = Content,
        BackgroundColor3 = CONFIG.CardDark,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 36),
    })
    corner(wrap, 10)
    stroke(wrap, CONFIG.NeonPurple, 1.5, 0.4)

    local btn = new("TextButton", {
        Parent = wrap,
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextColor3 = CONFIG.TextMain,
        Size = UDim2.new(1, 0, 1, 0),
        AutoButtonColor = false,
    })

    btn.MouseButton1Click:Connect(function()
        tween(wrap, 0.08, { BackgroundColor3 = CONFIG.NeonPink })
        task.delay(0.15, function()
            tween(wrap, 0.2, { BackgroundColor3 = CONFIG.CardDark })
        end)
        if cb then
            local ok, err = pcall(cb)
            if not ok then warn("[BloxStrike] " .. tostring(err)) end
        end
    end)
    return btn
end

local function makeLabel(text, isSub)
    return new("TextLabel", {
        Parent = Content,
        BackgroundTransparency = 1,
        Text = text,
        Font = isSub and Enum.Font.Gotham or Enum.Font.GothamBold,
        TextSize = isSub and 11 or 13,
        TextColor3 = isSub and CONFIG.TextSub or CONFIG.TextMain,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, 0, 0, isSub and 20 or 26),
    })
end

--=============================================================
--  7. DRAG
--=============================================================
do
    local dragging, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)
end

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    _G.__BLOXSTRIKE_CHEAT_LOADED = false
end)

--=============================================================
--  8. ФУНКЦИИ ЧИТА
--=============================================================

makeLabel("🎯 Точность стрельбы", false)

-- No Recoil / Spread / Camera Shake
makeToggle("No Recoil / Spread / Camera", false, function(state)
    if state then
        pcall(function()
            local CameraController = require(ReplicatedStorage.Controllers.CameraController)
            CameraController.weaponKick = function() end
            CameraController.setWeaponRecoil = function() end
        end)
        pcall(function()
            local InventoryController = require(ReplicatedStorage.Controllers.InventoryController)
            if InventoryController and InventoryController.ShootWeapon then
                local Original = InventoryController.ShootWeapon
                InventoryController.ShootWeapon = function(Self, Data)
                    if Data and Data.Bullets then
                        local Look = workspace.CurrentCamera.CFrame.LookVector
                        for _, b in ipairs(Data.Bullets) do
                            if b and b.Direction then b.Direction = Look end
                        end
                    end
                    return Original(Self, Data)
                end
            end
        end)
        print("[BloxStrike] No Recoil включён")
    else
        print("[BloxStrike] Перезайди в игру, чтобы выключить")
    end
end)

-- Infinite Ammo (попытка)
makeToggle("Infinite Ammo (тест)", false, function(state)
    if state then
        pcall(function()
            local InventoryController = require(ReplicatedStorage.Controllers.InventoryController)
            if InventoryController then
                for _, v in pairs(InventoryController) do
                    if type(v) == "table" and v.Ammo then
                        v.Ammo = math.huge
                    end
                end
            end
        end)
        print("[BloxStrike] Infinite Ammo включён (может не работать)")
    end
end)

makeLabel("👁️ Визуал", false)

-- ESP игроков
local espFolder = new("Folder", { Parent = ScreenGui, Name = "GB_ESP" })
local espActive = false

makeToggle("Player ESP (союзники/враги)", false, function(state)
    espActive = state
    for _, v in pairs(espFolder:GetChildren()) do v:Destroy() end
    if not state then
        -- Очистка подсветки
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                local h = plr.Character:FindFirstChild("GB_Highlight")
                if h then h:Destroy() end
                local head = plr.Character:FindFirstChild("Head")
                if head and head:FindFirstChild("GB_ESP_Tag") then
                    head.GB_ESP_Tag:Destroy()
                end
            end
        end
        return
    end

    local function isTeammate(plr)
        return plr.Team and LP.Team and plr.Team == LP.Team
    end

    task.spawn(function()
        while espActive do
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    local head = plr.Character:FindFirstChild("Head")
                    if head then
                        local teammate = isTeammate(plr)
                        local color = teammate and Color3.fromRGB(0, 160, 255) or Color3.fromRGB(255, 140, 0)

                        -- Highlight
                        local hl = plr.Character:FindFirstChild("GB_Highlight")
                        if not hl then
                            hl = new("Highlight", {
                                Parent = plr.Character,
                                Name = "GB_Highlight",
                                DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
                            })
                        end
                        hl.FillColor = color
                        hl.OutlineColor = color
                        hl.FillTransparency = 0.7
                        hl.OutlineTransparency = 0

                        -- Ник
                        if not head:FindFirstChild("GB_ESP_Tag") then
                            local bb = new("BillboardGui", {
                                Parent = head,
                                Name = "GB_ESP_Tag",
                                Size = UDim2.new(0, 100, 0, 24),
                                StudsOffset = Vector3.new(0, 2.5, 0),
                                AlwaysOnTop = true,
                            })
                            new("TextLabel", {
                                Parent = bb,
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 1, 0),
                                Text = plr.Name .. (teammate and " [TEAM]" or " [ENEMY]"),
                                Font = Enum.Font.GothamBold,
                                TextSize = 13,
                                TextColor3 = color,
                                TextStrokeTransparency = 0.4,
                            })
                        end
                    end
                end
            end
            task.wait(0.3)
        end
    end)
    print("[BloxStrike] ESP включён")
end)

makeLabel("🌍 Мир", false)

-- Fullbright
local originalLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows,
}

makeToggle("Fullbright", false, function(state)
    if state then
        Lighting.Brightness = 3
        Lighting.ClockTime = 14
        Lighting.FogEnd = 1e6
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = originalLighting.Brightness
        Lighting.ClockTime = originalLighting.ClockTime
        Lighting.FogEnd = originalLighting.FogEnd
        Lighting.GlobalShadows = originalLighting.GlobalShadows
    end
end)

makeToggle("No Fog", false, function(state)
    Lighting.FogEnd = state and 1e6 or originalLighting.FogEnd
end)

makeLabel("⚙️ Утилиты", false)

makeButton("🔄 Переподключиться к серверу", function()
    pcall(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
    end)
end)

makeButton("📋 Скопировать Job ID", function()
    if setclipboard then
        setclipboard(game.JobId)
        print("[BloxStrike] Job ID скопирован")
    end
end)

--=============================================================
--  9. ХОТКЕЙ
--=============================================================
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == CONFIG.Keybind then
        Main.Visible = not Main.Visible
    end
end)

--=============================================================
--  10. АНИМАЦИЯ ПОЯВЛЕНИЯ
--=============================================================
Main.Size = UDim2.new(0, 0, 0, 0)
tween(Main, 0.35, { Size = UDim2.new(0, 400, 0, 320) })

print("[BloxStrike] Чит загружен! Хоткей: " .. CONFIG.Keybind.Name)
