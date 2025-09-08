-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- ====================
-- Owner ID & Key System
-- ====================
local OWNER_ID = 12958136

local function showKeySystem(callback)
    if LocalPlayer.UserId == OWNER_ID then
        callback() -- skip key system for owner
        return
    end

    -- Key GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = "KeySystemGUI"
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,400,0,150)
    frame.Position = UDim2.new(0.5,-200,0.4,-75)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    frame.BorderSizePixel = 0
    frame.Parent = gui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,15)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,-20,0,50)
    label.Position = UDim2.new(0,10,0,10)
    label.Text = "Visit https://loot-link.com/s?u4GYwvtK for the key"
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold
    label.Parent = frame

    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(1,-20,0,40)
    keyBox.Position = UDim2.new(0,10,0,70)
    keyBox.PlaceholderText = "Enter key here..."
    keyBox.Text = ""
    keyBox.BackgroundColor3 = Color3.fromRGB(55,55,55)
    keyBox.TextColor3 = Color3.fromRGB(255,255,255)
    keyBox.ClearTextOnFocus = false
    keyBox.Font = Enum.Font.SourceSans
    keyBox.TextScaled = true
    keyBox.Parent = frame
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0,8)
    corner2.Parent = keyBox

    local unlockButton = Instance.new("TextButton")
    unlockButton.Size = UDim2.new(0,120,0,35)
    unlockButton.Position = UDim2.new(0.5,-60,1,-45)
    unlockButton.Text = "Unlock"
    unlockButton.BackgroundColor3 = Color3.fromRGB(55,55,55)
    unlockButton.TextColor3 = Color3.fromRGB(255,255,255)
    unlockButton.Font = Enum.Font.SourceSans
    unlockButton.TextScaled = true
    unlockButton.Parent = frame
    local corner3 = Instance.new("UICorner")
    corner3.CornerRadius = UDim.new(0,8)
    corner3.Parent = unlockButton

    unlockButton.MouseButton1Click:Connect(function()
        if keyBox.Text == "143214Q5gT4K" then
            gui:Destroy()
            callback()
        else
            keyBox.Text = ""
            keyBox.PlaceholderText = "Invalid key, try again!"
        end
    end)
end

-- ====================
-- GUI Draggable Function
-- ====================
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- ====================
-- Main GUI
-- ====================
local function createMainGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "FunScriptsGUI"
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local window = Instance.new("Frame")
    window.Size = UDim2.new(0,420,0,520)
    window.Position = UDim2.new(0.5,-210,0.5,-260)
    window.BackgroundColor3 = Color3.fromRGB(45,45,45)
    window.BorderSizePixel = 0
    window.Parent = gui
    local windowCorner = Instance.new("UICorner")
    windowCorner.CornerRadius = UDim.new(0,15)
    windowCorner.Parent = window

    makeDraggable(window)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,50)
    title.BackgroundTransparency=1
    title.Text="Fun Scripts"
    title.TextColor3=Color3.fromRGB(255,255,255)
    title.TextScaled=true
    title.Font=Enum.Font.SourceSansBold
    title.Parent=window

    -- Tabs
    local tabNames = {"Main","Teleport","Movement"}
    local tabs = {}
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1,0,0,35)
    tabBar.Position=UDim2.new(0,0,0,50)
    tabBar.BackgroundTransparency=1
    tabBar.Parent = window

    local function selectTab(name)
        for _,v in pairs(tabs) do
            v.Frame.Visible = (v.Name==name)
            if v.Name==name then v.Button.BackgroundColor3=Color3.fromRGB(70,70,70)
            else v.Button.BackgroundColor3=Color3.fromRGB(55,55,55) end
        end
    end

    for i,name in ipairs(tabNames) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1/#tabNames-0.01,-5,1,0)
        btn.Position = UDim2.new((i-1)/#tabNames,2,0,0)
        btn.Text = name
        btn.BackgroundColor3 = Color3.fromRGB(55,55,55)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.SourceSans
        btn.TextScaled = true
        btn.Parent = tabBar
        local corner = Instance.new("UICorner")
        corner.CornerRadius=UDim.new(0,6)
        corner.Parent=btn

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1,-10,1,-100)
        frame.Position = UDim2.new(0,5,0,80)
        frame.BackgroundTransparency=1
        frame.Parent = window
        frame.Visible=false

        tabs[name]={Button=btn,Frame=frame,Name=name}
        btn.MouseButton1Click:Connect(function() selectTab(name) end)
    end
    selectTab("Main")

    -- Helper Button
    local function createButton(parent,text,posY,callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,-20,0,40)
        btn.Position = UDim2.new(0,10,0,posY)
        btn.Text=text
        btn.BackgroundColor3 = Color3.fromRGB(65,65,65)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.SourceSans
        btn.TextScaled=true
        btn.Parent=parent
        local corner=Instance.new("UICorner")
        corner.CornerRadius=UDim.new(0,8)
        corner.Parent=btn
        btn.MouseEnter:Connect(function() btn.BackgroundColor3=Color3.fromRGB(80,80,80) end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3=Color3.fromRGB(65,65,65) end)
        btn.MouseButton1Click:Connect(callback)
    end

    -- ====================
    -- Main Tab
    -- ====================
    local MainFrame=tabs["Main"].Frame
    local flying=false
    local flyConnection
    local flySpeed=60

    local function startFly()
        local hrp=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local bg=Instance.new("BodyGyro",hrp)
        local bv=Instance.new("BodyVelocity",hrp)
        bg.P=9e4; bg.MaxTorque=Vector3.new(9e9,9e9,9e9)
        bg.CFrame=hrp.CFrame
        bv.MaxForce=Vector3.new(9e9,9e9,9e9)
        flyConnection=RunService.RenderStepped:Connect(function()
            local mv=Vector3.zero
            local cf=camera.CFrame
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then mv+=cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then mv-=cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then mv-=cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then mv+=cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then mv+=cf.UpVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then mv-=cf.UpVector end
            bv.Velocity=mv.Magnitude>0 and mv.Unit*flySpeed or Vector3.zero
            bg.CFrame=cf
        end)
    end

    local function stopFly()
        if flyConnection then flyConnection:Disconnect() flyConnection=nil end
        local hrp=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _,v in pairs(hrp:GetChildren()) do
                if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then v:Destroy() end
            end
        end
    end

    createButton(MainFrame,"Toggle Fly",10,function() flying=not flying if flying then startFly() else stopFly() end end)
    createButton(MainFrame,"Get Flinged",60,function()
        local hrp=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bv=Instance.new("BodyVelocity",hrp)
            bv.Velocity=Vector3.new(0,200,0)
            bv.MaxForce=Vector3.new(1e5,1e5,1e5)
            game:GetService("Debris"):AddItem(bv,0.3)
        end
    end)
    createButton(MainFrame,"Spin",110,function()
        local hrp=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bav=Instance.new("BodyAngularVelocity",hrp)
            bav.MaxTorque=Vector3.new(0,math.huge,0)
            bav.AngularVelocity=Vector3.new(0,10,0)
            bav.P=10000
            task.delay(5,function() bav:Destroy() end)
        end
    end)

    -- Visit All Players with loopgoto
    createButton(MainFrame,"Visit All Players",160,function()
        local hrp=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local currentLoop
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local targetHRP = p.Character.HumanoidRootPart
                if currentLoop then currentLoop:Disconnect() end
                currentLoop = RunService.RenderStepped:Connect(function()
                    hrp.CFrame = targetHRP.CFrame + Vector3.new(0,5,0)
                end)
                task.wait(2)
            end
        end
        if currentLoop then currentLoop:Disconnect() end
    end)

    -- ====================
    -- Teleport Tab
    -- ====================
    local TeleFrame=tabs["Teleport"].Frame
    local function addTeleportButtons()
        TeleFrame:ClearAllChildren()
        local posY=10
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer then
                createButton(TeleFrame,"Teleport to "..p.Name,posY,function()
                    local hrp=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local targetHRP=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and targetHRP then hrp.CFrame=targetHRP.CFrame+Vector3.new(0,5,0) end
                end)
                posY=posY+50
            end
        end
    end
    addTeleportButtons()
    Players.PlayerAdded:Connect(addTeleportButtons)
    Players.PlayerRemoving:Connect(addTeleportButtons)

    -- ====================
    -- Movement Tab
    -- ====================
    local MoveFrame=tabs["Movement"].Frame
    local function createTextBox(parent,placeholder,posY,callback)
        local tb=Instance.new("TextBox")
        tb.Size=UDim2.new(1,-20,0,40)
        tb.Position = UDim2.new(0,10,0,posY)
        tb.PlaceholderText = placeholder
        tb.BackgroundColor3 = Color3.fromRGB(65,65,65)
        tb.TextColor3 = Color3.fromRGB(255,255,255)
        tb.Font = Enum.Font.SourceSans
        tb.TextScaled=true
        tb.ClearTextOnFocus=false
        tb.Parent=parent
        local corner=Instance.new("UICorner")
        corner.CornerRadius=UDim.new(0,8)
        corner.Parent=tb
        tb.FocusLost:Connect(function()
            local val = tonumber(tb.Text)
            if val then callback(val) end
        end)
    end
    createTextBox(MoveFrame,"WalkSpeed (16)",10,function(val)
        local humanoid=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        if humanoid then humanoid.WalkSpeed=val end
    end)
    createTextBox(MoveFrame,"JumpPower (50)",60,function(val)
        local humanoid=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        if humanoid then humanoid.JumpPower=val end
    end)
end

-- Initialize
showKeySystem(createMainGUI)

