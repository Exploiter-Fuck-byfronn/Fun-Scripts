local P=game:GetService("Players")local R=game:GetService("RunService")local U=game:GetService("UserInputService")local LP=P.LocalPlayer local C=workspace.CurrentCamera

local function drag(f)
 local d,i,s,p
 local function u(inp)
  local del=inp.Position-s
  f.Position=UDim2.new(p.X.Scale,p.X.Offset+del.X,p.Y.Scale,p.Y.Offset+del.Y)
 end
 f.InputBegan:Connect(function(inp)
  if inp.UserInputType==Enum.UserInputType.MouseButton1 then d=true s=inp.Position p=f.Position inp.Changed:Connect(function()if inp.UserInputState==Enum.UserInputState.End then d=false end end)end end)
 f.InputChanged:Connect(function(inp)if inp.UserInputType==Enum.UserInputType.MouseMovement then i=inp end end)
 U.InputChanged:Connect(function(inp)if inp==i and d then u(inp)end end)
end

local gui=Instance.new("ScreenGui",LP:WaitForChild("PlayerGui"))
local blur=Instance.new("BlurEffect",game.Lighting)blur.Size=15

local win=Instance.new("Frame",gui)win.Size=UDim2.new(0,600,0,400)win.Position=UDim2.new(0.5,-300,0.5,-200)win.BackgroundColor3=Color3.fromRGB(20,20,20)Instance.new("UICorner",win).CornerRadius=UDim.new(0,15)drag(win)

local title=Instance.new("TextLabel",win)title.Size=UDim2.new(1,0,0,50)title.BackgroundTransparency=1 title.Text="Fun Scripts" title.Font=Enum.Font.GothamBold title.TextScaled=true title.TextColor3=Color3.new(1,1,1)

local tabNames={"Main","Teleport","Movement"}local tabs={}local bar=Instance.new("Frame",win)bar.Size=UDim2.new(1,0,0,35)bar.Position=UDim2.new(0,0,0,50)bar.BackgroundTransparency=1

local function selectTab(n)
 for _,v in pairs(tabs)do v.F.Visible=(v.N==n)if v.N==n then v.B.BackgroundColor3=Color3.fromRGB(70,70,70)else v.B.BackgroundColor3=Color3.fromRGB(50,50,50)end end end

for i,n in ipairs(tabNames)do
 local b=Instance.new("TextButton",bar)b.Size=UDim2.new(1/#tabNames-0.01,-5,1,0)b.Position=UDim2.new((i-1)/#tabNames,2,0,0)b.Text=n b.BackgroundColor3=Color3.fromRGB(50,50,50)b.TextColor3=Color3.new(1,1,1)b.Font=Enum.Font.GothamBold b.TextScaled=true Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
 local f=Instance.new("Frame",win)f.Size=UDim2.new(1,-10,1,-100)f.Position=UDim2.new(0,5,0,80)f.BackgroundTransparency=1 f.Visible=false tabs[n]={B=b,F=f,N=n} b.MouseButton1Click:Connect(function()selectTab(n)end)
end
selectTab("Main")

local function btn(p,text,y,cb)local b=Instance.new("TextButton",p)b.Size=UDim2.new(1,-20,0,40)b.Position=UDim2.new(0,10,0,y)b.Text=text b.BackgroundColor3=Color3.fromRGB(35,35,35) b.TextColor3=Color3.new(1,1,1) b.Font=Enum.Font.Gotham b.TextScaled=true Instance.new("UICorner",b).CornerRadius=UDim.new(0,8) b.MouseEnter:Connect(function()b.BackgroundColor3=Color3.fromRGB(50,50,50)end) b.MouseLeave:Connect(function()b.BackgroundColor3=Color3.fromRGB(35,35,35)end) b.MouseButton1Click:Connect(cb)end

-- Main tab controls
local MF=tabs.Main.F local flying=false local fc speed=60 local flyC
local function startF()local hr=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") if not hr then return end local bg=Instance.new("BodyGyro",hr) local bv=Instance.new("BodyVelocity",hr) bg.P=9e4 bg.MaxTorque=Vector3.new(9e9,9e9,9e9) bg.CFrame=hr.CFrame bv.MaxForce=Vector3.new(9e9,9e9,9e9) flyC=R.RenderStepped:Connect(function() local m=Vector3.zero local cf=C.CFrame if U:IsKeyDown(Enum.KeyCode.W)then m+=cf.LookVector end if U:IsKeyDown(Enum.KeyCode.S)then m-=cf.LookVector end if U:IsKeyDown(Enum.KeyCode.A)then m-=cf.RightVector end if U:IsKeyDown(Enum.KeyCode.D)then m+=cf.RightVector end if U:IsKeyDown(Enum.KeyCode.Space)then m+=cf.UpVector end if U:IsKeyDown(Enum.KeyCode.LeftShift)then m-=cf.UpVector end bv.Velocity=m.Magnitude>0 and m.Unit*speed or Vector3.zero bg.CFrame=cf end)end
local function stopF()if flyC then flyC:Disconnect() flyC=nil end local hr=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") if hr then for _,v in pairs(hr:GetChildren())do if v:IsA("BodyGyro")or v:IsA("BodyVelocity")then v:Destroy()end end end end
btn(MF,"Toggle Fly",10,function()flying=not flying if flying then startF() else stopF()end end)
btn(MF,"Get Flinged",60,function()local hr=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") if hr then local bv=Instance.new("BodyVelocity",hr) bv.Velocity=Vector3.new(0,200,0) bv.MaxForce=Vector3.new(1e5,1e5,1e5) game:GetService("Debris"):AddItem(bv,0.3)end end)
btn(MF,"Spin",110,function()local hr=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") if hr then local bav=Instance.new("BodyAngularVelocity",hr) bav.MaxTorque=Vector3.new(0,math.huge,0) bav.AngularVelocity=Vector3.new(0,10,0) bav.P=10000 task.delay(5,function()bav:Destroy()end)end end)

-- Teleport tab
local TF=tabs.Teleport.F local function addTP()TF:ClearAllChildren() local y=10 for _,p in ipairs(P:GetPlayers())do if p~=LP then btn(TF,"Teleport to "..p.Name,y,function()local hr=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") local tHR=p.Character and p.Character:FindFirstChild("HumanoidRootPart") if hr and tHR then hr.CFrame=tHR.CFrame+Vector3.new(0,5,0)end end) y=y+50 end end end addTP() P.PlayerAdded:Connect(addTP) P.PlayerRemoving:Connect(addTP)

-- Movement tab
local MF2=tabs.Movement.F local function txt(p,pl,y,cb)local tb=Instance.new("TextBox",p) tb.Size=UDim2.new(1,-20,0,40) tb.Position=UDim2.new(0,10,0,y) tb.PlaceholderText=pl tb.BackgroundColor3=Color3.fromRGB(35,35,35) tb.TextColor3=Color3.new(1,1,1) tb.Font=Enum.Font.Gotham tb.TextScaled=true tb.ClearTextOnFocus=false Instance.new("UICorner",tb).CornerRadius=UDim.new(0,8) tb.FocusLost:Connect(function()local v=tonumber(tb.Text) if v then cb(v)end end) end
txt(MF2,"WalkSpeed (16)",10,function(v)local h=LP.Character and LP.Character:FindFirstChildWhichIsA("Humanoid") if h then h.WalkSpeed=v end end)
txt(MF2,"JumpPower (50)",60,function(v)local h=LP.Character and LP.Character:FindFirstChildWhichIsA("Humanoid") if h then h.JumpPower=v end end)

-- Close button
local cb=Instance.new("TextButton",win) cb.Size=UDim2.new(0,50,0,30) cb.Position=UDim2.new(1,-55,0,5) cb.Text="X" cb.BackgroundColor3=Color3.fromRGB(35,35,35) cb.TextColor3=Color3.new(1,1,1) cb.Font=Enum.Font.GothamBold cb.TextScaled=true Instance.new("UICorner",cb).CornerRadius=UDim.new(0,5)
cb.MouseEnter:Connect(function()cb.BackgroundColor3=Color3.fromRGB(50,50,50)end) cb.MouseLeave:Connect(function()cb.BackgroundColor3=Color3.fromRGB(35,35,35)end) cb.MouseButton1Click:Connect(function() gui.Enabled=false blur:Destroy() local t=Instance.new("TextLabel",LP:WaitForChild("PlayerGui")) t.Size=UDim2.new(0,300,0,50) t.Position=UDim2.new(0.5,-150,0.5,-25) t.Text="Press K to open again" t.TextColor3=Color3.new(1,1,1) t.BackgroundTransparency=0.5 t.BackgroundColor3=Color3.fromRGB(0,0,0) t.Font=Enum.Font.GothamBold t.TextScaled=true task.delay(3,function()t:Destroy()end) end)

U.InputBegan:Connect(function(i,g)if not g and i.KeyCode==Enum.KeyCode.K then gui.Enabled=true blur=Instance.new("BlurEffect",game.Lighting) blur.Size=15 end end)
