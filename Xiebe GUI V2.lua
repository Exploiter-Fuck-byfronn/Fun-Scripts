local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local ownerId = 12958136
local hiddenPasswordData = {51,49,51,50,49,52,82,53,103,84,52,75}
local function getPassword()
    local pw = ""
    for _,v in ipairs(hiddenPasswordData) do
        pw = pw .. string.char(bit32.bxor(v,23))
    end
    return pw
end

local gui
local guiOpened = false

local function createKeyPrompt()
    local prompt = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
    prompt.Name = "XiebeKeyPrompt"
    local frame = Instance.new("Frame", prompt)
    frame.Size = UDim2.new(0,400,0,200)
    frame.Position = UDim2.new(0.5,-200,0.5,-100)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0,12)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,50)
    title.Position = UDim2.new(0,0,0,0)
    title.BackgroundTransparency = 1
    title.Text = "✊🏻Xiebe GUI V2✊🏻"
    title.TextColor3 = Color3.fromRGB(0,120,200)
    title.Font = Enum.Font.GothamBlack
    title.TextScaled = true

    local info = Instance.new("TextLabel", frame)
    info.Size = UDim2.new(1,-20,0,60)
    info.Position = UDim2.new(0,10,0,60)
    info.BackgroundTransparency = 1
    info.TextColor3 = Color3.fromRGB(255,255,255)
    info.TextWrapped = true
    info.Text = "Visit the link and copy the note to get the password.\nLink copied to clipboard!"
    pcall(function() setclipboard("https://loot-link.com/s?u4GYwvtK") end)

    local textbox = Instance.new("TextBox", frame)
    textbox.Size = UDim2.new(0,250,0,40)
    textbox.Position = UDim2.new(0.5,-125,0,130)
    textbox.PlaceholderText = "Enter Password"
    textbox.TextColor3 = Color3.fromRGB(255,255,255)
    textbox.BackgroundColor3 = Color3.fromRGB(50,50,50)
    local tbCorner = Instance.new("UICorner", textbox)
    tbCorner.CornerRadius = UDim.new(0,6)
    textbox.TextScaled = true

    local submit = Instance.new("TextButton", frame)
    submit.Size = UDim2.new(0,100,0,40)
    submit.Position = UDim2.new(0.5,50,0,130)
    submit.Text = "Submit"
    submit.TextColor3 = Color3.fromRGB(255,255,255)
    submit.BackgroundColor3 = Color3.fromRGB(0,120,200)
    local btnCorner = Instance.new("UICorner", submit)
    btnCorner.CornerRadius = UDim.new(0,6)
    submit.TextScaled = true

    local function checkKey()
        if textbox.Text == getPassword() then
            prompt:Destroy()
            guiOpened = true
            gui.Enabled = true
        else
            textbox.Text = ""
            textbox.PlaceholderText = "Wrong!"
        end
    end

    submit.MouseButton1Click:Connect(checkKey)
    textbox.FocusLost:Connect(function(enterPressed)
        if enterPressed then checkKey() end
    end)
end

local function createGUI()
    gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = "XiebeHubGUI"
    gui.ResetOnSpawn = false
    gui.Enabled = ownerId==LocalPlayer.UserId

    local window = Instance.new("Frame", gui)
    window.Size = UDim2.new(0,500,0,350)
    window.Position = UDim2.new(0.5,-250,0.5,-175)
    window.BackgroundColor3 = Color3.fromRGB(15,15,15)
    local corner = Instance.new("UICorner", window)
    corner.CornerRadius = UDim.new(0,15)

    local title = Instance.new("TextLabel", window)
    title.Size = UDim2.new(1,0,0,50)
    title.Position = UDim2.new(0,0,0,0)
    title.BackgroundTransparency = 1
    title.Text = "✊🏻Xiebe GUI V2✊🏻"
    title.TextColor3 = Color3.fromRGB(0,120,200)
    title.Font = Enum.Font.GothamBlack
    title.TextScaled = true

    local tabs = {"Main","Teleport","Movement"}
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

        local frame = Instance.new("Frame", window)
        frame.Size = UDim2.new(1,-20,1,-100)
        frame.Position = UDim2.new(0,10,0,90)
        frame.BackgroundTransparency = 1
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

    local dragging, dragStart, startPos
    window.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging=true
            dragStart=input.Position
            startPos=window.Position
            input.Changed:Connect(function()
                if input.UserInputState==Enum.UserInputState.End then dragging=false end
            end)
        end
    end)
    window.InputChanged:Connect(function(input)
        if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
            local delta=input.Position-dragStart
            window.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
        end
    end)

    local function createButton(parent,text,posY,callback)
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(0,150,0,35)
        btn.Position = UDim2.new(0,10,0,posY)
        btn.Text=text
        btn.TextColor3=Color3.fromRGB(255,255,255)
        btn.TextScaled=true
        btn.BackgroundColor3=Color3.fromRGB(50,50,50)
        local corner=Instance.new("UICorner", btn)
        corner.CornerRadius = UDim.new(0,8)
        btn.MouseButton1Click:Connect(callback)
    end

    local MainFrame=tabFrames["Main"]
    local flying, flyConn, flySpeed=false, nil, 60
    local function stopFly()
        if flyConn then flyConn:Disconnect() flyConn=nil end
        local hrp=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _,v in pairs(hrp:GetChildren()) do
                if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then v:Destroy() end
            end
        end
    end
    local function startFly()
        stopFly()
        local hrp=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local bg=Instance.new("BodyGyro",hrp)
        local bv=Instance.new("BodyVelocity",hrp)
        bg.P=9e4; bg.MaxTorque=Vector3.new(9e9,9e9,9e9)
        bv.MaxForce=Vector3.new(9e9,9e9,9e9)
        flyConn=RunService.RenderStepped:Connect(function()
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
            bav.AngularVelocity=Vector3.new(0,20,0)
            bav.P=1e4
            task.delay(5,function() bav:Destroy() end)
        end
    end)
    createButton(MainFrame,"Visit All Players",160,function()
        local hrp=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local target=p.Character.HumanoidRootPart
                hrp.CFrame=target.CFrame+Vector3.new(0,5,0)
                task.wait(3)
            end
        end
    end)

    local TeleFrameParent=tabFrames["Teleport"]
    local scrollFrame=Instance.new("ScrollingFrame",TeleFrameParent)
    scrollFrame.Size=UDim2.new(1,0,1,0)
    scrollFrame.CanvasSize=UDim2.new(0,0,0,0)
    scrollFrame.ScrollBarThickness=8
    scrollFrame.BackgroundTransparency=1
    local UIList=Instance.new("UIListLayout",scrollFrame)
    UIList.SortOrder=Enum.SortOrder.LayoutOrder
    UIList.Padding=UDim.new(0,5)

    local function addTeleportButtons()
        for _,child in pairs(scrollFrame:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer then
                local btn=Instance.new("TextButton",scrollFrame)
                btn.Size=UDim2.new(1,-10,0,35)
                btn.Text="Teleport to "..p.Name
                btn.TextColor3=Color3.fromRGB(255,255,255)
                btn.TextScaled=true
                btn.BackgroundColor3=Color3.fromRGB(50,50,50)
                local corner=Instance.new("UICorner",btn)
                corner.CornerRadius=UDim.new(0,6)
                btn.MouseButton1Click:Connect(function()
                    local hrp=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local targetHRP=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and targetHRP then
                        hrp.CFrame=targetHRP.CFrame+Vector3.new(0,5,0)
                    end
                end)
            end
        end
        scrollFrame.CanvasSize=UDim2.new(0,0,0,UIList.AbsoluteContentSize.Y+5)
    end
    addTeleportButtons()
    Players.PlayerAdded:Connect(addTeleportButtons)
    Players.PlayerRemoving:Connect(addTeleportButtons)

    local MoveFrame=tabFrames["Movement"]
    local function createTextBox(parent,placeholder,posY,callback)
        local tb=Instance.new("TextBox",parent)
        tb.Size=UDim2.new(0,150,0,35)
        tb.Position=UDim2.new(0,10,0,posY)
        tb.PlaceholderText=placeholder
        tb.Text=""
        tb.TextColor3=Color3.fromRGB(255,255,255)
        tb.BackgroundColor3=Color3.fromRGB(40,40,40)
        local corner=Instance.new("UICorner",tb)
        corner.CornerRadius=UDim.new(0,6)
        tb.ClearTextOnFocus=false
        tb.TextScaled=true
        tb.FocusLost:Connect(function()
            local val=tonumber(tb.Text)
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
    LocalPlayer.CharacterAdded:Connect(stopFly)
end

createGUI()
if LocalPlayer.UserId ~= ownerId then
    createKeyPrompt()
end
