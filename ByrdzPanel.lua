local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Byrdz = {}

function Byrdz:CreateWindow(customTitle)
    local ScreenGui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
    ScreenGui.Name = "Byrdz_Final"
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Active = true
    MainFrame.Draggable = true -- Built-in backup dragging
    Instance.new("UICorner", MainFrame)

    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.BackgroundColor3 = Color3.fromRGB(0, 35, 102)
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    Instance.new("UICorner", TopBar)
    
    local Title = Instance.new("TextLabel", TopBar)
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.Text = "  BYRDZ | " .. (customTitle or "Panel")
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Sidebar.Position = UDim2.new(0, 5, 0, 45)
    Sidebar.Size = UDim2.new(0, 110, 1, -50)
    Instance.new("UICorner", Sidebar)

    local TabList = Instance.new("UIListLayout", Sidebar)
    TabList.Padding = UDim.new(0, 5)
    TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local PageFolder = Instance.new("Folder", MainFrame)

    function Byrdz:CreateTab(name)
        local TabBtn = Instance.new("TextButton", Sidebar)
        TabBtn.Size = UDim2.new(0.9, 0, 0, 35)
        TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TabBtn.Text = name
        TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabBtn.Font = Enum.Font.GothamBold
        Instance.new("UICorner", TabBtn)
        
        local Page = Instance.new("ScrollingFrame", PageFolder)
        Page.BackgroundTransparency = 1
        Page.Position = UDim2.new(0, 120, 0, 45)
        Page.Size = UDim2.new(1, -125, 1, -50)
        Page.Visible = false
        Page.ScrollBarThickness = 2
        Page.BorderSizePixel = 0
        local PageLayout = Instance.new("UIListLayout", Page)
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

        TabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(PageFolder:GetChildren()) do p.Visible = false end
            Page.Visible = true
        end)

        local Elements = {}

        function Elements:CreateButton(text, callback)
            local Btn = Instance.new("TextButton", Page)
            Btn.Size = UDim2.new(0.9, 0, 0, 40)
            Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Btn.Text = text
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.Font = Enum.Font.GothamBold
            Instance.new("UICorner", Btn)
            Btn.MouseButton1Click:Connect(callback)
        end

        function Elements:CreateToggle(text, callback)
            local Tgl = Instance.new("TextButton", Page)
            Tgl.Size = UDim2.new(0.9, 0, 0, 40)
            Tgl.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Tgl.Text = text .. " [OFF]"
            Tgl.TextColor3 = Color3.fromRGB(255, 255, 255)
            Tgl.Font = Enum.Font.GothamBold
            Instance.new("UICorner", Tgl)
            local enabled = false
            Tgl.MouseButton1Click:Connect(function()
                enabled = not enabled
                Tgl.Text = text .. (enabled and " [ON]" or " [OFF]")
                Tgl.BackgroundColor3 = enabled and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(35, 35, 35)
                callback(enabled)
            end)
        end

        function Elements:CreateSlider(text, min, max, callback)
            local Sld = Instance.new("TextButton", Page) -- Simplified slider for stability
            Sld.Size = UDim2.new(0.9, 0, 0, 40)
            Sld.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Sld.Text = text .. " (Click to cycle)"
            Instance.new("UICorner", Sld)
            local val = min
            Sld.MouseButton1Click:Connect(function()
                val = val + 10
                if val > max then val = min end
                Sld.Text = text .. ": " .. val
                callback(val)
            end)
        end

        function Elements:CreateTextbox(text, placeholder, callback)
            local Box = Instance.new("TextBox", Page)
            Box.Size = UDim2.new(0.9, 0, 0, 40)
            Box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            Box.PlaceholderText = text .. " (" .. placeholder .. ")"
            Box.Text = ""
            Box.TextColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", Box)
            Box.FocusLost:Connect(function(e) if e then callback(Box.Text) end end)
        end

        return Elements
    end
    return Byrdz
end

return Byrdz
