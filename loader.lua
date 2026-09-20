--=============================================================
--  GUMMY BEAR HUB v6.0 — BloxStrike Edition
--  Собственный чит для BloxStrike
--=============================================================

-- ОЧИСТКА СТАРЫХ ПАНЕЛЕЙ
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

for _, g in pairs(PG:GetChildren()) do
    if g.Name:match("^GummyBear_") then g:Destroy() end
end

-- КОНФИГ
local CONFIG = {
    Title = "Gummy Bear Hub",
    Version = "v6.0",
    NeonPink   = Color3.fromRGB(255, 40, 160),
    NeonPurple = Color3.fromRGB(150, 70, 255),
    NeonBlue   = Color3.fromRGB(60, 180, 255),
    CardDark   = Color3.fromRGB(32, 24, 52),
    TextMain   = Color3.fromRGB(245, 240, 255),
    TextSub    = Color3.fromRGB(170, 160, 200),
    Keybind    = Enum.KeyCode.RightShift,
}

-- БАЗА ИГР
local GAMES = {
    [114234929420007] = { name = "BloxStrike", url = "" },
}

-- СЕРВИСЫ
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- УТИЛИТЫ
local function new(cls, props)
    local o = Instance.new(cls)
    for k, v in pairs(props or {}) do o[k] = v end
    return o
end
local function corner(p, r)
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r or 10); c.Parent = p; return c
end
local function stroke(p, c, th, tr)
    local s = Instance.new("UIStroke"); s.Color = c or CONFIG.NeonPurple; s.Thickness = th or 1.5; s.Transparency = tr or 0.4; s.Parent = p; return s
end
local function tween(o, t, props)
    TweenService:Create(o, TweenInfo.new(t or 0.2), props):Play()
end

-- ГЛАВНАЯ ПАНЕЛЬ
local ScreenGui = new("ScreenGui", { Name = "GummyBear_" .. math.random(100000, 999999), ResetOnSpawn = false, IgnoreGuiInset = true, Parent = PG })
local Main = new("Frame", { Name = "Main", Parent = ScreenGui, BackgroundColor3 = Color3.fromRGB(12, 8, 22), BorderSizePixel = 0, Size = UDim2.new(0, 560, 0, 380), Position = UDim2.new(0.5, -280, 0.5, -190), Active = true })
corner(Main, 18); stroke(Main, CONFIG.NeonPurple, 2, 0.2)

-- ВЕРХНЯЯ ПАНЕЛЬ
local TopBar = new("Frame", { Parent = Main, BackgroundColor3 = Color3.fromRGB(22, 16, 38), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 52) })
corner(TopBar, 18)
new("Frame", { Parent = TopBar, BackgroundColor3 = Color3.fromRGB(22, 16, 38), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 16), Position = UDim2.new(0, 0, 1, -16) })
new("Frame", { Parent = TopBar, BackgroundColor3 = CONFIG.NeonPink, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 2), Position = UDim2.new(0, 0, 1, -2) })
local icon = new("Frame", { Parent = TopBar, BackgroundColor3 = CONFIG.NeonPink, BorderSizePixel = 0, Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(0, 12, 0.5, -16) })
corner(icon, 999)
new("TextLabel", { Parent = icon, BackgroundTransparency = 1, Text = "🧸", Font = Enum.Font.GothamBold, TextSize = 18, Size = UDim2.new(1, 0, 1, 0) })
new("TextLabel", { Parent = TopBar, BackgroundTransparency = 1, Text = CONFIG.Title .. "  •  " .. CONFIG.Version, Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = CONFIG.TextMain, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, -140, 1, 0), Position = UDim2.new(0, 54, 0, 0) })

local function topBtn(txt, xOff, color)
    local b = new("TextButton", { Parent = TopBar, BackgroundColor3 = color, BorderSizePixel = 0, Text = txt, Font = Enum.Font.GothamBold, TextSize = 15, TextColor3 = CONFIG.TextMain, Size = UDim2.new(0, 30, 0, 30), Position = UDim2.new(1, xOff, 0.5, -15), AutoButtonColor = false })
    corner(b, 10); stroke(b, color, 1, 0.5); return b
end
local MinBtn = topBtn("—", -78, CONFIG.NeonPurple)
local CloseBtn = topBtn("✕", -42, CONFIG.NeonPink)

-- ЛЕВОЕ МЕНЮ
local TabBar = new("Frame", { Parent = Main, BackgroundColor3 = Color3.fromRGB(22, 16, 38), BorderSizePixel = 0, Size = UDim2.new(0, 145, 1, -52), Position = UDim2.new(0, 0, 0, 52) })
new("Frame", { Parent = TabBar, BackgroundColor3 = CONFIG.NeonPurple, BorderSizePixel = 0, Size = UDim2.new(0, 2, 1, 0), Position = UDim2.new(1, -2, 0, 0) })
local TabList = new("Frame", { Parent = TabBar, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -16), Position = UDim2.new(0, 0, 0, 12) })
new("UIListLayout", { Parent = TabList, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center })

-- КОНТЕНТ
local Content = new("Frame", { Parent = Main, BackgroundTransparency = 1, Size = UDim2.new(1, -145, 1, -52), Position = UDim2.new(0, 145, 0, 52) })
local Pages, ActiveTab = {}, nil

local function createTab(name, ico)
    local btn = new("TextButton", { Parent = TabList, BackgroundColor3 = CONFIG.CardDark, BorderSizePixel = 0, Text = "  " .. ico .. "   " .. name, Font = Enum.Font.GothamMedium, TextSize = 13, TextColor3 = CONFIG.TextSub, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, -18, 0, 38), AutoButtonColor = false })
    corner(btn, 10); stroke(btn, CONFIG.NeonPurple, 1, 0.7)
    local page = new("ScrollingFrame", { Parent = Content, BackgroundTransparency = 1, Size = UDim2.new(1, -24, 1, -24), Position = UDim2.new(0, 12, 0, 12), CanvasSize = UDim2.new(0, 0, 0, 1000), ScrollBarThickness = 4, ScrollBarImageColor3 = CONFIG.NeonPink, BorderSizePixel = 0, Visible = false })
    new("UIListLayout", { Parent = page, Padding = UDim.new(0, 9), SortOrder = Enum.SortOrder.LayoutOrder })
    new("UIPadding", { Parent = page, PaddingRight = UDim.new(0, 6), PaddingBottom = UDim.new(0, 8) })
    Pages[name] = { button = btn, page = page }
    btn.MouseButton1Click:Connect(function()
        if ActiveTab == name then return end
        ActiveTab = name
        for n, d in pairs(Pages) do
            local a = (n == name)
            d.page.Visible = a
            tween(d.button, 0.2, { BackgroundColor3 = a and CONFIG.NeonPurple or CONFIG.CardDark, TextColor3 = a and Color3.new(1,1,1) or CONFIG.TextSub })
        end
    end)
    if not ActiveTab then ActiveTab = name; btn.BackgroundColor3 = CONFIG.NeonPurple; btn.TextColor3 = Color3.new(1,1,1); page.Visible = true end
    return page
end

-- ЭЛЕМЕНТЫ UI
local function makeButton(parent, text, cb)
    local wrap = new("Frame", { Parent = parent, BackgroundColor3 = CONFIG.CardDark, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 38) })
    corner(wrap, 10); stroke(wrap, CONFIG.NeonPurple, 1.5, 0.4)
    local btn = new("TextButton", { Parent = wrap, BackgroundTransparency = 1, Text = text, Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = CONFIG.TextMain, Size = UDim2.new(1, 0, 1, 0), AutoButtonColor = false })
    btn.MouseButton1Click:Connect(function()
        tween(wrap, 0.08, { BackgroundColor3 = CONFIG.NeonPink })
        task.delay(0.15, function() tween(wrap, 0.2, { BackgroundColor3 = CONFIG.CardDark }) end)
        if cb then pcall(cb) end
    end)
    return btn
end

local function makeToggle(parent, text, default, cb)
    local state = default or false
    local wrap = new("TextButton", { Parent = parent, BackgroundColor3 = CONFIG.CardDark, BorderSizePixel = 0, Text = "", Size = UDim2.new(1, 0, 0, 38), AutoButtonColor = false })
    corner(wrap, 10); stroke(wrap, CONFIG.NeonPurple, 1.5, 0.4)
    new("TextLabel", { Parent = wrap, BackgroundTransparency = 1, Text = text, Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = CONFIG.TextMain, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, -70, 1, 0), Position = UDim2.new(0, 14, 0, 0) })
    local switch = new("Frame", { Parent = wrap, BackgroundColor3 = state and CONFIG.NeonPink or Color3.fromRGB(60, 50, 90), BorderSizePixel = 0, Size = UDim2.new(0, 40, 0, 22), Position = UDim2.new(1, -54, 0.5, -11) })
    corner(switch, 999)
    local knob = new("Frame", { Parent = switch, BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Size = UDim2.new(0, 16, 0, 16), Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 3, 0.5, -8) })
    corner(knob, 999)
    local function setState(v)
        state = v
        tween(switch, 0.2, { BackgroundColor3 = state and CONFIG.NeonPink or Color3.fromRGB(60, 50, 90) })
        tween(knob, 0.2, { Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 3, 0.5, -8) })
        if cb then pcall(cb, state) end
    end
    wrap.MouseButton1Click:Connect(function() setState(not state) end)
    return { set = setState }
end

local function makeLabel(parent, text, isSub)
    return new("TextLabel", { Parent = parent, BackgroundTransparency = 1, Text = text, Font = isSub and Enum.Font.Gotham or Enum.Font.GothamBold, TextSize = isSub and 12 or 14, TextColor3 = isSub and CONFIG.TextSub or CONFIG.TextMain, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, 0, 0, isSub and 22 or 28) })
end

-- DRAG ПАНЕЛИ
do
    local dragging, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = Main.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
end

-- КНОПКИ ЗАГОЛОВКА
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    tween(Main, 0.3, { Size = minimized and UDim2.new(0, 560, 0, 52) or UDim2.new(0, 560, 0, 380) })
    TabBar.Visible = not minimized; Content.Visible = not minimized
end)
CloseBtn.MouseButton1Click:Connect(function()
    tween(Main, 0.22, { Size = UDim2.new(0, 0, 0, 0) })
    task.delay(0.22, function() ScreenGui:Destroy() end)
end)

-- ВКЛАДКИ
local home = createTab("Главная", "🧸")
makeLabel(home, "Добро пожаловать в " .. CONFIG.Title, false)
makeLabel(home, "Place ID: " .. tostring(game.PlaceId), true)
local detectedGame = GAMES[game.PlaceId]
makeLabel(home, detectedGame and ("🎮 " .. detectedGame.name) or "❌ Игра не в базе", true)

-- СПЕЦИАЛЬНАЯ ВКЛАДКА ДЛЯ BLOXSTRIKE
local BLOXSTRIKE_ID = 114234929420007
if game.PlaceId == BLOXSTRIKE_ID then
    local bs = createTab("BloxStrike", "🔫")
    makeLabel(bs, "🎯 Обнаружен BloxStrike", false)
    makeLabel(bs, "Настрой точность и видимость", true)

    -- No Recoil / Spread / Camera Shake
    makeToggle(bs, "No Recoil / Spread / Camera Shake", false, function(state)
        if state then
            local CameraController = require(ReplicatedStorage.Controllers.CameraController)
            CameraController.weaponKick = function() end
            CameraController.setWeaponRecoil = function() end
            local InventoryController = require(ReplicatedStorage.Controllers.InventoryController)
            if InventoryController and InventoryController.ShootWeapon then
                local OriginalShoot = InventoryController.ShootWeapon
                InventoryController.ShootWeapon = function(Self, Data)
                    if Data and Data.Bullets then
                        local LookVector = workspace.CurrentCamera.CFrame.LookVector
                        for _, Bullet in ipairs(Data.Bullets) do
                            if Bullet and Bullet.Direction then
                                Bullet.Direction = LookVector
                            end
                        end
                    end
                    return OriginalShoot(Self, Data)
                end
            end
        else
            -- Восстановление оригинальных функций потребует перезахода
            print("[GB] Перезайди в игру, чтобы выключить No Recoil")
        end
    end)

    -- ESP игроков
    local espFolder = new("Folder", { Parent = ScreenGui, Name = "GB_ESP" })
    local espActive = false

    makeToggle(bs, "Player ESP (с проверкой на союзников)", false, function(state)
        espActive = state
        for _, v in pairs(espFolder:GetChildren()) do v:Destroy() end
        if not state then return end

        local function isTeammate(plr)
            return plr.Team and LP.Team and plr.Team == LP.Team
        end

        task.spawn(function()
            while espActive do
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LP and plr.Character then
                        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                        local head = plr.Character:FindFirstChild("Head")
                        if hrp and head then
                            local highlight = plr.Character:FindFirstChild("GB_Highlight")
                            if not highlight then
                                highlight = new("Highlight", { Parent = plr.Character, Name = "GB_Highlight", DepthMode = Enum.HighlightDepthMode.AlwaysOnTop })
                            end
                            if isTeammate(plr) then
                                highlight.FillColor = Color3.fromRGB(0, 160, 255) -- Синий для союзников
                                highlight.OutlineColor = Color3.fromRGB(0, 160, 255)
                            else
                                highlight.FillColor = Color3.fromRGB(255, 140, 0) -- Оранжевый для врагов
                                highlight.OutlineColor = Color3.fromRGB(255, 140, 0)
                            end

                            -- ESP ник (BillboardGui)
                            if not head:FindFirstChild("GB_ESP") then
                                local bb = new("BillboardGui", { Parent = head, Name = "GB_ESP", Size = UDim2.new(0, 100, 0, 30), StudsOffset = Vector3.new(0, 2, 0), AlwaysOnTop = true })
                                new("TextLabel", { Parent = bb, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Text = plr.Name, Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = isTeammate(plr) and Color3.fromRGB(0, 160, 255) or Color3.fromRGB(255, 140, 0), TextStrokeTransparency = 0.3 })
                            end
                        end
                    end
                end
                task.wait(0.3)
            end
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character then
                    local h = plr.Character:FindFirstChild("GB_Highlight")
                    if h then h:Destroy() end
                    local head = plr.Character:FindFirstChild("Head")
                    if head and head:FindFirstChild("GB_ESP") then head.GB_ESP:Destroy() end
                end
            end
        end)
    end)
end

-- ХОТКЕЙ И АНИМАЦИЯ
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == CONFIG.Keybind then Main.Visible = not Main.Visible end
end)
Main.Size = UDim2.new(0, 0, 0, 0)
tween(Main, 0.35, { Size = UDim2.new(0, 560, 0, 380) })
print("[Gummy Bear Hub] Загружено! Place ID: " .. tostring(game.PlaceId))
