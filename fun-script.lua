local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera
local Lighting = game:GetService("Lighting")

local OWNER_ID = 12958139
local KEY = "143214Q5gT4K"

local function showKeySystem(callback)
    if LocalPlayer.UserId == OWNER_ID then
        callback()
        return
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "KeySystemGUI"
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,400,0,150)
    frame.Position = UDim2.new(0.5,-200,0.4,-75)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    frame.BorderSizePixel = 0
    frame.Parent = gui
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0,15)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1,-20,0,50)
    label.Position = UDim2.new(0,10,0,10)
    label.Text = "Visit https://loot-link.com/s?u4GYwvtK for the key"
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold

    local keyBox = Instance.new("TextBox", frame)
    keyBox.Size = UDim2.new(1,-20,0,40)
    keyBox.Position = UDim2.new(0,10,0,70)
    keyBox.PlaceholderText = "Enter key here..."
    keyBox.BackgroundColor3 = Color3.fromRGB(55,55,55)
    keyBox.TextColor3 = Color3.fromRGB(255,255,255)
    keyBox.ClearTextOnFocus = false
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextScaled = true
    local corner2 = Instance.new("UICorner", keyBox)
    corner2.CornerRadius = UDim.new(0,8)

    local unlockButton = Instance.new("TextButton", frame)
    unlockButton.Size = UDim2.new(0,120,0,35)
    unlockButton.Position = UDim2.new(0.5,-60,1,-45)
    unlockButton.Text = "Unlock"
    unlockButton.BackgroundColor3 = Color3.fromRGB(55,55,55)
    unlockButton.TextColor3 = Color3.fromRGB(255,255,255)
    unlockButton.Font = Enum.Font.GothamBold
    unlockButton.TextScaled = true
    local corner3 = Instance.new("UICorner", unlockButton)
    corner3.CornerRadius = UDim.new(0,8)

    unlockButton.MouseButton1Click:Connect(function()
        if keyBox.Text == KEY then
            gui:Destroy()
            callback()
        else
            keyBox.Text = ""
            keyBox.PlaceholderText = "Invalid key, try again!"
        end
    end)
end

local function createGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "FunScriptsGUI"
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local blur = Instance.new("BlurEffect")
    blur.Size = 15
    blur.Parent = Lighting

    local window = Instance.new("Frame", gui)
    window.Size = UDim2.new(0,600,0,300)
    window.Position = UDim2.new(0.5,-300,0.5,-150)
    window.BackgroundColor3 = Color3.fromRGB(25,25,25)
    local windowCorner = Instance.new("UICorner", window)
    windowCorner.CornerRadius = UDim.new(0,15)

    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                     startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    window.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = window.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    window.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then update(input) end
    end)

    local title = Instance.new("TextLabel", window)
    title.Size = UDim2.new(1,0,0,40)
    title.BackgroundTransparency = 1
    title.Text = "Fun Scripts"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold

    local tabNames = {"Main","Teleport","Movement"}
    local tabs = {}
    local tabBar = Instance.new("Frame", window)
    tabBar.Size = UDim2.new(1,0,0,35)
    tabBar.Position = UDim2.new(0,0,0,40)
    tabBar.BackgroundTransparency = 1

    local function selectTab(name)
        for _,v in pairs(tabs) do
            v.Frame.Visible = (v.Name==name)
            v.Button.BackgroundColor3 = (v.Name==name) and Color3.fromRGB(70,70,70) or Color3.fromRGB(40,40,40)
        end
    end

    for i,name in ipairs(tabNames) do
        local btn = Instance.new("TextButton", tabBar)
        btn.Size = UDim2.new(1/#tabNames-0.01,-5,1,0)
        btn.Position = UDim2.new((i-1)/#tabNames,2,0,0)
        btn.Text = name
        btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextScaled = true
        local corner = Instance.new("UICorner", btn)
        corner.CornerRadius = UDim.new(0,6)

        local frame = Instance.new("Frame", window)
        frame.Size = UDim2.new(1,-10,1,-70)
        frame.Position = UDim2.new(0,5,0,70)
        frame.BackgroundTransparency = 1
        frame.Visible = false

        tabs[name] = {Button=btn, Frame=frame, Name=name}
        btn.MouseButton1Click:Connect(function() selectTab(name) end)
    end
    selectTab("Main")

    local function createButton(tabFrame,text,posY,callback)
        local btn = Instance.new("TextButton", tabFrame)
        btn.Size = UDim2.new(1,-20,0,35)
        btn.Position = UDim2.new(0,10,0,posY)
        btn.Text = text
        btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextScaled = true
        local corner = Instance.new("UICorner", btn)
        corner.CornerRadius = UDim.new(0,6)
        btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(60,60,60) end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(40,40,40) end)
        btn.MouseButton1Click:Connect(callback)
    end

    local MainFrame = tabs["Main"].Frame
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
    createButton(MainFrame,"Get Flinged",55,function()
        local hrp=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bv=Instance.new("BodyVelocity",hrp)
            bv.Velocity=Vector3.new(0,200,0)
            bv.MaxForce=Vector3.new(1e5,1e5,1e5)
            game:GetService("Debris"):AddItem(bv,0.3)
        end
    end)
    createButton(MainFrame,"Spin",100,function()
        local hrp=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bav=Instance.new("BodyAngularVelocity",hrp)
            bav.MaxTorque=Vector3.new(0,math.huge,0)
            bav.AngularVelocity=Vector3.new(0,10,0)
            bav.P=10000
            task.delay(5,function() bav:Destroy() end)
        end
    end)

    createButton(MainFrame,"Visit All Players",145,function()
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

    local TeleFrame = tabs["Teleport"].Frame
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
                posY=posY+45
            end
        end
    end
    addTeleportButtons()
    Players.PlayerAdded:Connect(addTeleportButtons)
    Players.PlayerRemoving:Connect(addTeleportButtons)

    local MoveFrame = tabs["Movement"].Frame
    local function createTextBox(parent,placeholder,posY,callback)
        local tb=Instance.new("TextBox",parent)
        tb.Size=UDim2.new(1,-20,0,35)
        tb.Position=UDim2.new(0,10,0,posY)
        tb.PlaceholderText=placeholder
        tb.BackgroundColor3=Color3.fromRGB(45,45,45)
        tb.TextColor3=Color3.fromRGB(255,255,255)
        tb.Font=Enum.Font.Gotham
        tb.TextScaled=true
        tb.ClearTextOnFocus=false
        local corner=Instance.new("UICorner", tb)
        corner.CornerRadius=UDim.new(0,6)
        tb.FocusLost:Connect(function()
            local val = tonumber(tb.Text)
            if val then callback(val) end
        end)
    end
    createTextBox(MoveFrame,"WalkSpeed (16)",10,function(val)
        local humanoid=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        if humanoid then humanoid.WalkSpeed=val end
    end)
    createTextBox(MoveFrame,"JumpPower (50)",55,function(val)
        local humanoid=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
        if humanoid then humanoid.JumpPower=val end
    end)

    local closeBtn = Instance.new("TextButton", window)
    closeBtn.Size = UDim2.new(0,35,0,35)
    closeBtn.Position = UDim2.new(1,-40,0,5)
    closeBtn.Text = "X"
    closeBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    local cornerClose = Instance.new("UICorner", closeBtn)
    cornerClose.CornerRadius=UDim.new(0,6)
    closeBtn.MouseEnter:Connect(function() closeBtn.BackgroundColor3 = Color3.fromRGB(60,60,60) end)
    closeBtn.MouseLeave:Connect(function() closeBtn.BackgroundColor3 = Color3.fromRGB(40,40,40) end)
    closeBtn.MouseButton1Click:Connect(function()
        gui.Enabled = false
        blur:Destroy()
        local hint = Instance.new("TextLabel", LocalPlayer.PlayerGui)
        hint.Size = UDim2.new(0,300,0,50)
        hint.Position = UDim2.new(0.5,-150,0.5,-25)
        hint.BackgroundColor3 = Color3.fromRGB(0,0,0)
        hint.TextColor3 = Color3.fromRGB(255,255,255)
        hint.Text = "Press K to open again"
        hint.TextScaled = true
        hint.Font = Enum.Font.GothamBold
        local uic = Instance.new("UICorner", hint)
        uic.CornerRadius = UDim.new(0,10)
        task.delay(3,function() hint:Destroy() end)
    end)

    UserInputService.InputBegan:Connect(function(input,processed)
        if input.KeyCode==Enum.KeyCode.K and not processed and not gui.Enabled then
            gui.Enabled = true
            local blur = Instance.new("BlurEffect", Lighting)
            blur.Size = 15
        end
    end)
end

showKeySystem(createGUI)
