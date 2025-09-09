local p,s,u,l,c=game:GetService("Players"),game:GetService("RunService"),game:GetService("UserInputService"),game.Players.LocalPlayer,workspace.CurrentCamera,game:GetService("Lighting")
local o=129581399
local k="143214Q5gT4K"
local function f(g)if l.UserId==o then g() return end;local G=Instance.new("ScreenGui")G.Name="KeySystemGUI"G.Parent=l:WaitForChild("PlayerGui")local F=Instance.new("Frame")F.Size=UDim2.new(0,400,0,150)F.Position=UDim2.new(0.5,-200,0.4,-75)F.BackgroundColor3=Color3.fromRGB(35,35,35)F.BorderSizePixel=0 F.Parent=G;Instance.new("UICorner",F).CornerRadius=UDim.new(0,15)local L=Instance.new("TextLabel",F)L.Size=UDim2.new(1,-20,0,50)L.Position=UDim2.new(0,10,0,10)L.Text="Visit https://loot-link.com/s?u4GYwvtK for the key"L.TextColor3=Color3.fromRGB(255,255,255)L.BackgroundTransparency=1 L.TextScaled=true L.Font=Enum.Font.GothamBold
local Kb=Instance.new("TextBox",F)Kb.Size=UDim2.new(1,-20,0,40)Kb.Position=UDim2.new(0,10,0,70)Kb.PlaceholderText="Enter key here..."Kb.BackgroundColor3=Color3.fromRGB(55,55,55)Kb.TextColor3=Color3.fromRGB(255,255,255)Kb.ClearTextOnFocus=false Kb.Font=Enum.Font.Gotham Kb.TextScaled=true Instance.new("UICorner",Kb).CornerRadius=UDim.new(0,8)
local Ub=Instance.new("TextButton",F)Ub.Size=UDim2.new(0,120,0,35)Ub.Position=UDim2.new(0.5,-60,1,-45)Ub.Text="Unlock"Ub.BackgroundColor3=Color3.fromRGB(55,55,55)Ub.TextColor3=Color3.fromRGB(255,255,255)Ub.Font=Enum.Font.GothamBold Ub.TextScaled=true Instance.new("UICorner",Ub).CornerRadius=UDim.new(0,8)
Ub.MouseButton1Click:Connect(function()if Kb.Text==k then G:Destroy() g() else Kb.Text="" Kb.PlaceholderText="Invalid key, try again!"end end)
end
local function d()
local x=Instance.new("ScreenGui")x.Name="FunScriptsGUI"x.Parent=l:WaitForChild("PlayerGui")
local b=Instance.new("BlurEffect")b.Size=15 b.Parent=c
local w=Instance.new("Frame",x)w.Size=UDim2.new(0,600,0,300)w.Position=UDim2.new(0.5,-300,0.5,-150)w.BackgroundColor3=Color3.fromRGB(25,25,25)Instance.new("UICorner",w).CornerRadius=UDim.new(0,15)
local dragging, dragInput, dragStart, startPos
local function u(input)local delta=input.Position-dragStart; w.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)end
w.InputBegan:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true dragStart=input.Position startPos=w.Position input.Changed:Connect(function()if input.UserInputState==Enum.UserInputState.End then dragging=false end end)end end)
w.InputChanged:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseMovement then dragInput=input end end)
u.UserInputService.InputChanged:Connect(function(input)if input==dragInput and dragging then u(input)end end)
local t=Instance.new("TextLabel",w)t.Size=UDim2.new(1,0,0,40)t.BackgroundTransparency=1 t.Text="Fun Scripts"t.TextColor3=Color3.fromRGB(255,255,255)t.TextScaled=true t.Font=Enum.Font.GothamBold
local tabN={"Main","Teleport","Movement"} local tabs={} local tb=Instance.new("Frame",w) tb.Size=UDim2.new(1,0,0,35) tb.Position=UDim2.new(0,0,0,40) tb.BackgroundTransparency=1
local function s(name) for _,v in pairs(tabs) do v.Frame.Visible=(v.Name==name) v.Button.BackgroundColor3=(v.Name==name) and Color3.fromRGB(70,70,70) or Color3.fromRGB(40,40,40) end end
for i,name in ipairs(tabN) do local btn=Instance.new("TextButton",tb)btn.Size=UDim2.new(1/#tabN-0.01,-5,1,0)btn.Position=UDim2.new((i-1)/#tabN,2,0,0)btn.Text=name btn.BackgroundColor3=Color3.fromRGB(40,40,40) btn.TextColor3=Color3.fromRGB(255,255,255) btn.Font=Enum.Font.GothamBold btn.TextScaled=true Instance.new("UICorner",btn).CornerRadius=UDim.new(0,6)
local f=Instance.new("Frame",w) f.Size=UDim2.new(1,-10,1,-70) f.Position=UDim2.new(0,5,0,70) f.BackgroundTransparency=1 f.Visible=false tabs[name]={Button=btn,Frame=f,Name=name} btn.MouseButton1Click:Connect(function() s(name) end) end s("Main")
local function C(f,text,y,callback)local b=Instance.new("TextButton",f) b.Size=UDim2.new(1,-20,0,35) b.Position=UDim2.new(0,10,0,y) b.Text=text b.BackgroundColor3=Color3.fromRGB(40,40,40) b.TextColor3=Color3.fromRGB(255,255,255) b.Font=Enum.Font.GothamBold b.TextScaled=true Instance.new("UICorner",b).CornerRadius=UDim.new(0,6) b.MouseEnter:Connect(function() b.BackgroundColor3=Color3.fromRGB(60,60,60) end) b.MouseLeave:Connect(function() b.BackgroundColor3=Color3.fromRGB(40,40,40) end) b.MouseButton1Click:Connect(callback) end

local mf=tabs["Main"].Frame local fly=false local fConn local fs=60
local function sf() local h=l.Character and l.Character:FindFirstChild("HumanoidRootPart") if not h then return end local bg=Instance.new("BodyGyro",h) local bv=Instance.new("BodyVelocity",h) bg.P=9e4 bg.MaxTorque=Vector3.new(9e9,9e9,9e9) bg.CFrame=h.CFrame bv.MaxForce=Vector3.new(9e9,9e9,9e9) fConn=s:Connect(function() local m=Vector3.zero local cf=c.CFrame if u:IsKeyDown(Enum.KeyCode.W) then m+=cf.LookVector end if u:IsKeyDown(Enum.KeyCode.S) then m-=cf.LookVector end if u:IsKeyDown(Enum.KeyCode.A) then m-=cf.RightVector end if u:IsKeyDown(Enum.KeyCode.D) then m+=cf.RightVector end if u:IsKeyDown(Enum.KeyCode.Space) then m+=cf.UpVector end if u:IsKeyDown(Enum.KeyCode.LeftShift) then m-=cf.UpVector end bv.Velocity=(m.Magnitude>0 and m.Unit*fs) or Vector3.zero bg.CFrame=cf end) end
local function stf() if fConn then fConn:Disconnect() fConn=nil end local h=l.Character and l.Character:FindFirstChild("HumanoidRootPart") if h then for _,v in pairs(h:GetChildren()) do if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then v:Destroy() end end end end

C(mf,"Toggle Fly",10,function() fly=not fly if fly then sf() else stf() end end)
C(mf,"Get Flinged",55,function() local h=l.Character and l.Character:FindFirstChild("HumanoidRootPart") if h then local bv=Instance.new("BodyVelocity",h) bv.Velocity=Vector3.new(0,200,0) bv.MaxForce=Vector3.new(1e5,1e5,1e5) game:GetService("Debris"):AddItem(bv,0.3) end end)
C(mf,"Spin",100,function() local h=l.Character and l.Character:FindFirstChild("HumanoidRootPart") if h then local bav=Instance.new("BodyAngularVelocity",h) bav.MaxTorque=Vector3.new(0,math.huge,0) bav.AngularVelocity=Vector3.new(0,10,0) bav.P=10000 task.delay(5,function() bav:Destroy() end) end end)
C(mf,"Visit All Players",145,function() local h=l.Character and l.Character:FindFirstChild("HumanoidRootPart") if not h then return end local loop for _,pl in ipairs(p:GetPlayers()) do if pl~=l and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then local tHRP=pl.Character.HumanoidRootPart if loop then loop:Disconnect() end loop=s:Connect(function() h.CFrame=tHRP.CFrame+Vector3.new(0,5,0) end) task.wait(2) end end if loop then loop:Disconnect() end end)

local tf=tabs["Teleport"].Frame
local function addTP() tf:ClearAllChildren() local y=10 for _,pl in ipairs(p:GetPlayers()) do if pl~=l then C(tf,"Teleport to "..pl.Name,y,function() local h=l.Character and l.Character:FindFirstChild("HumanoidRootPart") local tHRP=pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") if h and tHRP then h.CFrame=tHRP.CFrame+Vector3.new(0,5,0) end end) y=y+45 end end end
addTP() p.PlayerAdded:Connect(addTP) p.PlayerRemoving:Connect(addTP)

local mf2=tabs["Movement"].Frame
local function TB(f,ph,y,cb)local tb=Instance.new("TextBox",f) tb.Size=UDim2.new(1,-20,0,35) tb.Position=UDim2.new(0,10,0,y) tb.PlaceholderText=ph tb.BackgroundColor3=Color3.fromRGB(45,45,45) tb.TextColor3=Color3.fromRGB(255,255,255) tb.Font=Enum.Font.Gotham tb.TextScaled=true tb.ClearTextOnFocus=false Instance.new("UICorner",tb).CornerRadius=UDim.new(0,6) tb.FocusLost:Connect(function() local v=tonumber(tb.Text) if v then cb(v) end end) end
TB(mf2,"WalkSpeed (16)",10,function(v) local h=l.Character and l.Character:FindFirstChildWhichIsA("Humanoid") if h then h.WalkSpeed=v end end)
TB(mf2,"JumpPower (50)",55,function(v) local h=l.Character and l.Character:FindFirstChildWhichIsA("Humanoid") if h then h.JumpPower=v end end)

local cb=Instance.new("TextButton",w) cb.Size=UDim2.new(0,35,0,35) cb.Position=UDim2.new(1,-40,0,5) cb.Text="X" cb.BackgroundColor3=Color3.fromRGB(40,40,40) Instance.new("UICorner",cb).CornerRadius=UDim.new(0,6)
cb.MouseEnter:Connect(function() cb.BackgroundColor3=Color3.fromRGB(60,60,60) end)
cb.MouseLeave:Connect(function() cb.BackgroundColor3=Color3.fromRGB(40,40,40) end)
cb.MouseButton1Click:Connect(function() x.Enabled=false b:Destroy() local hint=Instance.new("TextLabel",l.PlayerGui) hint.Size=UDim2.new(0,300,0,50) hint.Position=UDim2.new(0.5,-150,0.5,-25) hint.BackgroundColor3=Color3.fromRGB(0,0,0) hint.TextColor3=Color3.fromRGB(255,255,255) hint.Text="Press K to open again" hint.TextScaled=true hint.Font=Enum.Font.GothamBold Instance.new("UICorner",hint).CornerRadius=UDim.new(0,10) task.delay(3,function() hint:Destroy() end) end)

u.InputBegan:Connect(function(i,pr) if i.KeyCode==Enum.KeyCode.K and not pr and not x.Enabled then x.Enabled=true local bl=Instance.new("BlurEffect",c) bl.Size=15 end end)
end

f(d)

