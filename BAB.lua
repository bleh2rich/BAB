local automationEnabled = false
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local stagesPath = workspace.BoatStages.NormalStages
local endTrigger = stagesPath.TheEnd.GoldenChest.Trigger

local function teleportTo(part)
    if part and player.Character then
        player.Character:MoveTo(part.Position)
        wait(0.45)
    end
end

local function startAutomation()
    while automationEnabled do
        character = player.Character or player.CharacterAdded:Wait()
        if not character or not character:FindFirstChild("Humanoid") then
            break
        end

        for i = 1, 10 do
            local stage = stagesPath:FindFirstChild("CaveStage" .. i)
            if stage then
                local darknessPart = stage:FindFirstChild("DarknessPart")
                if darknessPart then
                    teleportTo(darknessPart)
                end
            end
        end

        teleportTo(endTrigger)
        wait(23)
        workspace:WaitForChild("ClaimRiverResultsGold"):FireServer()
        wait(10)
    end
end

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.Name = "AutomationGUI"
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 100)
mainFrame.Position = UDim2.new(0.5, -100, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
mainFrame.BackgroundTransparency = 0.1
local mainFrameCorner = Instance.new("UICorner")
mainFrameCorner.CornerRadius = UDim.new(0, 8)
mainFrameCorner.Parent = mainFrame

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Build A Boat - Wattyhub"
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.Parent = topBar

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(1, -20, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 40)
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleButton.Text = "Turn On"
toggleButton.Font = Enum.Font.SourceSans
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 20
toggleButton.Parent = mainFrame
local toggleButtonCorner = Instance.new("UICorner")
toggleButtonCorner.CornerRadius = UDim.new(0, 8)
toggleButtonCorner.Parent = toggleButton

toggleButton.MouseButton1Click:Connect(function()
    automationEnabled = not automationEnabled
    toggleButton.Text = automationEnabled and "Turn Off" or "Turn On"
    toggleButton.BackgroundColor3 = automationEnabled and Color3.fromRGB(100, 60, 60) or Color3.fromRGB(60, 60, 60)

    if automationEnabled then
        startAutomation()
    end
end)

local notification = Instance.new("TextLabel")
notification.Size = UDim2.new(0, 300, 0, 50)
notification.Position = UDim2.new(0.5, 0, 0.5, 0)
notification.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
notification.TextColor3 = Color3.fromRGB(255, 255, 255)
notification.Text = "Thank you for choosing Wattyhub"
notification.Font = Enum.Font.SourceSansBold
notification.TextSize = 18
notification.Parent = screenGui
notification.AnchorPoint = Vector2.new(0.5, 0.5)
notification.BackgroundTransparency = 0.2
local notificationCorner = Instance.new("UICorner")
notificationCorner.CornerRadius = UDim.new(0, 10)
notificationCorner.Parent = notification

game:GetService("TweenService"):Create(notification, TweenInfo.new(3.5, Enum.EasingStyle.Linear), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
game.Debris:AddItem(notification, 3.5)
