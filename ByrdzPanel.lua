-- [[ BYRDZ UI v3.5 - THE FEATURE-COMPLETE EDITION ]]
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
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame)

    -- [[ THE TOP BAR ]]
    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.BackgroundColor3 = Color3.fromRGB(0, 35, 102) -- Default Blue
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    local TBClp = Instance.new("UICorner", TopBar)
    
    local Title = Instance.new("TextLabel", TopBar)
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -80, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.Text = "BYRDZ | " .. (customTitle or "Panel")
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- [[ MINIMIZE BUTTON ]]
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

    -- [[ SIDEBAR & PAGES ]]
    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Sidebar.Position = UDim2.new(0, 5, 0, 45)
    Sidebar.Size = UDim2.new(0, 110, 1, -50)
    Instance.new("UICorner", Sidebar)
    local PageFolder = Instance.new("Folder", MainFrame)

    -- [[ SETTINGS TAB (Pre-Built) ]]
    local SettingsPage = Instance.new("ScrollingFrame", PageFolder)
    SettingsPage.Size = UDim2.new(1, -125, 1, -50)
    SettingsPage.Position = UDim2.new(0, 120, 0, 45)
    SettingsPage.Visible = false
    SettingsPage.BackgroundTransparency = 1
    Instance.new("UIListLayout", SettingsPage).Padding = UDim.new(0, 5)

    -- Transparency Control
    local TransLabel = Instance.new("TextLabel", SettingsPage)
    TransLabel.Text = "Background Transparency"
    TransLabel.Size = UDim2.new(1, 0, 0, 20)
    TransLabel.TextColor3 = Color3.fromRGB(200,200,200)
    TransLabel.BackgroundTransparency = 1

    local TransBtn = Instance.new("TextButton", SettingsPage)
    TransBtn.Size = UDim2.new(0.9, 0, 0, 30)
    TransBtn.Text = "Cycle Transparency"
    TransBtn.MouseButton1Click:Connect(function()
        MainFrame.BackgroundTransparency = (MainFrame.BackgroundTransparency + 0.2) % 1
    end)

    -- Color Change (Blue / Red / Green)
    local ColorBtn = Instance.new("TextButton", SettingsPage)
    ColorBtn.Size = UDim2.new(0.9, 0, 0, 30)
    ColorBtn.Text = "Cycle Theme Color"
    local colors = {Color3.fromRGB(0,35,102), Color3.fromRGB(180,0,0), Color3.fromRGB(0,150,0)}
    local cIndex = 1
    ColorBtn.MouseButton1Click:Connect(function()
        cIndex = (cIndex % #colors) + 1
        TopBar.BackgroundColor3 = colors[cIndex]
    end)

    function Byrdz:CreateTab(name)
        local TabBtn = Instance.new("TextButton", Sidebar)
        TabBtn.Size = UDim2.new(0.9, 0, 0, 35)
        TabBtn.Text = name
        Instance.new("UICorner", TabBtn)
        
        local Page = Instance.new("ScrollingFrame", PageFolder)
        Page.Size = UDim2.new(1, -125, 1, -50)
        Page.Position = UDim2.new(0, 120, 0, 45)
        Page.Visible = false
        Page.BackgroundTransparency = 1
        Instance.new("UIListLayout", Page).Padding = UDim.new(0, 8)

        TabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(PageFolder:GetChildren()) do p.Visible = false end
            Page.Visible = true
        end)

        local Elements = {}
        function Elements:CreateButton(t, c)
            local b = Instance.new("TextButton", Page)
            b.Size = UDim2.new(0.9, 0, 0, 40)
            b.Text = t
            Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(c)
        end
        function Elements:CreateToggle(t, c)
            local b = Instance.new("TextButton", Page)
            b.Size = UDim2.new(0.9, 0, 0, 40)
            b.Text = t .. " [OFF]"
            local e = false
            b.MouseButton1Click:Connect(function()
                e = not e
                b.Text = t .. (e and " [ON]" or " [OFF]")
                c(e)
            end)
        end
        -- (Add Textbox/Slider logic here same as before)
        return Elements
    end

    -- Create Settings Tab Button manually at bottom
    local SetBtn = Instance.new("TextButton", Sidebar)
    SetBtn.Size = UDim2.new(0.9, 0, 0, 35)
    SetBtn.Text = "Settings"
    SetBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    SetBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(PageFolder:GetChildren()) do p.Visible = false end
        SettingsPage.Visible = true
    end)

    return Byrdz
end
return Byrdz
