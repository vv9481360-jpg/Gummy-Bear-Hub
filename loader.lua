--=============================================================
--  GUMMY BEAR HUB v7.0 — Universal Cheat Panel
--  Одна панель для всех игр, все читы внутри
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

--=============================================================
--  2. КОНФИГ
--=============================================================
local CONFIG = {
    Title = "Gummy Bear Hub",
    Version = "v7.0",
    NeonPink   = Color3.fromRGB(255, 40, 160),
    NeonPurple = Color3.fromRGB(150, 70, 255),
    NeonBlue   = Color3.fromRGB(60, 180, 255),
    NeonCyan   = Color3.fromRGB(80, 240, 255),
    CardDark   = Color3.fromRGB(32, 24, 52),
    TextMain   = Color3.fromRGB(245, 240, 255),
    TextSub    = Color3.fromRGB(170, 160, 200),
    Keybind    = Enum.KeyCode.RightShift,
}

--=============================================================
--  3. БИБЛИОТЕКА ЧИТОВ
--     Формат: [PlaceId] = { { name, url, author }, ... }
--     Одна игра может иметь несколько скриптов
--=============================================================
local CHEAT_LIBRARY = {
    -- BLOXSTRIKE (114234929420007)
    [114234929420007] = {
        { name = "NickHub (Aimbot + ESP)", url = "https://raw.githubusercontent.com/Nickk-GG/BloxStrike-NickHub-New-Gen/refs/heads/main/sc.lua", author = "Nickk-GG" },
        { name = "No Recoil (без ключа)", url = "https://xenoscripts.com/script/bloxstrike-no-recoil-script-keyless", author = "Xeno" },
        { name = "Spiem Hub (универсальный)", url = "https://raw.githubusercontent.com/perfectusmim1/spiemhub/refs/heads/main/loader", author = "Spiem" },
    },
    
    -- BLOX FRUITS (2753915549)
    [2753915549] = {
        { name = "Blox Fruits Hub", url = "https://example.com/bloxfruits.lua", author = "Unknown" },
    },
    
    -- BROOKHAVEN (4924922222)
    [4924922222] = {
        { name = "Brookhaven Admin", url = "https://example.com/brookhaven.lua", author = "Unknown" },
    },
    
    -- DOORS (6516141723)
    [6516141723] = {
        { name = "Doors ESP", url = "https://example.com/doors.lua", author = "Unknown" },
    },
    
    -- DA HOOD (2788229376)
    [2788229376] = {
        { name = "Da Hood Aim", url = "https://example.com/dahood.lua", author = "Unknown" },
    },
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
    Size = UDim2.new(0, 560, 0, 400),
    Position = UDim2.new(0.5, -280, 0.5, -200),
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
--  9. КОНТЕНТ
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
--  10. UI-ЭЛЕМЕНТЫ
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
    tween(Main, 0.3, { Size = minimized and UDim2.new(0, 560, 0, 52) or UDim2.new(0, 560, 0, 400) })
    TabBar.Visible = not minimized
    Content.Visible = not minimized
end)

CloseBtn.MouseButton1Click:Connect(function()
    tween(Main, 0.22, { Size = UDim2.new(0, 0, 0, 0) })
    task.delay(0.22, function() ScreenGui:Destroy() end)
end)

--=============================================================
--  13. ВКЛАДКА "ГЛАВНАЯ"
--=============================================================
local homePage = createTab("Главная", "🧸")
makeLabel(homePage, "Добро пожаловать в " .. CONFIG.Title, false)
makeLabel(homePage, "Place ID: " .. tostring(game.PlaceId), true)
makeLabel(homePage, "Игроков: " .. #Players:GetPlayers(), true)

local detectedGame = CHEAT_LIBRARY[game.PlaceId]
makeLabel(homePage, detectedGame and ("🎮 " .. tostring(#detectedGame) .. " читов доступно") or "❌ Игра не в базе", true)

--=============================================================
--  14. ВКЛАДКА "БИБЛИОТЕКА" (все читы для текущей игры)
--=============================================================
local libPage = createTab("Библиотека", "📚")

if detectedGame then
    makeDivider(libPage, "Доступно для этой игры")
    
    -- Кнопка "Загрузить ВСЕ"
    makeButton(libPage, "⚡ Загрузить ВСЕ " .. #detectedGame .. " читов", function()
        for _, cheat in ipairs(detectedGame) do
            local ok, err = pcall(function()
                loadstring(game:HttpGet(cheat.url))()
            end)
            if ok then
                print("[GB] Загружено: " .. cheat.name)
            else
                warn("[GB] Ошибка " .. cheat.name .. ": " .. tostring(err))
            end
            task.wait(0.5) -- пауза между загрузками
        end
    end)
    
    makeDivider(libPage, "Отдельные читы")
    
    -- Кнопка для каждого чита
    for i, cheat in ipairs(detectedGame) do
        makeButton(libPage, "📥 " .. cheat.name, function()
            local ok, err = pcall(function()
                loadstring(game:HttpGet(cheat.url))()
            end)
            if ok then
                print("[GB] Загружено: " .. cheat.name)
            else
                warn("[GB] Ошибка: " .. tostring(err))
            end
        end)
        makeLabel(libPage, "   Автор: " .. cheat.author, true)
    end
else
    makeLabel(libPage, "❌ Для этой игры читов нет", false)
    makeLabel(libPage, "Place ID: " .. tostring(game.PlaceId), true)
    makeLabel(libPage, "Добавь её в CHEAT_LIBRARY в коде", true)
end

--=============================================================
--  15. ВКЛАДКА "ВСЕ ИГРЫ" (список всех игр в библиотеке)
--=============================================================
local allPage = createTab("Все игры", "🎮")

local gameCount = 0
for id, list in pairs(CHEAT_LIBRARY) do
    gameCount = gameCount + 1
end

makeDivider(allPage, "Всего игр: " .. gameCount)

for id, list in pairs(CHEAT_LIBRARY) do
    local firstName = list[1] and list[1].name or "Unknown"
    makeButton(allPage, "🎮 " .. firstName .. " (" .. tostring(#list) .. " читов)", function()
        for _, cheat in ipairs(list) do
            local ok = pcall(function()
                loadstring(game:HttpGet(cheat.url))()
            end)
            if ok then print("[GB] Загружено: " .. cheat.name) end
            task.wait(0.3)
        end
    end)
end

--=============================================================
--  16. ВКЛАДКА "ИГРОК"
--=============================================================
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

--=============================================================
--  17. ВКЛАДКА "ВИЗУАЛ"
--=============================================================
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

--=============================================================
--  18. ХОТКЕЙ
--=============================================================
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == CONFIG.Keybind then
        Main.Visible = not Main.Visible
    end
end)

--=============================================================
--  19. АНИМАЦИЯ ПОЯВЛЕНИЯ
--=============================================================
Main.Size = UDim2.new(0, 0, 0, 0)
tween(Main, 0.35, { Size = UDim2.new(0, 560, 0, 400) })

print("[Gummy Bear Hub] Загружено! Place ID: " .. tostring(game.PlaceId))
print("[Gummy Bear Hub] Игр в библиотеке: " .. tostring(gameCount))
if detectedGame then
    print("[Gummy Bear Hub] Для этой игры доступно читов: " .. tostring(#detectedGame))
end
