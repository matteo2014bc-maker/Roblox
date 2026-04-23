-- [[ BYRDZ UI FRAMEWORK - v3.2 THE "COMPLETE" EDITION ]]
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
		["Midnight Gray"] = Color3.fromRGB(45, 45, 45),
		["Vampire Red"] = Color3.fromRGB(180, 0, 0),
		["Toxic Green"] = Color3.fromRGB(50, 255, 50)
	}

	local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
	ScreenGui.Name = "Byrdz_Final_V3_2"
	ScreenGui.ResetOnSpawn = false

	-- [[ MAIN FRAME ]]
	local MainFrame = Instance.new("Frame", ScreenGui)
	MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	MainFrame.BackgroundTransparency = 0.1 
	MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
	MainFrame.Size = UDim2.new(0, 520, 0, 380)
	Instance.new("UICorner", MainFrame)

	-- [[ TOP BAR ]]
	local TopBar = Instance.new("Frame", MainFrame)
	TopBar.BackgroundColor3 = UIThemes["Deep Sea Blue"]
	TopBar.Size = UDim2.new(1, 0, 0, 45)
	Instance.new("UICorner", TopBar)
	
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

	-- [[ SIDEBAR ]]
	local Sidebar = Instance.new("Frame", MainFrame)
	Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Sidebar.BackgroundTransparency = 0.6
	Sidebar.Position = UDim2.new(0, 10, 0, 55)
	Sidebar.Size = UDim2.new(0, 120, 1, -65)
	Instance.new("UICorner", Sidebar)
	local TabList = Instance.new("UIListLayout", Sidebar)
	TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabList.Padding = UDim.new(0, 6)

	local PageFolder = Instance.new("Folder", MainFrame)

	function Byrdz:CreateTab(name)
		local TabBtn = Instance.new("TextButton", Sidebar)
		TabBtn.Size = UDim2.new(0.9, 0, 0, 40)
		TabBtn.BackgroundTransparency = 1
		TabBtn.Text = name
		TabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
		TabBtn.Font = Enum.Font.GothamBold
		TabBtn.TextSize = 14
		
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

		-- BUTTON
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

		-- TOGGLE
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

		-- SLIDER
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

		-- TEXTBOX
		function Elements:CreateTextbox(text, placeholder, callback)
			local TxtFrame = Instance.new("Frame", Page)
			TxtFrame.Size = UDim2.new(0.95, 0, 0, 50)
			TxtFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Instance.new("UICorner", TxtFrame)
			local TxtLabel = Instance.new("TextLabel", TxtFrame)
			TxtLabel.Text = "  " .. text
			TxtLabel.Size = UDim2.new(0.4, 0, 1, 0)
			TxtLabel.BackgroundTransparency = 1
			TxtLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			TxtLabel.Font = Enum.Font.GothamBold
			TxtLabel.TextSize = 14
			TxtLabel.TextXAlignment = Enum.TextXAlignment.Left
			local Input = Instance.new("TextBox", TxtFrame)
			Input.Size = UDim2.new(0.55, -10, 0, 30)
			Input.Position = UDim2.new(0.4, 5, 0.5, -15)
			Input.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Input.TextColor3 = Color3.fromRGB(255, 255, 255)
			Input.PlaceholderText = placeholder or "Type..."
			Input.Font = Enum.Font.Gotham
			Input.TextSize = 14
			Instance.new("UICorner", Input)
			Input.FocusLost:Connect(function(enter) if enter then callback(Input.Text) end end)
		end

		return Elements, Page
	end

	-- Dragging Logic
	local d, ds, sp
	TopBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true ds = i.Position sp = MainFrame.Position end end)
	UserInputService.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then local del = i.Position - ds MainFrame.Position = UDim2.new(sp.X.Scale, sp.X.Offset + del.X, sp.Y.Scale, sp.Y.Offset + del.Y) end end)
	UserInputService.InputEnded:Connect(function() d = false end)
	
	return Byrdz
end

return Byrdz
