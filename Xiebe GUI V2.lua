-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Create window
local Window = Rayfield:CreateWindow({
    Name = "Xiebe Hub V2",
    LoadingTitle = "Xiebe Hub V2",
    LoadingSubtitle = "by Kaan",
    ConfigurationSaving = {Enabled = true, FolderName = nil, FileName = "XiebeHubV2"},
    Discord = {Enabled = false},
    KeySystem = false
})
-- Jerk off
local MyTab = Window:CreateTab("Secondary", 6023426915)

MyTab:CreateButton({
    Name = "Jerk off like crazy",       -- text shown on the button
    Callback = function()
        local speaker = game.Players.LocalPlayer
if not speaker then return end


local tool = Instance.new("Tool")
tool.Name = "jerk off"
tool.ToolTip = "Just keep jerking off bruv (CUM TOO)"
tool.RequiresHandle = false
local toolClone = tool:Clone()
tool.Parent = speaker:WaitForChild("Backpack")

local jorkin = false
local track = nil
local nameGui = nil
local lastPosition = nil

-- Cập nhật humanoid khi nhân vật thay đổi
local humanoid = speaker.Character and speaker.Character:FindFirstChildWhichIsA("Humanoid")
local function updateHumanoid()
    if speaker.Character then
        humanoid = speaker.Character:WaitForChild("Humanoid")
    end
end
if not humanoid then updateHumanoid() end
if not humanoid then return end


local function stopTomfoolery()
    jorkin = false
    if track then
        track:Stop()
        track = nil
    end
    if nameGui then
        nameGui:Destroy()
        nameGui = nil
    end
    lastPosition = nil
end

local function isR15(character)
    return character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15
end

local function playAnimation()
    if not jorkin then return end
    
    local isR15Model = isR15(speaker.Character)
    if not track then
        local anim = Instance.new("Animation")
        anim.AnimationId = isR15Model and "rbxassetid://698251653" or "rbxassetid://72042024"
        
        local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:FindFirstChildWhichIsA("AnimationController")
        if not animator then
            animator = Instance.new("Animator")
            animator.Parent = humanoid
        end
        
        track = animator:LoadAnimation(anim)
    end

    if track then
        track:Play()
        track:AdjustSpeed(isR15Model and 0.7 or 0.65)
        track.TimePosition = 0.6
        
        while track and track.IsPlaying and track.TimePosition < (isR15Model and 0.65 or 0.7) do
            task.wait(0.1)
        end
        
        track:Stop()
        track = nil
    end
end



-- Hiển thị tên tool với font
local function showToolName()
    if not speaker.Character then return end
    local head = speaker.Character:FindFirstChild("Head")
    if not head then return end

    nameGui = Instance.new("BillboardGui")
    nameGui.Parent = head
    nameGui.Size = UDim2.new(4, 0, 1, 0)
    nameGui.StudsOffset = Vector3.new(0, 3, 0)
    nameGui.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = nameGui
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "I'm Horney..."
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBlack
end

speaker.CharacterAdded:Connect(function(character)
    updateHumanoid()
    local backpack = speaker:WaitForChild("Backpack")
    task.wait(0.1)
    if not backpack:FindFirstChild("jerk off") then
        local newTool = toolClone:Clone()
        newTool.Parent = backpack
        newTool.Equipped:Connect(function()
            jorkin = true
            showToolName()
        end)
        newTool.Unequipped:Connect(stopTomfoolery)
        newTool.Activated:Connect(function()
            if jorkin then
                playAnimation()
            end
        end)
    end
end)

tool.Equipped:Connect(function()
    jorkin = true
    showToolName() 
end)

tool.Unequipped:Connect(stopTomfoolery)
humanoid.Died:Connect(stopTomfoolery)

tool.Activated:Connect(function()
    if jorkin then
        playAnimation()
    end
end)

print("Kaan")



      
        print("Jerking off!!")
    end
})

MyTab:CreateButton({
    Name = "Self fling FE press e to fling yourself and q to TP back",       -- text shown on the button
    Callback = function()
        --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- FE SELF FLING REAL
-- used for trolling example: bang someone and when they turn around and look at you, FLING YOURSELF
-- hotkey dont have to be capitals lol
-- press e to fling urself and q to go back where u previously were

local Config = {
    FlingHotkey = "E",
    TpBackHotkey = "Q",
    Permanent = false
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

local Character = Player.Character
local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
local RootPart = Humanoid.RootPart

for _, x in next, Config do
    if type(x) == "string" then
        Config[_] = x:upper()
    end
end

local CurrentPos
local Connection

Connection = UserInputService.InputBegan:Connect(function(Key, Typing)
    if not Typing then
        if Key.KeyCode == Enum.KeyCode[Config.FlingHotkey] then
            if Config.Permanent then
                if Player.Character.Humanoid.RootPart.Velocity.Magnitude <= 20 then
                    CurrentPos = Player.Character.Humanoid.RootPart.CFrame
                end
                Player.Character.Humanoid.RootPart.Velocity = (Player.Character.Humanoid.RootPart.Velocity + Vector3.new(0, 50, 0)) + (Player.Character.Humanoid.RootPart.CFrame.LookVector * 100)
                Player.Character.Humanoid.RootPart.RotVelocity = (Player.Character.Humanoid.RootPart.RotVelocity + Vector3.new(math.random(200, 300), math.random(-200, 300), math.random(200, 300))) 
            else
                if RootPart.Velocity.Magnitude <= 20 then
                    CurrentPos = RootPart.CFrame
                end
                RootPart.Velocity = (RootPart.Velocity + Vector3.new(0, 50, 0)) + (RootPart.CFrame.LookVector * 100)
                RootPart.RotVelocity = (RootPart.RotVelocity + Vector3.new(math.random(200, 300), math.random(-200, 300), math.random(200, 300)))
            end
        elseif Key.KeyCode == Enum.KeyCode[Config.TpBackHotkey] then
            if CurrentPos then
                if Config.Permanent then
                    if Player.Character.Humanoid.RootPart.Velocity.Magnitude >= 20 then
                        Player.Character.Humanoid.RootPart.Velocity = Vector3.new()
                        Player.Character.Humanoid.RootPart.RotVelocity = Vector3.new()
                        Player.Character.Humanoid.RootPart.CFrame = CurrentPos
                        Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                else
                    if RootPart.Velocity.Magnitude >= 20 then
                        RootPart.Velocity = Vector3.new()
                        RootPart.RotVelocity = Vector3.new()
                        RootPart.CFrame = CurrentPos
                        Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                end
            end
        end
    end
end)

if not Config.Permanent then
    Humanoid.Died:Connect(function()
        Connection:Disconnect()
    end)
end

        print("Button clicked!")
    end
}) 

local Button = Tab:CreateButton({
-- ==================== Local Player Tab ====================
local LocalPlayerTab = Window:CreateTab("Main", 4483362458)
LocalPlayerTab:CreateLabel("Server-Sided & Teleport Controls")

-- WalkSpeed slider
LocalPlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {0,500},
    Increment = 1,
    Suffix = "speed",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(val)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = val
        end
    end
})

-- JumpPower slider
LocalPlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {0,300},
    Increment = 1,
    Suffix = "power",
    CurrentValue = 50,
    Flag = "JumpPowerSlider",
    Callback = function(val)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = val
        end
    end
})

-- Teleport & Hold toggle
local holding = false
LocalPlayerTab:CreateToggle({
    Name = "Teleport & Hold",
    CurrentValue = false,
    Flag = "TeleportHold",
    Callback = function(state)
        holding = state
        spawn(function()
            while holding do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    -- Teleport using HumanoidRootPart
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(0,5,0)
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
                    workspace.CurrentCamera.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,10)
                end
                wait(7)
            end
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        end)
    end
})

-- Reset Character button
LocalPlayerTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        if player then
            pcall(function()
                player:LoadCharacter()
            end)
        end
    end
})

-- ==================== Teleporter Tab ====================
local TeleporterTab = Window:CreateTab("Teleporter", 4483362458)
TeleporterTab:CreateLabel("Teleport to specific locations or players")

-- Teleport to origin
TeleporterTab:CreateButton({
    Name = "Teleport to Origin (0,0,0)",
    Callback = function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(0,5,0)
        end
    end
})

-- Teleport to spawn
TeleporterTab:CreateButton({
    Name = "Teleport to Spawn",
    Callback = function()
        local spawn = workspace:FindFirstChildWhichIsA("SpawnLocation")
        if spawn and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0,5,0)
        end
    end
})

-- Player dropdown
local playerNames = {}
for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= player then
        table.insert(playerNames, plr.Name)
    end
end
local selectedPlayer = playerNames[1] or nil

local dropdown = TeleporterTab:CreateDropdown({
    Name = "Select Player",
    Options = playerNames,
    CurrentOption = selectedPlayer or "None",
    Flag = "PlayerDropdown",
    Callback = function(option)
        selectedPlayer = option
    end
})

-- Teleport to selected player button
TeleporterTab:CreateButton({
    Name = "Teleport to the player!",
    Callback = function()
        if selectedPlayer then
            local targetPlayer = Players:FindFirstChild(selectedPlayer)
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
            end
        else
            warn("No player selected!")
        end
    end
})

-- Update dropdown dynamically
Players.PlayerAdded:Connect(function(plr)
    if plr ~= player then dropdown:AddOption(plr.Name) end
end)
Players.PlayerRemoving:Connect(function(plr)
    if dropdown.Options then
        for i, name in pairs(dropdown.Options) do
            if name == plr.Name then
                table.remove(dropdown.Options,i)
                if selectedPlayer == plr.Name then selectedPlayer = nil end
                break
            end
        end
    end
end)

-- ==================== Combat Tab ====================
local CombatTab = Window:CreateTab("Combat", 4483362458)
CombatTab:CreateLabel("Combat features")

CombatTab:CreateToggle({
    Name = "Infinite Attack",
    CurrentValue = false,
    Flag = "InfiniteAttack",
    Callback = function(state)
        print("Infinite Attack:", state)
    end
})

CombatTab:CreateSlider({
    Name = "Attack Speed",
    Range = {1,10},
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = 1,
    Flag = "AttackSpeed",
    Callback = function(val)
        print("Attack Speed set to:", val)
    end
})

-- ==================== Visuals Tab ====================
local VisualsTab = Window:CreateTab("Visuals", 4483362458)
VisualsTab:CreateLabel("Visuals / ESP / Highlights")

-- Highlight players
VisualsTab:CreateToggle({
    Name = "Highlight Players",
    CurrentValue = false,
    Flag = "HighlightPlayers",
    Callback = function(state)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local highlight = plr.Character:FindFirstChild("Highlight")
                if state then
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Parent = plr.Character
                        highlight.FillColor = Color3.fromRGB(255,0,0)
                        highlight.OutlineColor = Color3.fromRGB(0,0,0)
                    end
                else
                    if highlight then highlight:Destroy() end
                end
            end
        end
    end
})

-- Background color picker
VisualsTab:CreateColorPicker({
    Name = "Background Color",
    Default = Color3.fromRGB(50,50,50),
    Flag = "BackgroundColor",
    Callback = function(color)
        if Window.MainFrame then
            Window.MainFrame.BackgroundColor3 = color
        end
    end
})

-- ==================== World Tab ====================
local WorldTab = Window:CreateTab("World", 4483362458)
WorldTab:CreateLabel("World manipulation")

WorldTab:CreateSlider({
    Name = "Gravity",
    Range = {0,500},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = workspace.Gravity,
    Flag = "GravitySlider",
    Callback = function(val)
        workspace.Gravity = val
    end
})

WorldTab:CreateSlider({
    Name = "Time of Day",
    Range = {0,24},
    Increment = 0.1,
    Suffix = "hours",
    CurrentValue = tonumber(game.Lighting.TimeOfDay:sub(1,2)),
    Flag = "TimeSlider",
    Callback = function(val)
        game.Lighting.TimeOfDay = tostring(val)
    end
})

-- ==================== UI Tab ====================
local UITab = Window:CreateTab("UI", 4483362458)
UITab:CreateLabel("UI customization")

UITab:CreateButton({
    Name = "Toggle GUI",
    Callback = function() Window:Toggle() end
})

UITab:CreateButton({
    Name = "Set Window Title",
    Callback = function() Window:SetWindowTitle("Xiebe Hub V2 Updated!") end
})

-- ==================== About Tab ====================
local AboutTab = Window:CreateTab("About", 631727250)
AboutTab:CreateLabel("Made by Kaan, hope you enjoy the script :))))")
