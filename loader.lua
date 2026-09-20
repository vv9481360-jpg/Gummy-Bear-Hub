--=============================================================
--  GUMMY BEAR HUB v5.0 — Clean Edition
--  Неоновый стиль + все функции + автоопределение игры
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

--=============================================================
--  2. КОНФИГ
--=============================================================
local CONFIG = {
    Title = "Gummy Bear Hub",
    Version = "v5.0",
    NeonPink   = Color3.fromRGB(255, 40, 160),
    NeonPurple = Color3.fromRGB(150, 70, 255),
    NeonBlue   = Color3.fromRGB(60, 180, 255),
    CardDark   = Color3.fromRGB(32, 24, 52),
    TextMain   = Color3.fromRGB(245, 240, 255),
    TextSub    = Color3.fromRGB(170, 160, 200),
    Keybind    = Enum.KeyCode.RightShift,
}

--=============================================================
--  3. БАЗА ИГР (ДОБАВЛЯЙ СВОИ)
--=============================================================
local GAMES = {
    -- Примеры (раскомментируй и замени ссылки):
    -- [2753915549] = { name = "Blox Fruits",   url = "https://..." },
    -- [4924922222] = { name = "Brookhaven RP", url = "https://..." },
    -- [6516141723] = { name = "Doors",         url = "https://..." },
    -- [2788229376] = { name = "Da Hood",       url = "https://..." },
}

--=============================================================
--  4. СЕРВИСЫ
--=============================================================
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

--=============================================================
--  5. УТИЛИТЫ
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
--  6. ГЛАВНАЯ ПАНЕЛЬ
--=============================================================
local ScreenGui = new("ScreenGui", {
    Name = "GummyBear_" .. math.random(100000, 999999),
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    Parent = PG,
})

local Main = new("Frame", {
    Name = "Main",
    Parent = ScreenGui,
    BackgroundColor3 = Color3.fromRGB(12, 8, 22),
    BorderSizePixel = 0,
    Size = UDim2.new(0, 560, 0, 380),
    Position = UDim2.new(0.5, -280, 0.5, -190),
    Active = true,
})
corner(Main, 18)
stroke(Main, CONFIG.NeonPurple, 2, 0.2)

--=============================================================
--  7. ВЕРХНЯЯ ПАНЕЛЬ
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
    Text = CONFIG.Title .. "  •  " .. CONFIG.Version,
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
--  8. ЛЕВОЕ МЕНЮ
--=============================================================
local TabBar = new("Frame", {
    Parent = Main,
    BackgroundColor3 = Color3.fromRGB(22, 16, 38),
    BorderSizePixel = 0,
    Size = UDim2.new(0, 145, 1, -52),
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
--  9. КОНТЕНТ
--=============================================================
local Content = new("Frame", {
    Parent = Main,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, -145, 1, -52),
    Position = UDim2.new(0, 145, 0, 52),
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
        CanvasSize = UDim2.new(0, 0, 0, 1000),
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
--  10. ЭЛЕМЕНТЫ UI
--=============================================================
local function makeButton(parent, text, cb)
    local wrap = new("Frame", {
        Parent = parent,
        BackgroundColor3 = CONFIG.CardDark,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 38),
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

--=============================================================
--  11. DRAG ПАНЕЛИ
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
--  12. КНОПКИ ЗАГОЛОВКА
--=============================================================
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    tween(Main, 0.3, { Size = minimized and UDim2.new(0, 560, 0, 52) or UDim2.new(0, 560, 0, 380) })
    TabBar.Visible = not minimized
    Content.Visible = not minimized
end)

CloseBtn.MouseButton1Click:Connect(function()
    tween(Main, 0.22, { Size = UDim2.new(0, 0, 0, 0) })
    task.delay(0.22, function() ScreenGui:Destroy() end)
end)

--=============================================================
--  13. ВКЛАДКИ
--=============================================================

-- === ГЛАВНАЯ ===
local home = createTab("Главная", "🧸")
makeLabel(home, "Добро пожаловать в " .. CONFIG.Title, false)
makeLabel(home, "Place ID: " .. tostring(game.PlaceId), true)
makeLabel(home, "Игроков: " .. #Players:GetPlayers(), true)

local detectedGame = GAMES[game.PlaceId]
makeLabel(home, detectedGame and ("🎮 " .. detectedGame.name) or "❌ Игра не в базе", true)

makeButton(home, "📥 Загрузить скрипт для этой игры", function()
    if not detectedGame then
        warn("[GB] Игра не поддерживается.")
        return
    end
    local ok, err = pcall(function()
        loadstring(game:HttpGet(detectedGame.url))()
    end)
    if ok then
        print("[GB] Скрипт загружен: " .. detectedGame.name)
    else
        warn("[GB] Ошибка: " .. tostring(err))
    end
end)

-- === ИГРОК ===
local playerPage = createTab("Игрок", "👤")

local infJumpConn
makeToggle(playerPage, "Бесконечный прыжок", false, function(state)
    if state then
        if infJumpConn then infJumpConn:Disconnect() end
        infJumpConn = UIS.JumpRequest:Connect(function()
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
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

-- === ТЕЛЕПОРТ ===
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
    if hrp then _G.__BearPos = hrp.Position end
end)

makeButton(tpPage, "↩️ Вернуться", function()
    if _G.__BearPos then tpTo(_G.__BearPos) end
end)

-- === ВИЗУАЛ ===
local visualPage = createTab("Визуал", "🎨")

makeToggle(visualPage, "Fullbright", false, function(state)
    if state then
        Lighting.Brightness = 3
        Lighting.ClockTime = 14
        Lighting.FogEnd = 1e6
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = 2
        Lighting.GlobalShadows = true
    end
end)

makeToggle(visualPage, "Убрать туман", false, function(state)
    Lighting.FogEnd = state and 1e6 or 100000
end)

-- ESP игроков
local espFolder = new("Folder", { Parent = ScreenGui, Name = "ESP" })
local espAdded

makeToggle(visualPage, "Player ESP", false, function(state)
    for _, v in pairs(espFolder:GetChildren()) do v:Destroy() end
    if not state then
        if espAdded then espAdded:Disconnect(); espAdded = nil end
        return
    end

    local function addESP(plr)
        if plr == LP then return end
        local function setup(char)
            local head = char:WaitForChild("Head", 5)
            if not head then return end
            local bb = new("BillboardGui", {
                Parent = espFolder,
                Adornee = head,
                Size = UDim2.new(0, 120, 0, 32),
                StudsOffset = Vector3.new(0, 3.2, 0),
                AlwaysOnTop = true,
            })
            new("TextLabel", {
                Parent = bb,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = plr.Name,
                Font = Enum.Font.GothamBold,
                TextSize = 14,
                TextColor3 = CONFIG.NeonPink,
                TextStrokeTransparency = 0.3,
            })
            char.AncestryChanged:Connect(function()
                if not char:IsDescendantOf(game) then bb:Destroy() end
            end)
        end
        if plr.Character then setup(plr.Character) end
        plr.CharacterAdded:Connect(setup)
    end

    for _, p in pairs(Players:GetPlayers()) do addESP(p) end
    espAdded = Players.PlayerAdded:Connect(addESP)
end)

--=============================================================
--  14. ХОТКЕЙ
--=============================================================
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == CONFIG.Keybind then
        Main.Visible = not Main.Visible
    end
end)

--=============================================================
--  15. АНИМАЦИЯ ПОЯВЛЕНИЯ
--=============================================================
Main.Size = UDim2.new(0, 0, 0, 0)
tween(Main, 0.35, { Size = UDim2.new(0, 560, 0, 380) })

print("[Gummy Bear Hub] Загружено! Place ID: " .. tostring(game.PlaceId))
