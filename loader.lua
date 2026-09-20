--=============================================================
--  GUMMY BEAR HUB v10.1 — BloxStrike Fixed Edition
--  Все баги исправлены
--=============================================================

--=============================================================
--  1. ОЧИСТКА СТАРЫХ ПАНЕЛЕЙ
--=============================================================
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

for _, g in pairs(PG:GetChildren()) do
    if g.Name:match("^GummyBear_") then g:Destroy() end
end

-- Очистка старых флагов (если были)
_G.__GB_Loaded = nil
_G.__GB_SavedPos = nil

--=============================================================
--  2. КОНФИГ
--=============================================================
local CONFIG = {
    Title = "Gummy Bear Hub",
    Version = "10.1",
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
local TeleportService = game:GetService("TeleportService")

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
    local ok = pcall(function()
        TweenService:Create(o, TweenInfo.new(t or 0.2), props):Play()
    end)
    return ok
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
    return { set = setState }
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
makeLabel(homePage, "Игроков: " .. #Players:GetPlayers(), true)

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

makeButton(tpPage, "↩️ Вернуться", function()
    if _G.__GB_SavedPos then tpTo(_G.__GB_SavedPos) end
end)

--=============================================================
--  15. ВИЗУАЛ
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
--  16. BLOXSTRIKE
--=============================================================
if game.PlaceId == BLOXSTRIKE_ID then
    local bsPage = createTab("BloxStrike", "🔫")
    
    local function isTeammate(plr)
        if not plr.Team or not LP.Team then return false end
        return plr.Team == LP.Team
    end
    
    -- ---------- ESP для врагов ----------
    makeDivider(bsPage, "👁️ ESP (только враги)")
    
    local espActive = false
    
    local function cleanupESP()
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
    end
    
    makeToggle(bsPage, "ESP только для врагов", false, function(state)
        espActive = state
        cleanupESP()
        if not state then return end
        
        task.spawn(function()
            while espActive do
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LP and plr.Character and not isTeammate(plr) then
                        local head = plr.Character:FindFirstChild("Head")
                        if head then
                            local color = Color3.fromRGB(255, 140, 0)
                            
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
                                    Text = plr.Name .. " [ENEMY]",
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
        print("[BS] ESP для врагов включён")
    end)
    
    -- ---------- Wallhack ----------
    makeDivider(bsPage, "🧱 Wallhack")
    
    local wallhackActive = false
    
    makeToggle(bsPage, "Wallhack (стены прозрачные)", false, function(state)
        wallhackActive = state
        if state then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    pcall(function()
                        obj.LocalTransparencyModifier = 0.7
                    end)
                end
            end
        else
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    pcall(function()
                        obj.LocalTransparencyModifier = 0
                    end)
                end
            end
        end
    end)
    
    -- ---------- Aimbot ----------
    makeDivider(bsPage, "🎯 Aimbot")
    
    local aimbotActive = false
    local aimSmooth = 0.5
    local aimFOV = 200
    local aimPart = "Head"
    
    makeToggle(bsPage, "Aimbot (зажми ПКМ)", false, function(state)
        aimbotActive = state
    end)
    
    makeSlider(bsPage, "Smoothness (1-10)", 1, 10, 5, function(v)
        aimSmooth = v / 10
    end)
    
    makeSlider(bsPage, "FOV", 50, 500, 200, function(v)
        aimFOV = v
    end)
    
    makeButton(bsPage, "🎯 Цель: Head", function()
        aimPart = "Head"
    end)
    
    makeButton(bsPage, "🎯 Цель: Torso", function()
        aimPart = "HumanoidRootPart"
    end)
    
    task.spawn(function()
        while true do
            task.wait(0.01)
            if aimbotActive and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                local closest, shortest = nil, math.huge
                local cam = workspace.CurrentCamera
                local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
                
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LP and plr.Character and not isTeammate(plr) then
                        local part = plr.Character:FindFirstChild(aimPart)
                        if part then
                            local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
                            if onScreen then
                                local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                                if dist < aimFOV and dist < shortest then
                                    shortest = dist
                                    closest = part
                                end
                            end
                        end
                    end
                end
                
                if closest then
                    pcall(function()
                        cam.CFrame = cam.CFrame:Lerp(
                            CFrame.new(cam.CFrame.Position, closest.Position),
                            aimSmooth
                        )
                    end)
                end
            end
        end
    end)
    
    -- ---------- Triggerbot ----------
    makeDivider(bsPage, "🔫 Triggerbot")
    
    local triggerbotActive = false
    
    makeToggle(bsPage, "Triggerbot (авто-выстрел)", false, function(state)
        triggerbotActive = state
    end)
    
    task.spawn(function()
        while true do
            task.wait(0.05)
            if triggerbotActive then
                pcall(function()
                    local cam = workspace.CurrentCamera
                    local params = RaycastParams.new()
                    params.FilterDescendantsInstances = {LP.Character}
                    params.FilterType = Enum.RaycastFilterType.Exclude
                    
                    local result = workspace:Raycast(cam.CFrame.Position, cam.CFrame.LookVector * 1000, params)
                    if result and result.Instance then
                        local model = result.Instance:FindFirstAncestorOfClass("Model")
                        local plr = model and Players:GetPlayerFromCharacter(model)
                        if plr and plr ~= LP and not isTeammate(plr) then
                            if UIS.MouseEnabled then
                                -- Пытаемся выстрелить через VirtualInputManager (если доступен)
                                pcall(function()
                                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(
                                        0, 0, 0, true, game, 0
                                    )
                                    task.wait(0.05)
                                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(
                                        0, 0, 0, false, game, 0
                                    )
