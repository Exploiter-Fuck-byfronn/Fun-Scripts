-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Fly variables
local flying = false
local bodyVelocity = nil
local bodyGyro = nil
local flySpeed = 50
local maxForce = Vector3.new(math.huge, math.huge, math.huge)

-- Function to start flying
local function startFlying()
    local character = player.Character
    if not character then return end
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end

    flying = true
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = maxForce
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = maxForce
    bodyGyro.P = 10000
    bodyGyro.Parent = rootPart

    humanoid.PlatformStand = true
end

-- Function to stop flying
local function stopFlying()
    flying = false
    if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
    if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then humanoid.PlatformStand = false end
    end
end

-- Fly movement update
local flyConnection
local function updateFly()
    if flyConnection then flyConnection:Disconnect() end
    flyConnection = RunService.RenderStepped:Connect(function()
        if not flying then return end
        local character = player.Character
        if not character then return end
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart or not bodyVelocity or not bodyGyro then return end
        local camera = workspace.CurrentCamera
        local direction = Vector3.new(0, 0, 0)

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            direction = direction + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            direction = direction - Vector3.new(0, 1, 0)
        end

        if direction.Magnitude > 0 then
            bodyVelocity.Velocity = direction.Unit * flySpeed
        else
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
        bodyGyro.CFrame = camera.CFrame
    end)
end

-- Handle character reset
player.CharacterAdded:Connect(function()
    stopFlying()
    updateFly()
end)

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
local MyTab = Window:CreateTab("🚀Secondary🚀", 6023426915)

MyTab:CreateButton({
    Name = "Jerk off like crazy",
    Callback = function()
        local speaker = game.Players.LocalPlayer
        if not speaker then return end

        local tool = Instance.new("Tool")
        tool.Name = "jerk off"
        tool.ToolTip = "KHEN.CC!"
        tool.RequiresHandle = false
        local toolClone = tool:Clone()
        tool.Parent = speaker:WaitForChild("Backpack")

        local jorkin = false
        local track = nil
        local nameGui = nil

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

        print("khen.cc")
        print("Jerking off!!")
    end
})

-- ==================== Local Player Tab ====================
local LocalPlayerTab = Window:CreateTab("🚀Main🚀", 4483362458)
LocalPlayerTab:CreateLabel("Server-Sided & Teleport Controls")

-- WalkSpeed slider
LocalPlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {0, 500},
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
    Range = {0, 300},
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

-- Fly Speed slider
LocalPlayerTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 200},
    Increment = 5,
    Suffix = "speed",
    CurrentValue = 50,
    Flag = "FlySpeedSlider",
    Callback = function(val)
        flySpeed = val
    end
})

-- Fly toggle
LocalPlayerTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(state)
        if state then
            startFlying()
            updateFly()
        else
            stopFlying()
        end
    end
})

-- Infinite Jump toggle
local infiniteJump = false
UserInputService.JumpRequest:Connect(function()
    if infiniteJump and player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

LocalPlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJump",
    Callback = function(state)
        infiniteJump = state
    end
})

-- Noclip toggle
local noclip = false
local noclipConnection = nil
LocalPlayerTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(state)
        noclip = state
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        if state then
            noclipConnection = RunService.Stepped:Connect(function()
                if noclip and player.Character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
    end
})

-- Speed Boost button
LocalPlayerTab:CreateButton({
    Name = "Speed Boost (2x for 5s)",
    Callback = function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            local originalSpeed = humanoid.WalkSpeed
            humanoid.WalkSpeed = originalSpeed * 2
            task.wait(5)
            if humanoid and humanoid.Parent then
                humanoid.WalkSpeed = originalSpeed
            end
        end
    end
})

-- Teleport & Hold toggle
local holding = false
local teleportConnection
LocalPlayerTab:CreateToggle({
    Name = "Teleport & Hold",
    CurrentValue = false,
    Flag = "TeleportHold",
    Callback = function(state)
        holding = state
        if teleportConnection then
            teleportConnection:Disconnect()
            teleportConnection = nil
        end
        if state then
            teleportConnection = RunService.Heartbeat:Connect(function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local rootPart = player.Character.HumanoidRootPart
                    rootPart.CFrame = CFrame.new(0, 5, 0)
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
                    workspace.CurrentCamera.CFrame = rootPart.CFrame + Vector3.new(0, 5, 10)
                end
            end)
        else
            if teleportConnection then
                teleportConnection:Disconnect()
                teleportConnection = nil
            end
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        end
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
            player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
        end
    end
})

-- Teleport to spawn
TeleporterTab:CreateButton({
    Name = "Teleport to Spawn",
    Callback = function()
        local spawn = workspace:FindFirstChildWhichIsA("SpawnLocation")
        if spawn and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
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
                player.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            else
                warn("Target player not found or invalid!")
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
                table.remove(dropdown.Options, i)
                if selectedPlayer == plr.Name then selectedPlayer = nil end
                break
            end
        end
        dropdown:RefreshOptions()
    end
end)

-- ==================== Combat Tab ====================
local CombatTab = Window:CreateTab("🚀Combat🚀", 4483362458)
CombatTab:CreateLabel("Combat features")

-- AutoClick variables
local autoClick = false
local cps = 10
local autoClickConnection = nil

-- AutoClick toggle
CombatTab:CreateToggle({
    Name = "AutoClick",
    CurrentValue = false,
    Flag = "AutoClick",
    Callback = function(state)
        autoClick = state
        if autoClickConnection then
            autoClickConnection:Disconnect()
            autoClickConnection = nil
        end
        if state then
            autoClickConnection = RunService.Heartbeat:Connect(function()
                local character = player.Character
                if character then
                    local tool = character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                end
                task.wait(1 / cps)
            end)
        end
    end
})

-- CPS slider for AutoClick
CombatTab:CreateSlider({
    Name = "Clicks Per Second",
    Range = {1, 50},
    Increment = 1,
    Suffix = "CPS",
    CurrentValue = 10,
    Flag = "CPS",
    Callback = function(val)
        cps = val
    end
})

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
    Range = {1, 10},
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = 1,
    Flag = "AttackSpeed",
    Callback = function(val)
        print("Attack Speed set to:", val)
    end
})

-- Aimbot variables
local aimbot = false
local aimFov = 200
local aimbotConnection = nil

-- Aimbot FOV slider
CombatTab:CreateSlider({
    Name = "Aimbot FOV",
    Range = {50, 500},
    Increment = 10,
    Suffix = "pixels",
    CurrentValue = 200,
    Flag = "AimbotFOV",
    Callback = function(val)
        aimFov = val
    end
})

-- Aimbot toggle
CombatTab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Flag = "Aimbot",
    Callback = function(state)
        aimbot = state
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end
        if state then
            aimbotConnection = RunService.RenderStepped:Connect(function()
                local closest = nil
                local minDist = math.huge
                local camera = workspace.CurrentCamera
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") and plr.Character.Humanoid.Health > 0 then
                        local head = plr.Character.Head
                        local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
                        if onScreen then
                            local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                            if dist < aimFov and dist < minDist then
                                minDist = dist
                                closest = head
                            end
                        end
                    end
                end
                if closest then
                    camera.CFrame = CFrame.lookAt(camera.CFrame.Position, closest.Position)
                end
            end)
        end
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
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
                    end
                else
                    if highlight then highlight:Destroy() end
                end
            end
        end
    end
})

-- ESP Names
local espNames = {}
VisualsTab:CreateToggle({
    Name = "ESP Names",
    CurrentValue = false,
    Flag = "ESPNames",
    Callback = function(state)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
                local head = plr.Character.Head
                local gui = espNames[plr]
                if state then
                    if not gui then
                        gui = Instance.new("BillboardGui")
                        gui.Name = "ESPName"
                        gui.Parent = head
                        gui.Size = UDim2.new(4, 0, 1, 0)
                        gui.StudsOffset = Vector3.new(0, 3, 0)
                        gui.AlwaysOnTop = true
                        local textLabel = Instance.new("TextLabel")
                        textLabel.Parent = gui
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                        textLabel.BackgroundTransparency = 1
                        textLabel.Text = plr.Name
                        textLabel.TextColor3 = Color3.new(1, 1, 1)
                        textLabel.TextScaled = true
                        textLabel.Font = Enum.Font.Gotham
                        espNames[plr] = gui
                    end
                else
                    if gui then
                        gui:Destroy()
                        espNames[plr] = nil
                    end
                end
            end
        end
    end
})

Players.PlayerAdded:Connect(function(plr)
    if plr ~= player and VisualsTab:GetFlag("ESPNames") then
        plr.CharacterAdded:Connect(function(char)
            local head = char:WaitForChild("Head")
            local gui = Instance.new("BillboardGui")
            gui.Name = "ESPName"
            gui.Parent = head
            gui.Size = UDim2.new(4, 0, 1, 0)
            gui.StudsOffset = Vector3.new(0, 3, 0)
            gui.AlwaysOnTop = true
            local textLabel = Instance.new("TextLabel")
            textLabel.Parent = gui
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.Text = plr.Name
            textLabel.TextColor3 = Color3.new(1, 1, 1)
            textLabel.TextScaled = true
            textLabel.Font = Enum.Font.Gotham
            espNames[plr] = gui
        end)
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if espNames[plr] then
        espNames[plr]:Destroy()
        espNames[plr] = nil
    end
end)

-- FOV Slider
VisualsTab:CreateSlider({
    Name = "Field of View",
    Range = {30, 120},
    Increment = 1,
    Suffix = "degrees",
    CurrentValue = workspace.CurrentCamera.FieldOfView,
    Flag = "FOVSlider",
    Callback = function(val)
        workspace.CurrentCamera.FieldOfView = val
    end
})

-- Background color picker
VisualsTab:CreateColorPicker({
    Name = "Background Color",
    Default = Color3.fromRGB(50, 50, 50),
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
    Range = {0, 500},
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
    Range = {0, 24},
    Increment = 0.1,
    Suffix = "hours",
    CurrentValue = tonumber(game.Lighting.TimeOfDay:sub(1, 2)),
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
