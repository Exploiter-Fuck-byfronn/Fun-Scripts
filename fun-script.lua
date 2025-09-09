local a,b,c,d=game:GetService("Players"),game:GetService("RunService"),game:GetService("UserInputService"),workspace.CurrentCamera
local e=a.LocalPlayer
local f=12958136

local function g(h)
    if e.UserId==f then h() return end
    local i=Instance.new("ScreenGui")
    i.Parent=e:WaitForChild("PlayerGui")
    local j=Instance.new("Frame")
    j.Size=UDim2.new(0,400,0,150)
    j.Position=UDim2.new(0.5,-200,0.4,-75)
    j.BackgroundColor3=Color3.fromRGB(35,35,35)
    j.BorderSizePixel=0
    j.Parent=i
    Instance.new("UICorner",j).CornerRadius=UDim.new(0,15)
    local k=Instance.new("TextLabel")
    k.Size=UDim2.new(1,-20,0,50)
    k.Position=UDim2.new(0,10,0,10)
    k.TextColor3=Color3.fromRGB(255,255,255)
    k.BackgroundTransparency=1
    k.TextScaled=true
    k.Font=Enum.Font.GothamBold
    k.Text="Visit https://loot-link.com/s?u4GYwvtK for the key"
    k.Parent=j
    local l=Instance.new("TextBox")
    l.Size=UDim2.new(1,-20,0,40)
    l.Position=UDim2.new(0,10,0,70)
    l.PlaceholderText="Enter key here..."
    l.BackgroundColor3=Color3.fromRGB(55,55,55)
    l.TextColor3=Color3.fromRGB(255,255,255)
    l.ClearTextOnFocus=false
    l.TextScaled=true
    l.Font=Enum.Font.Gotham
    l.Parent=j
    Instance.new("UICorner",l).CornerRadius=UDim.new(0,8)
    local m=Instance.new("TextButton")
    m.Size=UDim2.new(0,120,0,35)
    m.Position=UDim2.new(0.5,-60,1,-45)
    m.Text="Unlock"
    m.BackgroundColor3=Color3.fromRGB(55,55,55)
    m.TextColor3=Color3.fromRGB(255,255,255)
    m.TextScaled=true
    m.Font=Enum.Font.Gotham
    m.Parent=j
    Instance.new("UICorner",m).CornerRadius=UDim.new(0,8)
    m.MouseButton1Click:Connect(function()
        if l.Text=="143214Q5gT4K" then
            i:Destroy()
            h()
        else
            l.Text=""
            l.PlaceholderText="Invalid key, try again!"
        end
    end)
end

local function n(o)
    local p,q,r,s
    local function t(u)
        local v=u.Position-r
        o.Position=UDim2.new(s.X.Scale,s.X.Offset+v.X,s.Y.Scale,s.Y.Offset+v.Y)
    end
    o.InputBegan:Connect(function(u)
        if u.UserInputType==Enum.UserInputType.MouseButton1 then
            p=true
            r=u.Position
            s=o.Position
            u.Changed:Connect(function()
                if u.UserInputState==Enum.UserInputState.End then p=false end
            end)
        end
    end)
    o.InputChanged:Connect(function(u)
        if u.UserInputType==Enum.UserInputType.MouseMovement then q=u end
    end)
    d.InputChanged:Connect(function(u)
        if u==q and p then t(u) end
    end)
end

local function w()
    local x=Instance.new("ScreenGui")
    x.Parent=e:WaitForChild("PlayerGui")
    local y=Instance.new("BlurEffect")
    y.Size=25
    y.Parent=game.Lighting
    local z=Instance.new("Frame")
    z.Size=UDim2.new(0,700,0,400)
    z.Position=UDim2.new(0.5,-350,0.5,-200)
    z.BackgroundColor3=Color3.fromRGB(20,20,20)
    z.BorderSizePixel=0
    z.Parent=x
    Instance.new("UICorner",z).CornerRadius=UDim.new(0,15)
    n(z)
    local A=Instance.new("TextLabel")
    A.Size=UDim2.new(1,0,0,50)
    A.BackgroundTransparency=1
    A.Text="Fun Scripts"
    A.TextColor3=Color3.fromRGB(255,255,255)
    A.TextScaled=true
    A.Font=Enum.Font.GothamBold
    A.Parent=z
    local B={"Main","Teleport","Movement"}
    local C={}
    local D=Instance.new("Frame")
    D.Size=UDim2.new(1,0,0,35)
    D.Position=UDim2.new(0,0,0,50)
    D.BackgroundTransparency=1
    D.Parent=z
    local function E(F)
        for _,G in pairs(C) do
            G.F.Visible=(G.N==F)
            if G.N==F then G.B.BackgroundColor3=Color3.fromRGB(50,50,50)
            else G.B.BackgroundColor3=Color3.fromRGB(35,35,35) end
        end
    end
    for i,H in ipairs(B) do
        local I=Instance.new("TextButton")
        I.Size=UDim2.new(1/#B-0.01,-5,1,0)
        I.Position=UDim2.new((i-1)/#B,2,0,0)
        I.Text=H
        I.BackgroundColor3=Color3.fromRGB(35,35,35)
        I.TextColor3=Color3.fromRGB(255,255,255)
        I.Font=Enum.Font.Gotham
        I.TextScaled=true
        I.Parent=D
        Instance.new("UICorner",I).CornerRadius=UDim.new(0,6)
        local J=Instance.new("Frame")
        J.Size=UDim2.new(1,-10,1,-100)
        J.Position=UDim2.new(0,5,0,80)
        J.BackgroundTransparency=1
        J.Parent=z
        J.Visible=false
        C[H]={B=I,F=J,N=H}
        I.MouseButton1Click:Connect(function() E(H) end)
    end
    E("Main")

    local function K(L,M,N)
        local O=Instance.new("TextButton")
        O.Size=UDim2.new(1,-20,0,40)
        O.Position=UDim2.new(0,10,0,M)
        O.Text=L
        O.BackgroundColor3=Color3.fromRGB(45,45,45)
        O.TextColor3=Color3.fromRGB(255,255,255)
        O.Font=Enum.Font.Gotham
        O.TextScaled=true
        O.Parent=N
        Instance.new("UICorner",O).CornerRadius=UDim.new(0,8)
        O.MouseEnter:Connect(function() O.BackgroundColor3=Color3.fromRGB(60,60,60) end)
        O.MouseLeave:Connect(function() O.BackgroundColor3=Color3.fromRGB(45,45,45) end)
        return O
    end

    local P=C["Main"].F
    local Q=false
    local R
    local S=60
    local function T()
        local U=e.Character and e.Character:FindFirstChild("HumanoidRootPart")
        if not U then return end
        local V=Instance.new("BodyGyro",U)
        local W=Instance.new("BodyVelocity",U)
        V.P=9e4
        V.MaxTorque=Vector3.new(9e9,9e9,9e9)
        V.CFrame=U.CFrame
        W.MaxForce=Vector3.new(9e9,9e9,9e9)
        R=c.RenderStepped:Connect(function()
            local X=Vector3.zero
            local Y=d.CFrame
            if b:IsKeyDown(Enum.KeyCode.W) then X+=Y.LookVector end
            if b:IsKeyDown(Enum.KeyCode.S) then X-=Y.LookVector end
            if b:IsKeyDown(Enum.KeyCode.A) then X-=Y.RightVector end
            if b:IsKeyDown(Enum.KeyCode.D) then X+=Y.RightVector end
            if b:IsKeyDown(Enum.KeyCode.Space) then X+=Y.UpVector end
            if b:IsKeyDown(Enum.KeyCode.LeftShift) then X-=Y.UpVector end
            W.Velocity=X.Magnitude>0 and X.Unit*S or Vector3.zero
            V.CFrame=Y
        end)
    end
    local function Y()
        if R then R:Disconnect() R=nil end
        local Z=e.Character and e.Character:FindFirstChild("HumanoidRootPart")
        if Z then for _,_ in pairs(Z:GetChildren()) do if _:IsA("BodyGyro") or _:IsA("BodyVelocity") then _:Destroy() end end end
    end

    local aa=K("Toggle Fly",10,P)
    aa.MouseButton1Click:Connect(function() Q=not Q if Q then T() else Y() end end)

    local ab=K("Get Flinged",60,P)
    ab.MouseButton1Click:Connect(function()
        local ac=e.Character and e.Character:FindFirstChild("HumanoidRootPart")
        if ac then
            local ad=Instance.new("BodyVelocity",ac)
            ad.Velocity=Vector3.new(0,200,0)
            ad.MaxForce=Vector3.new(1e5,1e5,1e5)
            game:GetService("Debris"):AddItem(ad,0.3)
        end
    end)

    local ae=K("Spin",110,P)
    ae.MouseButton1Click:Connect(function()
        local af=e.Character and e.Character:FindFirstChild("HumanoidRootPart")
        if af then
            local ag=Instance.new("BodyAngularVelocity",af)
            ag.MaxTorque=Vector3.new(0,math.huge,0)
            ag.AngularVelocity=Vector3.new(0,10,0)
            ag.P=10000
            task.delay(5,function() ag:Destroy() end)
        end
    end)
end

g(w)
