-- ═══════════════════════════════════════════════════════
-- DYV HUB | The Classic Soccer
-- v0.4
-- ═══════════════════════════════════════════════════════

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- LIMPAR EXECUÇÃO ANTERIOR
pcall(function()
    if CoreGui:FindFirstChild("DyvHub") then
        CoreGui:FindFirstChild("DyvHub"):Destroy()
    end
end)
pcall(function()
    if player.PlayerGui:FindFirstChild("DyvHub") then
        player.PlayerGui:FindFirstChild("DyvHub"):Destroy()
    end
end)

-- CONFIG
local CORES = {
    {N="Azul",         C=Color3.fromRGB(40,130,255)},
    {N="Laranja",      C=Color3.fromRGB(255,150,30)},
    {N="Amarelo",      C=Color3.fromRGB(255,220,30)},
    {N="Roxo",         C=Color3.fromRGB(155,55,255)},
    {N="Rosa",         C=Color3.fromRGB(255,85,185)},
    {N="Vermelho",     C=Color3.fromRGB(255,45,45)},
    {N="Verde Claro",  C=Color3.fromRGB(90,255,120)},
    {N="RGB",          C=nil},
}

local TEXTURAS_PRONTAS = {
    {N="Bola 1", ID="rbxassetid://18320818504"},
    {N="Bola 2", ID="rbxassetid://80891382256138"},
    {N="Bola 3", ID="rbxassetid://18320818504"},
}

local SKYBOX_IDS = {
    {N="Sky 1", ID="rbxassetid://15803128405"},
    {N="Sky 2", ID="rbxassetid://4604073339"},
    {N="Sky 3", ID="rbxassetid://15387348852"},
    {N="Sky 4", ID="rbxassetid://16573649975"},
}

local TEMAS = {
    {N="Verde",        C=Color3.fromRGB(45,180,80),   LED=Color3.fromRGB(90,255,120), Sidebar=Color3.fromRGB(12,55,30)},
    {N="Preto",        C=Color3.fromRGB(60,60,60),    LED=Color3.fromRGB(180,180,180), Sidebar=Color3.fromRGB(25,25,25)},
    {N="Roxo",         C=Color3.fromRGB(140,70,220),  LED=Color3.fromRGB(190,120,255), Sidebar=Color3.fromRGB(45,20,70)},
    {N="Azul Escuro",  C=Color3.fromRGB(40,80,180),   LED=Color3.fromRGB(90,150,255),  Sidebar=Color3.fromRGB(15,25,60)},
    {N="Vermelho",     C=Color3.fromRGB(200,50,50),   LED=Color3.fromRGB(255,90,90),   Sidebar=Color3.fromRGB(60,15,15)},
}

-- GUI RAIZ
local gui = Instance.new("ScreenGui")
gui.Name = "DyvHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true

local ok = pcall(function() gui.Parent = CoreGui end)
if not ok then
    pcall(function() gui.Parent = player:WaitForChild("PlayerGui") end)
end

-- SOM
local som = Instance.new("Sound")
som.SoundId = "rbxassetid://82149511707056"
som.Volume = 0.35
som.Looped = true
som.Parent = SoundService
task.spawn(function() pcall(function() som:Play() end) end)

-- SPLASH (cobre TUDO)
local splash = Instance.new("Frame")
splash.Size = UDim2.new(1, 0, 1, 0)
splash.Position = UDim2.new(0, 0, 0, 0)
splash.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
splash.BackgroundTransparency = 0
splash.BorderSizePixel = 0
splash.ZIndex = 999
splash.Parent = gui

local splashTitle = Instance.new("TextLabel")
splashTitle.Size = UDim2.new(1,0,0,60)
splashTitle.Position = UDim2.new(0,0,0.5,-60)
splashTitle.BackgroundTransparency = 1
splashTitle.Text = "DYV HUB"
splashTitle.TextColor3 = Color3.fromRGB(90,255,120)
splashTitle.TextSize = 48
splashTitle.Font = Enum.Font.GothamBlack
splashTitle.TextTransparency = 1
splashTitle.ZIndex = 1000
splashTitle.Parent = splash

local splashSub = Instance.new("TextLabel")
splashSub.Size = UDim2.new(1,0,0,30)
splashSub.Position = UDim2.new(0,0,0.5,10)
splashSub.BackgroundTransparency = 1
splashSub.Text = "tcs"
splashSub.TextColor3 = Color3.fromRGB(90,255,120)
splashSub.TextSize = 22
splashSub.Font = Enum.Font.GothamBold
splashSub.TextTransparency = 1
splashSub.ZIndex = 1000
splashSub.Parent = splash

task.spawn(function()
    TweenService:Create(splashTitle, TweenInfo.new(1.5), {TextTransparency=0}):Play()
    TweenService:Create(splashSub, TweenInfo.new(1.5), {TextTransparency=0}):Play()
end)

task.delay(4, function()
    TweenService:Create(splashTitle, TweenInfo.new(3), {TextTransparency=1}):Play()
    TweenService:Create(splashSub, TweenInfo.new(3), {TextTransparency=1}):Play()
    TweenService:Create(splash, TweenInfo.new(3), {BackgroundTransparency=1}):Play()
    task.wait(3.2)
    splash:Destroy()
end)

-- BOTÃO FLUTUANTE "DYV"
local botaoFlutuante = Instance.new("TextButton")
botaoFlutuante.Size = UDim2.fromOffset(60,60)
botaoFlutuante.Position = UDim2.new(0,20,0.5,-30)
botaoFlutuante.BackgroundColor3 = Color3.fromRGB(20,80,45)
botaoFlutuante.Text = "DYV"
botaoFlutuante.TextColor3 = Color3.fromRGB(90,255,120)
botaoFlutuante.TextSize = 16
botaoFlutuante.Font = Enum.Font.GothamBlack
botaoFlutuante.BorderSizePixel = 0
botaoFlutuante.Active = true
botaoFlutuante.Draggable = true
botaoFlutuante.ZIndex = 50
botaoFlutuante.Parent = gui
Instance.new("UICorner", botaoFlutuante).CornerRadius = UDim.new(1,0)

local botaoStroke = Instance.new("UIStroke")
botaoStroke.Color = Color3.fromRGB(45,180,80)
botaoStroke.Thickness = 2
botaoStroke.Transparency = 0.2
botaoStroke.Parent = botaoFlutuante

-- PAINEL PRINCIPAL
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(420, 220)
main.Position = UDim2.new(0.5,-210,0.5,-110)
main.BackgroundColor3 = Color3.fromRGB(14,14,22)
main.BorderSizePixel = 0
main.Active = true
main.Visible = false
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

local strokeMain = Instance.new("UIStroke")
strokeMain.Color = Color3.fromRGB(45,180,80)
strokeMain.Thickness = 2
strokeMain.Transparency = 0.2
strokeMain.Parent = main

-- LED RODANDO
local LED_QTD = 20
local leds = {}

for i = 1, LED_QTD do
    local led = Instance.new("Frame")
    led.Size = UDim2.fromOffset(6,6)
    led.BackgroundColor3 = Color3.fromRGB(90,255,120)
    led.BorderSizePixel = 0
    led.ZIndex = 3
    led.Parent = main
    Instance.new("UICorner", led).CornerRadius = UDim.new(1,0)
    table.insert(leds, led)
end

local angle = 0
RunService.RenderStepped:Connect(function(dt)
    angle = (angle + dt * 1.4) % 1
    local w = main.AbsoluteSize.X
    local h = main.AbsoluteSize.Y
    if w < 10 then return end
    for i, led in ipairs(leds) do
        local t = (angle + (i-1)/LED_QTD) % 1
        local x, y
        local per = 2*(w+h)
        local d = t * per
        if d < w then
            x, y = d, 0
        elseif d < w + h then
            x, y = w, d - w
        elseif d < 2*w + h then
            x, y = w - (d - w - h), h
        else
            x, y = 0, h - (d - 2*w - h)
        end
        led.Position = UDim2.fromOffset(x - 3, y - 3)
        local tail = (i-1)/LED_QTD
        led.BackgroundTransparency = tail * 0.85
    end
end)

-- TITLE BAR
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1,0,0,32)
titleBar.BackgroundColor3 = Color3.fromRGB(18,18,30)
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 5
titleBar.Active = true
titleBar.Parent = main
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0,14)

local titleLbl = Instance.new("TextLabel")
titleLbl.Size = UDim2.new(1,-80,1,0)
titleLbl.Position = UDim2.fromOffset(14,0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "DYV HUB"
titleLbl.TextColor3 = Color3.fromRGB(90,255,120)
titleLbl.TextSize = 13
titleLbl.Font = Enum.Font.GothamBlack
titleLbl.TextXAlignment = Enum.TextXAlignment.Left
titleLbl.ZIndex = 5
titleLbl.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.fromOffset(24,24)
closeBtn.Position = UDim2.new(1,-30,0.5,-12)
closeBtn.BackgroundColor3 = Color3.fromRGB(170,40,50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.TextSize = 11
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 5
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,8)

-- SIDEBAR SCROLLÁVEL + BUSCA
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0,120,1,-42)
sidebar.Position = UDim2.fromOffset(10,36)
sidebar.BackgroundColor3 = Color3.fromRGB(12,55,30)
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 4
sidebar.ClipsDescendants = true
sidebar.Parent = main
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,10)

-- Barra de busca
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1,-8,0,24)
searchBox.Position = UDim2.fromOffset(4,4)
searchBox.BackgroundColor3 = Color3.fromRGB(8,35,20)
searchBox.BorderSizePixel = 0
searchBox.PlaceholderText = "🔍 Buscar..."
searchBox.Text = ""
searchBox.TextColor3 = Color3.fromRGB(200,255,215)
searchBox.PlaceholderColor3 = Color3.fromRGB(120,180,140)
searchBox.TextSize = 10
searchBox.Font = Enum.Font.Gotham
searchBox.ZIndex = 6
searchBox.Parent = sidebar
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0,6)

local searchStroke = Instance.new("UIStroke")
searchStroke.Color = Color3.fromRGB(45,180,80)
searchStroke.Thickness = 1
searchStroke.Transparency = 0.5
searchStroke.Parent = searchBox

-- ScrollingFrame pra botões
local sbScroll = Instance.new("ScrollingFrame")
sbScroll.Size = UDim2.new(1,-4,1,-36)
sbScroll.Position = UDim2.fromOffset(2,32)
sbScroll.BackgroundTransparency = 1
sbScroll.BorderSizePixel = 0
sbScroll.ScrollBarThickness = 3
sbScroll.ScrollBarImageColor3 = Color3.fromRGB(90,255,120)
sbScroll.ScrollBarImageTransparency = 0.4
sbScroll.CanvasSize = UDim2.fromOffset(0,0)
sbScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
sbScroll.ScrollingDirection = Enum.ScrollingDirection.Y
sbScroll.ElasticBehavior = Enum.ElasticBehavior.Always
sbScroll.ZIndex = 5
sbScroll.Parent = sidebar

local sbList = Instance.new("UIListLayout")
sbList.SortOrder = Enum.SortOrder.LayoutOrder
sbList.Padding = UDim.new(0,4)
sbList.HorizontalAlignment = Enum.HorizontalAlignment.Center
sbList.Parent = sbScroll

local sbPad = Instance.new("UIPadding")
sbPad.PaddingTop = UDim.new(0,4)
sbPad.PaddingLeft = UDim.new(0,2)
sbPad.PaddingRight = UDim.new(0,2)
sbPad.Parent = sbScroll

local content = Instance.new("Frame")
content.Size = UDim2.new(1,-140,1,-42)
content.Position = UDim2.new(0,136,0,36)
content.BackgroundColor3 = Color3.fromRGB(18,18,30)
content.BorderSizePixel = 0
content.ZIndex = 4
content.Parent = main
Instance.new("UICorner", content).CornerRadius = UDim.new(0,10)

local pages = {}
local botoesSidebar = {}

local function criarPagina(nome)
    local p = Instance.new("ScrollingFrame")
    p.Name = nome
    p.Size = UDim2.new(1,-12,1,-12)
    p.Position = UDim2.fromOffset(6,6)
    p.BackgroundTransparency = 1
    p.BorderSizePixel = 0
    p.ScrollBarThickness = 3
    p.ScrollBarImageColor3 = Color3.fromRGB(90,255,120)
    p.CanvasSize = UDim2.fromOffset(0,0)
    p.AutomaticCanvasSize = Enum.AutomaticSize.Y
    p.Visible = false
    p.ZIndex = 5
    p.Parent = content

    local l = Instance.new("UIListLayout")
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Padding = UDim.new(0,5)
    l.Parent = p

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0,3)
    pad.PaddingLeft = UDim.new(0,3)
    pad.PaddingRight = UDim.new(0,3)
    pad.Parent = p

    pages[nome] = p
    return p
end

local function mostrarPagina(nome)
    for n,p in pairs(pages) do
        p.Visible = (n == nome)
    end
    for n,b in pairs(botoesSidebar) do
        if n == nome then
            b.BackgroundColor3 = Color3.fromRGB(30,120,65)
        else
            b.BackgroundColor3 = Color3.fromRGB(16,70,40)
        end
    end
end

local todosBotoesSidebar = {}

local function criarBotaoSidebar(nome, icone, ordem)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-4,0,26)
    b.BackgroundColor3 = Color3.fromRGB(16,70,40)
    b.BorderSizePixel = 0
    b.Text = icone.."  "..nome
    b.TextColor3 = Color3.fromRGB(200,255,215)
    b.TextSize = 10
    b.Font = Enum.Font.GothamBold
    b.LayoutOrder = ordem
    b.ZIndex = 6
    b.Parent = sbScroll
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    b.MouseButton1Click:Connect(function()
        mostrarPagina(nome)
    end)
    botoesSidebar[nome] = b
    table.insert(todosBotoesSidebar, {Btn=b, Nome=nome})
end

-- BUSCA
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local txt = string.lower(searchBox.Text)
    for _, entry in ipairs(todosBotoesSidebar) do
        if txt == "" then
            entry.Btn.Visible = true
        else
            entry.Btn.Visible = string.find(string.lower(entry.Nome), txt) ~= nil
        end
    end
end)

-- BOTÃO 3D
local function criarBotao3D(parent, texto, cor, callback, ordem)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-6,0,30)
    b.BackgroundColor3 = cor
    b.BorderSizePixel = 0
    b.Text = texto
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.TextSize = 11
    b.Font = Enum.Font.GothamBold
    b.LayoutOrder = ordem
    b.ZIndex = 6
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

    local shine = Instance.new("Frame")
    shine.Size = UDim2.new(1,0,0.5,0)
    shine.BackgroundColor3 = Color3.fromRGB(255,255,255)
    shine.BackgroundTransparency = 0.85
    shine.BorderSizePixel = 0
    shine.ZIndex = 7
    shine.Parent = b
    Instance.new("UICorner", shine).CornerRadius = UDim.new(0,8)

    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(1,0,0.45,0)
    shadow.Position = UDim2.new(0,0,0.55,0)
    shadow.BackgroundColor3 = Color3.fromRGB(0,0,0)
    shadow.BackgroundTransparency = 0.7
    shadow.BorderSizePixel = 0
    shadow.ZIndex = 5
    shadow.Parent = b
    Instance.new("UICorner", shadow).CornerRadius = UDim.new(0,8)

    local st = Instance.new("UIStroke")
    st.Color = Color3.fromRGB(45,180,80)
    st.Thickness = 1.2
    st.Transparency = 0.5
    st.Parent = b

    b.MouseButton1Click:Connect(callback)
    return b
end

-- BILLBOARD "DYV HUB" RGB (MENOR + FIXO)
local char = player.Character or player.CharacterAdded:Wait()
local head = char:WaitForChild("Head", 10)

local billboard = Instance.new("BillboardGui")
billboard.Name = "DyvTag"
billboard.Size = UDim2.fromOffset(100, 20)
billboard.StudsOffset = Vector3.new(0, 2.2, 0)
billboard.AlwaysOnTop = true
billboard.Adornee = head
billboard.Parent = head

local tagLabel = Instance.new("TextLabel")
tagLabel.Size = UDim2.new(1,0,1,0)
tagLabel.BackgroundTransparency = 1
tagLabel.Text = "DYV HUB"
tagLabel.TextColor3 = Color3.fromRGB(90,255,120)
tagLabel.TextStrokeTransparency = 0.3
tagLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
tagLabel.TextScaled = false
tagLabel.TextSize = 14
tagLabel.Font = Enum.Font.GothamBlack
tagLabel.Parent = billboard

task.spawn(function()
    local hue = 0
    while billboard and billboard.Parent do
        hue = (hue + 0.01) % 1
        tagLabel.TextColor3 = Color3.fromHSV(hue, 0.85, 1)
        task.wait(0.05)
    end
end)

player.CharacterAdded:Connect(function(newChar)
    local newHead = newChar:WaitForChild("Head", 10)
    if newHead then
        billboard.Adornee = newHead
        billboard.Parent = newHead
    end
end)

-- PÁGINA FPS
local pFps = criarPagina("FPS")

local fpsOriginal = {
    GlobalShadows = Lighting.GlobalShadows,
    FogEnd = Lighting.FogEnd,
    Brightness = Lighting.Brightness,
}

local function restaurarFps()
    Lighting.GlobalShadows = fpsOriginal.GlobalShadows
    Lighting.FogEnd = fpsOriginal.FogEnd
    Lighting.Brightness = fpsOriginal.Brightness
end

criarBotao3D(pFps, "⚡ FPS Baixo", Color3.fromRGB(30,90,50), function()
    restaurarFps()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 500
end, 1)

criarBotao3D(pFps, "⚡⚡ FPS Médio", Color3.fromRGB(30,110,60), function()
    restaurarFps()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 250
    Lighting.Brightness = 1.5
    pcall(function() Lighting.Terrain.Decoration = false end)
end, 2)

criarBotao3D(pFps, "⚡⚡⚡ FPS Alto", Color3.fromRGB(30,140,70), function()
    restaurarFps()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 100
    Lighting.Brightness = 2
    pcall(function()
        Lighting.Terrain.Decoration = false
        Lighting.Technology = Enum.Technology.Compatibility
    end)
end, 3)

criarBotao3D(pFps, "↩ Restaurar", Color3.fromRGB(70,70,90), function()
    restaurarFps()
end, 4)

-- PÁGINA CÉU
local pCeu = criarPagina("Céu")

local ceuOriginal = {
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    ColorShift_Top = Lighting.ColorShift_Top,
    ColorShift_Bottom = Lighting.ColorShift_Bottom,
}

local rainbowCeuConn = nil

local function pararRainbowCeu()
    if rainbowCeuConn then
        rainbowCeuConn:Disconnect()
        rainbowCeuConn = nil
    end
end

local function aplicarCeu(color)
    pararRainbowCeu()
    Lighting.Ambient = color
    Lighting.OutdoorAmbient = color
    Lighting.ColorShift_Top = color
    Lighting.ColorShift_Bottom = color
end

local function rgbCeu()
    pararRainbowCeu()
    local hue = 0
    rainbowCeuConn = RunService.Heartbeat:Connect(function(dt)
        hue = (hue + dt * 0.4) % 1
        local c = Color3.fromHSV(hue, 0.8, 0.6)
        Lighting.Ambient = c
        Lighting.OutdoorAmbient = c
        Lighting.ColorShift_Top = c
        Lighting.ColorShift_Bottom = c
    end)
end

for i, data in ipairs(CORES) do
    criarBotao3D(pCeu, data.N, data.C or Color3.fromRGB(60,30,90), function()
        if data.C then aplicarCeu(data.C) else rgbCeu() end
    end, i)
end

criarBotao3D(pCeu, "↩ Restaurar", Color3.fromRGB(70,70,90), function()
    pararRainbowCeu()
    Lighting.Ambient = ceuOriginal.Ambient
    Lighting.OutdoorAmbient = ceuOriginal.OutdoorAmbient
    Lighting.ColorShift_Top = ceuOriginal.ColorShift_Top
    Lighting.ColorShift_Bottom = ceuOriginal.ColorShift_Bottom
end, #CORES + 1)

-- PÁGINA SKYBOX
local pSky = criarPagina("Skybox")

local skyOriginal = Lighting:FindFirstChildOfClass("Sky")
local skyBackup = nil

if skyOriginal then
    skyBackup = {
        SkyboxBk = skyOriginal.SkyboxBk,
        SkyboxDn = skyOriginal.SkyboxDn,
        SkyboxFt = skyOriginal.SkyboxFt,
        SkyboxLf = skyOriginal.SkyboxLf,
        SkyboxRt = skyOriginal.SkyboxRt,
        SkyboxUp = skyOriginal.SkyboxUp,
    }
end

local function aplicarSkybox(id)
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if not sky then
        sky = Instance.new("Sky")
        sky.Parent = Lighting
    end
    sky.SkyboxBk = id
    sky.SkyboxDn = id
    sky.SkyboxFt = id
    sky.SkyboxLf = id
    sky.SkyboxRt = id
    sky.SkyboxUp = id
end

local function restaurarSkybox()
    if skyBackup then
        local sky = Lighting:FindFirstChildOfClass("Sky")
        if sky then
            sky.SkyboxBk = skyBackup.SkyboxBk
            sky.SkyboxDn = skyBackup.SkyboxDn
            sky.SkyboxFt = skyBackup.SkyboxFt
            sky.SkyboxLf = skyBackup.SkyboxLf
            sky.SkyboxRt = skyBackup.SkyboxRt
            sky.SkyboxUp = skyBackup.SkyboxUp
        end
    end
end

for i, sky in ipairs(SKYBOX_IDS) do
    criarBotao3D(pSky, "🌌 "..sky.N, Color3.fromRGB(50,50,120), function()
        aplicarSkybox(sky.ID)
    end, i)
end

criarBotao3D(pSky, "↩ Restaurar", Color3.fromRGB(70,70,90), function()
    restaurarSkybox()
end, #SKYBOX_IDS + 1)

-- PÁGINA BALL
local pBall = criarPagina("Ball")

local bolas = {}
local texturasBackup = {}
local rainbowBallConn = nil

local KEYWORDS = {"ball","bola","soccer","futebol","futbol","pelota"}

local function temKeyword(nome)
    local low = string.lower(nome)
    for _, kw in ipairs(KEYWORDS) do
        if string.find(low, kw) then return true end
    end
    return false
end

local function esferica(part)
    local s = part.Size
    local avg = (s.X+s.Y+s.Z)/3
    if avg < 0.5 or avg > 10 then return false end
    local t = avg*0.5
    return math.abs(s.X-avg)<t and math.abs(s.Y-avg)<t and math.abs(s.Z-avg)<t
end

local function scanBolas()
    local found = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if not obj:IsA("BasePart") then continue end
        local match = false
        if temKeyword(obj.Name) then match = true end
        if not match and obj.Parent and obj.Parent ~= workspace and temKeyword(obj.Parent.Name) then
            match = true
        end
        if not match and obj:IsA("MeshPart") and esferica(obj) and not obj.Anchored then
            match = true
        end
        if not match and obj:IsA("Part") then
            pcall(function()
                if obj.Shape == Enum.PartType.Ball and not obj.Anchored then
                    match = true
                end
            end)
        end
        if match then
            found[obj] = true
            if obj.Parent and obj.Parent:IsA("Model") and obj.Parent ~= workspace then
                for _, p in ipairs(obj.Parent:GetDescendants()) do
                    if p:IsA("BasePart") then found[p] = true end
                end
            end
        end
    end
    bolas = {}
    for part, _ in pairs(found) do
        table.insert(bolas, part)
    end
end

local function salvarTexturas()
    for _, part in ipairs(bolas) do
        if texturasBackup[part] then continue end
        local data = {Decals={}}
        pcall(function()
            if part:IsA("MeshPart") and part.TextureID ~= "" then
                data.TextureID = part.TextureID
            end
        end)
        local mesh = part:FindFirstChildWhichIsA("SpecialMesh")
        if mesh then
            pcall(function()
                if mesh.TextureId ~= "" then
                    data.MeshTexId = mesh.TextureId
                    data.Mesh = mesh
                end
            end)
        end
        for _, child in ipairs(part:GetChildren()) do
            if child:IsA("Texture") or child:IsA("Decal") then
                table.insert(data.Decals, {Obj=child, Trans=child.Transparency})
            end
        end
        texturasBackup[part] = data
    end
end

local function removerTexturas()
    for _, part in ipairs(bolas) do
        if not part or not part.Parent then continue end
        pcall(function()
            if part:IsA("MeshPart") then part.TextureID = "" end
        end)
        pcall(function()
            local mesh = part:FindFirstChildWhichIsA("SpecialMesh")
            if mesh then mesh.TextureId = "" end
        end)
        for _, child in ipairs(part:GetChildren()) do
            pcall(function()
                if child:IsA("Texture") or child:IsA("Decal") then
                    child.Transparency = 1
                end
            end)
        end
    end
end

local function restaurarTexturas()
    for part, data in pairs(texturasBackup) do
        if not part or not part.Parent then continue end
        pcall(function()
            if data.TextureID then part.TextureID = data.TextureID end
        end)
        pcall(function()
            if data.MeshTexId and data.Mesh then data.Mesh.TextureId = data.MeshTexId end
        end)
        for _, d in ipairs(data.Decals) do
            pcall(function()
                if d.Obj and d.Obj.Parent then d.Obj.Transparency = d.Trans end
            end)
        end
    end
end

local function pararRainbowBall()
    if rainbowBallConn then
        rainbowBallConn:Disconnect()
        rainbowBallConn = nil
    end
end

local function aplicarCorBall(color)
    pararRainbowBall()
    salvarTexturas()
    removerTexturas()
    for _, part in ipairs(bolas) do
        pcall(function()
            if part and part.Parent then part.Color = color end
        end)
    end
end

local function rgbBall()
    pararRainbowBall()
    salvarTexturas()
    removerTexturas()
    local hue = 0
    rainbowBallConn = RunService.Heartbeat:Connect(function(dt)
        hue = (hue + dt*0.5) % 1
        local c = Color3.fromHSV(hue, 0.85, 1)
        for _, part in ipairs(bolas) do
            pcall(function()
                if part and part.Parent then part.Color = c end
            end)
        end
    end)
end

local function aplicarTexturaBall(id)
    pararRainbowBall()
    salvarTexturas()
    for _, part in ipairs(bolas) do
        pcall(function()
            if part and part.Parent then
                if part:IsA("MeshPart") then
                    part.TextureID = id
                else
                    local mesh = part:FindFirstChildWhichIsA("SpecialMesh")
                    if mesh then mesh.TextureId = id end
                end
            end
        end)
    end
end

criarBotao3D(pBall, "🔍 Detectar Bola", Color3.fromRGB(50,40,140), function()
    scanBolas()
end, 1)

for i, data in ipairs(CORES) do
    criarBotao3D(pBall, data.N, data.C or Color3.fromRGB(60,30,90), function()
        if #bolas == 0 then scanBolas() end
        if data.C then aplicarCorBall(data.C) else rgbBall() end
    end, i+1)
end

local ordemTextura = #CORES + 2
for i, tex in ipairs(TEXTURAS_PRONTAS) do
    criarBotao3D(pBall, "🎨 "..tex.N, Color3.fromRGB(80,50,120), function()
        if #bolas == 0 then scanBolas() end
        aplicarTexturaBall(tex.ID)
    end, ordemTextura + i - 1)
endlocal texBox = Instance.new("TextBox")
texBox.Size = UDim2.new(1,-6,0,30)
texBox.BackgroundColor3 = Color3.fromRGB(25,25,40)
texBox.BorderSizePixel = 0
texBox.PlaceholderText = "Cole o ID da textura..."
texBox.Text = ""
texBox.TextColor3 = Color3.fromRGB(220,220,240)
texBox.PlaceholderColor3 = Color3.fromRGB(120,120,150)
texBox.TextSize = 11
texBox.Font = Enum.Font.Gotham
texBox.LayoutOrder = ordemTextura + #TEXTURAS_PRONTAS
texBox.ZIndex = 6
texBox.Parent = pBall
Instance.new("UICorner", texBox).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke", texBox).Color = Color3.fromRGB(45,180,80)

local aplicarTexBtn = Instance.new("TextButton")
aplicarTexBtn.Size = UDim2.new(1,-6,0,28)
aplicarTexBtn.BackgroundColor3 = Color3.fromRGB(40,130,70)
aplicarTexBtn.BorderSizePixel = 0
aplicarTexBtn.Text = "✔ Aplicar Textura"
aplicarTexBtn.TextColor3 = Color3.fromRGB(255,255,255)
aplicarTexBtn.TextSize = 11
aplicarTexBtn.Font = Enum.Font.GothamBold
aplicarTexBtn.LayoutOrder = ordemTextura + #TEXTURAS_PRONTAS + 1
aplicarTexBtn.ZIndex = 6
aplicarTexBtn.Parent = pBall
Instance.new("UICorner", aplicarTexBtn).CornerRadius = UDim.new(0,8)

aplicarTexBtn.MouseButton1Click:Connect(function()
    local id = texBox.Text
    if id == "" then return end
    if not string.find(id, "rbxassetid://") then
        id = "rbxassetid://" .. id
    end
    if #bolas == 0 then scanBolas() end
    aplicarTexturaBall(id)
end)

criarBotao3D(pBall, "↩ Restaurar", Color3.fromRGB(70,70,90), function()
    pararRainbowBall()
    restaurarTexturas()
end, ordemTextura + #TEXTURAS_PRONTAS + 2)

-- PÁGINA MÚSICA
local pMus = criarPagina("Música")

local musPausada = false

local playPauseBtn = criarBotao3D(pMus, "⏸ Pausar", Color3.fromRGB(40,90,140), function()
    musPausada = not musPausada
    if musPausada then
        pcall(function() som:Pause() end)
        playPauseBtn.Text = "▶ Tocar"
    else
        pcall(function() som:Resume() end)
        playPauseBtn.Text = "⏸ Pausar"
    end
end, 1)

local volFrame = Instance.new("Frame")
volFrame.Size = UDim2.new(1,-6,0,50)
volFrame.BackgroundColor3 = Color3.fromRGB(25,25,40)
volFrame.BorderSizePixel = 0
volFrame.LayoutOrder = 2
volFrame.ZIndex = 6
volFrame.Parent = pMus
Instance.new("UICorner", volFrame).CornerRadius = UDim.new(0,8)

local volLabel = Instance.new("TextLabel")
volLabel.Size = UDim2.new(1,0,0,20)
volLabel.Position = UDim2.fromOffset(0,4)
volLabel.BackgroundTransparency = 1
volLabel.Text = "🔊 Volume: 35%"
volLabel.TextColor3 = Color3.fromRGB(200,255,215)
volLabel.TextSize = 11
volLabel.Font = Enum.Font.GothamBold
volLabel.ZIndex = 7
volLabel.Parent = volFrame

local volBarBg = Instance.new("Frame")
volBarBg.Size = UDim2.new(1,-20,0,8)
volBarBg.Position = UDim2.new(0,10,1,-16)
volBarBg.BackgroundColor3 = Color3.fromRGB(40,40,60)
volBarBg.BorderSizePixel = 0
volBarBg.ZIndex = 7
volBarBg.Parent = volFrame
Instance.new("UICorner", volBarBg).CornerRadius = UDim.new(1,0)

local volBarFill = Instance.new("Frame")
volBarFill.Size = UDim2.new(0.35,0,1,0)
volBarFill.BackgroundColor3 = Color3.fromRGB(90,255,120)
volBarFill.BorderSizePixel = 0
volBarFill.ZIndex = 8
volBarFill.Parent = volBarBg
Instance.new("UICorner", volBarFill).CornerRadius = UDim.new(1,0)

local volBtn = Instance.new("TextButton")
volBtn.Size = UDim2.new(1,0,1,0)
volBtn.BackgroundTransparency = 1
volBtn.Text = ""
volBtn.ZIndex = 9
volBtn.Parent = volBarBg

local draggingVol = false

local function atualizarVolume(input)
    local rel = (input.Position.X - volBarBg.AbsolutePosition.X) / volBarBg.AbsoluteSize.X
    rel = math.clamp(rel, 0, 1)
    volBarFill.Size = UDim2.new(rel, 0, 1, 0)
    som.Volume = rel
    volLabel.Text = "🔊 Volume: " .. math.floor(rel*100) .. "%"
end

volBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        draggingVol = true
        atualizarVolume(input)
    end
end)

volBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        draggingVol = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if not draggingVol then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        atualizarVolume(input)
    end
end)

local musBox = Instance.new("TextBox")
musBox.Size = UDim2.new(1,-6,0,30)
musBox.BackgroundColor3 = Color3.fromRGB(25,25,40)
musBox.BorderSizePixel = 0
musBox.PlaceholderText = "Cole o ID da música..."
musBox.Text = ""
musBox.TextColor3 = Color3.fromRGB(220,220,240)
musBox.PlaceholderColor3 = Color3.fromRGB(120,120,150)
musBox.TextSize = 11
musBox.Font = Enum.Font.Gotham
musBox.LayoutOrder = 3
musBox.ZIndex = 6
musBox.Parent = pMus
Instance.new("UICorner", musBox).CornerRadius = UDim.new(0,8)
Instance.new("UIStroke", musBox).Color = Color3.fromRGB(45,180,80)

local trocarMusBtn = Instance.new("TextButton")
trocarMusBtn.Size = UDim2.new(1,-6,0,28)
trocarMusBtn.BackgroundColor3 = Color3.fromRGB(40,130,70)
trocarMusBtn.BorderSizePixel = 0
trocarMusBtn.Text = "🎵 Trocar Música"
trocarMusBtn.TextColor3 = Color3.fromRGB(255,255,255)
trocarMusBtn.TextSize = 11
trocarMusBtn.Font = Enum.Font.GothamBold
trocarMusBtn.LayoutOrder = 4
trocarMusBtn.ZIndex = 6
trocarMusBtn.Parent = pMus
Instance.new("UICorner", trocarMusBtn).CornerRadius = UDim.new(0,8)

trocarMusBtn.MouseButton1Click:Connect(function()
    local id = musBox.Text
    if id == "" then return end
    if not string.find(id, "rbxassetid://") then
        id = "rbxassetid://" .. id
    end
    som.SoundId = id
    som:Play()
    musPausada = false
    playPauseBtn.Text = "⏸ Pausar"
end)

-- PÁGINA CONFIGURAÇÕES
local pConf = criarPagina("Config")

local function aplicarTema(tema)
    strokeMain.Color = tema.C
    botaoStroke.Color = tema.C
    botaoFlutuante.BackgroundColor3 = tema.Sidebar
    botaoFlutuante.TextColor3 = tema.LED
    titleLbl.TextColor3 = tema.LED
    sidebar.BackgroundColor3 = tema.Sidebar
    for _, b in pairs(botoesSidebar) do
        b.TextColor3 = tema.LED
    end
    for _, led in ipairs(leds) do
        led.BackgroundColor3 = tema.LED
    end
end

for i, tema in ipairs(TEMAS) do
    criarBotao3D(pConf, "🎨 "..tema.N, tema.C, function()
        aplicarTema(tema)
    end, i)
end

-- SIDEBAR BOTÕES
criarBotaoSidebar("FPS", "⚡", 1)
criarBotaoSidebar("Céu", "☁", 2)
criarBotaoSidebar("Skybox", "🌌", 3)
criarBotaoSidebar("Ball", "⚽", 4)
criarBotaoSidebar("Música", "🎵", 5)
criarBotaoSidebar("Config", "⚙", 6)
mostrarPagina("FPS")

-- ABRIR/FECHAR PAINEL
botaoFlutuante.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

-- DRAG DO PAINEL
local dragging, dragStart, startPos = false, nil, nil
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)
titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
UIS.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- FECHAR
closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
end)

print("[DYV HUB v0.4] Carregado com sucesso!")
