local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local OWNER_ID = 12958136

-- Blur effect
local function enableBlur()
    if not Lighting:FindFirstChild("FunScriptsBlur") then
        local blur = Instance.new("BlurEffect")
        blur.Name = "FunScriptsBlur"
        blur.Size = 20
        blur.Parent = Lighting
    end
end
local function disableBlur()
    local blur = Lighting:FindFirstChild("FunScriptsBlur")
    if blur then blur:Destroy() end
end

local function showKeySystem(callback)
    if LocalPlayer.UserId == OWNER_ID then
        enableBlur()
        callback()
        return
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "KeySystemGUI"
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,400,0,150)
    frame.Position = UDim2.new(0.5,-200,0.4,-75)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,15) -- darker
    frame.BorderSizePixel = 0
    frame.Parent = gui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,15)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,-20,0,50)
    label.Position = UDim2.new(0,10,0,10)
    label.Text = "Visit https://loot-link.com/s?u4GYwvtK for the key"
    label.TextColor3 = Color3.fromRGB(230,230,230)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = frame

    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(1,-20,0,40)
    keyBox.Position = UDim2.new(0,10,0,70)
    keyBox.PlaceholderText = "Enter key here..."
    keyBox.Text = ""
    keyBox.BackgroundColor3 = Color3.fromRGB(25,25,25) -- darker input
    keyBox.TextColor3 = Color3.fromRGB(255,255,255)
    keyBox.ClearTextOnFocus = false
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextScaled = true
    keyBox.Parent = frame
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0,8)
    corner2.Parent = keyBox

    local unlockButton = Instance.new("TextButton")
    unlockButton.Size = UDim2.new(0,120,0,35)
    unlockButton.Position = UDim2.new(0.5,-60,1,-45)
    unlockButton.Text = "Unlock"
    unlockButton.BackgroundColor3 = Color3.fromRGB(45,80,160) -- darker blue
    unlockButton.TextColor3 = Color3.fromRGB(255,255,255)
    unlockButton.Font = Enum.Font.GothamBold
    unlockButton.TextScaled = true
    unlockButton.Parent = frame
    local corner3 = Instance.new("UICorner")
    corner3.CornerRadius = UDim.new(0,8)
    corner3.Parent = unlockButton

    unlockButton.MouseButton1Click:Connect(function()
        if keyBox.Text == "143214Q5gT4K" then
            gui:Destroy()
            enableBlur()
            callback()
        else
            keyBox.Text = ""
            keyBox.PlaceholderText = "Invalid key, try again!"
        end
    end)
end

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

local function createMainGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "FunScriptsGUI"
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 600, 0, 350)
    window.Position = UDim2.new(0.5,-300,0.5,-175)
    window.BackgroundColor3 = Color3.fromRGB(10,10,10) -- darkest
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
    title.Font=Enum.Font.GothamBold
    title.Parent=window

    local tabNames = {"Main","Teleport","Movement"}
    local tabs = {}
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1,0,0,40)
    tabBar.Position=UDim2.new(0,0,0,50)
    tabBar.BackgroundTransparency=1
    tabBar.Parent = window

    local function selectTab(name)
        for _,v in pairs(tabs) do
            v.Frame.Visible = (v.Name==name)
            if v.Name==name then
                v.Button.BackgroundColor3=Color3.fromRGB(60,100,200) -- active
            else
                v.Button.BackgroundColor3=Color3.fromRGB(25,25,25) -- dark inactive
            end
        end
    end

    for i,name in ipairs(tabNames) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1/#tabNames-0.01,-5,1,0)
        btn.Position = UDim2.new((i-1)/#tabNames,2,0,0)
        btn.Text = name
        btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.Gotham
        btn.TextScaled = true
        btn.Parent = tabBar
        local corner = Instance.new("UICorner")
        corner.CornerRadius=UDim.new(0,6)
        corner.Parent=btn

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1,-20,1,-100)
        frame.Position = UDim2.new(0,10,0,90)
        frame.BackgroundTransparency=1
        frame.Parent = window
        frame.Visible=false

        tabs[name]={Button=btn,Frame=frame,Name=name}
        btn.MouseButton1Click:Connect(function() selectTab(name) end)
    end
    selectTab("Main")

    local function createButton(parent,text,posY,callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,-20,0,40)
        btn.Position = UDim2.new(0,10,0,posY)
        btn.Text=text
        btn.BackgroundColor3 = Color3.fromRGB(45,80,160) -- darker blue
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.Gotham
        btn.TextScaled=true
        btn.Parent=parent
        local corner=Instance.new("UICorner")
        corner.CornerRadius=UDim.new(0,8)
        corner.Parent=btn
        btn.MouseEnter:Connect(function() btn.BackgroundColor3=Color3.fromRGB(70,120,230) end)
        btn.MouseLeave:Connect(function() btn.BackgroundColor3=Color3.fromRGB(45,80,160) end)
        btn.MouseButton1Click:Connect(callback)
    end

    -- add your fly/teleport/movement logic here (unchanged)

end

showKeySystem(createMainGUI)
