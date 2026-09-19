--=============================================================
-- PrimDLC v17 | by @LutshiyKot
--=============================================================
local P=game:GetService("Players")
local R=game:GetService("RunService")
local U=game:GetService("UserInputService")
local T=game:GetService("TeleportService")
local H=game:GetService("HttpService")
local L=game:GetService("Lighting")
local Tw=game:GetService("TweenService")
local D=game:GetService("Debris")
local LP=P.LocalPlayer
while not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") do task.wait(.1) end
task.wait(.5)
local Cam=workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()Cam=workspace.CurrentCamera end)
LP.CharacterAdded:Connect(function(c)c:WaitForChild("HumanoidRootPart")task.wait(.5)Cam=workspace.CurrentCamera end)

--=============================================================
-- SETTINGS
--=============================================================
local S={
-- Aim
Aim=true,Smooth=.05,FOV=120,Part="Head",MaxD=500,VisChk=true,AutoS=false,Pred=false,
TargetMode="Closest",IgnoreFriends=false,
-- ESP
ESP=true,Box=true,BoxStyle="Normal",HL=true,Name=true,Dist=true,HP=true,
Tracer=false,Skel=false,HDot=false,Chams=false,
-- Target ESP
TgtE=true,TgtCol="Red",TgtName=true,TgtHP=true,TgtDist=true,
-- Visual
ShowFov=true,FovCol="Purple",
-- Rivals
SilentAim=false,SilentFOV=200,SilentWalls=true,SilentFire=false,
-- Combat
KillAura=false,KillAuraRange=15,AutoDodge=false,AutoDodgeRange=30,
HitboxExpander=false,HitboxSize=8,
-- Movement
Spd=16,Jmp=50,FlyS=50,IJmp=false,Fly=false,Noclip=false,
ThirdPerson=false,ThirdPersonDist=10,SpinBot=false,SpinBotSpeed=10,
-- Sounds
HSnd=false,HSndT="Click",KSnd=false,KSndT="Explosion",
KillFeed=true,
-- Theme
Theme="Purple",
}
local C={Purple=Color3.fromRGB(180,100,255),Red=Color3.fromRGB(255,80,80),Blue=Color3.fromRGB(80,150,255),
Green=Color3.fromRGB(80,255,120),Yellow=Color3.fromRGB(255,220,80),White=Color3.fromRGB(255,255,255),
Pink=Color3.fromRGB(255,100,200),Cyan=Color3.fromRGB(80,255,255),Orange=Color3.fromRGB(255,150,50)}
local Themes={
Purple={bg=Color3.fromRGB(55,20,110),accent=Color3.fromRGB(180,100,255),accent2=Color3.fromRGB(120,200,255),text=Color3.fromRGB(255,220,255)},
Dark={bg=Color3.fromRGB(20,20,25),accent=Color3.fromRGB(120,120,140),accent2=Color3.fromRGB(80,80,100),text=Color3.fromRGB(230,230,240)},
Cyan={bg=Color3.fromRGB(15,45,60),accent=Color3.fromRGB(80,220,255),accent2=Color3.fromRGB(60,150,220),text=Color3.fromRGB(200,245,255)},
Green={bg=Color3.fromRGB(15,50,25),accent=Color3.fromRGB(80,255,120),accent2=Color3.fromRGB(50,180,80),text=Color3.fromRGB(200,255,210)},
Red={bg=Color3.fromRGB(60,15,15),accent=Color3.fromRGB(255,80,80),accent2=Color3.fromRGB(200,50,50),text=Color3.fromRGB(255,200,200)},
Matrix={bg=Color3.fromRGB(10,20,10),accent=Color3.fromRGB(60,255,60),accent2=Color3.fromRGB(30,180,30),text=Color3.fromRGB(150,255,150)},
Pink={bg=Color3.fromRGB(60,20,50),accent=Color3.fromRGB(255,120,220),accent2=Color3.fromRGB(200,80,180),text=Color3.fromRGB(255,200,240)},
}
local T1=Themes[S.Theme]or Themes.Purple

--=============================================================
-- UI
--=============================================================
local gui=Instance.new("ScreenGui")
gui.Name="PrimDLC"
gui.ResetOnSpawn=false
gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
pcall(function() gui.Parent=game:GetService("CoreGui") end)
if not gui.Parent then gui.Parent=LP:WaitForChild("PlayerGui") end

local MF=Instance.new("Frame",gui)
MF.Size=UDim2.new(0,460,0,340)
MF.Position=UDim2.new(.5,-230,.5,-170)
MF.BackgroundColor3=T1.bg
MF.BackgroundTransparency=.15
MF.BorderSizePixel=0
MF.Active=true
MF.Draggable=true
Instance.new("UICorner",MF).CornerRadius=UDim.new(0,14)

local GR=Instance.new("UIGradient",MF)
GR.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,T1.accent),ColorSequenceKeypoint.new(.5,T1.bg),ColorSequenceKeypoint.new(1,T1.accent2)})
GR.Rotation=45
local IG=Instance.new("Frame",MF)
IG.Size=UDim2.new(1,0,1,0)
IG.BackgroundColor3=T1.accent
IG.BackgroundTransparency=.82
IG.BorderSizePixel=0
Instance.new("UICorner",IG).CornerRadius=UDim.new(0,14)
local N1=Instance.new("UIStroke",MF)N1.Color=T1.accent N1.Thickness=2

local HD=Instance.new("Frame",MF)
HD.Size=UDim2.new(1,0,0,42)
HD.BackgroundColor3=T1.accent
HD.BackgroundTransparency=.5
HD.BorderSizePixel=0
Instance.new("UICorner",HD).CornerRadius=UDim.new(0,14)
local AV=Instance.new("TextLabel",HD)
AV.Size=UDim2.new(0,26,0,26)AV.Position=UDim2.new(0,10,0,8)
AV.BackgroundColor3=T1.bg AV.Text="👑"AV.TextSize=15
AV.Font=Enum.Font.GothamBold AV.BorderSizePixel=0
Instance.new("UICorner",AV).CornerRadius=UDim.new(0,7)
local TL=Instance.new("TextLabel",HD)
TL.Size=UDim2.new(1,-180,0,20)TL.Position=UDim2.new(0,44,0,6)
TL.BackgroundTransparency=1 TL.Text="@LutshiyKot"
TL.TextColor3=Color3.fromRGB(255,255,255)TL.TextSize=14
TL.Font=Enum.Font.GothamBold TL.TextXAlignment=Enum.TextXAlignment.Left
local SL=Instance.new("TextLabel",HD)
SL.Size=UDim2.new(1,-180,0,14)SL.Position=UDim2.new(0,44,0,22)
SL.BackgroundTransparency=1 SL.Text="PrimDLC v17"
SL.TextColor3=T1.text SL.TextSize=10
SL.Font=Enum.Font.Gotham SL.TextXAlignment=Enum.TextXAlignment.Left

local function mkb(t,x,cb)
local b=Instance.new("TextButton",HD)
b.Size=UDim2.new(0,26,0,26)b.Position=UDim2.new(1,x,0,6)
b.BackgroundColor3=T1.bg b.BackgroundTransparency=.15
b.Text=t b.TextColor3=Color3.fromRGB(255,255,255)b.TextSize=13
b.Font=Enum.Font.GothamBold b.BorderSizePixel=0 b.AutoButtonColor=false
Instance.new("UICorner",b).CornerRadius=UDim.new(0,7)
local bs=Instance.new("UIStroke",b)bs.Color=T1.accent bs.Thickness=1 bs.Transparency=.1
b.MouseButton1Click:Connect(cb)
end

mkb("X",-30,function()MF.Visible=false end)

local SB=Instance.new("ScrollingFrame",MF)
SB.Size=UDim2.new(0,115,1,-55)SB.Position=UDim2.new(0,10,0,48)
SB.BackgroundColor3=T1.bg SB.BackgroundTransparency=.55 SB.BorderSizePixel=0
SB.ScrollBarThickness=2 SB.ScrollBarImageColor3=T1.accent
SB.CanvasSize=UDim2.new(0,0,0,0)SB.AutomaticCanvasSize=Enum.AutomaticSize.Y
SB.ScrollingDirection=Enum.ScrollingDirection.Y
Instance.new("UICorner",SB).CornerRadius=UDim.new(0,10)
local sbs=Instance.new("UIStroke",SB)sbs.Color=T1.accent sbs.Thickness=1 sbs.Transparency=.3
local sbl=Instance.new("UIListLayout",SB)sbl.Padding=UDim.new(0,4)
local sbp=Instance.new("UIPadding",SB)sbp.PaddingTop=UDim.new(0,6)sbp.PaddingLeft=UDim.new(0,6)sbp.PaddingRight=UDim.new(0,6)sbp.PaddingBottom=UDim.new(0,6)

local CT=Instance.new("ScrollingFrame",MF)
CT.Size=UDim2.new(1,-135,1,-55)CT.Position=UDim2.new(0,130,0,48)
CT.BackgroundTransparency=1 CT.BorderSizePixel=0
CT.ScrollBarThickness=3 CT.ScrollBarImageColor3=T1.accent
CT.CanvasSize=UDim2.new(0,0,0,0)CT.AutomaticCanvasSize=Enum.AutomaticSize.Y
local cl=Instance.new("UIListLayout",CT)cl.Padding=UDim.new(0,5)

local tabs={}
local function clr()
for _,c in pairs(CT:GetChildren()) do
if c:IsA("TextButton")or c:IsA("TextLabel")or c:IsA("Frame")then c:Destroy()end
end
end
local function mkSec(t)
local l=Instance.new("TextLabel",CT)
l.Size=UDim2.new(1,-6,0,22)l.BackgroundTransparency=1
l.Text=t l.TextColor3=T1.text l.TextSize=13
l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left
end
local function mkC(t,d,cb)
local c=Instance.new("TextButton",CT)
c.Size=UDim2.new(1,-6,0,36)c.BackgroundColor3=T1.bg c.BackgroundTransparency=.3
c.Text=""c.BorderSizePixel=0 c.AutoButtonColor=false
Instance.new("UICorner",c).CornerRadius=UDim.new(0,9)
local cs=Instance.new("UIStroke",c)cs.Color=T1.accent cs.Thickness=1 cs.Transparency=.2
local l=Instance.new("TextLabel",c)
l.Size=UDim2.new(1,-60,1,0)l.Position=UDim2.new(0,14,0,0)l.BackgroundTransparency=1
l.Text=t l.TextColor3=T1.text l.TextSize=12
l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left
local tg=Instance.new("Frame",c)
tg.Size=UDim2.new(0,36,0,18)tg.Position=UDim2.new(1,-46,.5,-9)
tg.BackgroundColor3=d and T1.accent or T1.bg
tg.BorderSizePixel=0
Instance.new("UICorner",tg).CornerRadius=UDim.new(1,0)
local k=Instance.new("Frame",tg)
k.Size=UDim2.new(0,14,0,14)k.Position=d and UDim2.new(1,-16,.5,-7) or UDim2.new(0,2,.5,-7)
k.BackgroundColor3=Color3.fromRGB(255,255,255)k.BorderSizePixel=0
Instance.new("UICorner",k).CornerRadius=UDim.new(1,0)
local st=d
c.MouseButton1Click:Connect(function()
st=not st cb(st)
tg.BackgroundColor3=st and T1.accent or T1.bg
k:TweenPosition(st and UDim2.new(1,-16,.5,-7) or UDim2.new(0,2,.5,-7),"Out","Quad",.15,true)
end)
end
local function mkB2(t,cb)
local b=Instance.new("TextButton",CT)
b.Size=UDim2.new(1,-6,0,36)b.BackgroundColor3=T1.accent b.BackgroundTransparency=.5
b.Text=t b.TextColor3=T1.text b.TextSize=12
b.Font=Enum.Font.GothamBold b.BorderSizePixel=0 b.AutoButtonColor=false
Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
local bs=Instance.new("UIStroke",b)bs.Color=T1.accent bs.Thickness=1.5 bs.Transparency=.1
b.MouseButton1Click:Connect(function()bs.Transparency=0 task.wait(.1)bs.Transparency=.1 cb()end)
end
local function mkSl(t,mn,mx,d,cb)
local f=Instance.new("Frame",CT)
f.Size=UDim2.new(1,-6,0,52)f.BackgroundColor3=T1.bg f.BackgroundTransparency=.3
f.BorderSizePixel=0
Instance.new("UICorner",f).CornerRadius=UDim.new(0,9)
local cs=Instance.new("UIStroke",f)cs.Color=T1.accent cs.Thickness=1 cs.Transparency=.2
local l=Instance.new("TextLabel",f)
l.Size=UDim2.new(1,-20,0,18)l.Position=UDim2.new(0,14,0,5)l.BackgroundTransparency=1
l.Text=t..": "..tostring(d)l.TextColor3=T1.text l.TextSize=12
l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left
local bg=Instance.new("Frame",f)
bg.Size=UDim2.new(1,-28,0,7)bg.Position=UDim2.new(0,14,0,32)bg.BackgroundColor3=T1.bg
bg.BorderSizePixel=0
Instance.new("UICorner",bg).CornerRadius=UDim.new(1,0)
local fl=Instance.new("Frame",bg)
fl.Size=UDim2.new((d-mn)/(mx-mn),0,1,0)fl.BackgroundColor3=T1.accent
fl.BorderSizePixel=0
Instance.new("UICorner",fl).CornerRadius=UDim.new(1,0)
local dr=false
local function upd(i)
local p=i.Position.X-bg.AbsolutePosition.X
local pc=math.clamp(p/bg.AbsoluteSize.X,0,1)
local v=mn+(mx-mn)*pc
fl.Size=UDim2.new(pc,0,1,0)l.Text=t..": "..string.format("%.0f",v)cb(v)
end
bg.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true upd(i)end end)
U.InputChanged:Connect(function(i)if dr and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then upd(i)end end)
U.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)
end
local function mkDr(t,op,d,cb)
local b=Instance.new("TextButton",CT)
b.Size=UDim2.new(1,-6,0,36)b.BackgroundColor3=T1.bg b.BackgroundTransparency=.3
b.Text=""b.BorderSizePixel=0 b.AutoButtonColor=false
Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
local cs=Instance.new("UIStroke",b)cs.Color=T1.accent cs.Thickness=1 cs.Transparency=.2
local l=Instance.new("TextLabel",b)
l.Size=UDim2.new(.5,-10,1,0)l.Position=UDim2.new(0,14,0,0)l.BackgroundTransparency=1
l.Text=t l.TextColor3=T1.text l.TextSize=12
l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left
local v=Instance.new("TextLabel",b)
v.Size=UDim2.new(.5,-14,1,0)v.Position=UDim2.new(.5,0,0,0)v.BackgroundTransparency=1
v.Text=d v.TextColor3=T1.accent v.TextSize=12
v.Font=Enum.Font.GothamBold v.TextXAlignment=Enum.TextXAlignment.Right
local i=1
for x,o in ipairs(op) do if o==d then i=x break end end
b.MouseButton1Click:Connect(function()i=i%#op+1 v.Text=op[i]cb(op[i])end)
end
local function mkT(name,icon,cb)
local b=Instance.new("TextButton",SB)
b.Size=UDim2.new(1,0,0,28)b.BackgroundColor3=T1.bg b.BackgroundTransparency=.5
b.Text=""b.BorderSizePixel=0 b.AutoButtonColor=false
Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
local bs=Instance.new("UIStroke",b)bs.Color=T1.accent bs.Thickness=1 bs.Transparency=.6
local l=Instance.new("TextLabel",b)
l.Size=UDim2.new(1,-32,1,0)l.Position=UDim2.new(0,26,0,0)l.BackgroundTransparency=1
l.Text=name l.TextColor3=T1.text l.TextSize=10
l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left
local ic=Instance.new("TextLabel",b)
ic.Size=UDim2.new(0,18,1,0)ic.Position=UDim2.new(0,8,0,0)ic.BackgroundTransparency=1
ic.Text=icon ic.TextSize=11 ic.Font=Enum.Font.GothamBold
b.MouseButton1Click:Connect(function()
for _,t in pairs(tabs) do t.btn.BackgroundColor3=T1.bg t.lbl.TextColor3=T1.text t.bs.Transparency=.6 end
b.BackgroundColor3=T1.accent l.TextColor3=Color3.fromRGB(255,255,255)bs.Transparency=0 cb()
end)
return{btn=b,lbl=l,bs=bs,callback=cb}
end

-- SOUNDS
local HSnd={Click="rbxassetid://6895079853",Bell="rbxassetid://6042054027",Minecraft="rbxassetid://6042054196",Pew="rbxassetid://6042054652",Bubble="rbxassetid://6042054764"}
local KSnd={Explosion="rbxassetid://153467001",Ding="rbxassetid://4590662766",Bruh="rbxassetid://6042055494",Vine="rbxassetid://6042055656",Sniper="rbxassetid://6042055794"}
local soundHolder=Instance.new("Folder",gui)
local function pSnd(id,v)
if not id or id=="" then return end
local s=Instance.new("Sound")
s.SoundId=id s.Volume=v or 1 s.Parent=soundHolder
pcall(function() s:Play() end)
D:AddItem(s,5)
end

--=============================================================
-- TABS
--=============================================================
table.insert(tabs,mkT("Main","🏠",function()
clr()
mkSec("Aimbot")mkC("Aimbot",S.Aim,function(v)S.Aim=v end)mkC("Auto Shoot",S.AutoS,function(v)S.AutoS=v end)
mkC("Prediction",S.Pred,function(v)S.Pred=v end)mkC("Wall Check",S.VisChk,function(v)S.VisChk=v end)
mkSec("ESP")mkC("ESP",S.ESP,function(v)S.ESP=v end)mkC("Box",S.Box,function(v)S.Box=v end)
mkC("Highlight",S.HL,function(v)S.HL=v end)mkC("Chams",S.Chams,function(v)S.Chams=v end)
end))
table.insert(tabs,mkT("Aim","⚔",function()
clr()
mkSec("Aimbot")mkC("Aimbot",S.Aim,function(v)S.Aim=v end)mkC("Auto Shoot",S.AutoS,function(v)S.AutoS=v end)
mkC("Prediction",S.Pred,function(v)S.Pred=v end)mkC("Wall Check",S.VisChk,function(v)S.VisChk=v end)
mkSec("Target")mkDr("Hit Part",{"Head","UpperTorso","LowerTorso","HumanoidRootPart"},S.Part,function(v)S.Part=v end)
mkDr("FOV Color",{"Purple","Red","Blue","Green","Yellow","White","Pink","Cyan","Orange"},S.FovCol,function(v)S.FovCol=v end)
mkSl("FOV",50,800,S.FOV,function(v)S.FOV=v end)
mkSl("Smooth",0,95,S.Smooth*100,function(v)S.Smooth=v/100 end)
mkSl("Max Dist",50,2000,S.MaxD,function(v)S.MaxD=v end)
mkSec("Advanced")mkDr("Target Mode",{"Closest","Lowest HP","Highest HP","Nearest"},S.TargetMode,function(v)S.TargetMode=v end)
mkC("Ignore Friends",S.IgnoreFriends,function(v)S.IgnoreFriends=v end)
end))
table.insert(tabs,mkT("Visual","🎨",function()
clr()
mkSec("ESP")mkC("ESP",S.ESP,function(v)S.ESP=v end)mkC("Box",S.Box,function(v)S.Box=v end)
mkDr("Box Style",{"Normal","Corner","Filled"},S.BoxStyle,function(v)S.BoxStyle=v end)
mkC("Highlight",S.HL,function(v)S.HL=v end)mkC("Chams",S.Chams,function(v)S.Chams=v end)
mkC("Name",S.Name,function(v)S.Name=v end)mkC("Distance",S.Dist,function(v)S.Dist=v end)
mkC("Health Bar",S.HP,function(v)S.HP=v end)mkC("Tracer",S.Tracer,function(v)S.Tracer=v end)
mkC("Skeleton",S.Skel,function(v)S.Skel=v end)mkC("Head Dot",S.HDot,function(v)S.HDot=v end)
mkSec("Screen")mkC("FOV Circle",S.ShowFov,function(v)S.ShowFov=v end)
mkSec("Target ESP")mkC("Enable",S.TgtE,function(v)S.TgtE=v end)
mkC("Name",S.TgtName,function(v)S.TgtName=v end)
mkC("HP",S.TgtHP,function(v)S.TgtHP=v end)
mkC("Distance",S.TgtDist,function(v)S.TgtDist=v end)
mkDr("Color",{"Red","Yellow","Green","Cyan","White","Purple"},S.TgtCol,function(v)S.TgtCol=v end)
end))
table.insert(tabs,mkT("Rivals","🥊",function()
clr()
mkSec("═══ SILENT AIM ═══")
mkC("Enable Silent Aim",S.SilentAim,function(v)S.SilentAim=v end)
mkC("Auto Fire",S.SilentFire,function(v)S.SilentFire=v end)
mkC("Ignore Walls",S.SilentWalls,function(v)S.SilentWalls=v end)
mkSl("Silent FOV",30,500,S.SilentFOV,function(v)S.SilentFOV=v end)
mkSec("═══ COMBAT ═══")
mkC("Kill Aura",S.KillAura,function(v)S.KillAura=v end)
mkSl("Aura Range",5,50,S.KillAuraRange,function(v)S.KillAuraRange=v end)
mkC("Auto Dodge",S.AutoDodge,function(v)S.AutoDodge=v end)
mkSl("Dodge Range",10,60,S.AutoDodgeRange,function(v)S.AutoDodgeRange=v end)
mkC("Hitbox Expander",S.HitboxExpander,function(v)S.HitboxExpander=v end)
mkSl("Hitbox Size",3,15,S.HitboxSize,function(v)S.HitboxSize=v end)
mkSec("═══ MOVEMENT ═══")
mkSl("Walk Speed",16,200,S.Spd,function(v)S.Spd=v local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")if h then h.WalkSpeed=v end end)
mkSl("Jump Power",50,300,S.Jmp,function(v)S.Jmp=v local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")if h then h.JumpPower=v end end)
mkC("Infinite Jump",S.IJmp,function(v)S.IJmp=v end)
mkC("Fly",S.Fly,function(v)
S.Fly=v local c=LP.Character if not c then return end
local hrp=c:FindFirstChild("HumanoidRootPart")if not hrp then return end
if v then local bg=Instance.new("BodyVelocity")bg.MaxForce=Vector3.new(math.huge,math.huge,math.huge)bg.Velocity=Vector3.zero bg.Name="FlyBV"bg.Parent=hrp
else local bg=hrp:FindFirstChild("FlyBV")if bg then bg:Destroy()end end
end)
mkSl("Fly Speed",10,300,S.FlyS,function(v)S.FlyS=v end)
mkC("Noclip",S.Noclip,function(v)S.Noclip=v end)
mkSec("═══ CAMERA ═══")
mkC("Third Person",S.ThirdPerson,function(v)S.ThirdPerson=v end)
mkSl("TP Distance",5,20,S.ThirdPersonDist,function(v)S.ThirdPersonDist=v end)
mkC("Spin Bot",S.SpinBot,function(v)S.SpinBot=v end)
mkSl("Spin Speed",5,30,S.SpinBotSpeed,function(v)S.SpinBotSpeed=v end)
mkSec("═══ SOUNDS ═══")
mkC("Hit Sound",S.HSnd,function(v)S.HSnd=v end)
mkDr("Hit Type",{"Click","Bell","Minecraft","Pew","Bubble"},S.HSndT,function(v)S.HSndT=v end)
mkC("Kill Sound",S.KSnd,function(v)S.KSnd=v end)
mkDr("Kill Type",{"Explosion","Ding","Bruh","Vine","Sniper"},S.KSndT,function(v)S.KSndT=v end)
mkC("Kill Feed",S.KillFeed,function(v)S.KillFeed=v end)
end))
table.insert(tabs,mkT("Extras","⚡",function()
clr()
mkSec("Combat")mkC("Hitbox Expander",S.HitboxExpander,function(v)S.HitboxExpander=v end)
mkSl("Hitbox Size",3,15,S.HitboxSize,function(v)S.HitboxSize=v end)
mkC("Kill Aura",S.KillAura,function(v)S.KillAura=v end)
mkSl("Aura Range",5,50,S.KillAuraRange,function(v)S.KillAuraRange=v end)
mkC("Auto Dodge",S.AutoDodge,function(v)S.AutoDodge=v end)
mkSl("Dodge Range",10,60,S.AutoDodgeRange,function(v)S.AutoDodgeRange=v end)
mkSec("Movement")mkC("Infinite Jump",S.IJmp,function(v)S.IJmp=v end)
mkC("Fly",S.Fly,function(v)
S.Fly=v local c=LP.Character if not c then return end
local hrp=c:FindFirstChild("HumanoidRootPart")if not hrp then return end
if v then local bg=Instance.new("BodyVelocity")bg.MaxForce=Vector3.new(math.huge,math.huge,math.huge)bg.Velocity=Vector3.zero bg.Name="FlyBV"bg.Parent=hrp
else local bg=hrp:FindFirstChild("FlyBV")if bg then bg:Destroy()end end
end)
mkC("Noclip",S.Noclip,function(v)S.Noclip=v end)
mkSl("Walk Speed",16,200,S.Spd,function(v)S.Spd=v local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")if h then h.WalkSpeed=v end end)
mkSl("Jump Power",50,300,S.Jmp,function(v)S.Jmp=v local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")if h then h.JumpPower=v end end)
mkSl("Fly Speed",10,300,S.FlyS,function(v)S.FlyS=v end)
mkSec("Camera")mkC("Third Person",S.ThirdPerson,function(v)S.ThirdPerson=v end)
mkSl("TP Distance",5,20,S.ThirdPersonDist,function(v)S.ThirdPersonDist=v end)
mkC("Spin Bot",S.SpinBot,function(v)S.SpinBot=v end)
mkSl("Spin Speed",5,30,S.SpinBotSpeed,function(v)S.SpinBotSpeed=v end)
end))
table.insert(tabs,mkT("Theme","🌈",function()
clr()
mkSec("UI Theme")
mkDr("Theme",{"Purple","Dark","Cyan","Green","Red","Matrix","Pink"},S.Theme,function(v)
S.Theme=v
local T2=Themes[v]or Themes.Purple
MF.BackgroundColor3=T2.bg
GR.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,T2.accent),ColorSequenceKeypoint.new(.5,T2.bg),ColorSequenceKeypoint.new(1,T2.accent2)})
N1.Color=T2.accent
HD.BackgroundColor3=T2.accent
SB.BackgroundColor3=T2.bg
sbs.Color=T2.accent
for _,t in pairs(tabs) do t.btn.BackgroundColor3=T2.bg t.lbl.TextColor3=T2.text t.bs.Color=T2.accent t.bs.Transparency=.6 end
end)
end))
table.insert(tabs,mkT("Player","👤",function()
clr()
mkSec("Utility")
mkB2("🔄 RESET",function()local c=LP.Character if c then local h=c:FindFirstChildOfClass("Humanoid")if h then h.Health=0 end end end)
mkB2("📋 COPY JOB ID",function()if setclipboard then setclipboard(game.JobId)end end)
mkB2("📋 COPY PLACE ID",function()if setclipboard then setclipboard(tostring(game.PlaceId))end end)
mkSec("Server")
mkB2("🌐 SERVER HOP",function()
local pid=game.PlaceId local jid=game.JobId
local url="https://games.roblox.com/v1/games/"..pid.."/servers/Public?sortOrder=Asc&limit=100"
local ok,r=pcall(function()return H:JSONDecode(game:HttpGet(url))end)
if ok and r and r.data then
for _,s in pairs(r.data)do
if s.playing<s.maxPlayers and s.id~=jid then pcall(function()T:TeleportToPlaceInstance(pid,s.id,LP)end)return end
end
end
pcall(function()T:Teleport(pid,LP)end)
end)
mkB2("🔄 REJOIN",function()pcall(function()T:TeleportToPlaceInstance(game.PlaceId,game.JobId,LP)end)end)
end))
tabs[1].callback()
tabs[1].btn.BackgroundColor3=T1.accent
tabs[1].lbl.TextColor3=Color3.fromRGB(255,255,255)
tabs[1].bs.Transparency=0

-- KEYBIND
U.InputBegan:Connect(function(input)
if input.KeyCode==Enum.KeyCode.RightShift then
MF.Visible=not MF.Visible
end
end)
--=============================================================
-- FOV CIRCLE
--=============================================================
local fovCircle=Drawing.new("Circle")
fovCircle.Thickness=1.5 fovCircle.Filled=false fovCircle.NumSides=60 fovCircle.Transparency=.8 fovCircle.Visible=false
R.RenderStepped:Connect(function()
if not S.ShowFov or not S.Aim then fovCircle.Visible=false return end
local vp=Cam.ViewportSize
fovCircle.Position=Vector2.new(vp.X/2,vp.Y/2)
fovCircle.Radius=S.FOV/2
fovCircle.Color=C[S.FovCol]or C.Purple
fovCircle.Visible=true
end)

--=============================================================
-- THIRD PERSON
--=============================================================
spawn(function()
while true do
task.wait(.1)
local c=LP.Character
local hrp=c and c:FindFirstChild("HumanoidRootPart")
if S.ThirdPerson and hrp then
local newPos=hrp.Position-Vector3.new(0,0,S.ThirdPersonDist)+Vector3.new(0,2,0)
Cam.CFrame=CFrame.new(newPos,hrp.Position+Vector3.new(0,.5,0))
end
end
end)

--=============================================================
-- SPIN BOT
--=============================================================
spawn(function()
while true do
task.wait(.05)
if S.SpinBot then
local c=LP.Character
local hrp=c and c:FindFirstChild("HumanoidRootPart")
if hrp then
hrp.CFrame=CFrame.new(hrp.Position)*CFrame.Angles(0,math.rad(tick()*S.SpinBotSpeed*36),0)
end
end
end
end)

--=============================================================
-- HITBOX
--=============================================================
spawn(function()
while true do
task.wait(.5)
if S.HitboxExpander then
for _,p in pairs(P:GetPlayers())do
if p~=LP then
local c=p.Character
if c then
for _,part in pairs(c:GetChildren())do
if part:IsA("BasePart")and part.Name~="HumanoidRootPart"then
pcall(function()
part.Size=Vector3.new(S.HitboxSize,S.HitboxSize,S.HitboxSize)
part.Transparency=.5
end)
end
end
end
end
end
end
end
end)

--=============================================================
-- KILL AURA
--=============================================================
spawn(function()
while true do
task.wait(.1)
if S.KillAura then
local c=LP.Character
if c then
local hrp=c:FindFirstChild("HumanoidRootPart")
if hrp then
for _,p in pairs(P:GetPlayers())do
if p~=LP then
local t=p.Character
if t then
local th=t:FindFirstChildOfClass("Humanoid")
local thrp=t:FindFirstChild("HumanoidRootPart")
if th and thrp and th.Health>0 and(hrp.Position-thrp.Position).Magnitude<=S.KillAuraRange then
pcall(function() th.Health=th.Health-25 end)
end
end
end
end
end
end
end
end
end)

--=============================================================
-- AUTO DODGE
--=============================================================
spawn(function()
while true do
task.wait(.3)
if S.AutoDodge then
local c=LP.Character
if c then
local hrp=c:FindFirstChild("HumanoidRootPart")
if hrp then
for _,p in pairs(P:GetPlayers())do
if p~=LP then
local t=p.Character
if t then
local thrp=t:FindFirstChild("HumanoidRootPart")
local th=t:FindFirstChildOfClass("Humanoid")
if thrp and th and th.Health>0 then
local d=(hrp.Position-thrp.Position).Magnitude
if d<S.AutoDodgeRange then
local dir=(hrp.Position-thrp.Position).Unit
pcall(function() hrp.CFrame=CFrame.new(hrp.Position+dir*10) end)
end
end
end
end
end
end
end
end
end
end)

--=============================================================
-- MOVEMENT
--=============================================================
U.JumpRequest:Connect(function()
if S.IJmp then
local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end
end
end)
R.Stepped:Connect(function()
if S.Noclip then
local c=LP.Character
if c then
for _,p in pairs(c:GetDescendants())do
if p:IsA("BasePart")and p.CanCollide then p.CanCollide=false end
end
end
end
end)
R.RenderStepped:Connect(function()
if S.Fly then
local c=LP.Character
if c then
local hrp=c:FindFirstChild("HumanoidRootPart")
local bg=hrp and hrp:FindFirstChild("FlyBV")
if hrp and bg then
local d=Vector3.zero local cf=Cam.CFrame
if U:IsKeyDown(Enum.KeyCode.W)then d=d+cf.LookVector end
if U:IsKeyDown(Enum.KeyCode.S)then d=d-cf.LookVector end
if U:IsKeyDown(Enum.KeyCode.A)then d=d-cf.RightVector end
if U:IsKeyDown(Enum.KeyCode.D)then d=d+cf.RightVector end
if U:IsKeyDown(Enum.KeyCode.Space)then d=d+Vector3.new(0,1,0)end
if U:IsKeyDown(Enum.KeyCode.LeftControl)then d=d-Vector3.new(0,1,0)end
bg.Velocity=d.Magnitude>0 and d.Unit*S.FlyS or Vector3.zero
end
end
end
end)

--=============================================================
-- SILENT AIM
--=============================================================
R:BindToRenderStep("SilentAim",Enum.RenderPriority.Camera.Value+15,function()
if not S.SilentAim then return end
local c=LP.Character if not c then return end
local closest,sd=nil,S.SilentFOV
local vp=Cam.ViewportSize
local cen=Vector2.new(vp.X/2,vp.Y/2)
for _,p in pairs(P:GetPlayers())do
if p~=LP then
local t=p.Character
if t then
local h=t:FindFirstChildOfClass("Humanoid")
if h and h.Health>0 then
local part=t:FindFirstChild(S.Part)or t:FindFirstChild("Head")
if part then
if not S.SilentWalls then
local rp=RaycastParams.new()
rp.FilterDescendantsInstances={c,Cam}
rp.FilterType=Enum.RaycastFilterType.Exclude
local r=workspace:Raycast(Cam.CFrame.Position,part.Position-Cam.CFrame.Position,rp)
end
local sp,on=Cam:WorldToViewportPoint(part.Position)
if on then
local d=(Vector2.new(sp.X,sp.Y)-cen).Magnitude
if d<sd then sd=d closest=part end
end
end
end
end
end
end
if closest then
Cam.CFrame=CFrame.new(Cam.CFrame.Position,closest.Position)
if S.SilentFire then
local tl=c:FindFirstChildOfClass("Tool")
if tl then pcall(function()tl:Activate()end)end
end
end
end)

--=============================================================
-- AIMBOT
--=============================================================
local function isVisible(ch,pt)
local rp=RaycastParams.new()
rp.FilterDescendantsInstances={LP.Character,Cam}
rp.FilterType=Enum.RaycastFilterType.Exclude
local r=workspace:Raycast(Cam.CFrame.Position,pt.Position-Cam.CFrame.Position,rp)
if r then return r.Instance:IsDescendantOf(ch)end
return true
end
local curT=nil
local function findTarget()
local targets={}
local vp=Cam.ViewportSize
local cen=Vector2.new(vp.X/2,vp.Y/2)
for _,p in pairs(P:GetPlayers())do
if p==LP then continue end
local c=p.Character if not c then continue end
local h=c:FindFirstChildOfClass("Humanoid")if not h or h.Health<=0 then continue end
local hrp=c:FindFirstChild("HumanoidRootPart")if not hrp then continue end
if(Cam.CFrame.Position-hrp.Position).Magnitude>S.MaxD then continue end
if S.IgnoreFriends and LP:IsFriendsWith(p.UserId)then continue end
local part=c:FindFirstChild(S.Part)or c:FindFirstChild("Head")or hrp
if S.VisChk and not isVisible(c,part)then continue end
local sp,on=Cam:WorldToViewportPoint(part.Position)
if not on then continue end
local d=(Vector2.new(sp.X,sp.Y)-cen).Magnitude
if d<S.FOV then
table.insert(targets,{part=part,dist=d,hp=h.Health,dist3D=(Cam.CFrame.Position-hrp.Position).Magnitude})
end
end
if #targets==0 then return nil end
local best=targets[1]
if S.TargetMode=="Closest"then
for _,t in ipairs(targets)do if t.dist<best.dist then best=t end end
elseif S.TargetMode=="Lowest HP"then
for _,t in ipairs(targets)do if t.hp<best.hp then best=t end end
elseif S.TargetMode=="Highest HP"then
for _,t in ipairs(targets)do if t.hp>best.hp then best=t end end
elseif S.TargetMode=="Nearest"then
for _,t in ipairs(targets)do if t.dist3D<best.dist3D then best=t end end
end
return best.part
end
R:BindToRenderStep("AimLoop",Enum.RenderPriority.Camera.Value+10,function()
if not S.Aim then curT=nil return end
local t=findTarget()
curT=t
if not t then return end
local tp=t.Position
if S.Pred then
local v=t.AssemblyLinearVelocity
local d=(t.Position-Cam.CFrame.Position).Magnitude
tp=t.Position+v*(d/500)
end
local cf=CFrame.new(Cam.CFrame.Position,tp)
if S.Smooth>0 then Cam.CFrame=Cam.CFrame:Lerp(cf,1-S.Smooth)else Cam.CFrame=cf end
if S.AutoS then
local tl=LP.Character and LP.Character:FindFirstChildOfClass("Tool")
if tl then pcall(function()tl:Activate()end)end
end
end)

--=============================================================
-- TARGET ESP
--=============================================================
local tBox=Drawing.new("Square")tBox.Thickness=1.5 tBox.Filled=false tBox.Visible=false
local tCorners={}
for i=1,8 do tCorners[i]=Drawing.new("Line")tCorners[i].Thickness=2 tCorners[i].Visible=false end
local tHPBg=Drawing.new("Square")tHPBg.Filled=true tHPBg.Color=Color3.fromRGB(0,0,0)tHPBg.Visible=false
local tHPFg=Drawing.new("Square")tHPFg.Filled=true tHPFg.Visible=false
local tNm=Drawing.new("Text")tNm.Size=12 tNm.Center=true tNm.Outline=true tNm.Color=Color3.fromRGB(255,255,255)tNm.Visible=false
local tHPTxt=Drawing.new("Text")tHPTxt.Size=11 tHPTxt.Center=true tHPTxt.Outline=true tHPTxt.Visible=false
local tDs=Drawing.new("Text")tDs.Size=11 tDs.Center=true tDs.Outline=true tDs.Color=Color3.fromRGB(200,200,200)tDs.Visible=false
R.RenderStepped:Connect(function()
if not S.TgtE or not curT then
tBox.Visible=false tHPBg.Visible=false tHPFg.Visible=false
tNm.Visible=false tHPTxt.Visible=false tDs.Visible=false
for _,c in pairs(tCorners)do c.Visible=false end
return
end
local c=curT.Parent if not c then return end
local hd=c:FindFirstChild("Head")
local hrp=c:FindFirstChild("HumanoidRootPart")
local hum=c:FindFirstChildOfClass("Humanoid")
if not hd or not hrp or not hum then return end
local col=C[S.TgtCol]or C.Red
local top,t1=Cam:WorldToViewportPoint(hd.Position+Vector3.new(0,.5,0))
local bot,t2=Cam:WorldToViewportPoint(hrp.Position-Vector3.new(0,3,0))
if not(t1 and t2)then return end
local h=math.abs(top.Y-bot.Y)local w=h*.5
local bx=top.X-w/2 local by=top.Y local ex=bx+w local ey=by+h
tBox.Size=Vector2.new(w,h)tBox.Position=Vector2.new(bx,by)tBox.Color=col tBox.Transparency=.9 tBox.Visible=true
local cl=math.min(w,h)*.25
local corners={{bx,by,bx+cl,by},{bx,by,bx,by+cl},{ex,by,ex-cl,by},{ex,by,ex,by+cl},{bx,ey,bx+cl,ey},{bx,ey,bx,ey-cl},{ex,ey,ex-cl,ey},{ex,ey,ex,ey-cl}}
for i,cr in ipairs(corners)do
tCorners[i].From=Vector2.new(cr[1],cr[2])
tCorners[i].To=Vector2.new(cr[3],cr[4])
tCorners[i].Color=col
tCorners[i].Visible=true
end
local hp=hum.Health/hum.MaxHealth
tHPBg.Size=Vector2.new(2,h)tHPBg.Position=Vector2.new(bx-5,by)tHPBg.Visible=true
tHPFg.Size=Vector2.new(2,h*hp)tHPFg.Position=Vector2.new(bx-5,by+h*(1-hp))tHPFg.Color=Color3.fromRGB(80,220,80)tHPFg.Visible=true
tNm.Text=c.Name tNm.Position=Vector2.new(top.X,by-16)tNm.Visible=true
tHPTxt.Text=math.floor(hum.Health).." HP"tHPTxt.Position=Vector2.new(top.X,by-3)tHPTxt.Color=Color3.fromRGB(80,220,80)tHPTxt.Visible=true
local dist=(Cam.CFrame.Position-hrp.Position).Magnitude
tDs.Text=string.format("[%dm]",math.floor(dist))tDs.Position=Vector2.new(top.X,ey+4)tDs.Visible=true
end)

--=============================================================
-- ESP
--=============================================================
local HLS,BOX,BF,NAM,DST,HPB,HPG,TRC,HD2,SK,CH={},{},{},{},{},{},{},{},{},{},{}
R.RenderStepped:Connect(function()
for _,p in pairs(P:GetPlayers())do
if p==LP then continue end
local c=p.Character
local function hide()
if HLS[p]then HLS[p].Enabled=false end
if BOX[p]then BOX[p].Visible=false end
if BF[p]then BF[p].Visible=false end
if NAM[p]then NAM[p].Visible=false end
if DST[p]then DST[p].Visible=false end
if HPB[p]then HPB[p].Visible=false end
if HPG[p]then HPG[p].Visible=false end
if TRC[p]then TRC[p].Visible=false end
if HD2[p]then HD2[p].Visible=false end
if SK[p]then for _,l in pairs(SK[p])do l.Visible=false end end
if CH[p]then for _,cc in pairs(CH[p])do cc:Destroy()end CH[p]=nil end
end
if not c then hide()continue end
local hum=c:FindFirstChildOfClass("Humanoid")
if not hum or hum.Health<=0 or not S.ESP then hide()continue end
if S.Chams then
if not CH[p]or next(CH[p])==nil then
CH[p]={}
for _,pt in pairs(c:GetChildren())do
if pt:IsA("BasePart")then
local hl=Instance.new("Highlight",pt)
hl.FillColor=Color3.fromRGB(255,60,60)
hl.FillTransparency=.3
hl.OutlineTransparency=1
hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
table.insert(CH[p],hl)
end
end
end
elseif CH[p]then for _,cc in pairs(CH[p])do cc:Destroy()end CH[p]=nil end
if S.HL then
if not HLS[p]or HLS[p].Parent~=c then
if HLS[p]then HLS[p]:Destroy()end
local hl=Instance.new("Highlight",c)
hl.FillColor=Color3.fromRGB(255,60,60)
hl.FillTransparency=.5
hl.OutlineColor=Color3.fromRGB(255,255,255)
hl.OutlineTransparency=.2
hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
HLS[p]=hl
end
HLS[p].Enabled=true
elseif HLS[p]then HLS[p].Enabled=false end
local hrp=c:FindFirstChild("HumanoidRootPart")
local hd=c:FindFirstChild("Head")
if hrp and hd then
local tp,o1=Cam:WorldToViewportPoint(hd.Position+Vector3.new(0,.5,0))
local bp,o2=Cam:WorldToViewportPoint(hrp.Position-Vector3.new(0,3,0))
if o1 and o2 then
local h=math.abs(tp.Y-bp.Y)local w=h*.55
local bx=tp.X-w/2 local by=tp.Y
if S.Box then
if S.BoxStyle=="Filled"then
if not BF[p]then BF[p]=Drawing.new("Square")BF[p].Filled=true BF[p].Color=Color3.fromRGB(255,60,60)BF[p].Transparency=.75 end
BF[p].Size=Vector2.new(w,h)BF[p].Position=Vector2.new(bx,by)BF[p].Visible=true
if BOX[p]then BOX[p].Visible=false end
else
if not BOX[p]then
BOX[p]=Drawing.new("Square")BOX[p].Thickness=2 BOX[p].Filled=false BOX[p].Color=Color3.fromRGB(255,60,60)
end
BOX[p].Size=Vector2.new(w,h)BOX[p].Position=Vector2.new(bx,by)BOX[p].Visible=true
if BF[p]then BF[p].Visible=false end
end
else
if BOX[p]then BOX[p].Visible=false end
if BF[p]then BF[p].Visible=false end
end
if S.HDot then
if not HD2[p]then HD2[p]=Drawing.new("Circle")HD2[p].Radius=6 HD2[p].Filled=false HD2[p].Thickness=2 HD2[p].Color=Color3.fromRGB(255,100,100)end
HD2[p].Position=Vector2.new(tp.X,tp.Y+5)HD2[p].Visible=true
elseif HD2[p]then HD2[p].Visible=false end
if S.Skel then
local bones={{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"}}
if not SK[p]then
SK[p]={}
for i=1,#bones do
local ln=Drawing.new("Line")ln.Thickness=1.5 ln.Color=Color3.fromRGB(255,255,255)
table.insert(SK[p],ln)
end
end
for i,b in ipairs(bones)do
local p1=c:FindFirstChild(b[1])local p2=c:FindFirstChild(b[2])
if p1 and p2 then
local v1,oo1=Cam:WorldToViewportPoint(p1.Position)
local v2,oo2=Cam:WorldToViewportPoint(p2.Position)
if oo1 and oo2 then SK[p][i].From=Vector2.new(v1.X,v1.Y)SK[p][i].To=Vector2.new(v2.X,v2.Y)SK[p][i].Visible=true
else SK[p][i].Visible=false end
end
end
elseif SK[p]then for _,l in pairs(SK[p])do l.Visible=false end end
if S.Name then
if not NAM[p]then NAM[p]=Drawing.new("Text")NAM[p].Size=14 NAM[p].Center=true NAM[p].Outline=true NAM[p].Color=Color3.fromRGB(255,255,255)end
NAM[p].Text=p.Name NAM[p].Position=Vector2.new(tp.X,tp.Y-18)NAM[p].Visible=true
elseif NAM[p]then NAM[p].Visible=false end
if S.Dist then
if not DST[p]then DST[p]=Drawing.new("Text")DST[p].Size=12 DST[p].Center=true DST[p].Outline=true DST[p].Color=Color3.fromRGB(255,220,120)end
DST[p].Text=string.format("[%d]",math.floor((Cam.CFrame.Position-hrp.Position).Magnitude))
DST[p].Position=Vector2.new(tp.X,tp.Y+h+3)DST[p].Visible=true
elseif DST[p]then DST[p].Visible=false end
if S.HP then
if not HPG[p]then
HPG[p]=Drawing.new("Square")HPG[p].Thickness=1 HPG[p].Filled=true HPG[p].Color=Color3.fromRGB(20,20,20)
HPB[p]=Drawing.new("Square")HPB[p].Thickness=1 HPB[p].Filled=true
end
local hp=hum.Health/hum.MaxHealth
HPG[p].Size=Vector2.new(3,h)HPG[p].Position=Vector2.new(bx-6,tp.Y)HPG[p].Visible=true
HPB[p].Size=Vector2.new(3,h*hp)HPB[p].Position=Vector2.new(bx-6,tp.Y+h*(1-hp))
HPB[p].Color=Color3.fromRGB(math.floor(255*(1-hp)),math.floor(255*hp),60)HPB[p].Visible=true
else
if HPB[p]then HPB[p].Visible=false end
if HPG[p]then HPG[p].Visible=false end
end
if S.Tracer then
if not TRC[p]then TRC[p]=Drawing.new("Line")TRC[p].Thickness=1 TRC[p].Color=Color3.fromRGB(255,80,80)TRC[p].Transparency=.8 end
local vp=Cam.ViewportSize
TRC[p].From=Vector2.new(vp.X/2,vp.Y)
TRC[p].To=Vector2.new(tp.X,tp.Y+h)
TRC[p].Visible=true
elseif TRC[p]then TRC[p].Visible=false end
else hide()end
end
end
end)
P.PlayerRemoving:Connect(function(p)
if HLS[p]then HLS[p]:Destroy()end
if BOX[p]then BOX[p]:Remove()end
if BF[p]then BF[p]:Remove()end
if NAM[p]then NAM[p]:Remove()end
if DST[p]then DST[p]:Remove()end
if HPB[p]then HPB[p]:Remove()end
if HPG[p]then HPG[p]:Remove()end
if TRC[p]then TRC[p]:Remove()end
if HD2[p]then HD2[p]:Remove()end
if SK[p]then for _,l in pairs(SK[p])do l:Remove()end end
if CH[p]then for _,cc in pairs(CH[p])do cc:Destroy()end end
end)

--=============================================================
-- KILL FEED
--=============================================================
local kfY=0
local function killFeed(text)
local f=Instance.new("Frame",gui)
f.Size=UDim2.new(0,280,0,32)
f.Position=UDim2.new(1,-290,.3,kfY)
f.BackgroundColor3=Color3.fromRGB(18,18,26)
f.BackgroundTransparency=.2
f.BorderSizePixel=0
Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)
local l=Instance.new("TextLabel",f)
l.Size=UDim2.new(1,-16,1,0)l.Position=UDim2.new(0,8,0,0)
l.BackgroundTransparency=1 l.Text=text
l.TextColor3=Color3.fromRGB(255,255,255)
l.TextSize=13 l.Font=Enum.Font.GothamMedium
l.TextXAlignment=Enum.TextXAlignment.Left
kfY=kfY+36
task.delay(4,function()
f:TweenPosition(UDim2.new(1,-290,.3,kfY-40),"In","Quad",.3,true)
task.wait(.3)
f:Destroy()
kfY=kfY-36
end)
end
local watchedKF={}
P.PlayerAdded:Connect(function(p)
task.spawn(function()
local c=p.Character or p.CharacterAdded:Wait()
local h=c:WaitForChild("Humanoid",5)
if not h then return end
if watchedKF[h]then return end
watchedKF[h]=true
h.Died:Connect(function()
if S.KillFeed then
if p==LP then killFeed("💀 Ты умер")
else killFeed("☠ "..p.Name.." умер")end
end
end)
end)
end)
for _,p in pairs(P:GetPlayers())do
if p~=LP then
task.spawn(function()
local c=p.Character or p.CharacterAdded:Wait()
local h=c:WaitForChild("Humanoid",5)
if not h then return end
if watchedKF[h]then return end
watchedKF[h]=true
h.Died:Connect(function()
if S.KillFeed then killFeed("☠ "..p.Name.." умер")end
end)
end)
end
end

--=============================================================
-- HIT SOUND + KILL SOUND
--=============================================================
local watchedHum={}
local function watchHum(p,h)
if p==LP or not h or watchedHum[h]then return end
watchedHum[h]=true
local last=h.Health
h.HealthChanged:Connect(function(newHP)
if newHP<last and newHP>0 and S.HSnd then
local c=LP.Character
if c then
local myHrp=c:FindFirstChild("HumanoidRootPart")
local tHrp=h.Parent and h.Parent:FindFirstChild("HumanoidRootPart")
if myHrp and tHrp and(myHrp.Position-tHrp.Position).Magnitude<=250 then
pSnd(HSnd[S.HSndT],.5)
end
end
end
last=newHP
end)
h.Died:Connect(function()
if not S.KSnd then return end
local c=LP.Character
if not c then return end
local myHrp=c:FindFirstChild("HumanoidRootPart")
local tHrp=h.Parent and h.Parent:FindFirstChild("HumanoidRootPart")
if myHrp and tHrp and(myHrp.Position-tHrp.Position).Magnitude<=300 then
pSnd(KSnd[S.KSndT],.7)
end
end)
end
local function setupPlayer(p)
if p==LP then return end
local function setup(c)
local h=c:WaitForChild("Humanoid",5)
if h then watchHum(p,h)end
end
if p.Character then task.spawn(setup,p.Character)end
p.CharacterAdded:Connect(setup)
end
for _,p in pairs(P:GetPlayers())do setupPlayer(p)end
P.PlayerAdded:Connect(setupPlayer)

--=============================================================
-- LOADED
--=============================================================
print("[PrimDLC v17] loaded | @LutshiyKot")
