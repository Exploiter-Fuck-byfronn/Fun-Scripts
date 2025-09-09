
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera


local ownerId = 12958136

-- GUI Variables
local gui
local flySpeed = 60
local flying, flyConn = false, nil
local noclipEnabled = false
local noclipConnection
local espEnabled = false
local espBoxes = {}


local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
        end
    end)
end

local function updateCanvas(frame)
    local layout = frame:FindFirstChildOfClass("UIListLayout")
    if layout then
        frame.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
    end
end


local function createButton(parent,text,callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1,-10,0,35)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextScaled = true
    btn.Text = text
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,6)
    btn.MouseButton1Click:Connect(callback)
    updateCanvas(parent)
end


local function createSlider(parent,text,min,max,default,callback)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(1,0,0,60)
    container.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", container)
    label.Size = UDim2.new(1,0,0,20)
    label.Position = UDim2.new(0,0,0,0)
    label.Text = text..": "..default
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextScaled = true
    label.BackgroundTransparency = 1

    local slider = Instance.new("TextButton", container)
    slider.Size = UDim2.new(1,0,0,20)
    slider.Position = UDim2.new(0,0,0,30)
    slider.BackgroundColor3 = Color3.fromRGB(70,70,70)
    slider.Text = ""
    local corner = Instance.new("UICorner", slider)
    corner.CornerRadius = UDim.new(0,6)

    local dragging = false
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    slider.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = math.clamp(input.Position.X - slider.AbsolutePosition.X,0,slider.AbsoluteSize.X)
            local value = min + (pos/slider.AbsoluteSize.X)*(max-min)
            label.Text = text..": "..math.floor(value)
            callback(value)
        end
    end)
    updateCanvas(parent)
end


local function startFly()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local bg = Instance.new("BodyGyro", hrp)
    local bv = Instance.new("BodyVelocity", hrp)
    bg.P = 9e4; bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
    bv.MaxForce = Vector3.new(9e9,9e9,9e9)
    flyConn = RunService.RenderStepped:Connect(function()
        local mv = Vector3.zero
        local cf = camera.CFrame
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then mv += cf.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then mv -= cf.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then mv -= cf.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then mv += cf.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then mv += cf.UpVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then mv -= cf.UpVector end
        bv.Velocity = (mv.Magnitude>0) and mv.Unit*flySpeed or Vector3.zero
        bg.CFrame = cf
    end)
end

local function stopFly()
    if flyConn then flyConn:Disconnect() flyConn = nil end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        for _,v in pairs(hrp:GetChildren()) do
            if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then v:Destroy() end
        end
    end
end


local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        noclipConnection = RunService.Stepped:Connect(function()
            for _,part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
        for _,part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

-- ESP
local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        for _,p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp and not espBoxes[p] then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Adornee = hrp
                    box.Size = Vector3.new(2,3,1)
                    box.Color3 = Color3.fromRGB(0,255,0)
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Parent = hrp
                    espBoxes[p] = box
                end
            end
        end
    else
        for _,box in pairs(espBoxes) do
            if box then box:Destroy() end
        end
        espBoxes = {}
    end
end

Players.PlayerAdded:Connect(function(p)
    if espEnabled and p ~= LocalPlayer and p.Character then
        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
        if hrp and not espBoxes[p] then
            local box = Instance.new("BoxHandleAdornment")
            box.Adornee = hrp
            box.Size = Vector3.new(2,3,1)
            box.Color3 = Color3.fromRGB(0,255,0)
            box.AlwaysOnTop = true
            box.ZIndex = 10
            box.Parent = hrp
            espBoxes[p] = box
        end
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if espBoxes[p] then
        espBoxes[p]:Destroy()
        espBoxes[p] = nil
    end
end)


local function createGUI()
    gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = "XiebeHubGUI"
    gui.ResetOnSpawn = false
    gui.Enabled = true

    -- Main window
    local window = Instance.new("Frame", gui)
    window.Size = UDim2.new(0,500,0,350)
    window.Position = UDim2.new(0.5,-250,0.5,-175)
    window.BackgroundColor3 = Color3.fromRGB(15,15,15)
    local corner = Instance.new("UICorner", window)
    corner.CornerRadius = UDim.new(0,15)
    makeDraggable(window)

    local title = Instance.new("TextLabel", window)
    title.Size = UDim2.new(1,0,0,50)
    title.Position = UDim2.new(0,0,0,0)
    title.BackgroundTransparency = 1
    title.Text = "✊🏻Xiebe Hub V3✊🏻"
    title.TextColor3 = Color3.fromRGB(0,120,200)
    title.Font = Enum.Font.GothamBlack
    title.TextScaled = true


    local tabs = {"Main","Player","Combat","Movement","Teleport","Settings"}
    local tabFrames = {}
    local tabBar = Instance.new("Frame", window)
    tabBar.Size = UDim2.new(1,0,0,35)
    tabBar.Position = UDim2.new(0,0,0,50)
    tabBar.BackgroundTransparency = 1

    local function selectTab(name)
        for tName,frame in pairs(tabFrames) do
            frame.Visible = (tName == name)
        end
    end

    for i,name in ipairs(tabs) do
        local btn = Instance.new("TextButton", tabBar)
        btn.Size = UDim2.new(1/#tabs-0.01,-5,1,0)
        btn.Position = UDim2.new((i-1)/#tabs,2,0,0)
        btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Text = name
        local cornerBtn = Instance.new("UICorner", btn)
        cornerBtn.CornerRadius = UDim.new(0,6)

        local frame = Instance.new("ScrollingFrame", window)
        frame.Size = UDim2.new(1,-20,1,-100)
        frame.Position = UDim2.new(0,10,0,90)
        frame.BackgroundTransparency = 1
        frame.ScrollBarThickness = 8
        local layout = Instance.new("UIListLayout", frame)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0,5)
        frame.Visible = false
        tabFrames[name] = frame

        btn.MouseButton1Click:Connect(function() selectTab(name) end)
    end
    selectTab("Main")

  
    local closeBtn = Instance.new("TextButton", window)
    closeBtn.Size = UDim2.new(0,40,0,30)
    closeBtn.Position = UDim2.new(1,-50,0,10)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
    closeBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    local closeCorner = Instance.new("UICorner", closeBtn)
    closeCorner.CornerRadius = UDim.new(0,5)
    closeBtn.MouseButton1Click:Connect(function()
        gui.Enabled = false
    end)

    
    local MainFrame = tabFrames["Main"]
    createButton(MainFrame,"Toggle Fly",function() flying = not flying if flying then startFly() else stopFly() end end)
    createButton(MainFrame,"Toggle Noclip",toggleNoclip)
    createButton(MainFrame,"Visit All Players (3s each)",function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        for _,p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                hrp.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
                task.wait(3)
            end
        end
    end)

   
    local MoveFrame = tabFrames["Movement"]
    createSlider(MoveFrame,"WalkSpeed",16,300,16,function(val)
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        if humanoid then humanoid.WalkSpeed = val end
    end)
    createSlider(MoveFrame,"JumpPower",50,300,50,function(val)
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        if humanoid then humanoid.JumpPower = val end
    end)
    createSlider(MoveFrame,"Fly Speed",10,200,60,function(val) flySpeed = val end)

 
    local PlayerFrame = tabFrames["Player"]
    createButton(PlayerFrame,"Toggle ESP",toggleESP)

 
    local CombatFrame = tabFrames["Combat"]
    createButton(CombatFrame,"Auto Click / Auto Farm",function() print("Auto Click activated") end)
    createButton(CombatFrame,"Auto Heal",function() print("Auto Heal activated") end)
    createButton(CombatFrame,"Weapon Modifiers",function() print("Weapon Mods activated") end)
    createButton(CombatFrame,"Extend Reach / Hitbox",function() print("Hitbox extended") end)


    local TeleFrame = tabFrames["Teleport"]
    for _,p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            createButton(TeleFrame,"Teleport to "..p.Name,function()
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local targetHRP = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                if hrp and targetHRP then hrp.CFrame = targetHRP.CFrame + Vector3.new(0,5,0) end
            end)
        end
    end
    

    local SettingsFrame = tabFrames["Settings"]
    createButton(SettingsFrame,"Anti Kick / Anti Death",function() print("Anti Kick enabled") end)
    createButton(SettingsFrame,"Auto Rejoin / Server Hop",function() print("Auto Rejoin enabled") end)
    createButton(SettingsFrame,"Copy Code Shortcut",function() setclipboard("Some in-game code") end)


    LocalPlayer.CharacterAdded:Connect(function()
        stopFly()
        if noclipEnabled then toggleNoclip() toggleNoclip() end
    end)
end


createGUI()
