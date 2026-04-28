-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Configuration & UI State
local config = {
    HeroColor = Color3.fromRGB(0, 162, 255), -- Blue
    MurdererColor = Color3.fromRGB(255, 0, 0), -- Red
    InnocentColor = Color3.fromRGB(0, 255, 0), -- Green
    RainbowEnabled = false,
    TracersEnabled = true
}

--- 1. Role & Highlight Logic (Player/Name ESP)
local function applyVisuals(player)
    if player == LocalPlayer then return end

    local function onCharacterAdded(char)
        -- Highlight System
        local highlight = Instance.new("Highlight")
        highlight.Name = "AdminHighlight"
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = char

        -- Metadata Label (Name ESP)
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "StateLabel"
        billboard.Size = UDim2.new(0, 100, 0, 50)
        billboard.Adornee = char:WaitForChild("Head")
        billboard.AlwaysOnTop = true
        billboard.ExtentsOffset = Vector3.new(0, 3, 0)
        billboard.Parent = char

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.new(1, 1, 1)
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextSize = 14
        nameLabel.Text = player.Name
        nameLabel.Parent = billboard

        -- Role Monitoring Loop
        task.spawn(function()
            while char.Parent do
                local color = config.InnocentColor
                
                -- Hero/Sheriff logic (Checks for 'Gun' or 'Revolver')
                local hasGun = player.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun") or 
                               player.Backpack:FindFirstChild("Revolver") or char:FindFirstChild("Revolver")
                
                if hasGun then
                    color = config.HeroColor
                end
                
                highlight.FillColor = color
                nameLabel.TextColor3 = color
                task.wait(1)
            end
        end)
    end

    if player.Character then onCharacterAdded(player.Character) end
    player.CharacterAdded:Connect(onCharacterAdded)
end

--- 2. World Item Tracking (Dropped Gun ESP)
-- Checks for a dropped gun part in the workspace
local function trackDroppedItems()
    for _, item in ipairs(workspace:GetDescendants()) do
        if item.Name == "Gun" and item:IsA("BasePart") and not item:FindFirstChild("ItemLabel") then
            local bill = Instance.new("BillboardGui")
            bill.Name = "ItemLabel"
            bill.Size = UDim2.new(0, 80, 0, 40)
            bill.AlwaysOnTop = true
            bill.Adornee = item
            bill.Parent = item

            local txt = Instance.new("TextLabel")
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.BackgroundTransparency = 1
            txt.Text = "GUN"
            txt.TextColor3 = config.HeroColor
            txt.Font = Enum.Font.SourceSansBold
            txt.Parent = bill
        end
    end
end

--- 3. Tracer System (Line ESP)
-- Uses WorldToViewportPoint to calculate 2D positions for lines
local function updateTracers()
    -- Standard tracer logic would draw a Line object from the screen bottom 
    -- to the target position calculated here:
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local vector, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                -- Logic to update line position would go here
            end
        end
    end
end

-- Execution Loops
RunService.Heartbeat:Connect(function()
    trackDroppedItems()
    updateTracers()
end)

for _, p in ipairs(Players:GetPlayers()) do applyVisuals(p) end
Players.PlayerAdded:Connect(applyVisuals)
