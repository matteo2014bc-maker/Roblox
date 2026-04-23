-- [[ BYRDZ UI FRAMEWORK - v3.1 THE "PANEL" EDITION ]]
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Byrdz = {}

function Byrdz:CreateWindow(customTitle)
	local UIThemes = {
		["Deep Sea Blue"] = Color3.fromRGB(0, 35, 102),
		["Vampire Red"] = Color3.fromRGB(180, 0, 0),
		["Toxic Green"] = Color3.fromRGB(50, 255, 50),
		["Neon Pink"] = Color3.fromRGB(255, 20, 147),
		["Golden Byrd"] = Color3.fromRGB(255, 215, 0),
		["Aqua Marine"] = Color3.fromRGB(0, 255, 255),
		["Midnight Gray"] = Color3.fromRGB(45, 45, 45),
		["Pure White"] = Color3.fromRGB(255, 255, 255)
	}

	local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
	ScreenGui.Name = "Byrdz_Final_V3_1"
	ScreenGui.ResetOnSpawn = false

	-- [[ DRAGGABLE MINI OPEN BUTTON ]]
	local OpenButton = Instance.new("TextButton", ScreenGui)
	OpenButton.BackgroundColor3 = UIThemes["Deep Sea Blue"]
	OpenButton.Position = UDim2.new(0, 20, 0.5, -20)
	OpenButton.Size = UDim2.new(0, 60, 0, 60)
	OpenButton.Visible = false
	OpenButton.Text = "B"
	OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	OpenButton.Font = Enum.Font.GothamBold
	OpenButton.TextSize = 25
	Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 12)
	Instance.new("UIStroke", OpenButton).Thickness = 2

	local bDrag, bStart, bPos
	OpenButton.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then bDrag = true bStart = i.Position bPos = OpenButton.Position end end)
	UserInputService.InputChanged:Connect(function(i) if bDrag and i.UserInputType == Enum.UserInputType.MouseMovement then local d = i.Position - bStart OpenButton.Position = UDim2.new(bPos.X.Scale, bPos.X.Offset + d.X, bPos.Y.Scale, bPos.Y.Offset + d.Y) end end)
	UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then bDrag = false end end)

	-- [[ MAIN FRAME ]]
	local MainFrame = Instance.new("Frame", ScreenGui)
	MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	MainFrame.BackgroundTransparency = 0.2 
	MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
	MainFrame.Size = UDim2.new(0, 520, 0, 380)
	Instance.new("UICorner", MainFrame)

	-- [[ TOP BAR ]]
	local TopBar = Instance.new("Frame", MainFrame)
	TopBar.BackgroundColor3 = UIThemes["Deep Sea Blue"]
	TopBar.Size = UDim2.new(1, 0, 0, 45)
	Instance.new("UICorner", TopBar)

	-- [[ BRANDING: BYRDZ | PANEL ]]
	local Title = Instance.new("TextLabel", TopBar)
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0, 20, 0, 0)
	Title.Size = UDim2.new(1, -80, 1, 0)
	Title.Font = Enum.Font.GothamBold
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 18
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.RichText = true
	local subText = customTitle or "Panel"
	Title.Text = "BYRDZ <font color='#AAAAAA'>|</font> " .. subText

	local CloseBtn = Instance.new("TextButton", TopBar)
	CloseBtn.BackgroundTransparency = 1
	CloseBtn.Position = UDim2.new(1, -45, 0, 0)
	CloseBtn.Size = UDim2.new(0, 45, 1, 0)
	CloseBtn.Text = "X"
	CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseBtn.Font = Enum.Font.GothamBold
	CloseBtn.TextSize = 22

	local Sidebar = Instance.new("Frame", MainFrame)
	Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Sidebar.BackgroundTransparency = 0.6
	Sidebar.Position = UDim2.new(0, 10, 0, 55)
	Sidebar.Size = UDim2.new(0, 120, 1, -65)
	Instance.new("UICorner", Sidebar)
	local TabList = Instance.new("UIListLayout", Sidebar)
	TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabList.Padding = UDim.new(0, 6)
	TabList.SortOrder = Enum.SortOrder.LayoutOrder

	local PageFolder = Instance.new("Folder", MainFrame)
	local tabCount = 0

	function Byrdz:CreateTab(name, isSettings)
		tabCount = tabCount + 1
		local TabBtn = Instance.new("TextButton", Sidebar)
		TabBtn.Size = UDim2.new(0.9, 0, 0, 40)
		TabBtn.BackgroundTransparency = 1
		TabBtn.Text = name
		TabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
		TabBtn.Font = Enum.Font.GothamBold
		TabBtn.TextSize = 14
		TabBtn.LayoutOrder = isSettings and 9999 or tabCount

		local Page = Instance.new("ScrollingFrame", PageFolder)
		Page.BackgroundTransparency = 1
		Page.Position = UDim2.new(0, 140, 0, 55)
		Page.Size = UDim2.new(1, -150, 1, -65)
		Page.Visible = false
		Page.ScrollBarThickness = 0
		Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
		local PageLayout = Instance.new("UIListLayout", Page)
		PageLayout.Padding = UDim.new(0, 10)
		PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

		TabBtn.MouseButton1Click:Connect(function()
			for _, p in pairs(PageFolder:GetChildren()) do p.Visible = false end
			for _, b in pairs(Sidebar:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(180,180,180) end end
			Page.Visible = true
			TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		end)

		local Elements = {}

		function Elements:CreateButton(text, callback)
			local Btn = Instance.new("TextButton", Page)
			Btn.Size = UDim2.new(0.95, 0, 0, 45)
			Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Btn.Text = text
			Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			Btn.Font = Enum.Font.GothamBold
			Btn.TextSize = 16
			Instance.new("UICorner", Btn)
			Btn.MouseButton1Click:Connect(callback)
		end

		function Elements:CreateToggle(text, callback)
			local TglFrame = Instance.new("Frame", Page)
			TglFrame.Size = UDim2.new(0.95, 0, 0, 45)
			TglFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Instance.new("UICorner", TglFrame)
			local TglText = Instance.new("TextLabel", TglFrame)
			TglText.BackgroundTransparency = 1
			TglText.Position = UDim2.new(0, 15, 0, 0)
			TglText.Size = UDim2.new(1, -60, 1, 0)
			TglText.Text = text
			TglText.TextColor3 = Color3.fromRGB(255, 255, 255)
			TglText.Font = Enum.Font.GothamBold
			TglText.TextSize = 16
			TglText.TextXAlignment = Enum.TextXAlignment.Left
			local Box = Instance.new("Frame", TglFrame)
			Box.Position = UDim2.new(1, -40, 0.5, -12)
			Box.Size = UDim2.new(0, 30, 0, 24)
			Box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Instance.new("UICorner", Box)
			local enabled = false
			TglFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					enabled = not enabled
					TweenService:Create(Box, TweenInfo.new(0.3), {BackgroundColor3 = enabled and TopBar.BackgroundColor3 or Color3.fromRGB(50, 50, 50)}):Play()
					callback(enabled)
				end
			end)
		end

		function Elements:CreateSlider(text, min, max, callback)
			local SldFrame = Instance.new("Frame", Page)
			SldFrame.Size = UDim2.new(0.95, 0, 0, 60)
			SldFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Instance.new("UICorner", SldFrame)
			local SldText = Instance.new("TextLabel", SldFrame)
			SldText.Text = text .. ": " .. min
			SldText.Size = UDim2.new(1, 0, 0, 30)
			SldText.BackgroundTransparency = 1
			SldText.TextColor3 = Color3.fromRGB(255, 255, 255)
			SldText.Font = Enum.Font.GothamBold
			SldText.TextSize = 16
			local Bar = Instance.new("Frame", SldFrame)
			Bar.Position = UDim2.new(0.1, 0, 0.75, 0)
			Bar.Size = UDim2.new(0.8, 0, 0, 6)
			Bar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			local Fill = Instance.new("Frame", Bar)
			Fill.Size = UDim2.new(0, 0, 1, 0)
			Fill.BackgroundColor3 = TopBar.BackgroundColor3
			local dragging = false
			local function update()
				local p = math.clamp((Mouse.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
				local val = math.floor(min + (max - min) * p)
				SldText.Text = text .. ": " .. val
				Fill.Size = UDim2.new(p, 0, 1, 0)
				callback(val)
			end
			SldFrame.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true update() end end)
			UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
			RunService.RenderStepped:Connect(function() if dragging then update() end end)
		end
		return Elements, Page
	end

	-- Settings
	local Settings, SetPage = Byrdz:CreateTab("Settings", true)
	SetPage.Visible = true
	local DropFrame = Instance.new("Frame", SetPage)
	DropFrame.Size = UDim2.new(0.95, 0, 0, 45)
	DropFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	DropFrame.ClipsDescendants = true
	Instance.new("UICorner", DropFrame)
	local ToggleBtn = Instance.new("TextButton", DropFrame)
	ToggleBtn.Size = UDim2.new(1, 0, 0, 45)
	ToggleBtn.BackgroundTransparency = 1
	ToggleBtn.Text = "  ▼ SELECT THEME"
	ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	ToggleBtn.Font = Enum.Font.GothamBold
	ToggleBtn.TextSize = 15
	ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UIListLayout", DropFrame)
	ToggleBtn.MouseButton1Click:Connect(function()
		local d = DropFrame.Size.Y.Offset == 45
		TweenService:Create(DropFrame, TweenInfo.new(0.3), {Size = UDim2.new(0.95, 0, 0, d and 350 or 45)}):Play()
	end)
	for n, v in pairs(UIThemes) do
		local O = Instance.new("TextButton", DropFrame)
		O.Size = UDim2.new(1, 0, 0, 35)
		O.BackgroundTransparency = 1
		O.Text = "      " .. n
		O.TextColor3 = v
		O.Font = Enum.Font.GothamBold
		O.MouseButton1Click:Connect(function()
			TopBar.BackgroundColor3 = v
			OpenButton.BackgroundColor3 = v
		end)
	end

	CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenButton.Visible = true end)
	OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = true OpenButton.Visible = false end)
	local d, ds, sp
	TopBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true ds = i.Position sp = MainFrame.Position end end)
	UserInputService.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then local del = i.Position - ds MainFrame.Position = UDim2.new(sp.X.Scale, sp.X.Offset + del.X, sp.Y.Scale, sp.Y.Offset + del.Y) end end)
	UserInputService.InputEnded:Connect(function() d = false end)

	return Byrdz
end

-- [[ CLEAN EXECUTION ]]
local Lib = Byrdz:CreateWindow("Panel") 

-- Start adding your real tabs and buttons below!
