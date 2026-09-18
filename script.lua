local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") do task.wait(0.1) end
task.wait(0.5)

local Camera = workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() Camera = workspace.CurrentCamera end)
LocalPlayer.CharacterAdded:Connect(function(char) char:WaitForChild("HumanoidRootPart") task.wait(0.5) Camera = workspace.CurrentCamera end)

local Settings = {
    AimbotEnabled = true, AimSmoothness = 0.05, AimFOV = 120, AimPart = "Head",
    AimMaxDistance = 500, VisibleCheck = true, AutoShoot = false, Prediction = false,

    TargetEspEnabled = true, TargetEspStyle = "Box", TargetEspColor = "Yellow",
    TargetEspPulse = true, TargetEspShowName = true, TargetEspShowHP = true,
    TargetEspShowDist = true, TargetEspShowArrow = true, TargetEspOnlyLocked = false,
    TargetEspBox = true, TargetEspTrail = false,

    EspEnabled = true, EspBox = true, EspBoxStyle = "Normal", EspHighlight = true,
    EspName = true, EspDistance = true, EspHealth = true, EspTracer = false,
    EspSkeleton = false, EspHeadDot = false, EspArrow = false, EspChams = false,
    EspBeam = false, EspFullbright = false, EspNoFog = false,

    ShowFov = true, ShowCrosshair = true, ShowWatermark = true, FovColor = "Purple",
    CrosshairStyle = "Dot",

    ChinaHat = false, RainbowPlayer = false, CameraFOV = 70, CameraFOVEnabled = false,

    SnowEnabled = false, SnowType = "Normal",
    SkyEnabled = false, SkyType = "Night",
    TimeEnabled = false, TimeValue = 14,
    BloomEnabled = false, BloomIntensity = 1.5,
    ColorCorrection = false, CCRGB = "None",
    SunRays = false, Atmosphere = false,

    WalkSpeed = 16, JumpPower = 50, InfiniteJump = false, Fly = false,
    Noclip = false, FlySpeed = 50, AntiAFK = false, AutoRespawn = false,
    ShowFPS = false, ShowPing = false, ShowClock = false,
}

local fovColors = {
    Purple = Color3.fromRGB(180,100,255), Red = Color3.fromRGB(255,80,80),
    Blue = Color3.fromRGB(80,150,255), Green = Color3.fromRGB(80,255,120),
    Yellow = Color3.fromRGB(255,220,80), White = Color3.fromRGB(255,255,255),
    Pink = Color3.fromRGB(255,100,200), Cyan = Color3.fromRGB(80,255,255),
    Orange = Color3.fromRGB(255,150,50),
}

local screenGui, mainFrame, content, openBtn, sidebar, innerGlow
local highlights, boxes, boxFills, names, dists, healthBars, healthBgs, tracers = {},{},{},{},{},{},{},{}
local headDots, skeletons, arrows, beams, chams = {},{},{},{},{}
local tabs = {}

pcall(function()
    screenGui = Instance.new("ScreenGui"); screenGui.Name = "Gui"; screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; screenGui.Parent = game:GetService("CoreGui")
end)
if not screenGui or not screenGui.Parent then
    screenGui = Instance.new("ScreenGui"); screenGui.Name = "Gui"; screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- ПРИВЕТСТВИЕ
local notify = Instance.new("Frame")
notify.Size = UDim2.new(0,320,0,65); notify.Position = UDim2.new(0.5,-160,0,-70)
notify.BackgroundColor3 = Color3.fromRGB(30,10,60); notify.BackgroundTransparency = 0.1
notify.BorderSizePixel = 0; notify.ZIndex = 100; notify.Parent = screenGui
local nc = Instance.new("UICorner"); nc.CornerRadius = UDim.new(0,12); nc.Parent = notify
local ns = Instance.new("UIStroke"); ns.Color = Color3.fromRGB(200,100,255); ns.Thickness = 2; ns.Transparency = 0.1; ns.Parent = notify
local nt = Instance.new("TextLabel"); nt.Size = UDim2.new(1,-20,1,0); nt.Position = UDim2.new(0,10,0,0)
nt.BackgroundTransparency = 1; nt.Text = "Привет от @LutshiyKot"; nt.TextColor3 = Color3.fromRGB(255,255,255)
nt.TextSize = 19; nt.Font = Enum.Font.GothamBold; nt.ZIndex = 101; nt.Parent = notify
notify:TweenPosition(UDim2.new(0.5,-160,0,30), "Out", "Quad", 0.5, true)
task.delay(4, function() notify:TweenPosition(UDim2.new(0.5,-160,0,-70), "In", "Quad", 0.5, true) task.wait(0.6) notify:Destroy() end)

-- ВОДЯНОЙ ЗНАК
local watermark = Instance.new("Frame")
watermark.Size = UDim2.new(0,200,0,32); watermark.Position = UDim2.new(0,15,0,15)
watermark.BackgroundColor3 = Color3.fromRGB(30,10,60); watermark.BackgroundTransparency = 0.3
watermark.BorderSizePixel = 0; watermark.ZIndex = 60; watermark.Parent = screenGui
local wmc = Instance.new("UICorner"); wmc.CornerRadius = UDim.new(0,8); wmc.Parent = watermark
local wms = Instance.new("UIStroke"); wms.Color = Color3.fromRGB(200,100,255); wms.Thickness = 1.5; wms.Transparency = 0.2; wms.Parent = watermark
local wmt = Instance.new("TextLabel"); wmt.Size = UDim2.new(1,-20,1,0); wmt.Position = UDim2.new(0,10,0,0)
wmt.BackgroundTransparency = 1; wmt.Text = "⚡ @LutshiyKot | v5.0"; wmt.TextColor3 = Color3.fromRGB(255,255,255)
wmt.TextSize = 13; wmt.Font = Enum.Font.GothamBold; wmt.TextXAlignment = Enum.TextXAlignment.Left; wmt.ZIndex = 61; wmt.Parent = watermark
spawn(function() local t=0 while watermark.Parent do t=t+0.05 local r=(math.sin(t)+1)/2 wms.Color=Color3.fromRGB(150+100*r,80+100*r,255) task.wait(0.05) end end)

-- GLOW
local glowLayers = {}
for i = 1, 6 do
    local glow = Instance.new("Frame")
    glow.Size = UDim2.new(0,460+i*14,0,340+i*14); glow.Position = UDim2.new(0.5,-(230+i*7),0.5,-(170+i*7))
    glow.BackgroundColor3 = Color3.fromRGB(200,100,255); glow.BackgroundTransparency = 0.9+(i*0.012)
    glow.BorderSizePixel = 0; glow.ZIndex = 0; glow.Parent = screenGui
    local gc = Instance.new("UICorner"); gc.CornerRadius = UDim.new(0,22); gc.Parent = glow
    table.insert(glowLayers, glow)
end

-- ОКНО
mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0,460,0,340); mainFrame.Position = UDim2.new(0.5,-230,0.5,-170)
mainFrame.BackgroundColor3 = Color3.fromRGB(55,20,110); mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0; mainFrame.Active = true; mainFrame.Draggable = true; mainFrame.ZIndex = 2; mainFrame.Parent = screenGui
mainFrame:GetPropertyChangedSignal("Position"):Connect(function()
    for i, g in ipairs(glowLayers) do g.Position = mainFrame.Position - UDim2.new(0,7*i,0,7*i) end
end)
local mc = Instance.new("UICorner"); mc.CornerRadius = UDim.new(0,14); mc.Parent = mainFrame
local bgGrad = Instance.new("UIGradient")
bgGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(150,40,230)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(70,20,150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120,40,200))})
bgGrad.Rotation = 45; bgGrad.Parent = mainFrame

innerGlow = Instance.new("Frame")
innerGlow.Size = UDim2.new(1,0,1,0); innerGlow.BackgroundColor3 = Color3.fromRGB(200,100,255)
innerGlow.BackgroundTransparency = 0.82; innerGlow.BorderSizePixel = 0; innerGlow.ZIndex = 2; innerGlow.Parent = mainFrame
local igc = Instance.new("UICorner"); igc.CornerRadius = UDim.new(0,14); igc.Parent = innerGlow

local neon1 = Instance.new("UIStroke"); neon1.Color = Color3.fromRGB(220,120,255); neon1.Thickness = 2; neon1.Parent = mainFrame
local neon2 = Instance.new("UIStroke"); neon2.Color = Color3.fromRGB(120,200,255); neon2.Thickness = 4; neon2.Transparency = 0.4; neon2.Parent = mainFrame
local neon3 = Instance.new("UIStroke"); neon3.Color = Color3.fromRGB(255,100,220); neon3.Thickness = 8; neon3.Transparency = 0.7; neon3.Parent = mainFrame

spawn(function()
    local t = 0
    while mainFrame.Parent do
        t = t + 0.05
        local r=(math.sin(t)+1)/2 local g=(math.sin(t+2)+1)/2 local b=(math.sin(t+4)+1)/2
        neon1.Color = Color3.fromRGB(math.floor(180+75*r),math.floor(80+120*g),math.floor(220+35*b))
        neon2.Color = Color3.fromRGB(math.floor(100+100*b),math.floor(150+100*r),math.floor(220+35*g))
        neon3.Color = Color3.fromRGB(math.floor(220+35*b),math.floor(80+120*g),math.floor(200+55*r))
        bgGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(math.floor(120+50*r),math.floor(30+30*g),math.floor(200+40*b))),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(math.floor(50+30*b),math.floor(15+15*r),math.floor(120+50*g))),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(math.floor(100+50*g),math.floor(30+30*b),math.floor(170+50*r)))})
        bgGrad.Rotation = (t*25)%360
        innerGlow.BackgroundColor3 = Color3.fromRGB(math.floor(150+80*r),math.floor(60+100*g),math.floor(200+55*b))
        innerGlow.BackgroundTransparency = 0.78+0.08*r
        mainFrame.BackgroundColor3 = Color3.fromRGB(math.floor(45+30*r),math.floor(15+15*g),math.floor(90+40*b))
        for i, gl in ipairs(glowLayers) do
            gl.BackgroundColor3 = Color3.fromRGB(math.floor(140+100*r),math.floor(60+100*g),math.floor(200+55*b))
            gl.BackgroundTransparency = 0.86+(i*0.015)+0.04*(1-r)
        end
        RunService.Heartbeat:Wait()
    end
end)

-- ШАПКА
local header = Instance.new("Frame")
header.Size = UDim2.new(1,0,0,42); header.BackgroundColor3 = Color3.fromRGB(80,30,150)
header.BackgroundTransparency = 0.35; header.BorderSizePixel = 0; header.ZIndex = 3; header.Parent = mainFrame
local hc = Instance.new("UICorner"); hc.CornerRadius = UDim.new(0,14); hc.Parent = header
local hf = Instance.new("Frame")
hf.Size = UDim2.new(1,0,0,18); hf.Position = UDim2.new(0,0,1,-18); hf.BackgroundColor3 = Color3.fromRGB(80,30,150)
hf.BackgroundTransparency = 0.35; hf.BorderSizePixel = 0; hf.ZIndex = 3; hf.Parent = header
local av = Instance.new("TextLabel"); av.Size = UDim2.new(0,28,0,28); av.Position = UDim2.new(0,10,0,7)
av.BackgroundColor3 = Color3.fromRGB(80,40,140); av.Text = "👑"; av.TextSize = 15
av.Font = Enum.Font.GothamBold; av.BorderSizePixel = 0; av.ZIndex = 4; av.Parent = header
local avc = Instance.new("UICorner"); avc.CornerRadius = UDim.new(0,8); avc.Parent = av
local ttl = Instance.new("TextLabel"); ttl.Size = UDim2.new(1,-180,0,20); ttl.Position = UDim2.new(0,46,0,5)
ttl.BackgroundTransparency = 1; ttl.Text = "@LutshiyKot"; ttl.TextColor3 = Color3.fromRGB(255,255,255)
ttl.TextSize = 14; ttl.Font = Enum.Font.GothamBold; ttl.TextXAlignment = Enum.TextXAlignment.Left; ttl.ZIndex = 4; ttl.Parent = header
local stl = Instance.new("TextLabel"); stl.Size = UDim2.new(1,-180,0,14); stl.Position = UDim2.new(0,46,0,22)
stl.BackgroundTransparency = 1; stl.Text = "by @LutshiyKot"; stl.TextColor3 = Color3.fromRGB(230,200,255)
stl.TextSize = 10; stl.Font = Enum.Font.Gotham; stl.TextXAlignment = Enum.TextXAlignment.Left; stl.ZIndex = 4; stl.Parent = header

local function makeBtn(text, x, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,26,0,26); btn.Position = UDim2.new(1,x,0,8)
    btn.BackgroundColor3 = Color3.fromRGB(60,25,110); btn.BackgroundTransparency = 0.15
    btn.Text = text; btn.TextColor3 = Color3.fromRGB(255,255,255); btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold; btn.BorderSizePixel = 0; btn.AutoButtonColor = false
    btn.ZIndex = 4; btn.Parent = header
    local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0,7); bc.Parent = btn
    local bs = Instance.new("UIStroke"); bs.Color = Color3.fromRGB(220,130,255); bs.Thickness = 1; bs.Transparency = 0.1; bs.Parent = btn
    btn.MouseButton1Click:Connect(cb)
end

sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0,115,1,-55); sidebar.Position = UDim2.new(0,10,0,48)
sidebar.BackgroundColor3 = Color3.fromRGB(70,25,130); sidebar.BackgroundTransparency = 0.55
sidebar.BorderSizePixel = 0; sidebar.ZIndex = 3; sidebar.Parent = mainFrame
local sc = Instance.new("UICorner"); sc.CornerRadius = UDim.new(0,10); sc.Parent = sidebar
local ss = Instance.new("UIStroke"); ss.Color = Color3.fromRGB(200,120,255); ss.Thickness = 1; ss.Transparency = 0.3; ss.Parent = sidebar
local sLayout = Instance.new("UIListLayout"); sLayout.Padding = UDim.new(0,4); sLayout.Parent = sidebar
local sPad = Instance.new("UIPadding"); sPad.PaddingTop = UDim.new(0,6); sPad.PaddingLeft = UDim.new(0,6); sPad.PaddingRight = UDim.new(0,6); sPad.Parent = sidebar

content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1,-135,1,-55); content.Position = UDim2.new(0,130,0,48)
content.BackgroundTransparency = 1; content.BorderSizePixel = 0; content.ScrollBarThickness = 3
content.ScrollBarImageColor3 = Color3.fromRGB(220,130,255); content.CanvasSize = UDim2.new(0,0,0,0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y; content.ZIndex = 4; content.Parent = mainFrame
local cLayout = Instance.new("UIListLayout"); cLayout.Padding = UDim.new(0,5); cLayout.Parent = content

local isMin = false
local function setMin(min)
    isMin = min
    if min then
        mainFrame.Size = UDim2.new(0,460,0,42); sidebar.Visible = false; content.Visible = false; innerGlow.Visible = false
        for i, g in ipairs(glowLayers) do g.Size = UDim2.new(0,460+i*14,0,42+i*14) g.Position = UDim2.new(0.5,-(230+i*7),0.5,-(21+i*7)) end
    else
        mainFrame.Size = UDim2.new(0,460,0,340); sidebar.Visible = true; content.Visible = true; innerGlow.Visible = true
        for i, g in ipairs(glowLayers) do g.Size = UDim2.new(0,460+i*14,0,340+i*14) g.Position = UDim2.new(0.5,-(230+i*7),0.5,-(170+i*7)) end
    end
end

makeBtn("—", -90, function() setMin(not isMin) end)
makeBtn("□", -60, function() setMin(false) end)
makeBtn("✕", -30, function()
    mainFrame.Visible = false; for _, g in ipairs(glowLayers) do g.Visible = false end
    if openBtn then openBtn.Visible = true end
end)

openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0,45,0,45); openBtn.Position = UDim2.new(0,20,0,100)
openBtn.BackgroundColor3 = Color3.fromRGB(60,25,110); openBtn.Text = "⚡"
openBtn.TextColor3 = Color3.fromRGB(255,255,255); openBtn.TextSize = 20; openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0; openBtn.Visible = false; openBtn.ZIndex = 50; openBtn.Parent = screenGui
local obc = Instance.new("UICorner"); obc.CornerRadius = UDim.new(1,0); obc.Parent = openBtn
local obs = Instance.new("UIStroke"); obs.Color = Color3.fromRGB(220,130,255); obs.Thickness = 2; obs.Parent = openBtn
openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true; for _, g in ipairs(glowLayers) do g.Visible = true end
    setMin(false); openBtn.Visible = false
end)

-- ЭЛЕМЕНТЫ
local function createSection(text)
    local l = Instance.new("TextLabel"); l.Size = UDim2.new(1,-6,0,22); l.BackgroundTransparency = 1
    l.Text = text; l.TextColor3 = Color3.fromRGB(255,220,255); l.TextSize = 13
    l.Font = Enum.Font.GothamBold; l.TextXAlignment = Enum.TextXAlignment.Left; l.ZIndex = 5; l.Parent = content
end

local function createCard(text, default, cb)
    local card = Instance.new("TextButton"); card.Size = UDim2.new(1,-6,0,38)
    card.BackgroundColor3 = Color3.fromRGB(60,25,120); card.BackgroundTransparency = 0.3
    card.Text = ""; card.BorderSizePixel = 0; card.AutoButtonColor = false; card.ZIndex = 4; card.Parent = content
    local cc = Instance.new("UICorner"); cc.CornerRadius = UDim.new(0,9); cc.Parent = card
    local cs = Instance.new("UIStroke"); cs.Color = Color3.fromRGB(200,120,255); cs.Thickness = 1; cs.Transparency = 0.2; cs.Parent = card
    local t = Instance.new("TextLabel"); t.Size = UDim2.new(1,-70,1,0); t.Position = UDim2.new(0,14,0,0)
    t.BackgroundTransparency = 1; t.Text = text; t.TextColor3 = Color3.fromRGB(255,240,255)
    t.TextSize = 12; t.Font = Enum.Font.GothamBold; t.TextXAlignment = Enum.TextXAlignment.Left; t.ZIndex = 5; t.Parent = card
    local tg = Instance.new("Frame"); tg.Size = UDim2.new(0,38,0,20); tg.Position = UDim2.new(1,-50,0.5,-10)
    tg.BackgroundColor3 = default and Color3.fromRGB(200,100,255) or Color3.fromRGB(80,40,130)
    tg.BorderSizePixel = 0; tg.ZIndex = 5; tg.Parent = card
    local tc = Instance.new("UICorner"); tc.CornerRadius = UDim.new(1,0); tc.Parent = tg
    local ts = Instance.new("UIStroke"); ts.Color = Color3.fromRGB(255,180,255); ts.Thickness = 1
    ts.Transparency = default and 0 or 0.8; ts.Parent = tg
    local k = Instance.new("Frame"); k.Size = UDim2.new(0,16,0,16)
    k.Position = default and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
    k.BackgroundColor3 = Color3.fromRGB(255,255,255); k.BorderSizePixel = 0; k.ZIndex = 6; k.Parent = tg
    local kc = Instance.new("UICorner"); kc.CornerRadius = UDim.new(1,0); kc.Parent = k
    local state = default
    card.MouseButton1Click:Connect(function()
        state = not state; cb(state)
        if state then tg.BackgroundColor3 = Color3.fromRGB(200,100,255); ts.Transparency = 0
            k:TweenPosition(UDim2.new(1,-18,0.5,-8),"Out","Quad",0.15,true)
        else tg.BackgroundColor3 = Color3.fromRGB(80,40,130); ts.Transparency = 0.8
            k:TweenPosition(UDim2.new(0,2,0.5,-8),"Out","Quad",0.15,true) end
    end)
end

local function createButton(text, cb)
    local b = Instance.new("TextButton"); b.Size = UDim2.new(1,-6,0,38)
    b.BackgroundColor3 = Color3.fromRGB(80,30,150); b.BackgroundTransparency = 0.2
    b.Text = text; b.TextColor3 = Color3.fromRGB(255,240,255); b.TextSize = 12
    b.Font = Enum.Font.GothamBold; b.BorderSizePixel = 0; b.AutoButtonColor = false; b.ZIndex = 4; b.Parent = content
    local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0,9); bc.Parent = b
    local bs = Instance.new("UIStroke"); bs.Color = Color3.fromRGB(255,150,255); bs.Thickness = 1.5; bs.Transparency = 0.1; bs.Parent = b
    b.MouseButton1Click:Connect(function() bs.Transparency = 0 task.wait(0.1) bs.Transparency = 0.1 cb() end)
end

local function createSlider(text, min, max, default, cb)
    local f = Instance.new("Frame"); f.Size = UDim2.new(1,-6,0,52)
    f.BackgroundColor3 = Color3.fromRGB(60,25,120); f.BackgroundTransparency = 0.3
    f.BorderSizePixel = 0; f.ZIndex = 4; f.Parent = content
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,9); c.Parent = f
    local cs = Instance.new("UIStroke"); cs.Color = Color3.fromRGB(200,120,255); cs.Thickness = 1; cs.Transparency = 0.2; cs.Parent = f
    local l = Instance.new("TextLabel"); l.Size = UDim2.new(1,-20,0,18); l.Position = UDim2.new(0,14,0,5)
    l.BackgroundTransparency = 1; l.Text = text..": "..tostring(default); l.TextColor3 = Color3.fromRGB(255,240,255)
    l.TextSize = 12; l.Font = Enum.Font.GothamBold; l.TextXAlignment = Enum.TextXAlignment.Left; l.ZIndex = 5; l.Parent = f
    local bg = Instance.new("Frame"); bg.Size = UDim2.new(1,-28,0,7); bg.Position = UDim2.new(0,14,0,32)
    bg.BackgroundColor3 = Color3.fromRGB(60,30,100); bg.BorderSizePixel = 0; bg.ZIndex = 5; bg.Parent = f
    local bgc = Instance.new("UICorner"); bgc.CornerRadius = UDim.new(1,0); bgc.Parent = bg
    local fill = Instance.new("Frame"); fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
    fill.BackgroundColor3 = Color3.fromRGB(220,120,255); fill.BorderSizePixel = 0; fill.ZIndex = 6; fill.Parent = bg
    local fc = Instance.new("UICorner"); fc.CornerRadius = UDim.new(1,0); fc.Parent = fill
    local drag = false
    local function upd(inp)
        local p = inp.Position.X - bg.AbsolutePosition.X
        local pct = math.clamp(p / bg.AbsoluteSize.X, 0, 1)
        local v = min + (max-min)*pct
        fill.Size = UDim2.new(pct,0,1,0); l.Text = text..": "..string.format("%.0f",v); cb(v)
    end
    bg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true upd(i) end end)
    UserInputService.InputChanged:Connect(function(i) if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then upd(i) end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end end)
end

local function createDropdown(text, opts, default, cb)
    local b = Instance.new("TextButton"); b.Size = UDim2.new(1,-6,0,38)
    b.BackgroundColor3 = Color3.fromRGB(60,25,120); b.BackgroundTransparency = 0.3; b.Text = ""
    b.BorderSizePixel = 0; b.AutoButtonColor = false; b.ZIndex = 4; b.Parent = content
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,9); c.Parent = b
    local cs = Instance.new("UIStroke"); cs.Color = Color3.fromRGB(200,120,255); cs.Thickness = 1; cs.Transparency = 0.2; cs.Parent = b
    local l = Instance.new("TextLabel"); l.Size = UDim2.new(0.5,-10,1,0); l.Position = UDim2.new(0,14,0,0)
    l.BackgroundTransparency = 1; l.Text = text; l.TextColor3 = Color3.fromRGB(255,240,255)
    l.TextSize = 12; l.Font = Enum.Font.GothamBold; l.TextXAlignment = Enum.TextXAlignment.Left; l.ZIndex = 5; l.Parent = b
    local v = Instance.new("TextLabel"); v.Size = UDim2.new(0.5,-14,1,0); v.Position = UDim2.new(0.5,0,0,0)
    v.BackgroundTransparency = 1; v.Text = default; v.TextColor3 = Color3.fromRGB(255,200,255)
    v.TextSize = 12; v.Font = Enum.Font.GothamBold; v.TextXAlignment = Enum.TextXAlignment.Right; v.ZIndex = 5; v.Parent = b
    local idx = 1
    for i, o in ipairs(opts) do if o == default then idx = i break end end
    b.MouseButton1Click:Connect(function() idx = idx % #opts + 1 v.Text = opts[idx] cb(opts[idx]) end)
end

local function clearContent()
    for _, c in pairs(content:GetChildren()) do
        if c:IsA("TextButton") or c:IsA("TextLabel") or c:IsA("Frame") then c:Destroy() end
    end
end

local function createTab(name, icon, cb)
    local b = Instance.new("TextButton"); b.Size = UDim2.new(1,0,0,30)
    b.BackgroundColor3 = Color3.fromRGB(60,25,120); b.BackgroundTransparency = 0.5; b.Text = ""
    b.BorderSizePixel = 0; b.AutoButtonColor = false; b.ZIndex = 4; b.Parent = sidebar
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,8); c.Parent = b
    local bs = Instance.new("UIStroke"); bs.Color = Color3.fromRGB(180,100,255); bs.Thickness = 1; bs.Transparency = 0.6; bs.Parent = b
    local l = Instance.new("TextLabel"); l.Size = UDim2.new(1,-34,1,0); l.Position = UDim2.new(0,28,0,0)
    l.BackgroundTransparency = 1; l.Text = name; l.TextColor3 = Color3.fromRGB(220,200,255); l.TextSize = 11
    l.Font = Enum.Font.GothamBold; l.TextXAlignment = Enum.TextXAlignment.Left; l.ZIndex = 5; l.Parent = b
    local ic = Instance.new("TextLabel"); ic.Size = UDim2.new(0,20,1,0); ic.Position = UDim2.new(0,8,0,0)
    ic.BackgroundTransparency = 1; ic.Text = icon; ic.TextSize = 12; ic.Font = Enum.Font.GothamBold; ic.ZIndex = 5; ic.Parent = b
    b.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.btn.BackgroundColor3 = Color3.fromRGB(60,25,120) t.lbl.TextColor3 = Color3.fromRGB(220,200,255) t.bs.Transparency = 0.6 end
        b.BackgroundColor3 = Color3.fromRGB(120,50,220); l.TextColor3 = Color3.fromRGB(255,255,255); bs.Transparency = 0; cb()
    end)
    return {btn = b, lbl = l, bs = bs, callback = cb}
end

-- ВКЛАДКИ
table.insert(tabs, createTab("Main", "🏠", function()
    clearContent()
    createSection("Aimbot")
    createCard("Aimbot", Settings.AimbotEnabled, function(v) Settings.AimbotEnabled = v end)
    createCard("Auto Shoot", Settings.AutoShoot, function(v) Settings.AutoShoot = v end)
    createCard("Prediction", Settings.Prediction, function(v) Settings.Prediction = v end)
    createSection("ESP")
    createCard("ESP", Settings.EspEnabled, function(v) Settings.EspEnabled = v end)
    createCard("Box", Settings.EspBox, function(v) Settings.EspBox = v end)
    createCard("Highlight", Settings.EspHighlight, function(v) Settings.EspHighlight = v end)
    createSection("Target ESP")
    createCard("Target ESP", Settings.TargetEspEnabled, function(v) Settings.TargetEspEnabled = v end)
    createCard("Target Box", Settings.TargetEspBox, function(v) Settings.TargetEspBox = v end)
    createCard("Target Trail", Settings.TargetEspTrail, function(v) Settings.TargetEspTrail = v end)
end))

table.insert(tabs, createTab("Target", "🎯", function()
    clearContent()
    createSection("Target ESP")
    createCard("Enable Target ESP", Settings.TargetEspEnabled, function(v) Settings.TargetEspEnabled = v end)
    createCard("Show Name", Settings.TargetEspShowName, function(v) Settings.TargetEspShowName = v end)
    createCard("Show HP", Settings.TargetEspShowHP, function(v) Settings.TargetEspShowHP = v end)
    createCard("Show Distance", Settings.TargetEspShowDist, function(v) Settings.TargetEspShowDist = v end)
    createCard("Show Arrow", Settings.TargetEspShowArrow, function(v) Settings.TargetEspShowArrow = v end)
    createCard("Pulse Effect", Settings.TargetEspPulse, function(v) Settings.TargetEspPulse = v end)
    createCard("Target Box", Settings.TargetEspBox, function(v) Settings.TargetEspBox = v end)
    createCard("Target Trail", Settings.TargetEspTrail, function(v) Settings.TargetEspTrail = v end)
    createCard("Only Locked", Settings.TargetEspOnlyLocked, function(v) Settings.TargetEspOnlyLocked = v end)
    createSection("Style")
    createDropdown("Style", {"Box","Circle","Corner","Minimal"}, Settings.TargetEspStyle, function(v) Settings.TargetEspStyle = v end)
    createDropdown("Color", {"Yellow","Red","Green","Cyan","Pink","White"}, Settings.TargetEspColor, function(v) Settings.TargetEspColor = v end)
end))

table.insert(tabs, createTab("Aim", "⚔", function()
    clearContent()
    createSection("Aimbot")
    createCard("Aimbot", Settings.AimbotEnabled, function(v) Settings.AimbotEnabled = v end)
    createCard("Prediction", Settings.Prediction, function(v) Settings.Prediction = v end)
    createCard("Wall Check", Settings.VisibleCheck, function(v) Settings.VisibleCheck = v end)
    createCard("Auto Shoot", Settings.AutoShoot, function(v) Settings.AutoShoot = v end)
    createSection("Target")
    createDropdown("Hit Part", {"Head","UpperTorso","LowerTorso","HumanoidRootPart"}, Settings.AimPart, function(v) Settings.AimPart = v end)
    createDropdown("FOV Color", {"Purple","Red","Blue","Green","Yellow","White","Pink","Cyan","Orange"}, Settings.FovColor, function(v) Settings.FovColor = v end)
    createSlider("FOV", 50, 800, Settings.AimFOV, function(v) Settings.AimFOV = v end)
    createSlider("Smooth", 0, 95, Settings.AimSmoothness * 100, function(v) Settings.AimSmoothness = v / 100 end)
    createSlider("Max Dist", 50, 2000, Settings.AimMaxDistance, function(v) Settings.AimMaxDistance = v end)
end))

table.insert(tabs, createTab("Visual", "🎨", function()
    clearContent()
    createSection("ESP")
    createCard("ESP", Settings.EspEnabled, function(v) Settings.EspEnabled = v end)
    createCard("Box", Settings.EspBox, function(v) Settings.EspBox = v end)
    createDropdown("Box Style", {"Normal","Corner","Filled"}, Settings.EspBoxStyle, function(v) Settings.EspBoxStyle = v end)
    createCard("Highlight", Settings.EspHighlight, function(v) Settings.EspHighlight = v end)
    createCard("Chams", Settings.EspChams, function(v) Settings.EspChams = v end)
    createCard("Name", Settings.EspName, function(v) Settings.EspName = v end)
    createCard("Distance", Settings.EspDistance, function(v) Settings.EspDistance = v end)
    createCard("Health Bar", Settings.EspHealth, function(v) Settings.EspHealth = v end)
    createCard("Tracer", Settings.EspTracer, function(v) Settings.EspTracer = v end)
    createCard("Skeleton", Settings.EspSkeleton, function(v) Settings.EspSkeleton = v end)
    createCard("Head Dot", Settings.EspHeadDot, function(v) Settings.EspHeadDot = v end)
    createCard("Off-Screen Arrow", Settings.EspArrow, function(v) Settings.EspArrow = v end)
    createCard("Beam to Target", Settings.EspBeam, function(v) Settings.EspBeam = v end)
    createSection("Screen")
    createCard("FOV Circle", Settings.ShowFov, function(v) Settings.ShowFov = v fovCircle.Visible = v end)
    createCard("Custom Crosshair", Settings.ShowCrosshair, function(v) Settings.ShowCrosshair = v end)
    createDropdown("Crosshair", {"Dot","Cross","Circle","X"}, Settings.CrosshairStyle, function(v) Settings.CrosshairStyle = v end)
    createCard("Watermark", Settings.ShowWatermark, function(v) watermark.Visible = v end)
    createCard("Show FPS", Settings.ShowFPS, function(v) Settings.ShowFPS = v end)
    createCard("Show Ping", Settings.ShowPing, function(v) Settings.ShowPing = v end)
    createCard("Show Clock", Settings.ShowClock, function(v) Settings.ShowClock = v end)
end))

table.insert(tabs, createTab("FX", "✨", function()
    clearContent()
    createSection("Weather")
    createCard("Snow", Settings.SnowEnabled, function(v) Settings.SnowEnabled = v end)
    createDropdown("Snow Type", {"Normal","Neon","Gold"}, Settings.SnowType, function(v) Settings.SnowType = v end)
    createSection("Sky")
    createCard("Change Sky", Settings.SkyEnabled, function(v) Settings.SkyEnabled = v end)
    createDropdown("Sky Type", {"Night","Sunset","Space","Red","Neon","Cyber"}, Settings.SkyType, function(v) Settings.SkyType = v end)
    createSection("Time")
    createCard("Change Time", Settings.TimeEnabled, function(v) Settings.TimeEnabled = v end)
    createSlider("Clock Time", 0, 24, Settings.TimeValue, function(v) Settings.TimeValue = v end)
    createSection("Post-FX")
    createCard("Bloom", Settings.BloomEnabled, function(v) Settings.BloomEnabled = v end)
    createSlider("Bloom Intensity", 0, 5, Settings.BloomIntensity, function(v) Settings.BloomIntensity = v end)
    createCard("Color Correction", Settings.ColorCorrection, function(v) Settings.ColorCorrection = v end)
    createDropdown("CC Mode", {"None","Red","Blue","Green","Matrix","Cinematic"}, Settings.CCRGB, function(v) Settings.CCRGB = v end)
    createCard("Sun Rays", Settings.SunRays, function(v) Settings.SunRays = v end)
    createCard("Atmosphere", Settings.Atmosphere, function(v) Settings.Atmosphere = v end)
end))

table.insert(tabs, createTab("Extras", "⚡", function()
    clearContent()
    createSection("Lighting")
    createCard("Fullbright", Settings.EspFullbright, function(v)
        Settings.EspFullbright = v
        if v then Lighting.Brightness = 3 Lighting.ClockTime = 14 Lighting.FogEnd = 100000 Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(180,180,180)
        else Lighting.Brightness = 1 Lighting.GlobalShadows = true end
    end)
    createCard("No Fog", Settings.EspNoFog, function(v) Settings.EspNoFog = v Lighting.FogEnd = v and 100000 or 1000 end)
    createSection("Fun Visuals")
    createCard("Neon China Hat", Settings.ChinaHat, function(v) Settings.ChinaHat = v end)
    createCard("Rainbow Player", Settings.RainbowPlayer, function(v) Settings.RainbowPlayer = v end)
    createSection("Camera")
    createCard("Custom FOV", Settings.CameraFOVEnabled, function(v) Settings.CameraFOVEnabled = v Camera.FieldOfView = v and Settings.CameraFOV or 70 end)
    createSlider("Camera FOV", 30, 120, Settings.CameraFOV, function(v) Settings.CameraFOV = v if Settings.CameraFOVEnabled then Camera.FieldOfView = v end end)
    createSection("Movement")
    createCard("Infinite Jump", Settings.InfiniteJump, function(v) Settings.InfiniteJump = v end)
    createCard("Fly", Settings.Fly, function(v)
        Settings.Fly = v
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        if v then
            local bg = Instance.new("BodyVelocity"); bg.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
            bg.Velocity = Vector3.zero; bg.Name = "FlyBV"; bg.Parent = hrp
        else local bg = hrp:FindFirstChild("FlyBV") if bg then bg:Destroy() end end
    end)
    createCard("Noclip", Settings.Noclip, function(v) Settings.Noclip = v end)
    createCard("Anti-AFK", Settings.AntiAFK, function(v) Settings.AntiAFK = v end)
    createCard("Auto Respawn", Settings.AutoRespawn, function(v) Settings.AutoRespawn = v end)
    createSlider("Walk Speed", 16, 200, Settings.WalkSpeed, function(v)
        Settings.WalkSpeed = v
        local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = v end
    end)
    createSlider("Jump Power", 50, 300, Settings.JumpPower, function(v)
        Settings.JumpPower = v
        local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h.JumpPower = v end
    end)
    createSlider("Fly Speed", 10, 300, Settings.FlySpeed, function(v) Settings.FlySpeed = v end)
end))

table.insert(tabs, createTab("Player", "👤", function()
    clearContent()
    createSection("Utility")
    createButton("🔄 RESET CHARACTER", function()
        local char = LocalPlayer.Character
        if char then local h = char:FindFirstChildOfClass("Humanoid") if h then h.Health = 0 end end
    end)
    createButton("📋 COPY JOB ID", function() if setclipboard then setclipboard(game.JobId) end end)
    createButton("📋 COPY PLACE ID", function() if setclipboard then setclipboard(tostring(game.PlaceId)) end end)
    createSection("Server")
    createButton("🌐 SERVER HOP", function()
        local placeId = game.PlaceId; local jobId = game.JobId
        local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"
        local success, response = pcall(function() return HttpService:JSONDecode(game:HttpGet(url)) end)
        if success and response and response.data then
            for _, s in pairs(response.data) do
                if s.playing < s.maxPlayers and s.id ~= jobId then
                    pcall(function() TeleportService:TeleportToPlaceInstance(placeId, s.id, LocalPlayer) end); return
                end
            end
        end
        pcall(function() TeleportService:Teleport(placeId, LocalPlayer) end)
    end)
    createButton("🔄 REJOIN", function() pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end) end)
    createButton("🚪 LEAVE", function() pcall(function() game:Shutdown() end) end)
end))

tabs[1].callback()
tabs[1].btn.BackgroundColor3 = Color3.fromRGB(120,50,220)
tabs[1].lbl.TextColor3 = Color3.fromRGB(255,255,255)
tabs[1].bs.Transparency = 0

-- FOV + CROSSHAIR
local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 1.5; fovCircle.NumSides = 60; fovCircle.Radius = Settings.AimFOV
fovCircle.Filled = false; fovCircle.Transparency = 0.6
fovCircle.Color = fovColors[Settings.FovColor]; fovCircle.Visible = Settings.ShowFov

local crossDot = Drawing.new("Circle")
crossDot.Radius = 2.5; crossDot.Filled = true; crossDot.Color = Color3.fromRGB(255,255,255)
crossDot.Transparency = 0.9; crossDot.Visible = false

local crossL1 = Drawing.new("Line"); crossL1.Thickness = 1.5; crossL1.Color = Color3.fromRGB(255,255,255); crossL1.Visible = false
local crossL2 = Drawing.new("Line"); crossL2.Thickness = 1.5; crossL2.Color = Color3.fromRGB(255,255,255); crossL2.Visible = false
local crossC = Drawing.new("Circle"); crossC.Radius = 10; crossC.Thickness = 1.5; crossC.Filled = false; crossC.Color = Color3.fromRGB(255,255,255); crossC.Visible = false
local crossX1 = Drawing.new("Line"); crossX1.Thickness = 1.5; crossX1.Color = Color3.fromRGB(255,255,255); crossX1.Visible = false
local crossX2 = Drawing.new("Line"); crossX2.Thickness = 1.5; crossX2.Color = Color3.fromRGB(255,255,255); crossX2.Visible = false

RunService.RenderStepped:Connect(function()
    local vp = Camera.ViewportSize
    fovCircle.Position = Vector2.new(vp.X/2, vp.Y/2); fovCircle.Radius = Settings.AimFOV
    fovCircle.Color = fovColors[Settings.FovColor] or Color3.fromRGB(180,100,255)
    local c = Vector2.new(vp.X/2, vp.Y/2)
    crossDot.Position = c
    crossL1.From = Vector2.new(c.X-10,c.Y); crossL1.To = Vector2.new(c.X-3,c.Y)
    crossL2.From = Vector2.new(c.X+3,c.Y); crossL2.To = Vector2.new(c.X+10,c.Y)
    crossC.Position = c
    crossX1.From = Vector2.new(c.X-7,c.Y-7); crossX1.To = Vector2.new(c.X+7,c.Y+7)
    crossX2.From = Vector2.new(c.X+7,c.Y-7); crossX2.To = Vector2.new(c.X-7,c.Y+7)
    crossDot.Visible = false; crossL1.Visible = false; crossL2.Visible = false
    crossC.Visible = false; crossX1.Visible = false; crossX2.Visible = false
    if Settings.ShowCrosshair then
        if Settings.CrosshairStyle == "Dot" then crossDot.Visible = true
        elseif Settings.CrosshairStyle == "Cross" then crossL1.Visible = true crossL2.Visible = true
        elseif Settings.CrosshairStyle == "Circle" then crossC.Visible = true
        elseif Settings.CrosshairStyle == "X" then crossX1.Visible = true crossX2.Visible = true end
    end
end)

-- HUD
local fpsL = Drawing.new("Text"); fpsL.Size = 16; fpsL.Outline = true; fpsL.Color = Color3.fromRGB(120,255,120); fpsL.Position = Vector2.new(15,55); fpsL.Visible = false
local pingL = Drawing.new("Text"); pingL.Size = 16; pingL.Outline = true; pingL.Color = Color3.fromRGB(120,200,255); pingL.Position = Vector2.new(15,75); pingL.Visible = false
local clockL = Drawing.new("Text"); clockL.Size = 16; clockL.Outline = true; clockL.Color = Color3.fromRGB(255,220,120); clockL.Position = Vector2.new(15,95); clockL.Visible = false

local frames, lastT = 0, tick()
RunService.RenderStepped:Connect(function()
    frames = frames + 1
    if tick() - lastT >= 0.5 then
        fpsL.Text = "FPS: "..math.floor(frames/(tick()-lastT)); fpsL.Visible = Settings.ShowFPS
        frames = 0; lastT = tick()
    end
end)
spawn(function()
    while true do
        task.wait(1)
        if Settings.ShowPing then
            local p = 0
            pcall(function() p = math.floor(LocalPlayer:GetNetworkPing()*1000) end)
            pingL.Text = "Ping: "..p.." ms"
        end
        pingL.Visible = Settings.ShowPing
        if Settings.ShowClock then
            local t = os.date("*t")
            clockL.Text = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
        end
        clockL.Visible = Settings.ShowClock
    end
end)

-- NEON CHINA HAT + RAINBOW
local hueVal = 0
spawn(function()
    while true do
        task.wait(0.03)
        hueVal = (hueVal + 0.015) % 1
        if Settings.ChinaHat then
            local char = LocalPlayer.Character
            local head = char and char:FindFirstChild("Head")
            if head then
                if not head:FindFirstChild("NeonChinaHat") then
                    local hat = Instance.new("Part")
                    hat.Name = "NeonChinaHat"; hat.Shape = Enum.PartType.Cylinder
                    hat.Size = Vector3.new(0.15,4,4); hat.Color = Color3.fromRGB(255,100,255)
                    hat.Material = Enum.Material.Neon; hat.CanCollide = false; hat.Massless = true
                    hat.CastShadow = false; hat.Transparency = 0
                    hat.CFrame = head.CFrame * CFrame.new(0,2,0) * CFrame.Angles(0,0,math.rad(90))
                    local light = Instance.new("PointLight"); light.Brightness = 5; light.Range = 15
                    light.Color = Color3.fromRGB(255,100,255); light.Parent = hat
                    local hat2 = Instance.new("Part")
                    hat2.Name = "NeonChinaHat2"; hat2.Shape = Enum.PartType.Cylinder
                    hat2.Size = Vector3.new(0.15,2.5,2.5); hat2.Color = Color3.fromRGB(100,200,255)
                    hat2.Material = Enum.Material.Neon; hat2.CanCollide = false; hat2.Massless = true
                    hat2.CastShadow = false
                    hat2.CFrame = head.CFrame * CFrame.new(0,2.4,0) * CFrame.Angles(0,0,math.rad(90))
                    local l2 = Instance.new("PointLight"); l2.Brightness = 3; l2.Range = 10
                    l2.Color = Color3.fromRGB(100,200,255); l2.Parent = hat2
                    local w1 = Instance.new("WeldConstraint"); w1.Part0 = hat; w1.Part1 = head; w1.Parent = hat
                    local w2 = Instance.new("WeldConstraint"); w2.Part0 = hat2; w2.Part1 = hat; w2.Parent = hat2
                    hat.Parent = head; hat2.Parent = head
                end
                local hat = head:FindFirstChild("NeonChinaHat")
                local hat2 = head:FindFirstChild("NeonChinaHat2")
                if hat then
                    hat.Color = Color3.fromHSV(hueVal, 1, 1)
                    local l = hat:FindFirstChildOfClass("PointLight")
                    if l then l.Color = Color3.fromHSV(hueVal, 1, 1) end
                end
                if hat2 then
                    hat2.Color = Color3.fromHSV((hueVal+0.5)%1, 1, 1)
                    local l = hat2:FindFirstChildOfClass("PointLight")
                    if l then l.Color = Color3.fromHSV((hueVal+0.5)%1, 1, 1) end
                end
            end
        else
            local char = LocalPlayer.Character
            if char then
                local head = char:FindFirstChild("Head")
                if head then
                    local h = head:FindFirstChild("NeonChinaHat"); if h then h:Destroy() end
                    local h2 = head:FindFirstChild("NeonChinaHat2"); if h2 then h2:Destroy() end
                end
            end
        end
        if Settings.RainbowPlayer then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character then
                    for _, part in pairs(p.Character:GetChildren()) do
                        if part:IsA("BasePart") and part.Name ~= "NeonChinaHat" and part.Name ~= "NeonChinaHat2" then
                            pcall(function() part.Color = Color3.fromHSV(hueVal, 0.7, 1) end)
                        end
                    end
                end
            end
        end
    end
end)

-- SNOW
local snowEmitter = nil
local function updateSnow()
    if Settings.SnowEnabled then
        if not snowEmitter or not snowEmitter.Parent then
            local attach = Instance.new("Attachment"); attach.Name = "SnowAttach"; attach.Parent = Camera
            local e = Instance.new("ParticleEmitter"); e.Name = "SnowEmitter"
            e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
            e.Rate = 80; e.Lifetime = NumberRange.new(4,8); e.Speed = NumberRange.new(3,6)
            e.SpreadAngle = Vector2.new(0,0); e.Rotation = NumberRange.new(0,360)
            e.LightInfluence = 0; e.Parent = attach
            snowEmitter = e
        end
        if Settings.SnowType == "Normal" then
            snowEmitter.Color = ColorSequence.new(Color3.fromRGB(255,255,255))
            snowEmitter.LightEmission = 0.3
            snowEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.1,0.6),NumberSequenceKeypoint.new(1,0.6)})
            snowEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.1,0.3),NumberSequenceKeypoint.new(0.9,0.3),NumberSequenceKeypoint.new(1,1)})
        elseif Settings.SnowType == "Neon" then
            snowEmitter.Color = ColorSequence.new(Color3.fromHSV((tick()*0.3)%1,1,1))
            snowEmitter.LightEmission = 1
            snowEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.1,0.8),NumberSequenceKeypoint.new(1,0.8)})
            snowEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.1,0.1),NumberSequenceKeypoint.new(0.9,0.1),NumberSequenceKeypoint.new(1,1)})
        elseif Settings.SnowType == "Gold" then
            snowEmitter.Color = ColorSequence.new(Color3.fromRGB(255,215,0))
            snowEmitter.LightEmission = 0.8
            snowEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.1,0.5),NumberSequenceKeypoint.new(1,0.5)})
            snowEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.1,0.2),NumberSequenceKeypoint.new(0.9,0.2),NumberSequenceKeypoint.new(1,1)})
        end
    else
        if snowEmitter then snowEmitter:Destroy() snowEmitter = nil end
        local a = Camera:FindFirstChild("SnowAttach")
        if a then a:Destroy() end
    end
end

-- SKY
local customSky = nil
local function updateSky()
    if Settings.SkyEnabled then
        if customSky then customSky:Destroy() end
        local sky = Instance.new("Sky")
        if Settings.SkyType == "Night" then
            sky.SkyboxBk="rbxassetid://159454299" sky.SkyboxDn="rbxassetid://159454296"
            sky.SkyboxFt="rbxassetid://159454293" sky.SkyboxLf="rbxassetid://159454286"
            sky.SkyboxRt="rbxassetid://159454300" sky.SkyboxUp="rbxassetid://159454288"
            sky.StarCount = 5000; sky.SunAngularSize = 0; sky.MoonAngularSize = 15
        elseif Settings.SkyType == "Sunset" then
            sky.SkyboxBk="rbxassetid://271042516" sky.SkyboxDn="rbxassetid://271077243"
            sky.SkyboxFt="rbxassetid://271042556" sky.SkyboxLf="rbxassetid://271042310"
            sky.SkyboxRt="rbxassetid://271042467" sky.SkyboxUp="rbxassetid://271041815"
            sky.StarCount = 3000
        elseif Settings.SkyType == "Space" then
            sky.SkyboxBk="rbxassetid://159454299" sky.SkyboxDn="rbxassetid://159454296"
            sky.SkyboxFt="rbxassetid://159454293" sky.SkyboxLf="rbxassetid://159454286"
            sky.SkyboxRt="rbxassetid://159454300" sky.SkyboxUp="rbxassetid://159454288"
            sky.StarCount = 10000; sky.SunAngularSize = 0; sky.MoonAngularSize = 30
        elseif Settings.SkyType == "Red" then
            sky.SkyboxBk="rbxassetid://12064107" sky.SkyboxDn="rbxassetid://12064152"
            sky.SkyboxFt="rbxassetid://12064121" sky.SkyboxLf="rbxassetid://12063984"
            sky.SkyboxRt="rbxassetid://12064115" sky.SkyboxUp="rbxassetid://12064134"
        elseif Settings.SkyType == "Neon" then
            sky.SkyboxBk="rbxassetid://159454299" sky.SkyboxDn="rbxassetid://159454296"
            sky.SkyboxFt="rbxassetid://159454293" sky.SkyboxLf="rbxassetid://159454286"
            sky.SkyboxRt="rbxassetid://159454300" sky.SkyboxUp="rbxassetid://159454288"
            sky.StarCount = 8000
        elseif Settings.SkyType == "Cyber" then
            sky.SkyboxBk="rbxassetid://159454299" sky.SkyboxDn="rbxassetid://159454296"
            sky.SkyboxFt="rbxassetid://159454293" sky.SkyboxLf="rbxassetid://159454286"
            sky.SkyboxRt="rbxassetid://159454300" sky.SkyboxUp="rbxassetid://159454288"
            sky.StarCount = 6000
        end
        sky.Parent = Lighting
        customSky = sky
    else
        if customSky then customSky:Destroy() customSky = nil end
    end
end

-- BLOOM / CC / SUNRAYS / ATMOS
local bloom, cc, sunRays, atmos = nil,nil,nil,nil
local function updateFX()
    if Settings.BloomEnabled then
        if not bloom then bloom = Instance.new("BloomEffect"); bloom.Parent = Lighting end
        bloom.Intensity = Settings.BloomIntensity; bloom.Size = 24; bloom.Threshold = 0.8
    else if bloom then bloom:Destroy() bloom = nil end end

    if Settings.ColorCorrection then
        if not cc then cc = Instance.new("ColorCorrectionEffect"); cc.Parent = Lighting end
        if Settings.CCRGB == "None" then cc.TintColor = Color3.fromRGB(255,255,255) cc.Saturation = 0 cc.Contrast = 0 cc.Brightness = 0
        elseif Settings.CCRGB == "Red" then cc.TintColor = Color3.fromRGB(255,180,180) cc.Saturation = 0.3
        elseif Settings.CCRGB == "Blue" then cc.TintColor = Color3.fromRGB(180,200,255) cc.Saturation = 0.3
        elseif Settings.CCRGB == "Green" then cc.TintColor = Color3.fromRGB(180,255,180) cc.Saturation = 0.3
        elseif Settings.CCRGB == "Matrix" then cc.TintColor = Color3.fromRGB(100,255,100) cc.Saturation = -0.5 cc.Contrast = 0.5 cc.Brightness = -0.05
        elseif Settings.CCRGB == "Cinematic" then cc.TintColor = Color3.fromRGB(255,240,220) cc.Saturation = 0.2 cc.Contrast = 0.3 cc.Brightness = 0.05 end
    else if cc then cc:Destroy() cc = nil end end

    if Settings.SunRays then
        if not sunRays then sunRays = Instance.new("SunRaysEffect"); sunRays.Intensity = 0.3; sunRays.Spread = 1; sunRays.Parent = Lighting end
    else if sunRays then sunRays:Destroy() sunRays = nil end end

    if Settings.Atmosphere then
        if not atmos then atmos = Instance.new("Atmosphere"); atmos.Density = 0.4; atmos.Offset = 0.25
            atmos.Color = Color3.fromRGB(199,199,199); atmos.Decay = Color3.fromRGB(106,112,125)
            atmos.Glare = 0.5; atmos.Haze = 1.5; atmos.Parent = Lighting end
    else if atmos then atmos:Destroy() atmos = nil end end

    if Settings.TimeEnabled then Lighting.ClockTime = Settings.TimeValue end
end

spawn(function()
    while true do
        task.wait(0.2)
        pcall(updateSnow); pcall(updateSky); pcall(updateFX)
    end
end)

-- MOVEMENT
UserInputService.JumpRequest:Connect(function()
    if Settings.InfiniteJump then
        local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)
RunService.Stepped:Connect(function()
    if Settings.Noclip then
        local c = LocalPlayer.Character
        if c then for _, p in pairs(c:GetDescendants()) do if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end end end
    end
end)
spawn(function()
    while true do
        task.wait(60)
        if Settings.AntiAFK then
            pcall(function() game:GetService("VirtualUser"):CaptureController() game:GetService("VirtualUser"):ClickButton2(Vector2.new()) end)
        end
    end
end)
spawn(function()
    while true do
        task.wait(0.5)
        if Settings.AutoRespawn then
            local c = LocalPlayer.Character
            if c then local h = c:FindFirstChildOfClass("Humanoid")
                if h and h.Health <= 0 then task.wait(0.5) pcall(function() LocalPlayer:LoadCharacter() end) end
            end
        end
    end
end)
RunService.RenderStepped:Connect(function()
    if Settings.Fly then
        local c = LocalPlayer.Character
        if c then
            local hrp = c:FindFirstChild("HumanoidRootPart")
            local bg = hrp and hrp:FindFirstChild("FlyBV")
            if hrp and bg then
                local d = Vector3.zero
                local cf = Camera.CFrame
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then d = d + cf.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then d = d - cf.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then d = d - cf.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then d = d + cf.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then d = d + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then d = d - Vector3.new(0,1,0) end
                bg.Velocity = d.Magnitude > 0 and d.Unit * Settings.FlySpeed or Vector3.zero
            end
        end
    end
end)

-- WALL CHECK
local function isVisible(char, part)
    local rp = RaycastParams.new()
    rp.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    rp.FilterType = Enum.RaycastFilterType.Exclude
    local r = workspace:Raycast(Camera.CFrame.Position, part.Position - Camera.CFrame.Position, rp)
    if r then return r.Instance:IsDescendantOf(char) end
    return true
end

-- TARGET FINDER
local currentTargetPart = nil
local function getTarget()
    local closest, shortest = nil, Settings.AimFOV
    local vp = Camera.ViewportSize
    local center = Vector2.new(vp.X/2, vp.Y/2)
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local c = p.Character
        if not c then continue end
        local h = c:FindFirstChildOfClass("Humanoid")
        if not h or h.Health <= 0 then continue end
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        local d3 = (Camera.CFrame.Position - hrp.Position).Magnitude
        if d3 > Settings.AimMaxDistance then continue end
        local part = c:FindFirstChild(Settings.AimPart) or c:FindFirstChild("Head") or hrp
        if Settings.VisibleCheck and not isVisible(c, part) then continue end
        local sp, on = Camera:WorldToViewportPoint(part.Position)
        if not on then continue end
        local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
        if d < shortest then shortest = d closest = part end
    end
    return closest
end

RunService:BindToRenderStep("AimLoop", Enum.RenderPriority.Camera.Value + 10, function()
    if not Settings.AimbotEnabled then return end
    local t = getTarget()
    currentTargetPart = t
    if not t then return end
    local tp = t.Position
    if Settings.Prediction then
        local v = t.AssemblyLinearVelocity
        local d = (t.Position - Camera.CFrame.Position).Magnitude
        tp = t.Position + v * (d/500)
    end
    local cf = CFrame.new(Camera.CFrame.Position, tp)
    if Settings.AimSmoothness > 0 then Camera.CFrame = Camera.CFrame:Lerp(cf, 1 - Settings.AimSmoothness)
    else Camera.CFrame = cf end
    if Settings.AutoShoot then
        local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool then pcall(function() tool:Activate() end) end
    end
end)

-- TARGET ESP DRAWINGS
local tBox = Drawing.new("Square"); tBox.Thickness = 2.5; tBox.Filled = false; tBox.Visible = false
local tCircle = Drawing.new("Circle"); tCircle.Thickness = 2.5; tCircle.NumSides = 40; tCircle.Filled = false; tCircle.Visible = false
local tName = Drawing.new("Text"); tName.Size = 16; tName.Center = true; tName.Outline = true; tName.Visible = false
local tHP = Drawing.new("Text"); tHP.Size = 14; tHP.Center = true; tHP.Outline = true; tHP.Color = Color3.fromRGB(120,255,120); tHP.Visible = false
local tDist = Drawing.new("Text"); tDist.Size = 13; tDist.Center = true; tDist.Outline = true; tDist.Color = Color3.fromRGB(255,220,120); tDist.Visible = false
local tArrow = Drawing.new("Triangle"); tArrow.Thickness = 1; tArrow.Filled = true; tArrow.Visible = false
local tTrail = Drawing.new("Line"); tTrail.Thickness = 2; tTrail.Visible = false

RunService.RenderStepped:Connect(function()
    if not Settings.TargetEspEnabled or not currentTargetPart then
        tBox.Visible=false tCircle.Visible=false tName.Visible=false tHP.Visible=false tDist.Visible=false tArrow.Visible=false tTrail.Visible=false
        return
    end
    if Settings.TargetEspOnlyLocked and not Settings.AimbotEnabled then
        tBox.Visible=false tName.Visible=false tHP.Visible=false return
    end
    local char = currentTargetPart.Parent
    if not char then return end
    local head = char:FindFirstChild("Head"); local hrp = char:FindFirstChild("HumanoidRootPart"); local hum = char:FindFirstChildOfClass("Humanoid")
    if not head or not hrp or not hum then return end
    local tColor = fovColors[Settings.TargetEspColor] or Color3.fromRGB(255,220,80)
    local pulse = Settings.TargetEspPulse and (0.7 + 0.3*math.sin(tick()*5)) or 1
    local top, o1 = Camera:WorldToViewportPoint(head.Position + Vector3.new(0,1.5,0))
    local bot, o2 = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0,3,0))
    if not (o1 and o2) then
        tBox.Visible=false tCircle.Visible=false tName.Visible=false tHP.Visible=false tDist.Visible=false tArrow.Visible=false tTrail.Visible=false return
    end
    local h = math.abs(top.Y - bot.Y) + 30
    local w = h * 0.65
    local bx = top.X - w/2
    local by = top.Y - 15
    if Settings.TargetEspStyle == "Box" then
        tBox.Size = Vector2.new(w,h); tBox.Position = Vector2.new(bx,by); tBox.Color = tColor; tBox.Transparency = pulse; tBox.Visible = true; tCircle.Visible = false
    elseif Settings.TargetEspStyle == "Circle" then
        tCircle.Position = Vector2.new(top.X, by+h/2); tCircle.Radius = math.max(w,h)/2; tCircle.Color = tColor; tCircle.Transparency = pulse; tCircle.Visible = true; tBox.Visible = false
    elseif Settings.TargetEspStyle == "Corner" then
        tBox.Size = Vector2.new(w*0.6, h*0.6); tBox.Position = Vector2.new(top.X - w*0.3, by + h*0.2); tBox.Color = tColor; tBox.Transparency = pulse; tBox.Visible = true; tCircle.Visible = false
    elseif Settings.TargetEspStyle == "Minimal" then
        tCircle.Position = Vector2.new(top.X, by+h/2); tCircle.Radius = 20; tCircle.Color = tColor; tCircle.Transparency = pulse; tCircle.Visible = true; tBox.Visible = false
    end
    tName.Text = "🎯 "..(char.Name or "?")
    tName.Position = Vector2.new(top.X, by - 40); tName.Color = tColor; tName.Visible = Settings.TargetEspShowName
    local hp = math.floor(hum.Health); local mx = math.floor(hum.MaxHealth)
    tHP.Text = hp.." / "..mx.." ❤"
    tHP.Position = Vector2.new(top.X, by - 22)
    tHP.Color = Color3.fromRGB(math.floor(255*(1-hp/mx)), math.floor(255*(hp/mx)), 60)
    tHP.Visible = Settings.TargetEspShowHP
    local dd = (Camera.CFrame.Position - hrp.Position).Magnitude
    tDist.Text = string.format("%d studs", math.floor(dd))
    tDist.Position = Vector2.new(top.X, by+h+5); tDist.Visible = Settings.TargetEspShowDist
    if Settings.TargetEspShowArrow then
        local aS = 12 + 3*math.sin(tick()*6)
        local aY = by - 55
        tArrow.PointA = Vector2.new(top.X, aY+aS); tArrow.PointB = Vector2.new(top.X-aS*0.7, aY); tArrow.PointC = Vector2.new(top.X+aS*0.7, aY)
        tArrow.Color = tColor; tArrow.Visible = true
    else tArrow.Visible = false end
    if Settings.TargetEspTrail then
        local vp = Camera.ViewportSize
        tTrail.From = Vector2.new(vp.X/2, vp.Y); tTrail.To = Vector2.new(top.X, by+h/2); tTrail.Color = tColor; tTrail.Visible = true
    else tTrail.Visible = false end
end)

-- ESP
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local char = p.Character
        local function hideAll()
            if highlights[p] then highlights[p].Enabled = false end
            if boxes[p] then if typeof(boxes[p])=="table" then for _,l in pairs(boxes[p]) do l.Visible=false end else boxes[p].Visible=false end end
            if boxFills[p] then boxFills[p].Visible = false end
            if names[p] then names[p].Visible = false end
            if dists[p] then dists[p].Visible = false end
            if healthBars[p] then healthBars[p].Visible = false end
            if healthBgs[p] then healthBgs[p].Visible = false end
            if tracers[p] then tracers[p].Visible = false end
            if headDots[p] then headDots[p].Visible = false end
            if arrows[p] then arrows[p].Visible = false end
            if beams[p] then beams[p].Visible = false end
            if skeletons[p] then for _,l in pairs(skeletons[p]) do l.Visible=false end end
            if chams[p] then for _,c in pairs(chams[p]) do c:Destroy() end chams[p]=nil end
        end
        if not char then hideAll() continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 or not Settings.EspEnabled then hideAll() continue end
        if Settings.EspChams then
            if not chams[p] or next(chams[p]) == nil then
                chams[p] = {}
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        local hl = Instance.new("Highlight"); hl.FillColor = Color3.fromRGB(255,60,60)
                        hl.FillTransparency = 0.3; hl.OutlineTransparency = 1
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent = part
                        table.insert(chams[p], hl)
                    end
                end
            end
        elseif chams[p] then for _,c in pairs(chams[p]) do c:Destroy() end chams[p]=nil end
        if Settings.EspHighlight then
            if not highlights[p] or highlights[p].Parent ~= char then
                if highlights[p] then highlights[p]:Destroy() end
                local hl = Instance.new("Highlight"); hl.Name="Esp"
                hl.FillColor = Color3.fromRGB(255,60,60); hl.FillTransparency = 0.5
                hl.OutlineColor = Color3.fromRGB(255,255,255); hl.OutlineTransparency = 0.2
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent = char
                highlights[p] = hl
            end
            highlights[p].Enabled = true
        elseif highlights[p] then highlights[p].Enabled = false end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local head = char:FindFirstChild("Head")
        if hrp and head then
            local top, o1 = Camera:WorldToViewportPoint(head.Position + Vector3.new(0,0.5,0))
            local bot, o2 = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0,3,0))
            if Settings.EspArrow then
                local cs = Camera.ViewportSize / 2
                local sp = Camera:WorldToViewportPoint(hrp.Position)
                local spv = Vector2.new(sp.X, sp.Y)
                local dir = spv - Vector2.new(cs.X, cs.Y)
                local onScr = sp.Z > 0 and math.abs(spv.X - cs.X) < cs.X and math.abs(spv.Y - cs.Y) < cs.Y
                if not onScr then
                    if not arrows[p] then arrows[p] = Drawing.new("Triangle") arrows[p].Thickness=1 arrows[p].Filled=true arrows[p].Color=Color3.fromRGB(255,60,60) arrows[p].Transparency=1 end
                    local a = math.atan2(dir.Y, dir.X); local r = 150
                    local pos = Vector2.new(cs.X + math.cos(a)*r, cs.Y + math.sin(a)*r)
                    local sz = 15
                    arrows[p].PointA = pos + Vector2.new(math.cos(a)*sz, math.sin(a)*sz)
                    arrows[p].PointB = pos + Vector2.new(math.cos(a+2.5)*sz, math.sin(a+2.5)*sz)
                    arrows[p].PointC = pos + Vector2.new(math.cos(a-2.5)*sz, math.sin(a-2.5)*sz)
                    arrows[p].Visible = true
                elseif arrows[p] then arrows[p].Visible = false end
            elseif arrows[p] then arrows[p].Visible = false end
            if Settings.EspBeam then
                if not beams[p] then beams[p] = Drawing.new("Line") beams[p].Thickness=1.5 beams[p].Color=Color3.fromRGB(255,100,200) beams[p].Transparency=0.7 end
                local vp = Camera.ViewportSize
                local tS = Camera:WorldToViewportPoint(hrp.Position)
                beams[p].From = Vector2.new(vp.X/2, vp.Y-30); beams[p].To = Vector2.new(tS.X, tS.Y); beams[p].Visible = true
            elseif beams[p] then beams[p].Visible = false end
            if o1 and o2 then
                local h = math.abs(top.Y - bot.Y); local w = h * 0.55
                local bx = top.X - w/2; local by = top.Y
                if Settings.EspBox then
                    if Settings.EspBoxStyle == "Filled" then
                        if not boxFills[p] then boxFills[p] = Drawing.new("Square") boxFills[p].Filled=true boxFills[p].Color=Color3.fromRGB(255,60,60) boxFills[p].Transparency=0.75 end
                        boxFills[p].Size = Vector2.new(w,h); boxFills[p].Position = Vector2.new(bx,by); boxFills[p].Visible = true
                        if boxes[p] and typeof(boxes[p])~="table" then boxes[p].Visible=false end
                    else
                        if not boxes[p] or typeof(boxes[p])=="table" then
                            if typeof(boxes[p])=="table" then for _,l in pairs(boxes[p]) do l:Remove() end end
                            boxes[p] = Drawing.new("Square"); boxes[p].Thickness=2; boxes[p].Filled=false; boxes[p].Color=Color3.fromRGB(255,60,60); boxes[p].Transparency=1
                        end
                        boxes[p].Size = Vector2.new(w,h); boxes[p].Position = Vector2.new(bx,by); boxes[p].Visible = true
                        if boxFills[p] then boxFills[p].Visible = false end
                    end
                elseif boxes[p] then
                    if typeof(boxes[p])=="table" then for _,l in pairs(boxes[p]) do l.Visible=false end else boxes[p].Visible=false end
                    if boxFills[p] then boxFills[p].Visible = false end
                end
                if Settings.EspHeadDot then
                    if not headDots[p] then headDots[p] = Drawing.new("Circle") headDots[p].Radius=6 headDots[p].Filled=false headDots[p].Thickness=2 headDots[p].Color=Color3.fromRGB(255,100,100) headDots[p].Transparency=1 end
                    headDots[p].Position = Vector2.new(top.X, top.Y+5); headDots[p].Visible = true
                elseif headDots[p] then headDots[p].Visible = false end
                if Settings.EspSkeleton then
                    local bones = {{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}}
                    if not skeletons[p] then
                        skeletons[p] = {}
                        for i=1,#bones do local ln = Drawing.new("Line") ln.Thickness=1.5 ln.Color=Color3.fromRGB(255,255,255) ln.Transparency=1 table.insert(skeletons[p], ln) end
                    end
                    for i, b in ipairs(bones) do
                        local p1 = char:FindFirstChild(b[1]); local p2 = char:FindFirstChild(b[2])
                        if p1 and p2 then
                            local v1, oo1 = Camera:WorldToViewportPoint(p1.Position)
                            local v2, oo2 = Camera:WorldToViewportPoint(p2.Position)
                            if oo1 and oo2 then skeletons[p][i].From = Vector2.new(v1.X,v1.Y) skeletons[p][i].To = Vector2.new(v2.X,v2.Y) skeletons[p][i].Visible = true
                            else skeletons[p][i].Visible = false end
                        end
                    end
                elseif skeletons[p] then for _,l in pairs(skeletons[p]) do l.Visible=false end end
                if Settings.EspName then
                    if not names[p] then names[p] = Drawing.new("Text") names[p].Size=14 names[p].Center=true names[p].Outline=true names[p].Color=Color3.fromRGB(255,255,255) end
                    names[p].Text = p.Name; names[p].Position = Vector2.new(top.X, top.Y-18); names[p].Visible = true
                elseif names[p] then names[p].Visible = false end
                if Settings.EspDistance then
                    if not dists[p] then dists[p] = Drawing.new("Text") dists[p].Size=12 dists[p].Center=true dists[p].Outline=true dists[p].Color=Color3.fromRGB(255,220,120) end
                    local dd = (Camera.CFrame.Position - hrp.Position).Magnitude
                    dists[p].Text = string.format("[%d]", math.floor(dd)); dists[p].Position = Vector2.new(top.X, top.Y+h+3); dists[p].Visible = true
                elseif dists[p] then dists[p].Visible = false end
                if Settings.EspHealth then
                    if not healthBgs[p] then
                        healthBgs[p] = Drawing.new("Square"); healthBgs[p].Thickness=1; healthBgs[p].Filled=true; healthBgs[p].Color=Color3.fromRGB(20,20,20)
                        healthBars[p] = Drawing.new("Square"); healthBars[p].Thickness=1; healthBars[p].Filled=true
                    end
                    local hp = hum.Health / hum.MaxHealth
                    healthBgs[p].Size = Vector2.new(3,h); healthBgs[p].Position = Vector2.new(bx-6, top.Y); healthBgs[p].Visible = true
                    healthBars[p].Size = Vector2.new(3, h*hp); healthBars[p].Position = Vector2.new(bx-6, top.Y + (h*(1-hp)))
                    healthBars[p].Color = Color3.fromRGB(math.floor(255*(1-hp)), math.floor(255*hp), 60); healthBars[p].Visible = true
                else
                    if healthBars[p] then healthBars[p].Visible = false end
                    if healthBgs[p] then healthBgs[p].Visible = false end
                end
                if Settings.EspTracer then
                    if not tracers[p] then tracers[p] = Drawing.new("Line") tracers[p].Thickness=1 tracers[p].Color=Color3.fromRGB(255,80,80) tracers[p].Transparency=0.8 end
                    local vp = Camera.ViewportSize
                    tracers[p].From = Vector2.new(vp.X/2, vp.Y); tracers[p].To = Vector2.new(top.X, top.Y+h); tracers[p].Visible = true
                elseif tracers[p] then tracers[p].Visible = false end
            else hideAll() end
        end
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if highlights[p] then highlights[p]:Destroy() highlights[p]=nil end
    if boxes[p] then if typeof(boxes[p])=="table" then for _,l in pairs(boxes[p]) do l:Remove() end else boxes[p]:Remove() end boxes[p]=nil end
    if boxFills[p] then boxFills[p]:Remove() boxFills[p]=nil end
    if names[p] then names[p]:Remove() names[p]=nil end
    if dists[p] then dists[p]:Remove() dists[p]=nil end
    if healthBars[p] then healthBars[p]:Remove() healthBars[p]=nil end
    if healthBgs[p] then healthBgs[p]:Remove() healthBgs[p]=nil end
    if tracers[p] then tracers[p]:Remove() tracers[p]=nil end
    if headDots[p] then headDots[p]:Remove() headDots[p]=nil end
    if arrows[p] then arrows[p]:Remove() arrows[p]=nil end
    if beams[p] then beams[p]:Remove() beams[p]=nil end
    if skeletons[p] then for _,l in pairs(skeletons[p]) do l:Remove() end skeletons[p]=nil end
    if chams[p] then for _,c in pairs(chams[p]) do c:Destroy() end chams[p]=nil end
end)
