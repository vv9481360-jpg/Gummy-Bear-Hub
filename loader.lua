--=============================================================
--  GUMMY BEAR HUB v11.0 — BloxStrike Quality Edition
--=============================================================

--=============================================================
--  1. ОЧИСТКА
--=============================================================
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

for _, g in pairs(PG:GetChildren()) do
    if g.Name:match("^GummyBear_") then g:Destroy() end
end
_G.__GB_Loaded = nil
_G.__GB_SavedPos = nil

--=============================================================
--  2. КОНФИГ
--=============================================================
local CONFIG = {
    Title = "Gummy Bear Hub",
    Version = "11.0",
    NeonPink = Color3.fromRGB(255, 40, 160),
    NeonPurple = Color3.fromRGB(150, 70, 255),
    NeonBlue = Color3.fromRGB(60, 180, 255),
    NeonCyan = Color3.fromRGB(80, 240, 255),
    CardDark = Color3.fromRGB(32, 24, 52),
    TextMain = Color3.fromRGB(245, 240, 255),
    TextSub = Color3.fromRGB(170, 160, 200),
    Keybind = Enum.KeyCode.RightShift,
}

local BLOXSTRIKE_ID = 114234929420007

--=============================================================
--  3. СЕРВИСЫ
--=============================================================
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

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
    pcall(function()
        TweenService:Create(o, TweenInfo.new(t or 0.2), props):Play()
    end)
end

--=============================================================
--  5. ГЛАВНАЯ ПАНЕЛЬ
--=============================================================
local ScreenGui = new("ScreenGui", {
    Name = "GummyBear_" .. math.random(100000, 999999),
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    Parent = PG,
})

local Main = new("Frame", {
    Parent = ScreenGui,
    BackgroundColor3 = Color3.fromRGB(12, 8, 22),
    BorderSizePixel = 0,
    Size = UDim2.new(0, 560, 0, 420),
    Position = UDim2.new(0.5, -280, 0.5, -210),
    Active = true,
})
corner(Main, 18)
stroke(Main, CONFIG.NeonPurple, 2, 0.2)

--=============================================================
--  6. ВЕРХНЯЯ ПАНЕЛЬ
--=============================================================
local TopBar = new("Frame", {
    Parent = Main,
    BackgroundColor3 = Color3.fromRGB(22, 16, 38),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 52),
})
corner(TopBar, 18)
new("Frame", {
    Parent = TopBar,
    BackgroundColor3 = Color3.fromRGB(22, 16, 38),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 16),
    Position = UDim2.new(0, 0, 1, -16),
})
new("Frame", {
    Parent = TopBar,
    BackgroundColor3 = CONFIG.NeonPink,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 2),
    Position = UDim2.new(0, 0, 1, -2),
})

local icon = new("Frame", {
    Parent = TopBar,
    BackgroundColor3 = CONFIG.NeonPink,
    BorderSizePixel = 0,
    Size = UDim2.new(0, 32, 0, 32),
    Position = UDim2.new(0, 12, 0.5, -16),
})
corner(icon, 999)
new("TextLabel", {
    Parent = icon,
    BackgroundTransparency = 1,
    Text = "🧸",
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    Size = UDim2.new(1, 0, 1, 0),
})

new("TextLabel", {
    Parent = TopBar,
    BackgroundTransparency = 1,
    Text = CONFIG.Title .. "  •  v" .. CONFIG.Version,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextColor3 = CONFIG.TextMain,
    TextXAlignment = Enum.TextXAlignment.Left,
    Size = UDim2.new(1, -140, 1, 0),
    Position = UDim2.new(0, 54, 0, 0),
})

local function topBtn(txt, xOff, color)
    local b = new("TextButton", {
        Parent = TopBar,
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Text = txt,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextColor3 = CONFIG.TextMain,
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, xOff, 0.5, -15),
        AutoButtonColor = false,
    })
    corner(b, 10)
    stroke(b, color, 1, 0.5)
    return b
end

local MinBtn = topBtn("—", -78, CONFIG.NeonPurple)
local CloseBtn = topBtn("✕", -42, CONFIG.NeonPink)

--=============================================================
--  7. ЛЕВОЕ МЕНЮ
--=============================================================
local TabBar = new("Frame", {
    Parent = Main,
    BackgroundColor3 = Color3.fromRGB(22, 16, 38),
    BorderSizePixel = 0,
    Size = UDim2.new(0, 155, 1, -52),
    Position = UDim2.new(0, 0, 0, 52),
})
new("Frame", {
    Parent = TabBar,
    BackgroundColor3 = CONFIG.NeonPurple,
    BorderSizePixel = 0,
    Size = UDim2.new(0, 2, 1, 0),
    Position = UDim2.new(1, -2, 0, 0),
})

local TabList = new("Frame", {
    Parent = TabBar,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, -16),
    Position = UDim2.new(0, 0, 0, 12),
})
new("UIListLayout", {
    Parent = TabList,
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
})

--=============================================================
--  8. КОНТЕНТ + ТАБЫ
--=============================================================
local Content = new("Frame", {
    Parent = Main,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, -155, 1, -52),
    Position = UDim2.new(0, 155, 0, 52),
})

local Pages, ActiveTab = {}, nil

local function createTab(name, ico)
    local btn = new("TextButton", {
        Parent = TabList,
        BackgroundColor3 = CONFIG.CardDark,
        BorderSizePixel = 0,
        Text = "  " .. ico .. "   " .. name,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextColor3 = CONFIG.TextSub,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, -18, 0, 38),
        AutoButtonColor = false,
    })
    corner(btn, 10)
    stroke(btn, CONFIG.NeonPurple, 1, 0.7)

    local page = new("ScrollingFrame", {
        Parent = Content,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -24, 1, -24),
        Position = UDim2.new(0, 12, 0, 12),
        CanvasSize = UDim2.new(0, 0, 0, 2000),
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = CONFIG.NeonPink,
        BorderSizePixel = 0,
        Visible = false,
    })
    new("UIListLayout", {
        Parent = page,
        Padding = UDim.new(0, 9),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    new("UIPadding", {
        Parent = page,
        PaddingRight = UDim.new(0, 6),
        PaddingBottom = UDim.new(0, 8),
    })

    Pages[name] = { button = btn, page = page }

    btn.MouseButton1Click:Connect(function()
        if ActiveTab == name then return end
        ActiveTab = name
        for n, d in pairs(Pages) do
            local a = (n == name)
            d.page.Visible = a
            tween(d.button, 0.2, {
                BackgroundColor3 = a and CONFIG.NeonPurple or CONFIG.CardDark,
                TextColor3 = a and Color3.new(1, 1, 1) or CONFIG.TextSub,
            })
        end
    end)

    if not ActiveTab then
        ActiveTab = name
        btn.BackgroundColor3 = CONFIG.NeonPurple
        btn.TextColor3 = Color3.new(1, 1, 1)
        page.Visible = true
    end

    return page
end

--=============================================================
--  9. UI-ЭЛЕМЕНТЫ
--=============================================================
local function makeButton(parent, text, cb)
    local wrap = new("Frame", {
        Parent = parent,
        BackgroundColor3 = CONFIG.CardDark,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 40),
    })
    corner(wrap, 10)
    stroke(wrap, CONFIG.NeonPurple, 1.5, 0.4)

    local btn = new("TextButton", {
        Parent = wrap,
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
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
            if not ok then warn("[GB] " .. tostring(err)) end
        end
    end)
    return btn
end

local function makeToggle(parent, text, default, cb)
    local state = default or false
    local wrap = new("TextButton", {
        Parent = parent,
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
        TextSize = 13,
        TextColor3 = CONFIG.TextMain,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, -70, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
    })

    local switch = new("Frame", {
        Parent = wrap,
        BackgroundColor3 = state and CONFIG.NeonPink or Color3.fromRGB(60, 50, 90),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 40, 0, 22),
        Position = UDim2.new(1, -54, 0.5, -11),
    })
    corner(switch, 999)

    local knob = new("Frame", {
        Parent = switch,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 16, 0, 16),
        Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
    })
    corner(knob, 999)

    local function setState(v)
        state = v
        tween(switch, 0.2, { BackgroundColor3 = state and CONFIG.NeonPink or Color3.fromRGB(60, 50, 90) })
        tween(knob, 0.2, {
            Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        })
        if cb then
            local ok, err = pcall(cb, state)
            if not ok then warn("[GB] " .. tostring(err)) end
        end
    end

    wrap.MouseButton1Click:Connect(function() setState(not state) end)
    return { set = setState, get = function() return state end }
end

local function makeSlider(parent, text, min, max, default, cb)
    local value = default or min
    local wrap = new("Frame", {
        Parent = parent,
        BackgroundColor3 = CONFIG.CardDark,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 54),
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
        Size = UDim2.new(1, -70, 0, 22),
        Position = UDim2.new(0, 14, 0, 6),
    })

    local valLabel = new("TextLabel", {
        Parent = wrap,
        BackgroundTransparency = 1,
        Text = tostring(value),
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextColor3 = CONFIG.NeonBlue,
        TextXAlignment = Enum.TextXAlignment.Right,
        Size = UDim2.new(0, 60, 0, 22),
        Position = UDim2.new(1, -70, 0, 6),
    })

    local bar = new("Frame", {
        Parent = wrap,
        BackgroundColor3 = Color3.fromRGB(18, 12, 32),
        BorderSizePixel = 0,
        Size = UDim2.new(1, -28, 0, 10),
        Position = UDim2.new(0, 14, 1, -18),
        Active = true,
    })
    corner(bar, 999)

    local fill = new("Frame", {
        Parent = bar,
        BackgroundColor3 = CONFIG.NeonPink,
        BorderSizePixel = 0,
        Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
    })
    corner(fill, 999)

    local dragging = false
    local function update(input)
        local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        value = math.floor(min + (max - min) * pos)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        valLabel.Text = tostring(value)
        if cb then
            local ok, err = pcall(cb, value)
            if not ok then warn("[GB] " .. tostring(err)) end
        end
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(input)
        end
    end)
    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)

    return { get = function() return value end }
end

local function makeLabel(parent, text, isSub)
    return new("TextLabel", {
        Parent = parent,
        BackgroundTransparency = 1,
        Text = text,
        Font = isSub and Enum.Font.Gotham or Enum.Font.GothamBold,
        TextSize = isSub and 12 or 14,
        TextColor3 = isSub and CONFIG.TextSub or CONFIG.TextMain,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, 0, 0, isSub and 22 or 28),
    })
end

local function makeDivider(parent, text)
    local wrap = new("Frame", {
        Parent = parent,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 26),
    })
    new("TextLabel", {
        Parent = wrap,
        BackgroundTransparency = 1,
        Text = "◆ " .. text,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextColor3 = CONFIG.NeonCyan,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(1, 0, 1, 0),
    })
    return wrap
end

--=============================================================
--  10. DRAG
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

--=============================================================
--  11. КНОПКИ ОКНА
--=============================================================
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    tween(Main, 0.3, { Size = minimized and UDim2.new(0, 560, 0, 52) or UDim2.new(0, 560, 0, 420) })
    TabBar.Visible = not minimized
    Content.Visible = not minimized
end)

CloseBtn.MouseButton1Click:Connect(function()
    tween(Main, 0.22, { Size = UDim2.new(0, 0, 0, 0) })
    task.delay(0.22, function() ScreenGui:Destroy() end)
end)
--=============================================================
--  12. ГЛАВНАЯ
--=============================================================
local homePage = createTab("Главная", "🧸")
makeLabel(homePage, "Добро пожаловать в " .. CONFIG.Title, false)
makeLabel(homePage, "Place ID: " .. tostring(game.PlaceId), true)
makeLabel(homePage, "Игроков онлайн: " .. #Players:GetPlayers(), true)

if game.PlaceId == BLOXSTRIKE_ID then
    makeLabel(homePage, "🎯 Режим BloxStrike активен!", true)
end

--=============================================================
--  13. ИГРОК
--=============================================================
local playerPage = createTab("Игрок", "👤")

local infJumpConn
makeToggle(playerPage, "Бесконечный прыжок", false, function(state)
    if state then
        if infJumpConn then infJumpConn:Disconnect() end
        infJumpConn = UIS.JumpRequest:Connect(function()
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end) end
        end)
    else
        if infJumpConn then infJumpConn:Disconnect(); infJumpConn = nil end
    end
end)

makeSlider(playerPage, "Скорость ходьбы", 16, 250, 16, function(v)
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = v end
end)

makeSlider(playerPage, "Сила прыжка", 50, 350, 50, function(v)
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = v; hum.UseJumpPower = true end
end)

makeButton(playerPage, "♻️ Перереспавнить", function()
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.Health = 0 end
end)

makeButton(playerPage, "🩹 Восстановить HP", function()
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.Health = hum.MaxHealth end
end)

--=============================================================
--  14. ТЕЛЕПОРТ
--=============================================================
local tpPage = createTab("Телепорт", "🌀")

local function tpTo(pos)
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = CFrame.new(pos) end
end

makeButton(tpPage, "⬆️ Вверх на 100", function()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then tpTo(hrp.Position + Vector3.new(0, 100, 0)) end
end)

makeButton(tpPage, "⬇️ Вниз на 100", function()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then tpTo(hrp.Position - Vector3.new(0, 100, 0)) end
end)

makeButton(tpPage, "🎯 К случайному игроку", function()
    local t = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(t, p)
        end
    end
    if #t == 0 then return end
    local target = t[math.random(1, #t)]
    tpTo(target.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
end)

makeButton(tpPage, "🌍 Сохранить позицию", function()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then _G.__GB_SavedPos = hrp.Position end
end)

makeButton(tpPage, "↩️ Вернуться к сохранённой", function()
    if _G.__GB_SavedPos then tpTo(_G.__GB_SavedPos) end
end)

--=============================================================
--  15. ВИЗУАЛ (общий)
--=============================================================
local visualPage = createTab("Визуал", "🎨")

local origLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows,
}

makeToggle(visualPage, "Fullbright", false, function(state)
    if state then
        Lighting.Brightness = 3
        Lighting.ClockTime = 14
        Lighting.FogEnd = 1e6
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = origLighting.Brightness
        Lighting.ClockTime = origLighting.ClockTime
        Lighting.FogEnd = origLighting.FogEnd
        Lighting.GlobalShadows = origLighting.GlobalShadows
    end
end)

makeToggle(visualPage, "Убрать туман", false, function(state)
    Lighting.FogEnd = state and 1e6 or origLighting.FogEnd
end)
--=============================================================
--  16. BLOXSTRIKE — качественный чит
--=============================================================
if game.PlaceId == BLOXSTRIKE_ID then
    local bsPage = createTab("BloxStrike", "🔫")
    
    -- Общие функции
    local function isTeammate(plr)
        if not plr.Team or not LP.Team then return false end
        return plr.Team == LP.Team
    end
    
    local function isAlive(plr)
        if not plr.Character then return false end
        local hum = plr.Character:FindFirstChildOfClass("Humanoid")
        return hum and hum.Health > 0
    end
    
    local function getAimPart(plr, partName)
        if not plr.Character then return nil end
        return plr.Character:FindFirstChild(partName)
    end
    
    local function getEnemies()
        local list = {}
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LP and isAlive(plr) and not isTeammate(plr) then
                table.insert(list, plr)
            end
        end
        return list
    end
    
    --=========================================================
    --  ESP ТОЛЬКО ДЛЯ ВРАГОВ (качественный)
    --=========================================================
    makeDivider(bsPage, "👁️ ESP (только враги)")
    
    local espActive = false
    local espShowName = true
    local espShowHealth = true
    local espShowDistance = true
    local espHighlight = true
    
    local function clearESP()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                local hl = plr.Character:FindFirstChild("GB_ESP_HL")
                if hl then hl:Destroy() end
                local head = plr.Character:FindFirstChild("Head")
                if head then
                    local tag = head:FindFirstChild("GB_ESP_Tag")
                    if tag then tag:Destroy() end
                end
            end
        end
    end
    
    -- Слежение за респавнами
    local playerConns = {}
    
    local function buildESPFor(plr)
        if plr == LP then return end
        
        local function setup(char)
            if not espActive then return end
            task.wait(0.3)
            if not char.Parent then return end
            
            -- Highlight (подсветка сквозь стены)
            if espHighlight then
                local hl = char:FindFirstChild("GB_ESP_HL")
                if not hl then
                    hl = new("Highlight", {
                        Parent = char,
                        Name = "GB_ESP_HL",
                        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
                        FillColor = Color3.fromRGB(255, 140, 0),
                        OutlineColor = Color3.fromRGB(255, 80, 0),
                        FillTransparency = 0.65,
                        OutlineTransparency = 0,
                    })
                end
            end
            
            -- Billboard (ник + HP + дистанция)
            local head = char:FindFirstChild("Head")
            if head and not head:FindFirstChild("GB_ESP_Tag") then
                local bb = new("BillboardGui", {
                    Parent = head,
                    Name = "GB_ESP_Tag",
                    Size = UDim2.new(0, 140, 0, 50),
                    StudsOffset = Vector3.new(0, 2.8, 0),
                    AlwaysOnTop = true,
                })
                
                local nameLbl = new("TextLabel", {
                    Parent = bb,
                    Name = "NameLbl",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 18),
                    Position = UDim2.new(0, 0, 0, 0),
                    Text = plr.Name,
                    Font = Enum.Font.GothamBold,
                    TextSize = 13,
                    TextColor3 = Color3.fromRGB(255, 140, 0),
                    TextStrokeTransparency = 0.3,
                })
                
                local infoLbl = new("TextLabel", {
                    Parent = bb,
                    Name = "InfoLbl",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 16),
                    Position = UDim2.new(0, 0, 0, 18),
                    Text = "",
                    Font = Enum.Font.Gotham,
                    TextSize = 11,
                    TextColor3 = Color3.fromRGB(255, 220, 180),
                    TextStrokeTransparency = 0.4,
                })
                
                local hpBarBg = new("Frame", {
                    Parent = bb,
                    Name = "HPBg",
                    BackgroundColor3 = Color3.fromRGB(40, 20, 20),
                    BorderSizePixel = 0,
                    Size = UDim2.new(0.9, 0, 0, 4),
                    Position = UDim2.new(0.05, 0, 1, -4),
                })
                corner(hpBarBg, 999)
                
                local hpBar = new("Frame", {
                    Parent = hpBarBg,
                    Name = "HPBar",
                    BackgroundColor3 = Color3.fromRGB(50, 220, 80),
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                })
                corner(hpBar, 999)
            end
            
            -- Убираем при удалении персонажа
            char.AncestryChanged:Connect(function()
                if not char:IsDescendantOf(game) then
                    local hl = char:FindFirstChild("GB_ESP_HL")
                    if hl then hl:Destroy() end
                end
            end)
        end
        
        if plr.Character then setup(plr.Character) end
        
        if playerConns[plr] then playerConns[plr]:Disconnect() end
        playerConns[plr] = plr.CharacterAdded:Connect(setup)
    end
    
    -- Обновление данных (HP, дистанция)
    task.spawn(function()
        while true do
            task.wait(0.15)
            if not espActive then continue end
            
            local myChar = LP.Character
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character and not isTeammate(plr) then
                    local head = plr.Character:FindFirstChild("Head")
                    local tag = head and head:FindFirstChild("GB_ESP_Tag")
                    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    
                    if tag and hum then
                        -- Имя
                        local nameLbl = tag:FindFirstChild("NameLbl")
                        if nameLbl then
                            nameLbl.Visible = espShowName
                        end
                        
                        -- Инфо (дистанция)
                        local infoLbl = tag:FindFirstChild("InfoLbl")
                        if infoLbl then
                            local parts = {}
                            if espShowDistance and myHRP and hrp then
                                local dist = math.floor((myHRP.Position - hrp.Position).Magnitude)
                                table.insert(parts, dist .. "m")
                            end
                            if espShowHealth then
                                table.insert(parts, math.floor(hum.Health) .. "HP")
                            end
                            infoLbl.Text = table.concat(parts, " | ")
                            infoLbl.Visible = #parts > 0
                        end
                        
                        -- HP-бар
                        local hpBg = tag:FindFirstChild("HPBg")
                        if hpBg then
                            hpBg.Visible = espShowHealth
                            local hpBar = hpBg:FindFirstChild("HPBar")
                            if hpBar then
                                local ratio = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                                hpBar.Size = UDim2.new(ratio, 0, 1, 0)
                                -- Цвет: зелёный → жёлтый → красный
                                if ratio > 0.6 then
                                    hpBar.BackgroundColor3 = Color3.fromRGB(50, 220, 80)
                                elseif ratio > 0.3 then
                                    hpBar.BackgroundColor3 = Color3.fromRGB(250, 200, 40)
                                else
                                    hpBar.BackgroundColor3 = Color3.fromRGB(250, 60, 60)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
    
    makeToggle(bsPage, "ESP только для врагов", false, function(state)
        espActive = state
        clearESP()
        if not state then
            for plr, conn in pairs(playerConns) do
                if conn then conn:Disconnect() end
            end
            playerConns = {}
            return
        end
        
        for _, plr in pairs(Players:GetPlayers()) do
            buildESPFor(plr)
        end
        
        Players.PlayerAdded:Connect(function(plr)
            if espActive then buildESPFor(plr) end
        end)
    end)
    
    makeToggle(bsPage, "  ↳ Показывать ник", true, function(v) espShowName = v end)
    makeToggle(bsPage, "  ↳ Показывать HP", true, function(v) espShowHealth = v end)
    makeToggle(bsPage, "  ↳ Показывать дистанцию", true, function(v) espShowDistance = v end)
    makeToggle(bsPage, "  ↳ Подсветка сквозь стены", true, function(v) espHighlight = v end)
    
    --=========================================================
    --  AIMBOT (качественный)
    --=========================================================
    makeDivider(bsPage, "🎯 Aimbot")
    
    local aimbotActive = false
    local aimSmooth = 0.35
    local aimFOV = 250
    local aimPart = "Head"
    local aimKey = Enum.UserInputType.MouseButton2
    local aimTeamCheck = true
    local aimVisibleCheck = false
    local aimPredict = 0
    
    -- Прицел FOV
    local fovCircle = new("Frame", {
        Parent = ScreenGui,
        Name = "FOVCircle",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0, aimFOV * 2, 0, aimFOV * 2),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Visible = false,
        ZIndex = 999,
    })
    local fovStroke = new("UIStroke", {
        Parent = fovCircle,
        Color = CONFIG.NeonPink,
        Thickness = 1.5,
        Transparency = 0.4,
    })
    corner(fovCircle, 999999)
    
    makeToggle(bsPage, "Aimbot (зажми ПКМ)", false, function(state)
        aimbotActive = state
        fovCircle.Visible = state
    end)
    
    makeSlider(bsPage, "Smoothness (1-10)", 1, 10, 4, function(v)
        aimSmooth = v / 10
    end)
    
    makeSlider(bsPage, "FOV (радиус)", 50, 500, 250, function(v)
        aimFOV = v
        fovCircle.Size = UDim2.new(0, v * 2, 0, v * 2)
    end)
    
    makeToggle(bsPage, "Проверка команды", true, function(v) aimTeamCheck = v end)
    makeToggle(bsPage, "Проверка видимости (Raycast)", false, function(v) aimVisibleCheck = v end)
    
    makeSlider(bsPage, "Предсказание (0-10)", 0, 10, 0, function(v)
        aimPredict = v / 100
    end)
    
    makeButton(bsPage, "🎯 Цель: Head", function()
        aimPart = "Head"
        print("[GB] Aimbot target: Head")
    end)
    
    makeButton(bsPage, "🎯 Цель: HumanoidRootPart", function()
        aimPart = "HumanoidRootPart"
        print("[GB] Aimbot target: Torso")
    end)
    
    makeButton(bsPage, "🎯 Цель: UpperTorso", function()
        aimPart = "UpperTorso"
        print("[GB] Aimbot target: UpperTorso")
    end)
    
    -- Raycast-проверка видимости
    local function hasLineOfSight(part)
        if not aimVisibleCheck then return true end
        local myChar = LP.Character
        local myHead = myChar and myChar:FindFirstChild("Head")
        if not myHead then return false end
        
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = {myChar}
        
        local result = Workspace:Raycast(myHead.Position, part.Position - myHead.Position, params)
        if not result then return true end
        
        -- Если луч попал в часть персонажа цели — видим
        local hitChar = result.Instance:FindFirstAncestorOfClass("Model")
        return hitChar == part.Parent
    end
    
    -- Главный цикл Aimbot
    task.spawn(function()
        while true do
            task.wait(0.008) -- ~120 FPS
            
            if aimbotActive and UIS:IsMouseButtonPressed(aimKey) then
                local cam = Workspace.CurrentCamera
                if not cam then continue end
                
                local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
                local closest = nil
                local shortest = aimFOV
                local targetPart = nil
                
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr == LP then continue end
                    if aimTeamCheck and isTeammate(plr) then continue end
                    if not isAlive(plr) then continue end
                    
                    local part = getAimPart(plr, aimPart)
                    if not part then continue end
                    
                    local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
                    if not onScreen then continue end
                    
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    if dist < shortest then
                        if hasLineOfSight(part) then
                            shortest = dist
                            closest = plr
                            targetPart = part
                        end
                    end
                end
                
                if targetPart then
                    -- Предсказание движения цели
                    local aimPos = targetPart.Position
                    if aimPredict > 0 then
                        local hum = closest.Character and closest.Character:FindFirstChildOfClass("Humanoid")
                        if hum then
                            aimPos = aimPos + hum.MoveDirection * aimPredict * 50
                        end
                    end
                    
                    local goalCFrame = CFrame.new(cam.CFrame.Position, aimPos)
                    cam.CFrame = cam.CFrame:Lerp(goalCFrame, aimSmooth)
                end
            end
        end
    end)
    
    --=========================================================
    --  TRIGGERBOT (качественный)
    --=========================================================
    makeDivider(bsPage, "🔫 Triggerbot")
    
    local triggerbotActive = false
    local triggerDelay = 0.05
    local triggerTeamCheck = true
    local triggerVisibleCheck = true
    local triggerFOV = 10
    local lastShot = 0
    
    makeToggle(bsPage, "Triggerbot (авто-выстрел)", false, function(state)
        triggerbotActive = state
    end)
    
    makeSlider(bsPage, "Задержка (мс x10)", 0, 30, 5, function(v)
        triggerDelay = v / 100
    end)
    
    makeSlider(bsPage, "FOV триггера", 1, 50, 10, function(v)
        triggerFOV = v
    end)
    
    makeToggle(bsPage, "Проверка команды", true, function(v) triggerTeamCheck = v end)
    makeToggle(bsPage, "Проверка видимости", true, function(v) triggerVisibleCheck = v end)
    
    -- Функция выстрела (совместимая с разными экзекьюторами)
    local function fireWeapon()
        -- Пытаемся через VirtualInputManager (работает в некоторых экзекьюторах)
        local VIM = game:GetService("VirtualInputManager")
        if VIM then
            pcall(function()
                VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                task.wait(0.01)
                VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end)
            return true
        end
        
        -- Fallback: mouse1click (если поддерживается)
        if mouse1click then
            pcall(mouse1click)
            return true
        end
        
        return false
    end
    
    -- Главный цикл Triggerbot
    task.spawn(function()
        while true do
            task.wait(0.01)
            
            if triggerbotActive then
                local now = tick()
                if now - lastShot < triggerDelay then continue end
                
                local cam = Workspace.CurrentCamera
                if not cam then continue end
                
                local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
                
                -- Ищем врага под прицелом
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr == LP then continue end
                    if triggerTeamCheck and isTeammate(plr) then continue end
                    if not isAlive(plr) then continue end
                    
                    local head = getAimPart(plr, "Head")
                    local hrp = getAimPart(plr, "HumanoidRootPart")
                    local target = head or hrp
                    if not target then continue end
                    
                    local screenPos, onScreen = cam:WorldToViewportPoint(target.Position)
                    if not onScreen then continue end
                    
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    if dist < triggerFOV then
                        if triggerVisibleCheck and not hasLineOfSight(target) then continue end
                        
                        -- Стреляем!
                        fireWeapon()
                        lastShot = now
                        break
                    end
                end
            end
        end
    end)
    
    --=========================================================
    --  WALLHACK
    --=========================================================
    makeDivider(bsPage, "🧱 Wallhack")
    
    local wallhackActive = false
    local originalTransparency = {}
    
    makeToggle(bsPage, "Wallhack (стены прозрачные)", false, function(state)
        wallhackActive = state
        
        if state then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    -- Пропускаем персонажей
                    if obj:FindFirstAncestorOfClass("Model") then
                        local model = obj:FindFirstAncestorOfClass("Model")
                        if Players:GetPlayerFromCharacter(model) then continue end
                    end
                    
                    pcall(function()
                        originalTransparency[obj] = obj.LocalTransparencyModifier
                        obj.LocalTransparencyModifier = 0.75
                    end)
                end
            end
        else
            for obj, orig in pairs(originalTransparency) do
                if obj and obj.Parent then
                    pcall(function()
                        obj.LocalTransparencyModifier = orig or 0
                    end)
                end
            end
            originalTransparency = {}
        end
    end)
    
    --=========================================================
    --  NO RECOIL / SPREAD
    --=========================================================
    makeDivider(bsPage, "🎯 Точность")
    
    makeToggle(bsPage, "No Recoil / Spread / Camera", false, function(state)
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
                            local Look = Workspace.CurrentCamera.CFrame.LookVector
                            for _, b in ipairs(Data.Bullets) do
                                if b and b.Direction then b.Direction = Look end
                            end
                        end
                        return Original(Self, Data)
                    end
                end
            end)
            print("[GB] No Recoil включён")
        else
            print("[GB] Перезайди в игру, чтобы выключить")
        end
    end)
    
    --=========================================================
    --  ВИЗУАЛ BLOXSTRIKE
    --=========================================================
    makeDivider(bsPage, "🌍 Визуал")
    
    makeToggle(bsPage, "No Flash / No Smoke", false, function(state)
        if state then
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("ColorCorrectionEffect") then
                    v.Brightness = 0
                end
            end
        end
    end)
    
    makeToggle(bsPage, "Fullbright (BloxStrike)", false, function(state)
        if state then
            Lighting.Brightness = 3
            Lighting.ClockTime = 14
            Lighting.FogEnd = 1e6
            Lighting.GlobalShadows = false
        else
            Lighting.Brightness = origLighting.Brightness
            Lighting.ClockTime = origLighting.ClockTime
            Lighting.FogEnd = origLighting.FogEnd
            Lighting.GlobalShadows = origLighting.GlobalShadows
        end
    end)
    
    --=========================================================
    --  SKIN CHANGER
    --=========================================================
    makeDivider(bsPage, "🎨 Skin Changer")
    
    makeButton(bsPage, "🎨 Загрузить Skin Changer", function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Nickk-GG/BloxStrike-NickHub-New-Gen/refs/heads/main/sc.lua"))()
        end)
        if not ok then warn("[GB] Skin Changer: " .. tostring(err)) end
    end)
    
    --=========================================================
    --  УТИЛИТЫ
    --=========================================================
    makeDivider(bsPage, "⚙️ Утилиты")
    
    makeButton(bsPage, "🔄 Переподключиться", function()
        pcall(function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
        end)
    end)
    
    makeButton(bsPage, "📋 Скопировать Job ID", function()
        if setclipboard then
            setclipboard(game.JobId)
            print("[GB] Job ID скопирован")
        end
    end)
end

--=============================================================
--  17. ХОТКЕЙ
--=============================================================
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == CONFIG.Keybind then
        Main.Visible = not Main.Visible
    end
end)

--=============================================================
--  18. АНИМАЦИЯ ПОЯВЛЕНИЯ
--=============================================================
Main.Size = UDim2.new(0, 0, 0, 0)
tween(Main, 0.35, { Size = UDim2.new(0, 560, 0, 420) })

print("[Gummy Bear Hub] Загружено! v" .. CONFIG.Version)
print("[Gummy Bear Hub] Place ID: " .. tostring(game.PlaceId))
if game.PlaceId == BLOXSTRIKE_ID then
    print("[Gummy Bear Hub] 🎯 BloxStrike режим активирован!")
    print("[Gummy Bear Hub] Доступно: ESP, Aimbot, Triggerbot, Wallhack, No Recoil")
end
