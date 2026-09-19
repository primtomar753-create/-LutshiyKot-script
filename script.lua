local P=game:GetService("Players")local R=game:GetService("RunService")local U=game:GetService("UserInputService")
local T=game:GetService("TeleportService")local H=game:GetService("HttpService")local L=game:GetService("Lighting")
local S1=game:GetService("SoundService")local Tw=game:GetService("TweenService")local D=game:GetService("Debris")
local LP=P.LocalPlayer
while not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") do task.wait(.1) end
task.wait(.5)
local Cam=workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()Cam=workspace.CurrentCamera end)
LP.CharacterAdded:Connect(function(c)c:WaitForChild("HumanoidRootPart")task.wait(.5)Cam=workspace.CurrentCamera end)
pcall(function() S1.RespectFilteringEnabled=false end)

local S={
Aim=true,Smooth=.05,FOV=120,Part="Head",MaxD=500,VisChk=true,AutoS=false,Pred=false,
HitboxExpander=false,HitboxSize=8,KillAura=false,KillAuraRange=15,
TeleportMenu=false,AutoDodge=false,AutoDodgeRange=30,Trail=false,
TgtE=true,TgtStyle="Box",TgtCol="Red",TgtPulse=false,TgtName=true,TgtHP=true,TgtDist=true,TgtArrow=false,TgtLock=false,TgtTrail=false,
ESP=true,Box=true,BoxStyle="Normal",HL=true,Name=true,Dist=true,HP=true,Tracer=false,Skel=false,HDot=false,Arr=false,Chams=false,Beam=false,
FB=false,NF=false,ShowFov=true,ShowCross=true,CrossSty="Dot",WM=true,FovCol="Purple",
HSnd=false,HSndT="Click",KSnd=false,KSndT="Explosion",KEff=false,KEffT="Explosion",Aura=false,AuraT="Fire",AuraR=40,
SpinBot=false,SpinBotSpeed=10,ThirdPerson=false,ThirdPersonDist=10,
Hat=true,Rainbow=false,CamFOVe=false,CamFOV=70,
Snow=false,SnowT="Normal",Sky=false,SkyPreset="None",Time=false,TimeV=14,Bloom=false,BloomI=1.5,CC=false,CCM="None",SunR=false,Atm=false,
Spd=16,Jmp=50,IJmp=false,Fly=false,Noclip=false,FlyS=50,AAFK=false,AutoR=false,FPS=true,Ping=true,Clock=false,
FPSUnlocker=false,FPSLimit=240,
AuraColor="Purple",AuraShape="Sphere",AuraSize=5,
KillFeed=true,HitMarker=true,DamageNumbers=true,
HatType="China",
AimAssist=false,AimAssistSmooth=0.5,AimAssistFOV=150,AimAssistPart="Head",
TriggerBot=false,TriggerDelay=0.2,
NoRecoil=false,NoSpread=false,FastReload=false,
Theme="Purple",
EmoteSpam=false,ChatSpam=false,
AutoRejoin=false,
AutoHide=false,
AimTargetMode="Closest",AimIgnoreFriends=false,AimStickyAim=false,AimHoldDelay=0,
FakeSilent=false,
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

local gui,MF,CT,SB,IG,OB
local HLS,BOX,BF,NAM,DST,HPB,HPG,TRC={},{},{},{},{},{},{},{}
local HD,SK,AR,BM,CH={},{},{},{},{}
local tabs={}
local dmgDrawings,hitMarkerDrawings={},{}
local kfY=0

pcall(function() gui=Instance.new("ScreenGui")gui.Name="Gui"gui.ResetOnSpawn=false gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling gui.Parent=game:GetService("CoreGui") end)
if not gui or not gui.Parent then gui=Instance.new("ScreenGui")gui.Name="Gui"gui.ResetOnSpawn=false gui.Parent=LP:WaitForChild("PlayerGui") end

local nt=Instance.new("Frame",gui)
nt.Size=UDim2.new(0,320,0,65)nt.Position=UDim2.new(.5,-160,0,-70)nt.BackgroundColor3=Color3.fromRGB(30,10,60)
nt.BackgroundTransparency=.1 nt.BorderSizePixel=0 nt.ZIndex=100
Instance.new("UICorner",nt).CornerRadius=UDim.new(0,12)
local nst=Instance.new("UIStroke",nt)nst.Color=T1.accent nst.Thickness=2
local ntx=Instance.new("TextLabel",nt)
ntx.Size=UDim2.new(1,-20,1,0)ntx.Position=UDim2.new(0,10,0,0)ntx.BackgroundTransparency=1
ntx.Text="Привет от @LutshiyKot"ntx.TextColor3=Color3.fromRGB(255,255,255)ntx.TextSize=19
ntx.Font=Enum.Font.GothamBold ntx.ZIndex=101
nt:TweenPosition(UDim2.new(.5,-160,0,30),"Out","Quad",.5,true)
task.delay(4,function()nt:Destroy() end)

local wmFrame=Instance.new("Frame",gui)
wmFrame.Size=UDim2.new(0,270,0,34)
wmFrame.Position=UDim2.new(1,-275,0,5)
wmFrame.BackgroundColor3=Color3.fromRGB(18,18,26)
wmFrame.BackgroundTransparency=0.15
wmFrame.BorderSizePixel=0
wmFrame.ZIndex=70
Instance.new("UICorner",wmFrame).CornerRadius=UDim.new(0,8)
local wmStroke=Instance.new("UIStroke",wmFrame)
wmStroke.Color=T1.accent wmStroke.Thickness=1 wmStroke.Transparency=0.3
local wmMoon=Instance.new("TextLabel",wmFrame)
wmMoon.Size=UDim2.new(0,22,1,0)wmMoon.Position=UDim2.new(0,10,0,0)
wmMoon.BackgroundTransparency=1 wmMoon.Text="🌙" wmMoon.TextSize=16
wmMoon.Font=Enum.Font.GothamBold wmMoon.TextColor3=T1.text
wmMoon.TextXAlignment=Enum.TextXAlignment.Left wmMoon.ZIndex=71
local wmName=Instance.new("TextLabel",wmFrame)
wmName.Size=UDim2.new(0,80,1,0)wmName.Position=UDim2.new(0,32,0,0)
wmName.BackgroundTransparency=1 wmName.Text="PrimDLC v17" wmName.TextSize=14
wmName.Font=Enum.Font.GothamBold wmName.TextColor3=T1.text
wmName.TextXAlignment=Enum.TextXAlignment.Left wmName.ZIndex=71
local d1=Instance.new("Frame",wmFrame)
d1.Size=UDim2.new(0,1,0,20)d1.Position=UDim2.new(0,116,0.5,-10)
d1.BackgroundColor3=T1.accent2 d1.BorderSizePixel=0 d1.ZIndex=71
local fpsIco=Instance.new("Frame",wmFrame)
fpsIco.Size=UDim2.new(0,20,0,20)fpsIco.Position=UDim2.new(0,124,0.5,-10)
fpsIco.BackgroundColor3=T1.accent fpsIco.BorderSizePixel=0 fpsIco.ZIndex=71
Instance.new("UICorner",fpsIco).CornerRadius=UDim.new(0,5)
local fpsIcoTxt=Instance.new("TextLabel",fpsIco)
fpsIcoTxt.Size=UDim2.new(1,0,1,0)fpsIcoTxt.BackgroundTransparency=1
fpsIcoTxt.Text="∿"fpsIcoTxt.TextSize=14
fpsIcoTxt.Font=Enum.Font.GothamBold fpsIcoTxt.TextColor3=Color3.fromRGB(255,255,255)fpsIcoTxt.ZIndex=72
local fpsTxt=Instance.new("TextLabel",wmFrame)
fpsTxt.Size=UDim2.new(0,50,1,0)fpsTxt.Position=UDim2.new(0,148,0,0)
fpsTxt.BackgroundTransparency=1 fpsTxt.Text="60 fps" fpsTxt.TextSize=13
fpsTxt.Font=Enum.Font.GothamBold fpsTxt.TextColor3=T1.text
fpsTxt.TextXAlignment=Enum.TextXAlignment.Left fpsTxt.ZIndex=71
local d2=Instance.new("Frame",wmFrame)
d2.Size=UDim2.new(0,1,0,20)d2.Position=UDim2.new(0,200,0.5,-10)
d2.BackgroundColor3=T1.accent2 d2.BorderSizePixel=0 d2.ZIndex=71
local pingIco=Instance.new("Frame",wmFrame)
pingIco.Size=UDim2.new(0,20,0,20)pingIco.Position=UDim2.new(0,208,0.5,-10)
pingIco.BackgroundColor3=T1.accent pingIco.BorderSizePixel=0 pingIco.ZIndex=71
Instance.new("UICorner",pingIco).CornerRadius=UDim.new(0,5)
local pingIcoTxt=Instance.new("TextLabel",pingIco)
pingIcoTxt.Size=UDim2.new(1,0,1,0)pingIcoTxt.BackgroundTransparency=1
pingIcoTxt.Text="●"pingIcoTxt.TextSize=11
pingIcoTxt.Font=Enum.Font.GothamBold pingIcoTxt.TextColor3=Color3.fromRGB(255,255,255)pingIcoTxt.ZIndex=72
local pingTxt=Instance.new("TextLabel",wmFrame)
pingTxt.Size=UDim2.new(0,55,1,0)pingTxt.Position=UDim2.new(0,232,0,0)
pingTxt.BackgroundTransparency=1 pingTxt.Text="0 ms" pingTxt.TextSize=13
pingTxt.Font=Enum.Font.GothamBold pingTxt.TextColor3=T1.text
pingTxt.TextXAlignment=Enum.TextXAlignment.Left pingTxt.ZIndex=71

MF=Instance.new("Frame",gui)
MF.Size=UDim2.new(0,460,0,340)MF.Position=UDim2.new(.5,-230,.5,-170)MF.BackgroundColor3=T1.bg
MF.BackgroundTransparency=.15 MF.BorderSizePixel=0 MF.Active=true MF.Draggable=true MF.ZIndex=2
Instance.new("UICorner",MF).CornerRadius=UDim.new(0,14)

local GL={}
for i=1,5 do
local g=Instance.new("Frame",MF)
g.AnchorPoint=Vector2.new(0.5,0.5)
g.Position=UDim2.new(0.5,0,0.5,0)
g.Size=UDim2.new(1,i*12,1,i*12)
g.BackgroundColor3=T1.accent
g.BackgroundTransparency=.9+i*.012
g.BorderSizePixel=0
g.ZIndex=0
Instance.new("UICorner",g).CornerRadius=UDim.new(0,20)
table.insert(GL,g)
end

local GR=Instance.new("UIGradient",MF)
GR.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,T1.accent),ColorSequenceKeypoint.new(.5,T1.bg),ColorSequenceKeypoint.new(1,T1.accent2)})
GR.Rotation=45
IG=Instance.new("Frame",MF)
IG.Size=UDim2.new(1,0,1,0)IG.BackgroundColor3=T1.accent IG.BackgroundTransparency=.82
IG.BorderSizePixel=0 IG.ZIndex=2
Instance.new("UICorner",IG).CornerRadius=UDim.new(0,14)
local N1=Instance.new("UIStroke",MF)N1.Color=T1.accent N1.Thickness=2
local N2=Instance.new("UIStroke",MF)N2.Color=T1.accent2 N2.Thickness=4 N2.Transparency=.4
local N3=Instance.new("UIStroke",MF)N3.Color=T1.accent N3.Thickness=8 N3.Transparency=.7

spawn(function()
local t=0
while MF.Parent do
t=t+.05
local r=(math.sin(t)+1)/2 local g=(math.sin(t+2)+1)/2 local b=(math.sin(t+4)+1)/2
N1.Color=Color3.fromRGB(math.floor(150+75*r),math.floor(60+120*g),math.floor(200+35*b))
N2.Color=Color3.fromRGB(math.floor(80+100*b),math.floor(150+100*r),math.floor(200+35*g))
N3.Color=Color3.fromRGB(math.floor(200+35*b),math.floor(80+120*g),math.floor(180+55*r))
GR.Rotation=(t*25)%360
IG.BackgroundTransparency=.78+.08*r
for i,gl in ipairs(GL) do
gl.BackgroundTransparency=.86+i*.015+.04*(1-r)
end
R.Heartbeat:Wait()
end
end)

local HD1=Instance.new("Frame",MF)
HD1.Size=UDim2.new(1,0,0,42)HD1.BackgroundColor3=T1.accent HD1.BackgroundTransparency=.5
HD1.BorderSizePixel=0 HD1.ZIndex=3
Instance.new("UICorner",HD1).CornerRadius=UDim.new(0,14)
local HF=Instance.new("Frame",HD1)
HF.Size=UDim2.new(1,0,0,14)HF.Position=UDim2.new(0,0,1,-14)HF.BackgroundColor3=T1.accent
HF.BackgroundTransparency=.5 HF.BorderSizePixel=0 HF.ZIndex=3
local AV=Instance.new("TextLabel",HD1)
AV.Size=UDim2.new(0,26,0,26)AV.Position=UDim2.new(0,10,0,8)AV.BackgroundColor3=T1.bg
AV.Text="👑"AV.TextSize=15 AV.Font=Enum.Font.GothamBold AV.BorderSizePixel=0 AV.ZIndex=4
Instance.new("UICorner",AV).CornerRadius=UDim.new(0,7)
local TL=Instance.new("TextLabel",HD1)
TL.Size=UDim2.new(1,-180,0,20)TL.Position=UDim2.new(0,44,0,6)TL.BackgroundTransparency=1
TL.Text="@LutshiyKot"TL.TextColor3=Color3.fromRGB(255,255,255)TL.TextSize=14
TL.Font=Enum.Font.GothamBold TL.TextXAlignment=Enum.TextXAlignment.Left TL.ZIndex=4
local SL=Instance.new("TextLabel",HD1)
SL.Size=UDim2.new(1,-180,0,14)SL.Position=UDim2.new(0,44,0,22)SL.BackgroundTransparency=1
SL.Text="by @LutshiyKot"SL.TextColor3=T1.text SL.TextSize=10
SL.Font=Enum.Font.Gotham SL.TextXAlignment=Enum.TextXAlignment.Left SL.ZIndex=4

local function mkb(t,x,cb)
local b=Instance.new("TextButton",HD1)
b.Size=UDim2.new(0,26,0,26)b.Position=UDim2.new(1,x,0,6)b.BackgroundColor3=T1.bg
b.BackgroundTransparency=.15 b.Text=t b.TextColor3=Color3.fromRGB(255,255,255)b.TextSize=13
b.Font=Enum.Font.GothamBold b.BorderSizePixel=0 b.AutoButtonColor=false b.ZIndex=4
Instance.new("UICorner",b).CornerRadius=UDim.new(0,7)
local bs=Instance.new("UIStroke",b)bs.Color=T1.accent bs.Thickness=1 bs.Transparency=.1
b.MouseButton1Click:Connect(cb)
end

SB=Instance.new("ScrollingFrame",MF)
SB.Size=UDim2.new(0,115,1,-55)SB.Position=UDim2.new(0,10,0,48)SB.BackgroundColor3=T1.bg
SB.BackgroundTransparency=.55 SB.BorderSizePixel=0 SB.ZIndex=3
SB.ScrollBarThickness=2
SB.ScrollBarImageColor3=T1.accent
SB.CanvasSize=UDim2.new(0,0,0,0)
SB.AutomaticCanvasSize=Enum.AutomaticSize.Y
SB.ScrollingDirection=Enum.ScrollingDirection.Y
SB.ScrollBarImageTransparency=0.3
Instance.new("UICorner",SB).CornerRadius=UDim.new(0,10)
local sbs=Instance.new("UIStroke",SB)sbs.Color=T1.accent sbs.Thickness=1 sbs.Transparency=.3
local sbl=Instance.new("UIListLayout",SB)sbl.Padding=UDim.new(0,4)
local sbp=Instance.new("UIPadding",SB)sbp.PaddingTop=UDim.new(0,6)sbp.PaddingLeft=UDim.new(0,6)sbp.PaddingRight=UDim.new(0,6)sbp.PaddingBottom=UDim.new(0,6)

CT=Instance.new("ScrollingFrame",MF)
CT.Size=UDim2.new(1,-135,1,-55)CT.Position=UDim2.new(0,130,0,48)CT.BackgroundTransparency=1 CT.BorderSizePixel=0
CT.ScrollBarThickness=3 CT.ScrollBarImageColor3=T1.accent CT.CanvasSize=UDim2.new(0,0,0,0)
CT.AutomaticCanvasSize=Enum.AutomaticSize.Y CT.ZIndex=4
local cl=Instance.new("UIListLayout",CT)cl.Padding=UDim.new(0,5)

local min=false
local function setMin(m)
min=m
if m then
MF.Size=UDim2.new(0,460,0,42)
SB.Visible=false CT.Visible=false IG.Visible=false
else
MF.Size=UDim2.new(0,460,0,340)
SB.Visible=true CT.Visible=true IG.Visible=true
end
end
mkb("—",-90,function()setMin(not min)end)
mkb("□",-60,function()setMin(false)end)
mkb("X",-30,function()MF.Visible=false if OB then OB.Visible=true end end)

OB=Instance.new("TextButton",gui)
OB.Size=UDim2.new(0,45,0,45)OB.Position=UDim2.new(0,20,0,100)OB.BackgroundColor3=T1.bg
OB.Text="⚡"OB.TextColor3=T1.text OB.TextSize=20 OB.Font=Enum.Font.GothamBold
OB.BorderSizePixel=0 OB.Visible=false OB.ZIndex=50
Instance.new("UICorner",OB).CornerRadius=UDim.new(1,0)
local obs=Instance.new("UIStroke",OB)obs.Color=T1.accent obs.Thickness=2
OB.MouseButton1Click:Connect(function()MF.Visible=true setMin(false)OB.Visible=false end)

local function mkSec(t)
local l=Instance.new("TextLabel",CT)
l.Size=UDim2.new(1,-6,0,22)l.BackgroundTransparency=1
l.Text=t l.TextColor3=T1.text l.TextSize=13
l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=5
end
local function mkC(t,d,cb)
local c=Instance.new("TextButton",CT)
c.Size=UDim2.new(1,-6,0,36)c.BackgroundColor3=T1.bg c.BackgroundTransparency=.3
c.Text=""c.BorderSizePixel=0 c.AutoButtonColor=false c.ZIndex=4
Instance.new("UICorner",c).CornerRadius=UDim.new(0,9)
local cs=Instance.new("UIStroke",c)cs.Color=T1.accent cs.Thickness=1 cs.Transparency=.2
local l=Instance.new("TextLabel",c)
l.Size=UDim2.new(1,-60,1,0)l.Position=UDim2.new(0,14,0,0)l.BackgroundTransparency=1
l.Text=t l.TextColor3=T1.text l.TextSize=12
l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=5
local tg=Instance.new("Frame",c)
tg.Size=UDim2.new(0,36,0,18)tg.Position=UDim2.new(1,-46,.5,-9)
tg.BackgroundColor3=d and T1.accent or T1.bg
tg.BorderSizePixel=0 tg.ZIndex=5
Instance.new("UICorner",tg).CornerRadius=UDim.new(1,0)
local k=Instance.new("Frame",tg)
k.Size=UDim2.new(0,14,0,14)k.Position=d and UDim2.new(1,-16,.5,-7) or UDim2.new(0,2,.5,-7)
k.BackgroundColor3=Color3.fromRGB(255,255,255)k.BorderSizePixel=0 k.ZIndex=6
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
b.Font=Enum.Font.GothamBold b.BorderSizePixel=0 b.AutoButtonColor=false b.ZIndex=4
Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
local bs=Instance.new("UIStroke",b)bs.Color=T1.accent bs.Thickness=1.5 bs.Transparency=.1
b.MouseButton1Click:Connect(function()bs.Transparency=0 task.wait(.1)bs.Transparency=.1 cb()end)
end
local function mkSl(t,mn,mx,d,cb)
local f=Instance.new("Frame",CT)
f.Size=UDim2.new(1,-6,0,52)f.BackgroundColor3=T1.bg f.BackgroundTransparency=.3
f.BorderSizePixel=0 f.ZIndex=4
Instance.new("UICorner",f).CornerRadius=UDim.new(0,9)
local cs=Instance.new("UIStroke",f)cs.Color=T1.accent cs.Thickness=1 cs.Transparency=.2
local l=Instance.new("TextLabel",f)
l.Size=UDim2.new(1,-20,0,18)l.Position=UDim2.new(0,14,0,5)l.BackgroundTransparency=1
l.Text=t..": "..tostring(d)l.TextColor3=T1.text l.TextSize=12
l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=5
local bg=Instance.new("Frame",f)
bg.Size=UDim2.new(1,-28,0,7)bg.Position=UDim2.new(0,14,0,32)bg.BackgroundColor3=T1.bg
bg.BorderSizePixel=0 bg.ZIndex=5
Instance.new("UICorner",bg).CornerRadius=UDim.new(1,0)
local fl=Instance.new("Frame",bg)
fl.Size=UDim2.new((d-mn)/(mx-mn),0,1,0)fl.BackgroundColor3=T1.accent
fl.BorderSizePixel=0 fl.ZIndex=6
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
b.Text=""b.BorderSizePixel=0 b.AutoButtonColor=false b.ZIndex=4
Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
local cs=Instance.new("UIStroke",b)cs.Color=T1.accent cs.Thickness=1 cs.Transparency=.2
local l=Instance.new("TextLabel",b)
l.Size=UDim2.new(.5,-10,1,0)l.Position=UDim2.new(0,14,0,0)l.BackgroundTransparency=1
l.Text=t l.TextColor3=T1.text l.TextSize=12
l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=5
local v=Instance.new("TextLabel",b)
v.Size=UDim2.new(.5,-14,1,0)v.Position=UDim2.new(.5,0,0,0)v.BackgroundTransparency=1
v.Text=d v.TextColor3=T1.accent v.TextSize=12
v.Font=Enum.Font.GothamBold v.TextXAlignment=Enum.TextXAlignment.Right v.ZIndex=5
local i=1
for x,o in ipairs(op) do if o==d then i=x break end end
b.MouseButton1Click:Connect(function()i=i%#op+1 v.Text=op[i]cb(op[i])end)
end
local function clr()
for _,c in pairs(CT:GetChildren()) do
if c:IsA("TextButton")or c:IsA("TextLabel")or c:IsA("Frame")then c:Destroy()end
end
end
local function mkT(name,icon,cb)
local b=Instance.new("TextButton",SB)
b.Size=UDim2.new(1,0,0,28)b.BackgroundColor3=T1.bg b.BackgroundTransparency=.5
b.Text=""b.BorderSizePixel=0 b.AutoButtonColor=false b.ZIndex=4
Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
local bs=Instance.new("UIStroke",b)bs.Color=T1.accent bs.Thickness=1 bs.Transparency=.6
local l=Instance.new("TextLabel",b)
l.Size=UDim2.new(1,-32,1,0)l.Position=UDim2.new(0,26,0,0)l.BackgroundTransparency=1
l.Text=name l.TextColor3=T1.text l.TextSize=10
l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=5
local ic=Instance.new("TextLabel",b)
ic.Size=UDim2.new(0,18,1,0)ic.Position=UDim2.new(0,8,0,0)ic.BackgroundTransparency=1
ic.Text=icon ic.TextSize=11 ic.Font=Enum.Font.GothamBold ic.ZIndex=5
b.MouseButton1Click:Connect(function()
for _,t in pairs(tabs) do t.btn.BackgroundColor3=T1.bg t.lbl.TextColor3=T1.text t.bs.Transparency=.6 end
b.BackgroundColor3=T1.accent l.TextColor3=Color3.fromRGB(255,255,255)bs.Transparency=0 cb()
end)
return{btn=b,lbl=l,bs=bs,callback=cb}
end

local HSnd={Click="rbxassetid://6895079853",Bell="rbxassetid://6042054027",Minecraft="rbxassetid://6042054196",Pew="rbxassetid://6042054652",Bubble="rbxassetid://6042054764"}
local KSnd={Explosion="rbxassetid://153467001",Ding="rbxassetid://4590662766",Bruh="rbxassetid://6042055494",Vine="rbxassetid://6042055656",Sniper="rbxassetid://6042055794"}
local soundHolder=Instance.new("Folder",gui)
soundHolder.Name="SoundHolder"
local function pSnd(id,v)
if not id or id=="" then return end
local s=Instance.new("Sound")
s.SoundId=id s.Volume=v or 1 s.Parent=soundHolder
pcall(function() s:Play() end)
D:AddItem(s,5)
end

-- ВКЛАДКИ
table.insert(tabs,mkT("Main","🏠",function()
clr()
mkSec("Aimbot")mkC("Aimbot",S.Aim,function(v)S.Aim=v end)mkC("Auto Shoot",S.AutoS,function(v)S.AutoS=v end)
mkC("Prediction",S.Pred,function(v)S.Pred=v end)mkC("Wall Check",S.VisChk,function(v)S.VisChk=v end)
mkSec("ESP")mkC("ESP",S.ESP,function(v)S.ESP=v end)mkC("Box",S.Box,function(v)S.Box=v end)
mkC("Highlight",S.HL,function(v)S.HL=v end)mkC("Target ESP",S.TgtE,function(v)S.TgtE=v end)mkC("Chams",S.Chams,function(v)S.Chams=v end)
end))
table.insert(tabs,mkT("Legit","🕊",function()
clr()
mkSec("Aim Assist (Legit)")
mkC("Enable Aim Assist",S.AimAssist,function(v)S.AimAssist=v end)
mkSl("Assist Smoothness",0,100,S.AimAssistSmooth*100,function(v)S.AimAssistSmooth=v/100 end)
mkSl("Assist FOV",50,400,S.AimAssistFOV,function(v)S.AimAssistFOV=v end)
mkDr("Assist Part",{"Head","UpperTorso","HumanoidRootPart"},S.AimAssistPart,function(v)S.AimAssistPart=v end)
mkSec("Trigger Bot")
mkC("Enable Trigger Bot",S.TriggerBot,function(v)S.TriggerBot=v end)
mkSl("Trigger Delay ms",0,500,S.TriggerDelay*1000,function(v)S.TriggerDelay=v/1000 end)
mkSec("Gun Mods")
mkC("No Recoil",S.NoRecoil,function(v)S.NoRecoil=v end)
mkC("No Spread",S.NoSpread,function(v)S.NoSpread=v end)
mkC("Fast Reload",S.FastReload,function(v)S.FastReload=v end)
end))
table.insert(tabs,mkT("Target","🎯",function()
clr()
mkSec("Target ESP (CS Style)")
mkC("Enable",S.TgtE,function(v)S.TgtE=v end)mkC("Name",S.TgtName,function(v)S.TgtName=v end)
mkC("HP",S.TgtHP,function(v)S.TgtHP=v end)mkC("Distance",S.TgtDist,function(v)S.TgtDist=v end)
mkC("Only Locked",S.TgtLock,function(v)S.TgtLock=v end)
mkSec("Style")mkDr("Color",{"Red","Yellow","Green","Cyan","White","Purple"},S.TgtCol,function(v)S.TgtCol=v end)
end))
table.insert(tabs,mkT("Aim","⚔",function()
clr()
mkSec("Aimbot")mkC("Aimbot",S.Aim,function(v)S.Aim=v end)mkC("Prediction",S.Pred,function(v)S.Pred=v end)
mkC("Wall Check",S.VisChk,function(v)S.VisChk=v end)mkC("Auto Shoot",S.AutoS,function(v)S.AutoS=v end)
mkSec("Target")mkDr("Hit Part",{"Head","UpperTorso","LowerTorso","HumanoidRootPart"},S.Part,function(v)S.Part=v end)
mkDr("FOV Color",{"Purple","Red","Blue","Green","Yellow","White","Pink","Cyan","Orange"},S.FovCol,function(v)S.FovCol=v end)
mkSl("FOV",50,800,S.FOV,function(v)S.FOV=v end)mkSl("Smooth",0,95,S.Smooth*100,function(v)S.Smooth=v/100 end)
mkSl("Max Dist",50,2000,S.MaxD,function(v)S.MaxD=v end)
mkSec("Advanced Aim")
mkDr("Target Mode",{"Closest","Lowest HP","Highest HP","Nearest"},S.AimTargetMode,function(v)S.AimTargetMode=v end)
mkC("Ignore Friends",S.AimIgnoreFriends,function(v)S.AimIgnoreFriends=v end)
mkC("Sticky Aim",S.AimStickyAim,function(v)S.AimStickyAim=v end)
mkSl("Hold Delay ms",0,500,S.AimHoldDelay,function(v)S.AimHoldDelay=v end)
mkC("Fake Silent Aim (Camera Lock)",S.FakeSilent,function(v)S.FakeSilent=v end)
end))
table.insert(tabs,mkT("Visual","🎨",function()
clr()
mkSec("ESP")mkC("ESP",S.ESP,function(v)S.ESP=v end)mkC("Box",S.Box,function(v)S.Box=v end)
mkDr("Box Style",{"Normal","Corner","Filled"},S.BoxStyle,function(v)S.BoxStyle=v end)
mkC("Highlight",S.HL,function(v)S.HL=v end)mkC("Chams",S.Chams,function(v)S.Chams=v end)
mkC("Name",S.Name,function(v)S.Name=v end)mkC("Distance",S.Dist,function(v)S.Dist=v end)
mkC("Health Bar",S.HP,function(v)S.HP=v end)mkC("Tracer",S.Tracer,function(v)S.Tracer=v end)
mkC("Skeleton",S.Skel,function(v)S.Skel=v end)mkC("Head Dot",S.HDot,function(v)S.HDot=v end)
mkC("Arrow",S.Arr,function(v)S.Arr=v end)mkC("Beam",S.Beam,function(v)S.Beam=v end)
mkC("Trail",S.Trail,function(v)S.Trail=v end)
mkSec("Screen")mkC("FOV Circle",S.ShowFov,function(v)S.ShowFov=v end)
mkC("Crosshair",S.ShowCross,function(v)S.ShowCross=v end)
mkDr("Crosshair Style",{"Dot","Cross","Circle","X"},S.CrossSty,function(v)S.CrossSty=v end)
mkSec("Watermark")mkC("Show Watermark",S.WM,function(v)wmFrame.Visible=v end)
mkC("FPS",S.FPS,function(v)S.FPS=v end)mkC("Ping",S.Ping,function(v)S.Ping=v end)
end))
table.insert(tabs,mkT("FX","✨",function()
clr()
mkSec("Weather")mkC("Snow",S.Snow,function(v)S.Snow=v end)
mkDr("Snow Type",{"Normal","Neon","Gold"},S.SnowT,function(v)S.SnowT=v end)
mkSec("Sky")mkC("Enable Sky Change",S.Sky,function(v)S.Sky=v end)
mkSec("Time")mkC("Change Time",S.Time,function(v)S.Time=v end)
mkSl("Clock Time",0,24,S.TimeV,function(v)S.TimeV=v end)
mkSec("Post-FX")mkC("Bloom",S.Bloom,function(v)S.Bloom=v end)
mkSl("Bloom Intensity",0,5,S.BloomI,function(v)S.BloomI=v end)
mkC("Color Correction",S.CC,function(v)S.CC=v end)
mkDr("CC Mode",{"None","Red","Blue","Green","Matrix","Cinematic"},S.CCM,function(v)S.CCM=v end)
mkC("Sun Rays",S.SunR,function(v)S.SunR=v end)mkC("Atmosphere",S.Atm,function(v)S.Atm=v end)
end))
table.insert(tabs,mkT("ExtraV","💠",function()
clr()
mkSec("FPS")mkC("FPS Unlocker",S.FPSUnlocker,function(v)S.FPSUnlocker=v end)
mkSl("FPS Limit",60,360,S.FPSLimit,function(v)S.FPSLimit=v end)
mkSec("Aura Sphere")
mkDr("Aura Color",{"Purple","Red","Blue","Green","Yellow","Cyan","Pink","White"},S.AuraColor,function(v)S.AuraColor=v end)
mkSl("Aura Size",3,15,S.AuraSize,function(v)S.AuraSize=v end)
mkSec("Sky Presets")mkDr("Preset",{"None","Night","Sunset","Space","Red","Neon","Cyberpunk","Retrowave","Horror"},S.SkyPreset,function(v)S.SkyPreset=v end)
mkSec("Visuals")mkC("Damage Numbers",S.DamageNumbers,function(v)S.DamageNumbers=v end)
mkC("Hit Marker",S.HitMarker,function(v)S.HitMarker=v end)
mkC("Kill Feed",S.KillFeed,function(v)S.KillFeed=v end)
mkSec("Hat")mkDr("Hat Type",{"China","Tophat","Crown","Halo"},S.HatType,function(v)S.HatType=v end)
end))
table.insert(tabs,mkT("Theme","🌈",function()
clr()
mkSec("UI Theme")
mkDr("Theme",{"Purple","Dark","Cyan","Green","Red","Matrix","Pink"},S.Theme,function(v)
S.Theme=v
local T2=Themes[v]or Themes.Purple
MF.BackgroundColor3=T2.bg
GR.Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,T2.accent),
ColorSequenceKeypoint.new(.5,T2.bg),
ColorSequenceKeypoint.new(1,T2.accent2)})
N1.Color=T2.accent
N2.Color=T2.accent2
N3.Color=T2.accent
HD1.BackgroundColor3=T2.accent
HF.BackgroundColor3=T2.accent
SB.BackgroundColor3=T2.bg
sbs.Color=T2.accent
wmStroke.Color=T2.accent
wmMoon.TextColor3=T2.text
wmName.TextColor3=T2.text
fpsTxt.TextColor3=T2.text
pingTxt.TextColor3=T2.text
fpsIco.BackgroundColor3=T2.accent
pingIco.BackgroundColor3=T2.accent
d1.BackgroundColor3=T2.accent2
d2.BackgroundColor3=T2.accent2
for _,g in ipairs(GL) do g.BackgroundColor3=T2.accent end
for _,t in pairs(tabs) do
t.btn.BackgroundColor3=T2.bg
t.lbl.TextColor3=T2.text
t.bs.Color=T2.accent
t.bs.Transparency=.6
end
if tabs[10] then
tabs[10].btn.BackgroundColor3=T2.accent
tabs[10].lbl.TextColor3=Color3.fromRGB(255,255,255)
tabs[10].bs.Transparency=0
end
for _,el in pairs(CT:GetChildren())do
if el:IsA("TextButton")then
el.BackgroundColor3=T2.bg
for _,ch in pairs(el:GetChildren())do
if ch:IsA("TextLabel")then ch.TextColor3=T2.text end
if ch:IsA("UIStroke")then ch.Color=T2.accent end
end
elseif el:IsA("TextLabel")then
el.TextColor3=T2.text
elseif el:IsA("Frame")then
el.BackgroundColor3=T2.bg
for _,ch in pairs(el:GetChildren())do
if ch:IsA("Frame")then ch.BackgroundColor3=T2.accent end
if ch:IsA("TextLabel")then ch.TextColor3=T2.text end
if ch:IsA("UIStroke")then ch.Color=T2.accent end
end
end
end
end)
mkSec("Behavior")
mkC("Auto Hide Menu",S.AutoHide,function(v)S.AutoHide=v end)
end))
table.insert(tabs,mkT("Sound","🔊",function()
clr()
mkSec("Hit Sound")mkC("Enable Hit Sound",S.HSnd,function(v)S.HSnd=v end)
mkDr("Type",{"Click","Bell","Minecraft","Pew","Bubble"},S.HSndT,function(v)S.HSndT=v end)
mkSec("Kill Sound")mkC("Enable Kill Sound",S.KSnd,function(v)S.KSnd=v end)
mkDr("Type",{"Explosion","Ding","Bruh","Vine","Sniper"},S.KSndT,function(v)S.KSndT=v end)
mkSec("Kill Effect")mkC("Enable Kill Effect",S.KEff,function(v)S.KEff=v end)
mkDr("Type",{"Explosion","Fire","Lightning","Confetti","Portal"},S.KEffT,function(v)S.KEffT=v end)
mkSec("Particle Aura")mkC("Enable Aura",S.Aura,function(v)S.Aura=v end)
mkDr("Aura Type",{"Fire","Sparkle","Lightning","Snow","Neon","Rainbow"},S.AuraT,function(v)S.AuraT=v end)
mkSl("Aura Rate",5,100,S.AuraR,function(v)S.AuraR=v end)
end))
table.insert(tabs,mkT("Extras","⚡",function()
clr()
mkSec("Lighting")mkC("Fullbright",S.FB,function(v)
S.FB=v
if v then L.Brightness=3 L.ClockTime=14 L.FogEnd=100000 L.GlobalShadows=false else L.Brightness=1 L.GlobalShadows=true end
end)
mkC("No Fog",S.NF,function(v)S.NF=v L.FogEnd=v and 100000 or 1000 end)
mkSec("Combat")mkC("Hitbox Expander",S.HitboxExpander,function(v)S.HitboxExpander=v end)
mkSl("Hitbox Size",3,15,S.HitboxSize,function(v)S.HitboxSize=v end)
mkC("Kill Aura",S.KillAura,function(v)S.KillAura=v end)
mkSl("Aura Range",5,50,S.KillAuraRange,function(v)S.KillAuraRange=v end)
mkC("Auto Dodge",S.AutoDodge,function(v)S.AutoDodge=v end)
mkSl("Dodge Range",10,60,S.AutoDodgeRange,function(v)S.AutoDodgeRange=v end)
mkSec("Teleport")mkC("TP to Nearest",S.TeleportMenu,function(v)S.TeleportMenu=v end)
mkSec("Anti-Bot")mkC("Spin Bot",S.SpinBot,function(v)S.SpinBot=v end)
mkSl("Spin Speed",5,30,S.SpinBotSpeed,function(v)S.SpinBotSpeed=v end)
mkSec("Camera")mkC("Third Person",S.ThirdPerson,function(v)S.ThirdPerson=v end)
mkSl("TP Distance",5,20,S.ThirdPersonDist,function(v)S.ThirdPersonDist=v end)
mkC("Custom FOV",S.CamFOVe,function(v)S.CamFOVe=v Cam.FieldOfView=v and S.CamFOV or 70 end)
mkSl("Camera FOV",30,120,S.CamFOV,function(v)S.CamFOV=v if S.CamFOVe then Cam.FieldOfView=v end end)
mkSec("Fun")mkC("Neon China Hat",S.Hat,function(v)S.Hat=v end)mkC("Rainbow Player",S.Rainbow,function(v)S.Rainbow=v end)
mkSec("Movement")mkC("Infinite Jump",S.IJmp,function(v)S.IJmp=v end)
mkC("Fly",S.Fly,function(v)
S.Fly=v local c=LP.Character if not c then return end
local hrp=c:FindFirstChild("HumanoidRootPart")if not hrp then return end
if v then local bg=Instance.new("BodyVelocity")bg.MaxForce=Vector3.new(math.huge,math.huge,math.huge)bg.Velocity=Vector3.zero bg.Name="FlyBV"bg.Parent=hrp
else local bg=hrp:FindFirstChild("FlyBV")if bg then bg:Destroy()end end
end)
mkC("Noclip",S.Noclip,function(v)S.Noclip=v end)mkC("Anti-AFK",S.AAFK,function(v)S.AAFK=v end)
mkC("Auto Respawn",S.AutoR,function(v)S.AutoR=v end)
mkSl("Walk Speed",16,200,S.Spd,function(v)S.Spd=v local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")if h then h.WalkSpeed=v end end)
mkSl("Jump Power",50,300,S.Jmp,function(v)S.Jmp=v local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")if h then h.JumpPower=v end end)
mkSl("Fly Speed",10,300,S.FlyS,function(v)S.FlyS=v end)
end))
table.insert(tabs,mkT("Player","👤",function()
clr()
mkSec("Utility")mkB2("🔄 RESET",function()local c=LP.Character if c then local h=c:FindFirstChildOfClass("Humanoid")if h then h.Health=0 end end end)
mkB2("📋 COPY JOB ID",function()if setclipboard then setclipboard(game.JobId)end end)
mkB2("📋 COPY PLACE ID",function()if setclipboard then setclipboard(tostring(game.PlaceId))end end)
mkSec("Config")
mkB2("💾 SAVE CONFIG",function()
local data={}
for k,v in pairs(S)do if type(v)=="boolean"or type(v)=="number"or type(v)=="string"then data[k]=v end end
if writefile then pcall(function() writefile("PrimDLC_config.json",H:JSONEncode(data)) end) end
end)
mkB2("📂 LOAD CONFIG",function()
if readfile and isfile and isfile("PrimDLC_config.json")then
pcall(function()
local data=H:JSONDecode(readfile("PrimDLC_config.json"))
for k,v in pairs(data)do if S[k]~=nil then S[k]=v end end
end)
end
end)
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
mkB2("🚪 LEAVE",function()pcall(function()game:Shutdown()end)end)
end))
tabs[1].callback()tabs[1].btn.BackgroundColor3=T1.accent tabs[1].lbl.TextColor3=Color3.fromRGB(255,255,255)tabs[1].bs.Transparency=0

-- KEYBIND MENU
U.InputBegan:Connect(function(input)
if input.KeyCode==Enum.KeyCode.RightShift then
local v=not MF.Visible
MF.Visible=v
for _,g in ipairs(GL) do g.Visible=v end
end
end)

-- FPS UNLOCKER
spawn(function()
while true do
task.wait(1)
if S.FPSUnlocker then pcall(function() setfpscap(S.FPSLimit) end) end
end
end)

-- FOV CIRCLE
local fovCircle=Drawing.new("Circle")
fovCircle.Thickness=1.5
fovCircle.Filled=false
fovCircle.NumSides=60
fovCircle.Transparency=0.8
fovCircle.Visible=false
R.RenderStepped:Connect(function()
if not S.ShowFov or not S.Aim then
fovCircle.Visible=false
return
end
local vp=Cam.ViewportSize
fovCircle.Position=Vector2.new(vp.X/2,vp.Y/2)
fovCircle.Radius=S.FOV/2
fovCircle.Color=C[S.FovCol]or C.Purple
fovCircle.Visible=true
end)

-- THIRD PERSON (ФИКС)
R:BindToRenderStep("ThirdPerson",Enum.RenderPriority.Camera.Value-1,function()
local c=LP.Character
local hrp=c and c:FindFirstChild("HumanoidRootPart")
if not hrp or not S.ThirdPerson then return end
local newPos=hrp.Position-Vector3.new(0,0,S.ThirdPersonDist)+Vector3.new(0,2,0)
local look=hrp.Position+Vector3.new(0,0.5,0)
Cam.CFrame=CFrame.new(newPos,look)
end)

-- SPIN BOT
spawn(function()
while true do
task.wait(0.05)
if S.SpinBot then
local c=LP.Character
local hrp=c and c:FindFirstChild("HumanoidRootPart")
if hrp then
local speed=S.SpinBotSpeed
local rot=CFrame.Angles(0,math.rad(tick()*speed*36),0)
hrp.CFrame=CFrame.new(hrp.Position)*rot
end
end
end
end)

-- HITBOX
spawn(function()
while true do
task.wait(0.5)
if S.HitboxExpander then
for _,p in pairs(P:GetPlayers())do
if p==LP then continue end
local c=p.Character
if c then
for _,part in pairs(c:GetChildren())do
if part:IsA("BasePart")and part.Name~="HumanoidRootPart"then
pcall(function()
part.Size=Vector3.new(S.HitboxSize,S.HitboxSize,S.HitboxSize)
part.Transparency=0.5
end)
end
end
end
end
end
end
end)

-- KILL AURA
spawn(function()
while true do
task.wait(0.1)
if S.KillAura then
local c=LP.Character
if c then
local hrp=c:FindFirstChild("HumanoidRootPart")
if hrp then
for _,p in pairs(P:GetPlayers())do
if p==LP then continue end
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
end)

-- TELEPORT
spawn(function()
while true do
task.wait(0.3)
if S.TeleportMenu then
local c=LP.Character
if c then
local hrp=c:FindFirstChild("HumanoidRootPart")
if hrp then
local cl,ds=nil,99999
for _,p in pairs(P:GetPlayers())do
if p==LP then continue end
local t=p.Character
if t then
local thrp=t:FindFirstChild("HumanoidRootPart")
if thrp and(hrp.Position-thrp.Position).Magnitude<ds then
ds=(hrp.Position-thrp.Position).Magnitude cl=thrp
end
end
end
if cl then hrp.CFrame=CFrame.new(cl.Position+Vector3.new(0,3,0))end
end
end
end
end
end)

-- AUTO DODGE
spawn(function()
while true do
task.wait(0.3)
if S.AutoDodge then
local c=LP.Character
if c then
local hrp=c:FindFirstChild("HumanoidRootPart")
local hum=c:FindFirstChildOfClass("Humanoid")
if hrp and hum then
for _,p in pairs(P:GetPlayers())do
if p==LP then continue end
local t=p.Character
if t then
local thrp=t:FindFirstChild("HumanoidRootPart")
local th=t:FindFirstChildOfClass("Humanoid")
if thrp and th and th.Health>0 then
local d=(hrp.Position-thrp.Position).Magnitude
if d<S.AutoDodgeRange then
local dir=(hrp.Position-thrp.Position).Unit
local newPos=hrp.Position+dir*10
pcall(function() hrp.CFrame=CFrame.new(newPos,newPos+dir) end)
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

-- TRAIL
local trailAttach=nil
spawn(function()
while true do
task.wait(0.5)
local c=LP.Character
local hrp=c and c:FindFirstChild("HumanoidRootPart")
if S.Trail and hrp then
if not trailAttach or trailAttach.Parent~=hrp then
if trailAttach then trailAttach:Destroy() end
local a0=Instance.new("Attachment",hrp)a0.Position=Vector3.new(0,1,0)
local a1=Instance.new("Attachment",hrp)a1.Position=Vector3.new(0,-1,0)
local tr=Instance.new("Trail",hrp)
tr.Attachment0=a0 tr.Attachment1=a1
tr.Lifetime=0.5
tr.Color=ColorSequence.new(T1.accent)
tr.LightEmission=1
trailAttach=tr
end
elseif trailAttach then trailAttach:Destroy()trailAttach=nil end
end
end)

-- AIM ASSIST
R:BindToRenderStep("AimAssist",Enum.RenderPriority.Camera.Value+5,function()
if not S.AimAssist or not S.Aim then return end
local c=LP.Character if not c then return end
local closest,sd=nil,S.AimAssistFOV
local vp=Cam.ViewportSize
local cen=Vector2.new(vp.X/2,vp.Y/2)
for _,p in pairs(P:GetPlayers())do
if p==LP then continue end
local t=p.Character if not t then continue end
local h=t:FindFirstChildOfClass("Humanoid")
if not h or h.Health<=0 then continue end
local part=t:FindFirstChild(S.AimAssistPart)or t:FindFirstChild("Head")
if not part then continue end
local sp,on=Cam:WorldToViewportPoint(part.Position)
if not on then continue end
local d=(Vector2.new(sp.X,sp.Y)-cen).Magnitude
if d<sd then sd=d closest=part end
end
if closest then
local newCF=CFrame.new(Cam.CFrame.Position,closest.Position)
Cam.CFrame=Cam.CFrame:Lerp(newCF,1-S.AimAssistSmooth)
end
end)

-- TRIGGER BOT
local lastTrigger=0
R.Stepped:Connect(function()
if not S.TriggerBot then return end
if tick()-lastTrigger<S.TriggerDelay then return end
local c=LP.Character if not c then return end
local vp=Cam.ViewportSize
local cen=Vector2.new(vp.X/2,vp.Y/2)
for _,p in pairs(P:GetPlayers())do
if p==LP then continue end
local t=p.Character if not t then continue end
local h=t:FindFirstChildOfClass("Humanoid")
if not h or h.Health<=0 then continue end
local part=t:FindFirstChild("Head")
if not part then continue end
local sp,on=Cam:WorldToViewportPoint(part.Position)
if not on then continue end
local d=(Vector2.new(sp.X,sp.Y)-cen).Magnitude
if d<10 then
local tool=c:FindFirstChildOfClass("Tool")
if tool then pcall(function() tool:Activate()end)lastTrigger=tick()return end
end
end
end)

-- DAMAGE NUMBERS + HIT MARKER
local watchedDmg={}
local function watchDamage(p,h)
if p==LP or not h or watchedDmg[h]then return end
watchedDmg[h]=true
local last=h.Health
h.HealthChanged:Connect(function(newHP)
if newHP<last and newHP>0 then
local dmg=last-newHP
if S.DamageNumbers then
local char=h.Parent
local hrp=char and char:FindFirstChild("HumanoidRootPart")
if hrp then
local sp=Cam:WorldToViewportPoint(hrp.Position+Vector3.new(0,3,0))
if sp.Z>0 then
local txt=Drawing.new("Text")
txt.Text="- "..math.floor(dmg)txt.Size=18 txt.Center=true txt.Outline=true
txt.Color=Color3.fromRGB(255,80,80)
txt.Position=Vector2.new(sp.X,sp.Y)txt.Visible=true
table.insert(dmgDrawings,{txt=txt,pos=Vector2.new(sp.X,sp.Y),life=1})
end
end
end
if S.HitMarker then
local cx,cy=Cam.ViewportSize.X/2,Cam.ViewportSize.Y/2
for i=1,4 do
local line=Drawing.new("Line")
line.Thickness=2 line.Color=Color3.fromRGB(255,255,255)line.Visible=true
table.insert(hitMarkerDrawings,{line=line,cx=cx,cy=cy,life=0.5,dir=i})
end
end
end
last=newHP
end)
h.Destroying:Connect(function() watchedDmg[h]=nil end)
end
spawn(function()
while true do
task.wait(0.3)
for _,p in pairs(P:GetPlayers())do
if p==LP then continue end
local c=p.Character
local h=c and c:FindFirstChildOfClass("Humanoid")
if h then watchDamage(p,h)end
end
end
end)
R.RenderStepped:Connect(function()
for i=#dmgDrawings,1,-1 do
local d=dmgDrawings[i]
d.life=d.life-0.02
d.pos=d.pos-Vector2.new(0,0.8)
d.txt.Position=d.pos
d.txt.Transparency=d.life
if d.life<=0 then d.txt:Remove()table.remove(dmgDrawings,i)end
end
for i=#hitMarkerDrawings,1,-1 do
local h=hitMarkerDrawings[i]
h.life=h.life-0.05
local len=8
if h.dir==1 then h.line.From=Vector2.new(h.cx-len,h.cy-len)h.line.To=Vector2.new(h.cx-len+4,h.cy-len+4)
elseif h.dir==2 then h.line.From=Vector2.new(h.cx+len,h.cy-len)h.line.To=Vector2.new(h.cx+len-4,h.cy-len+4)
elseif h.dir==3 then h.line.From=Vector2.new(h.cx-len,h.cy+len)h.line.To=Vector2.new(h.cx-len+4,h.cy+len-4)
elseif h.dir==4 then h.line.From=Vector2.new(h.cx+len,h.cy+len)h.line.To=Vector2.new(h.cx+len-4,h.cy+len-4)
end
h.line.Transparency=h.life*2
if h.life<=0 then h.line:Remove()table.remove(hitMarkerDrawings,i)end
end
end)

-- KILL FEED
local function killFeed(text)
local f=Instance.new("Frame",gui)
f.Size=UDim2.new(0,280,0,32)
f.Position=UDim2.new(1,-290,0.3,kfY)
f.BackgroundColor3=Color3.fromRGB(18,18,26)
f.BackgroundTransparency=0.2
f.BorderSizePixel=0
f.ZIndex=80
Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)
local l=Instance.new("TextLabel",f)
l.Size=UDim2.new(1,-16,1,0)l.Position=UDim2.new(0,8,0,0)
l.BackgroundTransparency=1 l.Text=text
l.TextColor3=Color3.fromRGB(255,255,255)
l.TextSize=13 l.Font=Enum.Font.GothamMedium
l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=81
kfY=kfY+36
task.delay(4,function()
f:TweenPosition(UDim2.new(1,-290,0.3,kfY-40),"In","Quad",0.3,true)
task.wait(0.3)
f:Destroy()
kfY=kfY-36
end)
end
local watchedKF={}
local function watchKill(p,h)
if not h or watchedKF[h]then return end
watchedKF[h]=true
local pname=p.Name
h.Died:Connect(function()
if S.KillFeed then
if p==LP then killFeed("💀 Ты умер")
else killFeed("☠ "..pname.." died")end
end
end)
h.Destroying:Connect(function() watchedKF[h]=nil end)
end
spawn(function()
while true do
task.wait(0.5)
for _,p in pairs(P:GetPlayers())do
local c=p.Character
local h=c and c:FindFirstChildOfClass("Humanoid")
if h then watchKill(p,h)end
end
end
end)

-- HAT CHANGER
spawn(function()
while true do
task.wait(0.1)
local c=LP.Character
local hd=c and c:FindFirstChild("Head")
if not hd then task.wait(0.5)continue end
for _,v in pairs(hd:GetChildren())do
if v.Name=="NCH_Layer"or v.Name=="HatCustom"then v:Destroy()end
end
if not S.Hat then task.wait(0.3)continue end
if S.HatType=="China"then
local layers={{y=1.5,s=4.5},{y=1.9,s=3.8},{y=2.3,s=3.1},{y=2.7,s=2.4},{y=3.1,s=1.7},{y=3.5,s=1.0},{y=3.9,s=.4}}
for i,l in ipairs(layers)do
local p=Instance.new("Part",hd)
p.Name="NCH_Layer"p.Shape=Enum.PartType.Cylinder p.Size=Vector3.new(.25,l.s,l.s)
p.Material=Enum.Material.Neon p.CanCollide=false p.Massless=true p.CastShadow=false
p.CFrame=hd.CFrame*CFrame.new(0,l.y,0)*CFrame.Angles(0,0,math.rad(90))
local w=Instance.new("WeldConstraint",p)w.Part0=p w.Part1=hd
if i==1 then local li=Instance.new("PointLight",p)li.Brightness=3 li.Range=15 li.Shadows=false end
end
elseif S.HatType=="Tophat"then
local brim=Instance.new("Part",hd)
brim.Name="HatCustom"brim.Shape=Enum.PartType.Cylinder
brim.Size=Vector3.new(.2,3,3)
brim.Material=Enum.Material.Neon brim.Color=Color3.fromRGB(100,100,255)
brim.CanCollide=false brim.Massless=true
brim.CFrame=hd.CFrame*CFrame.new(0,1.5,0)*CFrame.Angles(0,0,math.rad(90))
local w1=Instance.new("WeldConstraint",brim)w1.Part0=brim w1.Part1=hd
local cap=Instance.new("Part",hd)
cap.Name="HatCustom"cap.Shape=Enum.PartType.Cylinder
cap.Size=Vector3.new(1,2,2)
cap.Material=Enum.Material.Neon cap.Color=Color3.fromRGB(100,100,255)
cap.CanCollide=false cap.Massless=true
cap.CFrame=hd.CFrame*CFrame.new(0,2.5,0)*CFrame.Angles(0,0,math.rad(90))
local w2=Instance.new("WeldConstraint",cap)w2.Part0=cap w2.Part1=hd
elseif S.HatType=="Crown"then
for i=-1,1 do
local spike=Instance.new("Part",hd)
spike.Name="HatCustom"spike.Shape=Enum.PartType.Cylinder
spike.Size=Vector3.new(.2,.5,.5)
spike.Material=Enum.Material.Neon spike.Color=Color3.fromRGB(255,215,0)
spike.CanCollide=false spike.Massless=true
spike.CFrame=hd.CFrame*CFrame.new(i*.6,1.7,0)*CFrame.Angles(0,0,math.rad(90))
local w=Instance.new("WeldConstraint",spike)w.Part0=spike w.Part1=hd
end
local base=Instance.new("Part",hd)
base.Name="HatCustom"base.Shape=Enum.PartType.Cylinder
base.Size=Vector3.new(.2,2,2)
base.Material=Enum.Material.Neon base.Color=Color3.fromRGB(255,215,0)
base.CanCollide=false base.Massless=true
base.CFrame=hd.CFrame*CFrame.new(0,1.4,0)*CFrame.Angles(0,0,math.rad(90))
local w=Instance.new("WeldConstraint",base)w.Part0=base w.Part1=hd
elseif S.HatType=="Halo"then
local ring=Instance.new("Part",hd)
ring.Name="HatCustom"ring.Shape=Enum.PartType.Cylinder
ring.Size=Vector3.new(.15,2,2)
ring.Material=Enum.Material.Neon ring.Color=Color3.fromRGB(255,255,150)
ring.CanCollide=false ring.Massless=true
ring.CFrame=hd.CFrame*CFrame.new(0,2.5,0)*CFrame.Angles(0,0,math.rad(90))
local w=Instance.new("WeldConstraint",ring)w.Part0=ring w.Part1=hd
local li=Instance.new("PointLight",ring)li.Brightness=3 li.Range=12 li.Color=Color3.fromRGB(255,255,150)
end
for _,p in pairs(hd:GetChildren())do
if p.Name=="NCH_Layer"or p.Name=="HatCustom"then
p.Color=Color3.fromHSV((tick()*.15)%1,1,1)
end
end
task.wait(0.05)
end
end)

-- AURA SPHERE
local auraSphere=nil
spawn(function()
while true do
task.wait(0.3)
local c=LP.Character
local hrp=c and c:FindFirstChild("HumanoidRootPart")
if hrp then
if not auraSphere or auraSphere.Parent~=hrp then
if auraSphere then auraSphere:Destroy() end
local a=Instance.new("Part",hrp)
a.Name="AuraSphere"a.Shape=Enum.PartType.Ball
a.Size=Vector3.new(S.AuraSize,S.AuraSize,S.AuraSize)
a.Material=Enum.Material.ForceField
a.CanCollide=false a.Massless=true a.CastShadow=false
a.Transparency=0.7
a.Color=C[S.AuraColor]or C.Purple
a.CFrame=hrp.CFrame
local w=Instance.new("WeldConstraint",a)w.Part0=a w.Part1=hrp
auraSphere=a
end
if auraSphere then
auraSphere.Color=C[S.AuraColor]or C.Purple
auraSphere.Size=Vector3.new(S.AuraSize,S.AuraSize,S.AuraSize)
end
else
if auraSphere then auraSphere:Destroy()auraSphere=nil end
end
end
end)

-- SNOW
local sn=nil
spawn(function()
while true do
task.wait(.3)
if S.Snow and not sn then
local a=Instance.new("Attachment",Cam)
local e=Instance.new("ParticleEmitter",a)
e.Texture="rbxasset://textures/particles/sparkles_main.dds"
e.Rate=80 e.Lifetime=NumberRange.new(4,8)e.Speed=NumberRange.new(3,6)e.LightInfluence=0
e.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(.1,.6),NumberSequenceKeypoint.new(1,.6)})
sn=e
elseif not S.Snow and sn then
local a=sn.Parent if a then a:Destroy()end sn=nil
end
if sn then
if S.SnowT=="Normal"then sn.Color=ColorSequence.new(Color3.fromRGB(255,255,255))sn.LightEmission=.3
elseif S.SnowT=="Neon"then sn.Color=ColorSequence.new(Color3.fromHSV((tick()*.3)%1,1,1))sn.LightEmission=1
elseif S.SnowT=="Gold"then sn.Color=ColorSequence.new(Color3.fromRGB(255,215,0))sn.LightEmission=.8 end
end
end
end)

-- SKY PRESETS
local cSky,blm,cc,sr,atm=nil,nil,nil,nil,nil
local skyPresets={
Night={bk="rbxassetid://159454299",dn="rbxassetid://159454296",ft="rbxassetid://159454293",lf="rbxassetid://159454286",rt="rbxassetid://159454300",up="rbxassetid://159454288",star=5000},
Sunset={bk="rbxassetid://271042516",dn="rbxassetid://271077243",ft="rbxassetid://271042556",lf="rbxassetid://271042310",rt="rbxassetid://271042467",up="rbxassetid://271041815"},
Space={bk="rbxassetid://159454299",dn="rbxassetid://159454296",ft="rbxassetid://159454293",lf="rbxassetid://159454286",rt="rbxassetid://159454300",up="rbxassetid://159454288",star=10000},
Red={bk="rbxassetid://12064107",dn="rbxassetid://12064152",ft="rbxassetid://12064121",lf="rbxassetid://12063984",rt="rbxassetid://12064115",up="rbxassetid://12064134"},
Neon={bk="rbxassetid://159454299",dn="rbxassetid://159454296",ft="rbxassetid://159454293",lf="rbxassetid://159454286",rt="rbxassetid://159454300",up="rbxassetid://159454288",star=8000},
Cyberpunk={bk="rbxassetid://271042516",dn="rbxassetid://271077243",ft="rbxassetid://271042556",lf="rbxassetid://271042310",rt="rbxassetid://271042467",up="rbxassetid://271041815",star=4000},
Retrowave={bk="rbxassetid://12064107",dn="rbxassetid://12064152",ft="rbxassetid://12064121",lf="rbxassetid://12063984",rt="rbxassetid://12064115",up="rbxassetid://12064134",star=3000},
Horror={bk="rbxassetid://159454299",dn="rbxassetid://159454296",ft="rbxassetid://159454293",lf="rbxassetid://159454286",rt="rbxassetid://159454300",up="rbxassetid://159454288",star=0},
}
spawn(function()
while true do
task.wait(.3)
if S.Sky and S.SkyPreset~="None"and skyPresets[S.SkyPreset]then
if cSky then cSky:Destroy()end
local sk=Instance.new("Sky")
local p=skyPresets[S.SkyPreset]
sk.SkyboxBk=p.bk sk.SkyboxDn=p.dn sk.SkyboxFt=p.ft
sk.SkyboxLf=p.lf sk.SkyboxRt=p.rt sk.SkyboxUp=p.up
if p.star then sk.StarCount=p.star end
sk.Parent=L cSky=sk
elseif cSky then cSky:Destroy()cSky=nil end
if S.Bloom then if not blm then blm=Instance.new("BloomEffect",L)end blm.Intensity=S.BloomI blm.Size=24 blm.Threshold=.8
elseif blm then blm:Destroy()blm=nil end
if S.CC then
if not cc then cc=Instance.new("ColorCorrectionEffect",L)end
if S.CCM=="None"then cc.TintColor=Color3.fromRGB(255,255,255)cc.Saturation=0 cc.Contrast=0
elseif S.CCM=="Red"then cc.TintColor=Color3.fromRGB(255,180,180)cc.Saturation=.3
elseif S.CCM=="Blue"then cc.TintColor=Color3.fromRGB(180,200,255)cc.Saturation=.3
elseif S.CCM=="Green"then cc.TintColor=Color3.fromRGB(180,255,180)cc.Saturation=.3
elseif S.CCM=="Matrix"then cc.TintColor=Color3.fromRGB(100,255,100)cc.Saturation=-.5 cc.Contrast=.5
elseif S.CCM=="Cinematic"then cc.TintColor=Color3.fromRGB(255,240,220)cc.Saturation=.2 cc.Contrast=.3 end
elseif cc then cc:Destroy()cc=nil end
if S.SunR then if not sr then sr=Instance.new("SunRaysEffect",L)sr.Intensity=.3 sr.Spread=1 end
elseif sr then sr:Destroy()sr=nil end
if S.Atm then if not atm then atm=Instance.new("Atmosphere",L)atm.Density=.4 atm.Offset=.25 atm.Color=Color3.fromRGB(199,199,199)atm.Decay=Color3.fromRGB(106,112,125)atm.Glare=.5 atm.Haze=1.5 end
elseif atm then atm:Destroy()atm=nil end
if S.Time then L.ClockTime=S.TimeV end
end
end)

-- HIT SOUND + KILL SOUND
local watchedHum={}
local function watchHumanoid(p,h)
if p==LP or not h or watchedHum[h] then return end
watchedHum[h]=true
local last=h.Health
h.HealthChanged:Connect(function(newHP)
if newHP<last and newHP>0 then
local c=LP.Character
if c and S.HSnd then
local myHrp=c:FindFirstChild("HumanoidRootPart")
local tHrp=h.Parent and h.Parent:FindFirstChild("HumanoidRootPart")
if myHrp and tHrp then
local dist=(myHrp.Position-tHrp.Position).Magnitude
if dist<=250 then pSnd(HSnd[S.HSndT],.5) end
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
if not myHrp or not tHrp then return end
if (myHrp.Position-tHrp.Position).Magnitude<=300 then
pSnd(KSnd[S.KSndT],.7)
end
end)
h.Destroying:Connect(function() watchedHum[h]=nil end)
end
local function watchPlayer(p)
if p==LP then return end
local function setup(c)
local h=c:WaitForChild("Humanoid",5)
if not h then return end
watchHumanoid(p,h)
end
if p.Character then task.spawn(setup,p.Character) end
p.CharacterAdded:Connect(setup)
end
for _,p in ipairs(P:GetPlayers()) do watchPlayer(p) end
P.PlayerAdded:Connect(watchPlayer)

-- KILL EFFECT
local function kFX(pos)
if not S.KEff then return end
local pt=Instance.new("Part")
pt.Size=Vector3.new(1,1,1)pt.Position=pos pt.Anchored=true pt.CanCollide=false pt.Transparency=1 pt.Parent=workspace
if S.KEffT=="Explosion" then
local e=Instance.new("Explosion",workspace)
e.Position=pos e.BlastRadius=8 e.BlastPressure=0 e.ExplosionType=Enum.ExplosionType.NoCraters
D:AddItem(pt,.1)
elseif S.KEffT=="Fire" then
local f=Instance.new("Fire",pt)
f.Size=8 f.Heat=5 f.Color=Color3.fromRGB(255,100,50)f.SecondaryColor=Color3.fromRGB(255,200,50)
D:AddItem(pt,2)
elseif S.KEffT=="Lightning" then
local a1=Instance.new("Attachment",pt)local a2=Instance.new("Attachment",pt)
a2.Position=Vector3.new(0,30,0)
local b=Instance.new("Beam",pt)
b.Attachment0=a1 b.Attachment1=a2 b.Width0=.5 b.Width1=.5
b.Color=ColorSequence.new(Color3.fromRGB(100,200,255))b.LightEmission=1
D:AddItem(pt,.3)
elseif S.KEffT=="Confetti" then
local e=Instance.new("ParticleEmitter",pt)
e.Texture="rbxasset://textures/particles/sparkles_main.dds"
e.Lifetime=NumberRange.new(1,2)e.Speed=NumberRange.new(20,40)
e.SpreadAngle=Vector2.new(180,180)e.LightEmission=1
e.Color=ColorSequence.new(Color3.fromRGB(255,100,100))
e.Size=NumberSequence.new(1)e:Emit(50)
D:AddItem(pt,3)
elseif S.KEffT=="Portal" then
local r=Instance.new("Part")
r.Shape=Enum.PartType.Cylinder r.Size=Vector3.new(.5,10,10)
r.Color=Color3.fromRGB(180,100,255)r.Material=Enum.Material.Neon
r.Anchored=true r.CanCollide=false
r.CFrame=CFrame.new(pos)*CFrame.Angles(0,0,math.rad(90))r.Parent=workspace
Tw:Create(r,TweenInfo.new(1),{Size=Vector3.new(.5,20,20),Transparency=1}):Play()
D:AddItem(r,1.5)D:AddItem(pt,.1)
end
end
local function setupKillEffect(p)
if p==LP then return end
local function setup(c)
local h=c:WaitForChild("Humanoid",5)
if not h then return end
h.Died:Connect(function()
local root=c:FindFirstChild("HumanoidRootPart")
if root then kFX(root.Position) end
end)
end
if p.Character then task.spawn(setup,p.Character) end
p.CharacterAdded:Connect(setup)
end
for _,p in ipairs(P:GetPlayers()) do setupKillEffect(p) end
P.PlayerAdded:Connect(setupKillEffect)

-- PARTICLE AURA
local aE,aA=nil,nil
local aP={
Fire={tx="rbxasset://textures/particles/fire_main.dds",cl=ColorSequence.new(Color3.fromRGB(255,100,50)),lt=.8,
sz=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(.5,1),NumberSequenceKeypoint.new(1,0)}),sp=NumberRange.new(3,6)},
Sparkle={tx="rbxasset://textures/particles/sparkles_main.dds",cl=ColorSequence.new(Color3.fromRGB(255,255,200)),lt=1,
sz=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(.5,.5),NumberSequenceKeypoint.new(1,0)}),sp=NumberRange.new(5,10)},
Lightning={tx="rbxasset://textures/particles/sparkles_main.dds",cl=ColorSequence.new(Color3.fromRGB(100,200,255)),lt=1,
sz=NumberSequence.new(.3),sp=NumberRange.new(10,20)},
Snow={tx="rbxasset://textures/particles/sparkles_main.dds",cl=ColorSequence.new(Color3.fromRGB(255,255,255)),lt=.5,
sz=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(.5,.8),NumberSequenceKeypoint.new(1,0)}),sp=NumberRange.new(2,4)},
Neon={tx="rbxasset://textures/particles/sparkles_main.dds",cl=ColorSequence.new(Color3.fromRGB(200,100,255)),lt=1,
sz=NumberSequence.new(.6),sp=NumberRange.new(4,8)},
Rainbow={tx="rbxasset://textures/particles/sparkles_main.dds",cl=ColorSequence.new(Color3.fromRGB(255,100,100)),lt=1,
sz=NumberSequence.new(.5),sp=NumberRange.new(5,10)},
}
spawn(function()
while true do
task.wait(.5)
local c=LP.Character local hrp=c and c:FindFirstChild("HumanoidRootPart")
if S.Aura then
if hrp and(not aA or aA.Parent~=hrp)then
if aE then aE:Destroy()end if aA then aA:Destroy()end
local pr=aP[S.AuraT]or aP.Fire
aA=Instance.new("Attachment",hrp)aE=Instance.new("ParticleEmitter",aA)
aE.Texture=pr.tx aE.LightEmission=pr.lt aE.Color=pr.cl aE.Size=pr.sz aE.Speed=pr.sp
aE.Rate=S.AuraR aE.Lifetime=NumberRange.new(1,2)aE.SpreadAngle=Vector2.new(180,180)
end
if aE then
aE.Rate=S.AuraR
if S.AuraT=="Rainbow"then aE.Color=ColorSequence.new(Color3.fromHSV((tick()*.3)%1,1,1))end
end
else
if aE then aE:Destroy()aE=nil end if aA then aA:Destroy()aA=nil end
end
end
end)

-- MOVEMENT
U.JumpRequest:Connect(function()
if S.IJmp then local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end
end)
R.Stepped:Connect(function()
if S.Noclip then local c=LP.Character if c then for _,p in pairs(c:GetDescendants())do if p:IsA("BasePart")and p.CanCollide then p.CanCollide=false end end end end
end)
spawn(function()while true do task.wait(60) if S.AAFK then pcall(function()game:GetService("VirtualUser"):CaptureController()game:GetService("VirtualUser"):ClickButton2(Vector2.new())end)end end end)
spawn(function()while true do task.wait(.5) if S.AutoR then local c=LP.Character if c then local h=c:FindFirstChildOfClass("Humanoid")if h and h.Health<=0 then task.wait(.5)pcall(function()LP:LoadCharacter()end)end end end end end)
R.RenderStepped:Connect(function()
if S.Fly then
local c=LP.Character
if c then
local hrp=c:FindFirstChild("HumanoidRootPart")local bg=hrp and hrp:FindFirstChild("FlyBV")
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

-- WALL + TARGET FINDER
local function isV(ch,pt)
local rp=RaycastParams.new()
rp.FilterDescendantsInstances={LP.Character,Cam}
rp.FilterType=Enum.RaycastFilterType.Exclude
local r=workspace:Raycast(Cam.CFrame.Position,pt.Position-Cam.CFrame.Position,rp)
if r then return r.Instance:IsDescendantOf(ch)end
return true
end
local curT=nil
local function gT()
local cl,sd=nil,S.FOV
local vp=Cam.ViewportSize local cen=Vector2.new(vp.X/2,vp.Y/2)
for _,p in pairs(P:GetPlayers())do
if p==LP then continue end
local c=p.Character if not c then continue end
local h=c:FindFirstChildOfClass("Humanoid")if not h or h.Health<=0 then continue end
local hrp=c:FindFirstChild("HumanoidRootPart")if not hrp then continue end
if(Cam.CFrame.Position-hrp.Position).Magnitude>S.MaxD then continue end
local pt=c:FindFirstChild(S.Part)or c:FindFirstChild("Head")or hrp
if S.VisChk and not isV(c,pt)then continue end
local sp,on=Cam:WorldToViewportPoint(pt.Position)
if not on then continue end
local d=(Vector2.new(sp.X,sp.Y)-cen).Magnitude
if d<sd then sd=d cl=pt end
end
return cl
end
R:BindToRenderStep("AimLoop",Enum.RenderPriority.Camera.Value+10,function()
if not S.Aim then curT=nil return end
local t=gT()
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
if S.AutoS then local tl=LP.Character and LP.Character:FindFirstChildOfClass("Tool")if tl then pcall(function()tl:Activate()end)end end
end)

-- TARGET ESP
local tBox=Drawing.new("Square")tBox.Thickness=1.5 tBox.Filled=false tBox.Visible=false
local tCorners={}
for i=1,8 do tCorners[i]=Drawing.new("Line")tCorners[i].Thickness=2 tCorners[i].Visible=false end
local tHPBg=Drawing.new("Square")tHPBg.Filled=true tHPBg.Color=Color3.fromRGB(0,0,0)tHPBg.Visible=false
local tHPFg=Drawing.new("Square")tHPFg.Filled=true tHPFg.Visible=false
local tNm=Drawing.new("Text")tNm.Size=12 tNm.Center=true tNm.Outline=true tNm.Color=Color3.fromRGB(255,255,255)tNm.Visible=false
local tHPTxt=Drawing.new("Text")tHPTxt.Size=11 tHPTxt.Center=true tHPTxt.Outline=true tHPTxt.Visible=false
local tDs=Drawing.new("Text")tDs.Size=11 tDs.Center=true tDs.Outline=true tDs.Color=Color3.fromRGB(200,200,200)tDs.Visible=false
local tFade=0
R.RenderStepped:Connect(function()
if not S.TgtE or not curT then
tFade=math.max(0,tFade-.15)
if tFade<=0 then
tBox.Visible=false tHPBg.Visible=false tHPFg.Visible=false
tNm.Visible=false tHPTxt.Visible=false tDs.Visible=false
for _,c in pairs(tCorners)do c.Visible=false end
return
end
else tFade=math.min(1,tFade+.2)end
local c=curT.Parent if not c then return end
local hd=c:FindFirstChild("Head")
local hrp=c:FindFirstChild("HumanoidRootPart")
local hum=c:FindFirstChildOfClass("Humanoid")
if not hd or not hrp or not hum then return end
local col=C[S.TgtCol]or C.Red
local fa=tFade
local top,t1=Cam:WorldToViewportPoint(hd.Position+Vector3.new(0,0.5,0))
local bot,t2=Cam:WorldToViewportPoint(hrp.Position-Vector3.new(0,3,0))
if not(t1 and t2)then return end
local h=math.abs(top.Y-bot.Y)local w=h*0.5
local bx=top.X-w/2 local by=top.Y local ex=bx+w local ey=by+h
tBox.Size=Vector2.new(w,h)tBox.Position=Vector2.new(bx,by)tBox.Color=col tBox.Transparency=fa*0.9 tBox.Visible=true
local cl=math.min(w,h)*0.25
local corners={{bx,by,bx+cl,by},{bx,by,bx,by+cl},{ex,by,ex-cl,by},{ex,by,ex,by+cl},{bx,ey,bx+cl,ey},{bx,ey,bx,ey-cl},{ex,ey,ex-cl,ey},{ex,ey,ex,ey-cl}}
for i,cr in ipairs(corners)do
tCorners[i].From=Vector2.new(cr[1],cr[2])
tCorners[i].To=Vector2.new(cr[3],cr[4])
tCorners[i].Color=col
tCorners[i].Transparency=fa
tCorners[i].Visible=true
end
local hp=hum.Health/hum.MaxHealth
tHPBg.Size=Vector2.new(2,h)tHPBg.Position=Vector2.new(bx-5,by)tHPBg.Color=Color3.fromRGB(0,0,0)tHPBg.Transparency=fa*0.5 tHPBg.Visible=true
tHPFg.Size=Vector2.new(2,h*hp)tHPFg.Position=Vector2.new(bx-5,by+h*(1-hp))tHPFg.Color=Color3.fromRGB(80,220,80)tHPFg.Transparency=fa tHPFg.Visible=true
tNm.Text=c.Name tNm.Position=Vector2.new(top.X,by-16)tNm.Transparency=fa tNm.Visible=true
tHPTxt.Text=math.floor(hum.Health).." HP"tHPTxt.Position=Vector2.new(top.X,by-3)tHPTxt.Color=Color3.fromRGB(80,220,80)tHPTxt.Transparency=fa tHPTxt.Visible=true
local dist=(Cam.CFrame.Position-hrp.Position).Magnitude
tDs.Text=string.format("[%dm]",math.floor(dist))tDs.Position=Vector2.new(top.X,ey+4)tDs.Transparency=fa tDs.Visible=true
end)

-- ESP
R.RenderStepped:Connect(function()
for _,p in pairs(P:GetPlayers())do
if p==LP then continue end
local c=p.Character
local function hide()
if HLS[p]then HLS[p].Enabled=false end
if BOX[p]then if typeof(BOX[p])=="table"then for _,l in pairs(BOX[p])do l.Visible=false end else BOX[p].Visible=false end end
if BF[p]then BF[p].Visible=false end
if NAM[p]then NAM[p].Visible=false end
if DST[p]then DST[p].Visible=false end
if HPB[p]then HPB[p].Visible=false end
if HPG[p]then HPG[p].Visible=false end
if TRC[p]then TRC[p].Visible=false end
if HD[p]then HD[p].Visible=false end
if AR[p]then AR[p].Visible=false end
if BM[p]then BM[p].Visible=false end
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
local hl=Instance.new("Highlight",pt)hl.FillColor=Color3.fromRGB(255,60,60)hl.FillTransparency=.3
hl.OutlineTransparency=1 hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
table.insert(CH[p],hl)
end
end
end
elseif CH[p]then for _,cc in pairs(CH[p])do cc:Destroy()end CH[p]=nil end
if S.HL then
if not HLS[p]or HLS[p].Parent~=c then
if HLS[p]then HLS[p]:Destroy()end
local hl=Instance.new("Highlight",c)hl.FillColor=Color3.fromRGB(255,60,60)hl.FillTransparency=.5
hl.OutlineColor=Color3.fromRGB(255,255,255)hl.OutlineTransparency=.2 hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
HLS[p]=hl
end
HLS[p].Enabled=true
elseif HLS[p]then HLS[p].Enabled=false end
local hrp=c:FindFirstChild("HumanoidRootPart")local hd=c:FindFirstChild("Head")
if hrp and hd then
local tp,o1=Cam:WorldToViewportPoint(hd.Position+Vector3.new(0,.5,0))
local bp,o2=Cam:WorldToViewportPoint(hrp.Position-Vector3.new(0,3,0))
if S.Arr then
local cs=Cam.ViewportSize/2 local sp=Cam:WorldToViewportPoint(hrp.Position)
local spv=Vector2.new(sp.X,sp.Y)local dir=spv-Vector2.new(cs.X,cs.Y)
local onScr=sp.Z>0 and math.abs(spv.X-cs.X)<cs.X and math.abs(spv.Y-cs.Y)<cs.Y
if not onScr then
if not AR[p]then AR[p]=Drawing.new("Triangle")AR[p].Thickness=1 AR[p].Filled=true AR[p].Color=Color3.fromRGB(255,60,60)AR[p].Transparency=1 end
local a=math.atan2(dir.Y,dir.X)local r=150
local pos=Vector2.new(cs.X+math.cos(a)*r,cs.Y+math.sin(a)*r)local sz=15
AR[p].PointA=pos+Vector2.new(math.cos(a)*sz,math.sin(a)*sz)
AR[p].PointB=pos+Vector2.new(math.cos(a+2.5)*sz,math.sin(a+2.5)*sz)
AR[p].PointC=pos+Vector2.new(math.cos(a-2.5)*sz,math.sin(a-2.5)*sz)
AR[p].Visible=true
elseif AR[p]then AR[p].Visible=false end
elseif AR[p]then AR[p].Visible=false end
if S.Beam then
if not BM[p]then BM[p]=Drawing.new("Line")BM[p].Thickness=1.5 BM[p].Color=Color3.fromRGB(255,100,200)BM[p].Transparency=.7 end
local vp=Cam.ViewportSize
local tS=Cam:WorldToViewportPoint(hrp.Position)
BM[p].From=Vector2.new(vp.X/2,vp.Y-30)BM[p].To=Vector2.new(tS.X,tS.Y)BM[p].Visible=true
elseif BM[p]then BM[p].Visible=false end
if o1 and o2 then
local h=math.abs(tp.Y-bp.Y)local w=h*.55
local bx=tp.X-w/2 local by=tp.Y
if S.Box then
if S.BoxStyle=="Filled"then
if not BF[p]then BF[p]=Drawing.new("Square")BF[p].Filled=true BF[p].Color=Color3.fromRGB(255,60,60)BF[p].Transparency=.75 end
BF[p].Size=Vector2.new(w,h)BF[p].Position=Vector2.new(bx,by)BF[p].Visible=true
if BOX[p]and typeof(BOX[p])~="table"then BOX[p].Visible=false end
else
if not BOX[p]or typeof(BOX[p])=="table"then
if typeof(BOX[p])=="table"then for _,l in pairs(BOX[p])do l:Remove()end end
BOX[p]=Drawing.new("Square")BOX[p].Thickness=2 BOX[p].Filled=false BOX[p].Color=Color3.fromRGB(255,60,60)BOX[p].Transparency=1
end
BOX[p].Size=Vector2.new(w,h)BOX[p].Position=Vector2.new(bx,by)BOX[p].Visible=true
if BF[p]then BF[p].Visible=false end
end
elseif BOX[p]then
if typeof(BOX[p])=="table"then for _,l in pairs(BOX[p])do l.Visible=false end else BOX[p].Visible=false end
if BF[p]then BF[p].Visible=false end
end
if S.HDot then
if not HD[p]then HD[p]=Drawing.new("Circle")HD[p].Radius=6 HD[p].Filled=false HD[p].Thickness=2 HD[p].Color=Color3.fromRGB(255,100,100)HD[p].Transparency=1 end
HD[p].Position=Vector2.new(tp.X,tp.Y+5)HD[p].Visible=true
elseif HD[p]then HD[p].Visible=false end
if S.Skel then
local bones={{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}}
if not SK[p]then
SK[p]={}
for i=1,#bones do local ln=Drawing.new("Line")ln.Thickness=1.5 ln.Color=Color3.fromRGB(255,255,255)table.insert(SK[p],ln)end
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
TRC[p].From=Vector2.new(vp.X/2,vp.Y)TRC[p].To=Vector2.new(tp.X,tp.Y+h)TRC[p].Visible=true
elseif TRC[p]then TRC[p].Visible=false end
else hide()end
end
end
end)
P.PlayerRemoving:Connect(function(p)
if HLS[p]then HLS[p]:Destroy()end
if BOX[p]then if typeof(BOX[p])=="table"then for _,l in pairs(BOX[p])do l:Remove()end else BOX[p]:Remove()end end
if BF[p]then BF[p]:Remove()end if NAM[p]then NAM[p]:Remove()end if DST[p]then DST[p]:Remove()end
if HPB[p]then HPB[p]:Remove()end if HPG[p]then HPG[p]:Remove()end if TRC[p]then TRC[p]:Remove()end
if HD[p]then HD[p]:Remove()end if AR[p]then AR[p]:Remove()end if BM[p]then BM[p]:Remove()end
if SK[p]then for _,l in pairs(SK[p])do l:Remove()end end
if CH[p]then for _,cc in pairs(CH[p])do cc:Destroy()end end
end)
print("[v17 PrimDLC] @LutshiyKot loaded!")
