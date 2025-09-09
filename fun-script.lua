
local P,S,U,L,C=game:GetService("Players"),game:GetService("RunService"),game:GetService("UserInputService"),game.Players.LocalPlayer,workspace.CurrentCamera


local OWNER_ID=12958136

local function initGUI()
  
    local g=Instance.new("ScreenGui",L:WaitForChild("PlayerGui"))
    g.Name="FunScriptsGUI"
    local b=Instance.new("Frame",g)
    b.Size=UDim2.new(0.8,0,0.6,0); b.Position=UDim2.new(0.1,0,0.2,0)
    b.BackgroundColor3=Color3.fromRGB(20,20,20); local bc=Instance.new("UICorner",b); bc.CornerRadius=UDim.new(0,15)
    b.ClipsDescendants=true
    local blur=Instance.new("BlurEffect",game:GetService("Lighting")); blur.Size=15
    local title=Instance.new("TextLabel",b); title.Size=UDim2.new(1,0,0,40); title.Text="Fun Scripts"; title.Font=Enum.Font.GothamBold; title.TextScaled=true; title.TextColor3=Color3.fromRGB(255,255,255); title.BackgroundTransparency=1

    -- Tabs
    local tabs={Main={},Teleport={},Movement={}}; local tabNames={"Main","Teleport","Movement"}
    local bar=Instance.new("Frame",b); bar.Size=UDim2.new(1,0,0,35); bar.Position=UDim2.new(0,0,0,40); bar.BackgroundTransparency=1
    local function sel(n)
        for k,v in pairs(tabs) do v.Frame.Visible=(k==n); v.Button.BackgroundColor3=(k==n and Color3.fromRGB(45,45,45) or Color3.fromRGB(35,35,35)) end
    end
    for i,nm in ipairs(tabNames) do
        local btn=Instance.new("TextButton",bar); btn.Size=UDim2.new(1/#tabNames-0.01,-5,1,0); btn.Position=UDim2.new((i-1)/#tabNames,2,0,0); btn.Text=nm; btn.Font=Enum.Font.Gotham; btn.TextScaled=true; btn.BackgroundColor3=Color3.fromRGB(35,35,35); btn.TextColor3=Color3.fromRGB(255,255,255); local c=Instance.new("UICorner",btn); c.CornerRadius=UDim.new(0,6)
        local f=Instance.new("Frame",b); f.Size=UDim2.new(1,-10,1,-80); f.Position=UDim2.new(0,5,0,80); f.BackgroundTransparency=1; f.Visible=false
        tabs[nm]={Button=btn,Frame=f}
        btn.MouseButton1Click:Connect(function() sel(nm) end)
    end
    sel("Main")

    local function cb(p,t,y,fn) local bt=Instance.new("TextButton",p); bt.Size=UDim2.new(1,-20,0,35); bt.Position=UDim2.new(0,10,0,y); bt.Text=t; bt.BackgroundColor3=Color3.fromRGB(50,50,50); local c=Instance.new("UICorner",bt); c.CornerRadius=UDim.new(0,8); bt.TextColor3=Color3.fromRGB(255,255,255); bt.Font=Enum.Font.Gotham; bt.TextScaled=true; bt.MouseEnter:Connect(function() bt.BackgroundColor3=Color3.fromRGB(65,65,65) end); bt.MouseLeave:Connect(function() bt.BackgroundColor3=Color3.fromRGB(50,50,50) end); bt.MouseButton1Click:Connect(fn) end

    -- Main Tab
    local mf=tabs.Main.Frame
    local fly=false; local fc; local spd=60
    local function startFly() local h=L.Character and L.Character:FindFirstChild("HumanoidRootPart"); if not h then return end; local bg=Instance.new("BodyGyro",h); local bv=Instance.new("BodyVelocity",h); bg.P=9e4; bg.MaxTorque=Vector3.new(9e9,9e9,9e9); bg.CFrame=h.CFrame; bv.MaxForce=Vector3.new(9e9,9e9,9e9); fc=S.RenderStepped:Connect(function() local m=Vector3.zero; local cf=C.CFrame; if U:IsKeyDown(Enum.KeyCode.W)then m+=cf.LookVector end;if U:IsKeyDown(Enum.KeyCode.S)then m-=cf.LookVector end;if U:IsKeyDown(Enum.KeyCode.A)then m-=cf.RightVector end;if U:IsKeyDown(Enum.KeyCode.D)then m+=cf.RightVector end;if U:IsKeyDown(Enum.KeyCode.Space)then m+=cf.UpVector end;if U:IsKeyDown(Enum.KeyCode.LeftShift)then m-=cf.UpVector end; bv.Velocity=(m.Magnitude>0 and m.Unit*spd or Vector3.zero); bg.CFrame=cf end) end
    local function stopFly() if fc then fc:Disconnect() end; local h=L.Character and L.Character:FindFirstChild("HumanoidRootPart"); if h then for _,v in pairs(h:GetChildren())do if v:IsA("BodyGyro")or v:IsA("BodyVelocity")then v:Destroy()end end end end
    cb(mf,"Toggle Fly",10,function() fly=not fly; if fly then startFly()else stopFly()end end)
    cb(mf,"Get Flinged",55,function() local h=L.Character and L.Character:FindFirstChild("HumanoidRootPart"); if h then local bv=Instance.new("BodyVelocity",h); bv.Velocity=Vector3.new(0,200,0); bv.MaxForce=Vector3.new(1e5,1e5,1e5); game:GetService("Debris"):AddItem(bv,0.3)end end)
    cb(mf,"Spin",100,function() local h=L.Character and L.Character:FindFirstChild("HumanoidRootPart"); if h then local bav=Instance.new("BodyAngularVelocity",h); bav.MaxTorque=Vector3.new(0,math.huge,0); bav.AngularVelocity=Vector3.new(0,10,0); bav.P=1e4; task.delay(5,function() bav:Destroy()end) end end)
    
    cb(mf,"Visit All Players",145,function()
        local h=L.Character and L.Character:FindFirstChild("HumanoidRootPart"); if not h then return end
        local cur
        for _,p in ipairs(P:GetPlayers()) do
            if p~=L and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
                local t=p.Character.HumanoidRootPart
                if cur then cur:Disconnect() end
                cur=S.RenderStepped:Connect(function() h.CFrame=t.CFrame+Vector3.new(0,5,0) end)
                task.wait(1.5)
            end
        end
        if cur then cur:Disconnect() end
    end)

    local tf=tabs.Teleport.Frame
    local function addTP() tf:ClearAllChildren(); local y=10; for _,p in ipairs(P:GetPlayers())do if p~=L then cb(tf,"Teleport to "..p.Name,y,function() local h=L.Character and L.Character:FindFirstChild("HumanoidRootPart"); local t=p.Character and p.Character:FindFirstChild("HumanoidRootPart"); if h and t then h.CFrame=t.CFrame+Vector3.new(0,5,0)end end); y=y+45 end end
    addTP(); P.PlayerAdded:Connect(addTP); P.PlayerRemoving:Connect(addTP)


    local mf2=tabs.Movement.Frame
    local function addBox(p,ph,y,fn) local tb=Instance.new("TextBox",p); tb.Size=UDim2.new(1,-20,0,35); tb.Position=UDim2.new(0,10,0,y); tb.PlaceholderText=ph; tb.BackgroundColor3=Color3.fromRGB(60,60,60); tb.TextColor3=Color3.fromRGB(255,255,255); local c=Instance.new("UICorner",tb); c.CornerRadius=UDim.new(0,6); tb.Font=Enum.Font.Gotham; tb.TextScaled=true; tb.ClearTextOnFocus=false; tb.FocusLost:Connect(function() local v=tonumber(tb.Text); if v then fn(v)end end) end
    addBox(mf2,"WalkSpeed",10,function(v) local h=L.Character and L.Character:FindFirstChildWhichIsA("Humanoid"); if h then h.WalkSpeed=v end end)
    addBox(mf2,"JumpPower",55,function(v) local h=L.Character and L.Character:FindFirstChildWhichIsA("Humanoid"); if h then h.JumpPower=v end)
        -- Close button
    cb(b,"Close GUI",0,function() g.Enabled=false; blur:Destroy(); local tk=Instance.new("TextLabel",L:WaitForChild("PlayerGui")); tk.Size=UDim2.new(0.3,0,0.05,0); tk.Position=UDim2.new(0.35,0,0.95,0); tk.Text="Press K to open again"; tk.BackgroundTransparency=0.5; tk.BackgroundColor3=Color3.fromRGB(0,0,0); tk.TextColor3=Color3.fromRGB(255,255,255); task.delay(3,function() tk:Destroy() end) end)

 
    U.InputBegan:Connect(function(i,gp) if i.KeyCode==Enum.KeyCode.K and not g.Enabled then g.Enabled=true; blur=Instance.new("BlurEffect",game:GetService("Lighting")); blur.Size=15 end end)
end


if L.UserId~=OWNER_ID then
    local keyGui=Instance.new("ScreenGui",L:WaitForChild("PlayerGui"))
    local f=Instance.new("Frame",keyGui); f.Size=UDim2.new(0,400,0,150); f.Position=UDim2.new(0.5,-200,0.4,-75); f.BackgroundColor3=Color3.fromRGB(30,30,30); f.BorderSizePixel=0; local c=Instance.new("UICorner",f); c.CornerRadius=UDim.new(0,15)
    local label=Instance.new("TextLabel",f); label.Size=UDim2.new(1,-20,0,50); label.Position=UDim2.new(0,10,0,10); label.Text="Visit https://loot-link.com/s?u4GYwvtK for the key"; label.TextColor3=Color3.fromRGB(255,255,255); label.TextScaled=true; label.Font=Enum.Font.GothamBold; label.BackgroundTransparency=1
    local tb=Instance.new("TextBox",f); tb.Size=UDim2.new(1,-20,0,40); tb.Position=UDim2.new(0,10,0,70); tb.PlaceholderText="Enter key"; tb.Text=""; tb.BackgroundColor3=Color3.fromRGB(50,50,50); tb.TextColor3=Color3.fromRGB(255,255,255); local c2=Instance.new("UICorner",tb); c2.CornerRadius=UDim.new(0,8)
    local btn=Instance.new("TextButton",f); btn.Size=UDim2.new(0,120,0,35); btn.Position=UDim2.new(0.5,-60,1,-45); btn.Text="Unlock"; btn.BackgroundColor3=Color3.fromRGB(50,50,50); btn.TextColor3=Color3.fromRGB(255,255,255); local c3=Instance.new("UICorner",btn); c3.CornerRadius=UDim.new(0,8); btn.Font=Enum.Font.Gotham; btn.TextScaled=true
    btn.MouseButton1Click:Connect(function() if tb.Text=="143214Q5gT4K" then keyGui:Destroy(); initGUI() else tb.Text=""; tb.PlaceholderText="Invalid key!" end end)
else
    initGUI()
end
