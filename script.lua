local P=game:GetService("Players")local R=game:GetService("RunService")local U=game:GetService("UserInputService")
local T=game:GetService("TeleportService")local H=game:GetService("HttpService")local L=game:GetService("Lighting")
local S1=game:GetService("SoundService")local Tw=game:GetService("TweenService")local D=game:GetService("Debris")
local LP=P.LocalPlayer
while not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") do task.wait(.1) end
task.wait(.5)
local Cam=workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()Cam=workspace.CurrentCamera end)
LP.CharacterAdded:Connect(function(c)c:WaitForChild("HumanoidRootPart")task.wait(.5)Cam=workspace.CurrentCamera end)

local S={
 Aim=true,Smooth=.05,FOV=120,Part="Head",MaxD=500,VisChk=true,AutoS=false,Pred=false,
 TgtE=true,TgtStyle="Box",TgtCol="Yellow",TgtPulse=true,TgtName=true,TgtHP=true,TgtDist=true,TgtArrow=true,TgtLock=false,TgtTrail=false,
 ESP=true,Box=true,BoxStyle="Normal",HL=true,Name=true,Dist=true,HP=true,Tracer=false,Skel=false,HDot=false,Arr=false,Chams=false,Beam=false,
 FB=false,NF=false,ShowFov=true,ShowCross=true,CrossSty="Dot",WM=true,FovCol="Purple",
 HSnd=false,HSndT="Click",KSnd=false,KSndT="Explosion",KEff=false,KEffT="Explosion",Aura=false,AuraT="Fire",AuraR=40,
 Hat=true,Rainbow=false,CamFOVe=false,CamFOV=70,
 Snow=false,SnowT="Normal",Sky=false,SkyT="Night",Time=false,TimeV=14,Bloom=false,BloomI=1.5,CC=false,CCM="None",SunR=false,Atm=false,
 Spd=16,Jmp=50,IJmp=false,Fly=false,Noclip=false,FlyS=50,AAFK=false,AutoR=false,FPS=false,Ping=false,Clock=false,
}
local C={Purple=Color3.fromRGB(180,100,255),Red=Color3.fromRGB(255,80,80),Blue=Color3.fromRGB(80,150,255),
 Green=Color3.fromRGB(80,255,120),Yellow=Color3.fromRGB(255,220,80),White=Color3.fromRGB(255,255,255),
 Pink=Color3.fromRGB(255,100,200),Cyan=Color3.fromRGB(80,255,255),Orange=Color3.fromRGB(255,150,50)}

local gui,MF,CT,SB,IG,OB
local HLS,BOX,BF,NAM,DST,HPB,HPG,TRC={},{},{},{},{},{},{},{}
local HD,SK,AR,BM,CH={},{},{},{},{}
local tabs={}

pcall(function() gui=Instance.new("ScreenGui")gui.Name="Gui"gui.ResetOnSpawn=false gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling gui.Parent=game:GetService("CoreGui") end)
if not gui or not gui.Parent then gui=Instance.new("ScreenGui")gui.Name="Gui"gui.ResetOnSpawn=false gui.Parent=LP:WaitForChild("PlayerGui") end

-- ПРИВЕТ
local nt=Instance.new("Frame",gui)
nt.Size=UDim2.new(0,320,0,65)nt.Position=UDim2.new(.5,-160,0,-70)nt.BackgroundColor3=Color3.fromRGB(30,10,60)
nt.BackgroundTransparency=.1 nt.BorderSizePixel=0 nt.ZIndex=100
Instance.new("UICorner",nt).CornerRadius=UDim.new(0,12)
local nst=Instance.new("UIStroke",nt)nst.Color=Color3.fromRGB(200,100,255)nst.Thickness=2
local ntx=Instance.new("TextLabel",nt)
ntx.Size=UDim2.new(1,-20,1,0)ntx.Position=UDim2.new(0,10,0,0)ntx.BackgroundTransparency=1
ntx.Text="Привет от @LutshiyKot"ntx.TextColor3=Color3.fromRGB(255,255,255)ntx.TextSize=19
ntx.Font=Enum.Font.GothamBold ntx.ZIndex=101
nt:TweenPosition(UDim2.new(.5,-160,0,30),"Out","Quad",.5,true)
task.delay(4,function()nt:Destroy() end)

-- WM
local wm=Instance.new("Frame",gui)
wm.Size=UDim2.new(0,190,0,30)wm.Position=UDim2.new(0,15,0,15)wm.BackgroundColor3=Color3.fromRGB(30,10,60)
wm.BackgroundTransparency=.3 wm.BorderSizePixel=0 wm.ZIndex=60
Instance.new("UICorner",wm).CornerRadius=UDim.new(0,8)
local wms=Instance.new("UIStroke",wm)wms.Color=Color3.fromRGB(200,100,255)wms.Thickness=1.5 wms.Transparency=.2
local wmt=Instance.new("TextLabel",wm)
wmt.Size=UDim2.new(1,-20,1,0)wmt.Position=UDim2.new(0,10,0,0)wmt.BackgroundTransparency=1
wmt.Text="⚡ @LutshiyKot | v7"wmt.TextColor3=Color3.fromRGB(255,255,255)wmt.TextSize=13
wmt.Font=Enum.Font.GothamBold wmt.TextXAlignment=Enum.TextXAlignment.Left wmt.ZIndex=61

local GL={}
for i=1,5 do
 local g=Instance.new("Frame",gui)
 g.Size=UDim2.new(0,460+i*12,0,340+i*12)g.Position=UDim2.new(.5,-(230+i*6),.5,-(170+i*6))
 g.BackgroundColor3=Color3.fromRGB(200,100,255)g.BackgroundTransparency=.9+i*.012 g.BorderSizePixel=0 g.ZIndex=0
 Instance.new("UICorner",g).CornerRadius=UDim.new(0,22)
 table.insert(GL,g)
end

MF=Instance.new("Frame",gui)
MF.Size=UDim2.new(0,460,0,340)MF.Position=UDim2.new(.5,-230,.5,-170)MF.BackgroundColor3=Color3.fromRGB(55,20,110)
MF.BackgroundTransparency=.15 MF.BorderSizePixel=0 MF.Active=true MF.Draggable=true MF.ZIndex=2
Instance.new("UICorner",MF).CornerRadius=UDim.new(0,14)
MF:GetPropertyChangedSignal("Position"):Connect(function()
 for i,g in ipairs(GL) do g.Position=MF.Position-UDim2.new(0,6*i,0,6*i) end
end)
local GR=Instance.new("UIGradient",MF)
GR.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(150,40,230)),ColorSequenceKeypoint.new(.5,Color3.fromRGB(70,20,150)),ColorSequenceKeypoint.new(1,Color3.fromRGB(120,40,200))})
GR.Rotation=45
IG=Instance.new("Frame",MF)
IG.Size=UDim2.new(1,0,1,0)IG.BackgroundColor3=Color3.fromRGB(200,100,255)IG.BackgroundTransparency=.82
IG.BorderSizePixel=0 IG.ZIndex=2
Instance.new("UICorner",IG).CornerRadius=UDim.new(0,14)
local N1=Instance.new("UIStroke",MF)N1.Color=Color3.fromRGB(220,120,255)N1.Thickness=2
local N2=Instance.new("UIStroke",MF)N2.Color=Color3.fromRGB(120,200,255)N2.Thickness=4 N2.Transparency=.4
local N3=Instance.new("UIStroke",MF)N3.Color=Color3.fromRGB(255,100,220)N3.Thickness=8 N3.Transparency=.7

spawn(function()
 local t=0
 while MF.Parent do
  t=t+.05
  local r=(math.sin(t)+1)/2 local g=(math.sin(t+2)+1)/2 local b=(math.sin(t+4)+1)/2
  N1.Color=Color3.fromRGB(math.floor(180+75*r),math.floor(80+120*g),math.floor(220+35*b))
  N2.Color=Color3.fromRGB(math.floor(100+100*b),math.floor(150+100*r),math.floor(220+35*g))
  N3.Color=Color3.fromRGB(math.floor(220+35*b),math.floor(80+120*g),math.floor(200+55*r))
  GR.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(math.floor(120+50*r),math.floor(30+30*g),math.floor(200+40*b))),ColorSequenceKeypoint.new(.5,Color3.fromRGB(50,15,120)),ColorSequenceKeypoint.new(1,Color3.fromRGB(math.floor(100+50*g),math.floor(30+30*b),math.floor(170+50*r)))})
  GR.Rotation=(t*25)%360
  IG.BackgroundColor3=Color3.fromRGB(math.floor(150+80*r),math.floor(60+100*g),math.floor(200+55*b))
  IG.BackgroundTransparency=.78+.08*r
  MF.BackgroundColor3=Color3.fromRGB(math.floor(45+30*r),math.floor(15+15*g),math.floor(90+40*b))
  for i,gl in ipairs(GL) do
   gl.BackgroundColor3=Color3.fromRGB(math.floor(140+100*r),math.floor(60+100*g),math.floor(200+55*b))
   gl.BackgroundTransparency=.86+i*.015+.04*(1-r)
  end
  R.Heartbeat:Wait()
 end
end)

-- ШАПКА
local HD1=Instance.new("Frame",MF)
HD1.Size=UDim2.new(1,0,0,42)HD1.BackgroundColor3=Color3.fromRGB(80,30,150)HD1.BackgroundTransparency=.35
HD1.BorderSizePixel=0 HD1.ZIndex=3
Instance.new("UICorner",HD1).CornerRadius=UDim.new(0,14)
local HF=Instance.new("Frame",HD1)
HF.Size=UDim2.new(1,0,0,18)HF.Position=UDim2.new(0,0,1,-18)HF.BackgroundColor3=Color3.fromRGB(80,30,150)
HF.BackgroundTransparency=.35 HF.BorderSizePixel=0 HF.ZIndex=3
local AV=Instance.new("TextLabel",HD1)
AV.Size=UDim2.new(0,28,0,28)AV.Position=UDim2.new(0,10,0,7)AV.BackgroundColor3=Color3.fromRGB(80,40,140)
AV.Text="👑"AV.TextSize=15 AV.Font=Enum.Font.GothamBold AV.BorderSizePixel=0 AV.ZIndex=4
Instance.new("UICorner",AV).CornerRadius=UDim.new(0,8)
local TL=Instance.new("TextLabel",HD1)
TL.Size=UDim2.new(1,-180,0,20)TL.Position=UDim2.new(0,46,0,5)TL.BackgroundTransparency=1
TL.Text="@LutshiyKot"TL.TextColor3=Color3.fromRGB(255,255,255)TL.TextSize=14
TL.Font=Enum.Font.GothamBold TL.TextXAlignment=Enum.TextXAlignment.Left TL.ZIndex=4
local SL=Instance.new("TextLabel",HD1)
SL.Size=UDim2.new(1,-180,0,14)SL.Position=UDim2.new(0,46,0,22)SL.BackgroundTransparency=1
SL.Text="by @LutshiyKot"SL.TextColor3=Color3.fromRGB(230,200,255)SL.TextSize=10
SL.Font=Enum.Font.Gotham SL.TextXAlignment=Enum.TextXAlignment.Left SL.ZIndex=4

local function mkb(t,x,cb)
 local b=Instance.new("TextButton",HD1)
 b.Size=UDim2.new(0,26,0,26)b.Position=UDim2.new(1,x,0,8)b.BackgroundColor3=Color3.fromRGB(60,25,110)
 b.BackgroundTransparency=.15 b.Text=t b.TextColor3=Color3.fromRGB(255,255,255)b.TextSize=13
 b.Font=Enum.Font.GothamBold b.BorderSizePixel=0 b.AutoButtonColor=false b.ZIndex=4
 Instance.new("UICorner",b).CornerRadius=UDim.new(0,7)
 local bs=Instance.new("UIStroke",b)bs.Color=Color3.fromRGB(220,130,255)bs.Thickness=1 bs.Transparency=.1
 b.MouseButton1Click:Connect(cb)
end

SB=Instance.new("Frame",MF)
SB.Size=UDim2.new(0,115,1,-55)SB.Position=UDim2.new(0,10,0,48)SB.BackgroundColor3=Color3.fromRGB(70,25,130)
SB.BackgroundTransparency=.55 SB.BorderSizePixel=0 SB.ZIndex=3
Instance.new("UICorner",SB).CornerRadius=UDim.new(0,10)
local sbs=Instance.new("UIStroke",SB)sbs.Color=Color3.fromRGB(200,120,255)sbs.Thickness=1 sbs.Transparency=.3
local sbl=Instance.new("UIListLayout",SB)sbl.Padding=UDim.new(0,4)
local sbp=Instance.new("UIPadding",SB)sbp.PaddingTop=UDim.new(0,6)sbp.PaddingLeft=UDim.new(0,6)sbp.PaddingRight=UDim.new(0,6)

CT=Instance.new("ScrollingFrame",MF)
CT.Size=UDim2.new(1,-135,1,-55)CT.Position=UDim2.new(0,130,0,48)CT.BackgroundTransparency=1 CT.BorderSizePixel=0
CT.ScrollBarThickness=3 CT.ScrollBarImageColor3=Color3.fromRGB(220,130,255)CT.CanvasSize=UDim2.new(0,0,0,0)
CT.AutomaticCanvasSize=Enum.AutomaticSize.Y CT.ZIndex=4
local cl=Instance.new("UIListLayout",CT)cl.Padding=UDim.new(0,5)

local min=false
local function setMin(m)
 min=m
 if m then
  MF.Size=UDim2.new(0,460,0,42)SB.Visible=false CT.Visible=false IG.Visible=false
  for i,g in ipairs(GL) do g.Size=UDim2.new(0,460+i*12,0,42+i*12) g.Position=UDim2.new(.5,-(230+i*6),.5,-(21+i*6)) end
 else
  MF.Size=UDim2.new(0,460,0,340)SB.Visible=true CT.Visible=true IG.Visible=true
  for i,g in ipairs(GL) do g.Size=UDim2.new(0,460+i*12,0,340+i*12) g.Position=UDim2.new(.5,-(230+i*6),.5,-(170+i*6)) end
 end
end
mkb("—",-90,function()setMin(not min)end)
mkb("□",-60,function()setMin(false)end)
mkb("✕",-30,function()MF.Visible=false for _,g in ipairs(GL) do g.Visible=false end if OB then OB.Visible=true end end)

OB=Instance.new("TextButton",gui)
OB.Size=UDim2.new(0,45,0,45)OB.Position=UDim2.new(0,20,0,100)OB.BackgroundColor3=Color3.fromRGB(60,25,110)
OB.Text="⚡"OB.TextColor3=Color3.fromRGB(255,255,255)OB.TextSize=20 OB.Font=Enum.Font.GothamBold
OB.BorderSizePixel=0 OB.Visible=false OB.ZIndex=50
Instance.new("UICorner",OB).CornerRadius=UDim.new(1,0)
local obs=Instance.new("UIStroke",OB)obs.Color=Color3.fromRGB(220,130,255)obs.Thickness=2
OB.MouseButton1Click:Connect(function()MF.Visible=true for _,g in ipairs(GL) do g.Visible=true end setMin(false)OB.Visible=false end)

-- ЭЛЕМЕНТЫ
local function mkSec(t)
 local l=Instance.new("TextLabel",CT)
 l.Size=UDim2.new(1,-6,0,22)l.BackgroundTransparency=1
 l.Text=t l.TextColor3=Color3.fromRGB(255,220,255)l.TextSize=13
 l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=5
end
local function mkC(t,d,cb)
 local c=Instance.new("TextButton",CT)
 c.Size=UDim2.new(1,-6,0,36)c.BackgroundColor3=Color3.fromRGB(60,25,120)c.BackgroundTransparency=.3
 c.Text=""c.BorderSizePixel=0 c.AutoButtonColor=false c.ZIndex=4
 Instance.new("UICorner",c).CornerRadius=UDim.new(0,9)
 local cs=Instance.new("UIStroke",c)cs.Color=Color3.fromRGB(200,120,255)cs.Thickness=1 cs.Transparency=.2
 local l=Instance.new("TextLabel",c)
 l.Size=UDim2.new(1,-60,1,0)l.Position=UDim2.new(0,14,0,0)l.BackgroundTransparency=1
 l.Text=t l.TextColor3=Color3.fromRGB(255,240,255)l.TextSize=12
 l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=5
 local tg=Instance.new("Frame",c)
 tg.Size=UDim2.new(0,36,0,18)tg.Position=UDim2.new(1,-46,.5,-9)
 tg.BackgroundColor3=d and Color3.fromRGB(200,100,255) or Color3.fromRGB(80,40,130)
 tg.BorderSizePixel=0 tg.ZIndex=5
 Instance.new("UICorner",tg).CornerRadius=UDim.new(1,0)
 local k=Instance.new("Frame",tg)
 k.Size=UDim2.new(0,14,0,14)k.Position=d and UDim2.new(1,-16,.5,-7) or UDim2.new(0,2,.5,-7)
 k.BackgroundColor3=Color3.fromRGB(255,255,255)k.BorderSizePixel=0 k.ZIndex=6
 Instance.new("UICorner",k).CornerRadius=UDim.new(1,0)
 local st=d
 c.MouseButton1Click:Connect(function()
  st=not st cb(st)
  tg.BackgroundColor3=st and Color3.fromRGB(200,100,255) or Color3.fromRGB(80,40,130)
  k:TweenPosition(st and UDim2.new(1,-16,.5,-7) or UDim2.new(0,2,.5,-7),"Out","Quad",.15,true)
 end)
end
local function mkB2(t,cb)
 local b=Instance.new("TextButton",CT)
 b.Size=UDim2.new(1,-6,0,36)b.BackgroundColor3=Color3.fromRGB(80,30,150)b.BackgroundTransparency=.2
 b.Text=t b.TextColor3=Color3.fromRGB(255,240,255)b.TextSize=12
 b.Font=Enum.Font.GothamBold b.BorderSizePixel=0 b.AutoButtonColor=false b.ZIndex=4
 Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
 local bs=Instance.new("UIStroke",b)bs.Color=Color3.fromRGB(255,150,255)bs.Thickness=1.5 bs.Transparency=.1
 b.MouseButton1Click:Connect(function()bs.Transparency=0 task.wait(.1)bs.Transparency=.1 cb()end)
end
local function mkSl(t,mn,mx,d,cb)
 local f=Instance.new("Frame",CT)
 f.Size=UDim2.new(1,-6,0,52)f.BackgroundColor3=Color3.fromRGB(60,25,120)f.BackgroundTransparency=.3
 f.BorderSizePixel=0 f.ZIndex=4
 Instance.new("UICorner",f).CornerRadius=UDim.new(0,9)
 local cs=Instance.new("UIStroke",f)cs.Color=Color3.fromRGB(200,120,255)cs.Thickness=1 cs.Transparency=.2
 local l=Instance.new("TextLabel",f)
 l.Size=UDim2.new(1,-20,0,18)l.Position=UDim2.new(0,14,0,5)l.BackgroundTransparency=1
 l.Text=t..": "..tostring(d)l.TextColor3=Color3.fromRGB(255,240,255)l.TextSize=12
 l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=5
 local bg=Instance.new("Frame",f)
 bg.Size=UDim2.new(1,-28,0,7)bg.Position=UDim2.new(0,14,0,32)bg.BackgroundColor3=Color3.fromRGB(60,30,100)
 bg.BorderSizePixel=0 bg.ZIndex=5
 Instance.new("UICorner",bg).CornerRadius=UDim.new(1,0)
 local fl=Instance.new("Frame",bg)
 fl.Size=UDim2.new((d-mn)/(mx-mn),0,1,0)fl.BackgroundColor3=Color3.fromRGB(220,120,255)
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
 b.Size=UDim2.new(1,-6,0,36)b.BackgroundColor3=Color3.fromRGB(60,25,120)b.BackgroundTransparency=.3
 b.Text=""b.BorderSizePixel=0 b.AutoButtonColor=false b.ZIndex=4
 Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
 local cs=Instance.new("UIStroke",b)cs.Color=Color3.fromRGB(200,120,255)cs.Thickness=1 cs.Transparency=.2
 local l=Instance.new("TextLabel",b)
 l.Size=UDim2.new(.5,-10,1,0)l.Position=UDim2.new(0,14,0,0)l.BackgroundTransparency=1
 l.Text=t l.TextColor3=Color3.fromRGB(255,240,255)l.TextSize=12
 l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=5
 local v=Instance.new("TextLabel",b)
 v.Size=UDim2.new(.5,-14,1,0)v.Position=UDim2.new(.5,0,0,0)v.BackgroundTransparency=1
 v.Text=d v.TextColor3=Color3.fromRGB(255,200,255)v.TextSize=12
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
 b.Size=UDim2.new(1,0,0,28)b.BackgroundColor3=Color3.fromRGB(60,25,120)b.BackgroundTransparency=.5
 b.Text=""b.BorderSizePixel=0 b.AutoButtonColor=false b.ZIndex=4
 Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
 local bs=Instance.new("UIStroke",b)bs.Color=Color3.fromRGB(180,100,255)bs.Thickness=1 bs.Transparency=.6
 local l=Instance.new("TextLabel",b)
 l.Size=UDim2.new(1,-32,1,0)l.Position=UDim2.new(0,26,0,0)l.BackgroundTransparency=1
 l.Text=name l.TextColor3=Color3.fromRGB(220,200,255)l.TextSize=10
 l.Font=Enum.Font.GothamBold l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=5
 local ic=Instance.new("TextLabel",b)
 ic.Size=UDim2.new(0,18,1,0)ic.Position=UDim2.new(0,8,0,0)ic.BackgroundTransparency=1
 ic.Text=icon ic.TextSize=11 ic.Font=Enum.Font.GothamBold ic.ZIndex=5
 b.MouseButton1Click:Connect(function()
  for _,t in pairs(tabs) do t.btn.BackgroundColor3=Color3.fromRGB(60,25,120)t.lbl.TextColor3=Color3.fromRGB(220,200,255)t.bs.Transparency=.6 end
  b.BackgroundColor3=Color3.fromRGB(120,50,220)l.TextColor3=Color3.fromRGB(255,255,255)bs.Transparency=0 cb()
 end)
 return{btn=b,lbl=l,bs=bs,callback=cb}
end

-- SOUNDS
local HSnd={Click="rbxassetid://6042053626",Bell="rbxassetid://6042054027",Minecraft="rbxassetid://6042054196",Pew="rbxassetid://6042054652",Bubble="rbxassetid://6042054764"}
local KSnd={Explosion="rbxassetid://6042055134",Ding="rbxassetid://6042055325",Bruh="rbxassetid://6042055494",Vine="rbxassetid://6042055656",Sniper="rbxassetid://6042055794"}
local function pSnd(id,v)
 local s=Instance.new("Sound")s.SoundId=id s.Volume=v or 1 s.Parent=S1 s:Play()D:AddItem(s,5)
end

-- ВКЛАДКИ
table.insert(tabs,mkT("Main","🏠",function()
 clr()
 mkSec("Aimbot")mkC("Aimbot",S.Aim,function(v)S.Aim=v end)mkC("Auto Shoot",S.AutoS,function(v)S.AutoS=v end)
 mkC("Prediction",S.Pred,function(v)S.Pred=v end)mkC("Wall Check",S.VisChk,function(v)S.VisChk=v end)
 mkSec("ESP")mkC("ESP",S.ESP,function(v)S.ESP=v end)mkC("Box",S.Box,function(v)S.Box=v end)
 mkC("Highlight",S.HL,function(v)S.HL=v end)mkC("Target ESP",S.TgtE,function(v)S.TgtE=v end)mkC("Chams",S.Chams,function(v)S.Chams=v end)
end))
table.insert(tabs,mkT("Target","🎯",function()
 clr()
 mkSec("Target ESP")
 mkC("Enable",S.TgtE,function(v)S.TgtE=v end)mkC("Name",S.TgtName,function(v)S.TgtName=v end)
 mkC("HP",S.TgtHP,function(v)S.TgtHP=v end)mkC("Distance",S.TgtDist,function(v)S.TgtDist=v end)
 mkC("Arrow",S.TgtArrow,function(v)S.TgtArrow=v end)mkC("Pulse",S.TgtPulse,function(v)S.TgtPulse=v end)
 mkC("Trail",S.TgtTrail,function(v)S.TgtTrail=v end)mkC("Only Locked",S.TgtLock,function(v)S.TgtLock=v end)
 mkSec("Style")mkDr("Style",{"Box","Circle","Minimal"},S.TgtStyle,function(v)S.TgtStyle=v end)
 mkDr("Color",{"Yellow","Red","Green","Cyan","Pink","White"},S.TgtCol,function(v)S.TgtCol=v end)
end))
table.insert(tabs,mkT("Aim","⚔",function()
 clr()
 mkSec("Aimbot")mkC("Aimbot",S.Aim,function(v)S.Aim=v end)mkC("Prediction",S.Pred,function(v)S.Pred=v end)
 mkC("Wall Check",S.VisChk,function(v)S.VisChk=v end)mkC("Auto Shoot",S.AutoS,function(v)S.AutoS=v end)
 mkSec("Target")mkDr("Hit Part",{"Head","UpperTorso","LowerTorso","HumanoidRootPart"},S.Part,function(v)S.Part=v end)
 mkDr("FOV Color",{"Purple","Red","Blue","Green","Yellow","White","Pink","Cyan","Orange"},S.FovCol,function(v)S.FovCol=v end)
 mkSl("FOV",50,800,S.FOV,function(v)S.FOV=v end)mkSl("Smooth",0,95,S.Smooth*100,function(v)S.Smooth=v/100 end)
 mkSl("Max Dist",50,2000,S.MaxD,function(v)S.MaxD=v end)
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
 mkSec("Screen")mkC("FOV Circle",S.ShowFov,function(v)S.ShowFov=v;fovC.Visible=v end)
 mkC("Crosshair",S.ShowCross,function(v)S.ShowCross=v end)
 mkDr("Crosshair Style",{"Dot","Cross","Circle","X"},S.CrossSty,function(v)S.CrossSty=v end)
 mkC("Watermark",S.WM,function(v)wm.Visible=v end)
 mkC("FPS",S.FPS,function(v)S.FPS=v end)mkC("Ping",S.Ping,function(v)S.Ping=v end)mkC("Clock",S.Clock,function(v)S.Clock=v end)
end))
table.insert(tabs,mkT("FX","✨",function()
 clr()
 mkSec("Weather")mkC("Snow",S.Snow,function(v)S.Snow=v end)
 mkDr("Snow Type",{"Normal","Neon","Gold"},S.SnowT,function(v)S.SnowT=v end)
 mkSec("Sky")mkC("Change Sky",S.Sky,function(v)S.Sky=v end)
 mkDr("Sky Type",{"Night","Sunset","Space","Red"},S.SkyT,function(v)S.SkyT=v end)
 mkSec("Time")mkC("Change Time",S.Time,function(v)S.Time=v end)
 mkSlider2=mkSl mkSl("Clock Time",0,24,S.TimeV,function(v)S.TimeV=v end)
 mkSec("Post-FX")mkC("Bloom",S.Bloom,function(v)S.Bloom=v end)
 mkSl("Bloom Intensity",0,5,S.BloomI,function(v)S.BloomI=v end)
 mkC("Color Correction",S.CC,function(v)S.CC=v end)
 mkDr("CC Mode",{"None","Red","Blue","Green","Matrix","Cinematic"},S.CCM,function(v)S.CCM=v end)
 mkC("Sun Rays",S.SunR,function(v)S.SunR=v end)mkC("Atmosphere",S.Atm,function(v)S.Atm=v end)
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
 mkSec("Fun")mkC("Neon China Hat",S.Hat,function(v)S.Hat=v end)mkC("Rainbow Player",S.Rainbow,function(v)S.Rainbow=v end)
 mkSec("Camera")mkC("Custom FOV",S.CamFOVe,function(v)S.CamFOVe=v Cam.FieldOfView=v and S.CamFOV or 70 end)
 mkSl("Camera FOV",30,120,S.CamFOV,function(v)S.CamFOV=v if S.CamFOVe then Cam.FieldOfView=v end end)
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
tabs[1].callback()tabs[1].btn.BackgroundColor3=Color3.fromRGB(120,50,220)tabs[1].lbl.TextColor3=Color3.fromRGB(255,255,255)tabs[1].bs.Transparency=0

-- FOV + CROSS
local fovC=Drawing.new("Circle")fovC.Thickness=1.5 fovC.NumSides=60 fovC.Radius=S.FOV
fovC.Filled=false fovC.Transparency=.6 fovC.Color=C[S.FovCol]fovC.Visible=S.ShowFov
local cDot=Drawing.new("Circle")cDot.Radius=2.5 cDot.Filled=true cDot.Color=Color3.fromRGB(255,255,255)cDot.Transparency=.9 cDot.Visible=false
local cL1=Drawing.new("Line")cL1.Thickness=1.5 cL1.Color=Color3.fromRGB(255,255,255)cL1.Visible=false
local cL2=Drawing.new("Line")cL2.Thickness=1.5 cL2.Color=Color3.fromRGB(255,255,255)cL2.Visible=false
local cCir=Drawing.new("Circle")cCir.Radius=10 cCir.Thickness=1.5 cCir.Filled=false cCir.Color=Color3.fromRGB(255,255,255)cCir.Visible=false
local cX1=Drawing.new("Line")cX1.Thickness=1.5 cX1.Color=Color3.fromRGB(255,255,255)cX1.Visible=false
local cX2=Drawing.new("Line")cX2.Thickness=1.5 cX2.Color=Color3.fromRGB(255,255,255)cX2.Visible=false
R.RenderStepped:Connect(function()
 local vp=Cam.ViewportSize
 fovC.Position=Vector2.new(vp.X/2,vp.Y/2)fovC.Radius=S.FOV fovC.Color=C[S.FovCol]or C.Purple
 local c=Vector2.new(vp.X/2,vp.Y/2)
 cDot.Position=c
 cL1.From=Vector2.new(c.X-10,c.Y)cL1.To=Vector2.new(c.X-3,c.Y)
 cL2.From=Vector2.new(c.X+3,c.Y)cL2.To=Vector2.new(c.X+10,c.Y)
 cCir.Position=c
 cX1.From=Vector2.new(c.X-7,c.Y-7)cX1.To=Vector2.new(c.X+7,c.Y+7)
 cX2.From=Vector2.new(c.X+7,c.Y-7)cX2.To=Vector2.new(c.X-7,c.Y+7)
 cDot.Visible=false cL1.Visible=false cL2.Visible=false cCir.Visible=false cX1.Visible=false cX2.Visible=false
 if S.ShowCross then
  if S.CrossSty=="Dot"then cDot.Visible=true
  elseif S.CrossSty=="Cross"then cL1.Visible=true cL2.Visible=true
  elseif S.CrossSty=="Circle"then cCir.Visible=true
  elseif S.CrossSty=="X"then cX1.Visible=true cX2.Visible=true end
 end
end)

-- HUD
local fpsL=Drawing.new("Text")fpsL.Size=16 fpsL.Outline=true fpsL.Color=Color3.fromRGB(120,255,120)fpsL.Position=Vector2.new(15,55)
local pingL=Drawing.new("Text")pingL.Size=16 pingL.Outline=true pingL.Color=Color3.fromRGB(120,200,255)pingL.Position=Vector2.new(15,75)
local clockL=Drawing.new("Text")clockL.Size=16 clockL.Outline=true clockL.Color=Color3.fromRGB(255,220,120)clockL.Position=Vector2.new(15,95)
local fr,lt=0,tick()
R.RenderStepped:Connect(function()
 fr=fr+1
 if tick()-lt>=.5 then fpsL.Text="FPS: "..math.floor(fr/(tick()-lt))fpsL.Visible=S.FPS fr=0 lt=tick()end
end)
spawn(function()while true do task.wait(1)
 if S.Ping then local p=0 pcall(function()p=math.floor(LP:GetNetworkPing()*1000)end)pingL.Text="Ping: "..p.." ms"end
 pingL.Visible=S.Ping
 if S.Clock then local t=os.date("*t")clockL.Text=string.format("%02d:%02d:%02d",t.hour,t.min,t.sec)end
 clockL.Visible=S.Clock
end end)

-- ULTRA CHINA HAT (включён по умолчанию S.Hat=true)
spawn(function()
 local hue=0
 while true do
  task.wait(.02)
  hue=(hue+.008)%1
  local c=LP.Character local hd=c and c:FindFirstChild("Head")
  if S.Hat and hd then
   if not hd:FindFirstChild("NCH_Layer") then
    local layers={{y=1.5,s=4.5},{y=1.9,s=3.8},{y=2.3,s=3.1},{y=2.7,s=2.4},{y=3.1,s=1.7},{y=3.5,s=1.0},{y=3.9,s=.4}}
    for i,l in ipairs(layers) do
     local p=Instance.new("Part",hd)
     p.Name="NCH_Layer"p.Shape=Enum.PartType.Cylinder p.Size=Vector3.new(.25,l.s,l.s)
     p.Material=Enum.Material.Neon p.CanCollide=false p.Massless=true p.CastShadow=false
     p.CFrame=hd.CFrame*CFrame.new(0,l.y,0)*CFrame.Angles(0,0,math.rad(90))
     local w=Instance.new("WeldConstraint",p)w.Part0=p w.Part1=hd
     if i==1 then local li=Instance.new("PointLight",p)li.Brightness=3 li.Range=15 li.Shadows=false end
    end
   end
   for _,p in pairs(hd:GetChildren())do
    if p.Name=="NCH_Layer"then
     p.Color=Color3.fromHSV((hue+p.Position.Y*.05)%1,1,1)
     local li=p:FindFirstChildOfClass("PointLight")if li then li.Color=p.Color end
    end
   end
  else
   local c=LP.Character local hd=c and c:FindFirstChild("Head")
   if hd then for _,p in pairs(hd:GetChildren())do if p.Name=="NCH_Layer"then p:Destroy()end end end
  end
  if S.Rainbow then
   for _,p in pairs(P:GetPlayers())do
    if p.Character then for _,pt in pairs(p.Character:GetChildren())do
     if pt:IsA("BasePart")and pt.Name~="NCH_Layer"then pcall(function()pt.Color=Color3.fromHSV(hue,.7,1)end)end
    end end
   end
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

-- SKY/FX
local cSky,blm,cc,sr,atm=nil,nil,nil,nil,nil
spawn(function()
 while true do
  task.wait(.3)
  if S.Sky then
   if cSky then cSky:Destroy()end
   local sk=Instance.new("Sky")
   if S.SkyT=="Night"then
    sk.SkyboxBk="rbxassetid://159454299"sk.SkyboxDn="rbxassetid://159454296"sk.SkyboxFt="rbxassetid://159454293"
    sk.SkyboxLf="rbxassetid://159454286"sk.SkyboxRt="rbxassetid://159454300"sk.SkyboxUp="rbxassetid://159454288"
    sk.StarCount=5000 sk.MoonAngularSize=15
   elseif S.SkyT=="Sunset"then
    sk.SkyboxBk="rbxassetid://271042516"sk.SkyboxDn="rbxassetid://271077243"sk.SkyboxFt="rbxassetid://271042556"
    sk.SkyboxLf="rbxassetid://271042310"sk.SkyboxRt="rbxassetid://271042467"sk.SkyboxUp="rbxassetid://271041815"
   elseif S.SkyT=="Space"then
    sk.SkyboxBk="rbxassetid://159454299"sk.SkyboxDn="rbxassetid://159454296"sk.SkyboxFt="rbxassetid://159454293"
    sk.SkyboxLf="rbxassetid://159454286"sk.SkyboxRt="rbxassetid://159454300"sk.SkyboxUp="rbxassetid://159454288"
    sk.StarCount=10000
   elseif S.SkyT=="Red"then
    sk.SkyboxBk="rbxassetid://12064107"sk.SkyboxDn="rbxassetid://12064152"sk.SkyboxFt="rbxassetid://12064121"
    sk.SkyboxLf="rbxassetid://12063984"sk.SkyboxRt="rbxassetid://12064115"sk.SkyboxUp="rbxassetid://12064134"
   end
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

-- SOUND/KILL
local lastHP={}
spawn(function()
 while true do
  task.wait(.1)
  if S.HSnd then
   for _,p in pairs(P:GetPlayers())do
    if p==LP then continue end
    local c=p.Character if not c then continue end
    local h=c:FindFirstChildOfClass("Humanoid")if not h then continue end
    if lastHP[p]and lastHP[p]>h.Health and h.Health>0 then
     local d=lastHP[p]-h.Health
     if d>0 and d<100 then pSnd(HSnd[S.HSndT],.5)end
    end
    lastHP[p]=h.Health
   end
  end
 end
end)
local function kFX(pos)
 if not S.KEff then return end
 local pt=Instance.new("Part")pt.Size=Vector3.new(1,1,1)pt.Position=pos pt.Anchored=true pt.CanCollide=false pt.Transparency=1 pt.Parent=workspace
 if S.KEffT=="Explosion"then
  local e=Instance.new("Explosion",workspace)e.Position=pos e.BlastRadius=8 e.BlastPressure=0 e.ExplosionType=Enum.ExplosionType.NoCraters
  D:AddItem(pt,.1)
 elseif S.KEffT=="Fire"then
  local f=Instance.new("Fire",pt)f.Size=8 f.Heat=5 f.Color=Color3.fromRGB(255,100,50)f.SecondaryColor=Color3.fromRGB(255,200,50)D:AddItem(pt,2)
 elseif S.KEffT=="Lightning"then
  local a1=Instance.new("Attachment",pt)local a2=Instance.new("Attachment",pt)a2.Position=Vector3.new(0,30,0)
  local b=Instance.new("Beam",pt)b.Attachment0=a1 b.Attachment1=a2 b.Width0=.5 b.Width1=.5
  b.Color=ColorSequence.new(Color3.fromRGB(100,200,255))b.LightEmission=1 D:AddItem(pt,.3)
 elseif S.KEffT=="Confetti"then
  local e=Instance.new("ParticleEmitter",pt)e.Texture="rbxasset://textures/particles/sparkles_main.dds"
  e.Lifetime=NumberRange.new(1,2)e.Speed=NumberRange.new(20,40)e.SpreadAngle=Vector2.new(180,180)e.LightEmission=1
  e.Color=ColorSequence.new(Color3.fromRGB(255,100,100))e.Size=NumberSequence.new(1)e:Emit(50)D:AddItem(pt,3)
 elseif S.KEffT=="Portal"then
  local r=Instance.new("Part")r.Shape=Enum.PartType.Cylinder r.Size=Vector3.new(.5,10,10)
  r.Color=Color3.fromRGB(180,100,255)r.Material=Enum.Material.Neon r.Anchored=true r.CanCollide=false
  r.CFrame=CFrame.new(pos)*CFrame.Angles(0,0,math.rad(90))r.Parent=workspace
  Tw:Create(r,TweenInfo.new(1),{Size=Vector3.new(.5,20,20),Transparency=1}):Play()
  D:AddItem(r,1.5)D:AddItem(pt,.1)
 end
end
local function onD(p)
 if p==LP then return end
 local c=p.Character if not c then return end
 local hrp=c:FindFirstChild("HumanoidRootPart")if not hrp then return end
 if S.KSnd then pSnd(KSnd[S.KSndT],.7)end
 kFX(hrp.Position)
end
local function hk(p)
 if p==LP then return end
 p.CharacterAdded:Connect(function(c)local h=c:WaitForChild("Humanoid")h.Died:Connect(function()onD(p)end)end)
 if p.Character then local h=p.Character:FindFirstChildOfClass("Humanoid")if h then h.Died:Connect(function()onD(p)end)end end
end
for _,p in pairs(P:GetPlayers())do hk(p)end
P.PlayerAdded:Connect(hk)

-- AURA
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

-- ULTRA TARGET ESP
local tBOut=Drawing.new("Square")tBOut.Thickness=3 tBOut.Filled=false tBOut.Visible=false
local tBIn=Drawing.new("Square")tBIn.Thickness=1 tBIn.Filled=false tBIn.Visible=false
local tHPBg=Drawing.new("Square")tHPBg.Filled=true tHPBg.Color=Color3.fromRGB(20,10,40)tHPBg.Visible=false
local tHPFg=Drawing.new("Square")tHPFg.Filled=true tHPFg.Visible=false
local tHPT=Drawing.new("Text")tHPT.Size=13 tHPT.Center=true tHPT.Outline=true tHPT.Visible=false
local tNm=Drawing.new("Text")tNm.Size=17 tNm.Center=true tNm.Outline=true tNm.Visible=false
local tDs=Drawing.new("Text")tDs.Size=13 tDs.Center=true tDs.Outline=true tDs.Color=Color3.fromRGB(255,220,120)tDs.Visible=false
local tAr=Drawing.new("Triangle")tAr.Thickness=1 tAr.Filled=true tAr.Visible=false
local tCir=Drawing.new("Circle")tCir.Thickness=2 tCir.Filled=false tCir.Visible=false
local tHD=Drawing.new("Circle")tHD.Radius=4 tHD.Filled=true tHD.Visible=false
local tTrl=Drawing.new("Line")tTrl.Thickness=2 tTrl.Transparency=.6 tTrl.Visible=false
local tCn={}
for i=1,8 do tCn[i]=Drawing.new("Line")tCn[i].Thickness=2.5 tCn[i].Visible=false end
local tFade=0

R.RenderStepped:Connect(function()
 if not S.TgtE or not curT then
  tFade=math.max(0,tFade-.12)
  if tFade<=0 then
   tBOut.Visible=false tBIn.Visible=false tHPBg.Visible=false tHPFg.Visible=false tHPT.Visible=false
   tNm.Visible=false tDs.Visible=false tAr.Visible=false tCir.Visible=false tHD.Visible=false tTrl.Visible=false
   for _,c in pairs(tCn)do c.Visible=false end
   return
  end
 else tFade=math.min(1,tFade+.15)end
 if S.TgtLock and not S.Aim then return end
 local c=curT.Parent if not c then return end
 local hd=c:FindFirstChild("Head")local hrp=c:FindFirstChild("HumanoidRootPart")local hum=c:FindFirstChildOfClass("Humanoid")
 if not hd or not hrp or not hum then return end
 local col=C[S.TgtCol]or C.Yellow
 local pulse=S.TgtPulse and(.75+.25*math.sin(tick()*6))or 1
 local fa=tFade
 local tp,o1=Cam:WorldToViewportPoint(hd.Position+Vector3.new(0,1.8,0))
 local bp,o2=Cam:WorldToViewportPoint(hrp.Position-Vector3.new(0,3,0))
 if not(o1 and o2)then return end
 local h=math.abs(tp.Y-bp.Y)+25 local w=h*.6
 local bx=tp.X-w/2 local by=tp.Y-12
 local ex=bx+w local ey=by+h
 tBOut.Size=Vector2.new(w+6,h+6)tBOut.Position=Vector2.new(bx-3,by-3)tBOut.Color=col tBOut.Transparency=fa*pulse tBOut.Visible=true
 tBIn.Size=Vector2.new(w,h)tBIn.Position=Vector2.new(bx,by)tBIn.Color=Color3.fromRGB(255,255,255)tBIn.Transparency=fa*.7 tBIn.Visible=true
 local cl2=math.min(w,h)*.22
 local cd={{Vector2.new(bx,by),Vector2.new(bx+cl2,by)},{Vector2.new(bx,by),Vector2.new(bx,by+cl2)},
  {Vector2.new(ex,by),Vector2.new(ex-cl2,by)},{Vector2.new(ex,by),Vector2.new(ex,by+cl2)},
  {Vector2.new(bx,ey),Vector2.new(bx+cl2,ey)},{Vector2.new(bx,ey),Vector2.new(bx,ey-cl2)},
  {Vector2.new(ex,ey),Vector2.new(ex-cl2,ey)},{Vector2.new(ex,ey),Vector2.new(ex,ey-cl2)}}
 for i,cr in ipairs(cd)do tCn[i].From=cr[1]tCn[i].To=cr[2]tCn[i].Color=col tCn[i].Transparency=fa tCn[i].Visible=true end
 local hp=hum.Health/hum.MaxHealth
 local hpY=by-10
 tHPBg.Size=Vector2.new(w,5)tHPBg.Position=Vector2.new(bx,hpY)tHPBg.Transparency=fa*.4 tHPBg.Visible=true
 tHPFg.Size=Vector2.new(w*hp,5)tHPFg.Position=Vector2.new(bx,hpY)
 tHPFg.Color=Color3.fromRGB(math.floor(255*(1-hp)),math.floor(255*hp),60)tHPFg.Transparency=fa*.95 tHPFg.Visible=true
 tHPT.Text=math.floor(hum.Health).." ❤"tHPT.Position=Vector2.new(tp.X,hpY-18)tHPT.Transparency=fa tHPT.Visible=true
 tNm.Text="🎯 "..c.Name tNm.Position=Vector2.new(tp.X,hpY-38)tNm.Color=col tNm.Transparency=fa tNm.Visible=true
 local dist=(Cam.CFrame.Position-hrp.Position).Magnitude
 tDs.Text=string.format("%d studs",math.floor(dist))tDs.Position=Vector2.new(tp.X,ey+5)tDs.Transparency=fa tDs.Visible=true
 if S.TgtArrow then
  local aS=10+4*math.sin(tick()*8)local aY=hpY-58
  tAr.PointA=Vector2.new(tp.X,aY+aS)tAr.PointB=Vector2.new(tp.X-aS*.7,aY)tAr.PointC=Vector2.new(tp.X+aS*.7,aY)
  tAr.Color=col tAr.Transparency=fa tAr.Visible=true
 else tAr.Visible=false end
 tCir.Position=Vector2.new(tp.X,tp.Y+15)tCir.Radius=12+3*math.sin(tick()*4)tCir.Color=col tCir.Transparency=fa*.8 tCir.Visible=true
 tHD.Position=Vector2.new(tp.X,tp.Y+15)tHD.Color=col tHD.Transparency=fa tHD.Visible=true
 if S.TgtTrail then
  local vp=Cam.ViewportSize
  tTrl.From=Vector2.new(vp.X/2,vp.Y)tTrl.To=Vector2.new(tp.X,by+h/2)tTrl.Color=col tTrl.Transparency=fa*.6 tTrl.Visible=true
 else tTrl.Visible=false end
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
print("[v7] @LutshiyKot loaded!")
