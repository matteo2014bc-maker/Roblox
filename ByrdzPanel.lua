local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Byrdz = {}

function Byrdz:CreateWindow(customTitle)
    local ScreenGui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
    ScreenGui.Name = "Byrdz_Final"
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BackgroundTransparency = 0.2 -- Translucent by default
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.ClipsDescendants = true
    MainFrame.Active = true
    MainFrame.Draggable = true 
    Instance.new("UICorner", MainFrame)

    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.BackgroundColor3 = Color3.fromRGB(0, 35, 102)
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    Instance.new("UICorner", TopBar)
    
    local Title = Instance.new("TextLabel", TopBar)
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Size = UDim2.new(1, -80, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.Text = "BYRDZ | " .. (customTitle or "Panel")
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local MinBtn = Instance.new("TextButton", TopBar)
    MinBtn.Text = "-"
    MinBtn.Size = UDim2.new(0, 30, 0, 30)
    MinBtn.Position = UDim2.new(1, -35, 0, 5)
    MinBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", MinBtn)
    
    local minimized = false
    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        MainFrame:TweenSize(minimized and UDim2.new(0, 500, 0, 40) or UDim2.new(0, 500, 0, 350), "Out", "Quad", 0.3, true)
    end)

    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    Sidebar.BackgroundTransparency = 0.5
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
        TabBtn.Text = name
        TabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        Instance.new("UICorner", TabBtn)
        
        local Page = Instance.new("ScrollingFrame", PageFolder)
        Page.Size = UDim2.new(1, -125, 1, -50)
        Page.Position = UDim2.new(0, 120, 0, 45)
        Page.Visible = false
        Page.BackgroundTransparency = 1
        Page.ScrollBarThickness = 0
        Instance.new("UIListLayout", Page).Padding = UDim.new(0, 8)

        TabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(PageFolder:GetChildren()) do p.Visible = false end
            Page.Visible = true
        end)

        local Elements = {}
        function Elements:CreateButton(t, c)
            local b = Instance.new("TextButton", Page)
            b.Size = UDim2.new(0.95, 0, 0, 40)
            b.Text = t
            b.BackgroundColor3 = Color3.fromRGB(35,35,35)
            b.TextColor3 = Color3.fromRGB(255,255,255)
            Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(c)
        end
        function Elements:CreateToggle(t, c)
            local b = Instance.new("TextButton", Page)
            b.Size = UDim2.new(0.95, 0, 0, 40)
            b.Text = t .. " [OFF]"
            b.BackgroundColor3 = Color3.fromRGB(35,35,35)
            b.TextColor3 = Color3.fromRGB(255,255,255)
            Instance.new("UICorner", b)
            local e = false
            b.MouseButton1Click:Connect(function()
                e = not e
                b.Text = t .. (e and " [ON]" or " [OFF]")
                b.BackgroundColor3 = e and Color3.fromRGB(0,80,0) or Color3.fromRGB(35,35,35)
                c(e)
            end)
        end
        return Elements
    end

    return Byrdz
end

return Byrdz
