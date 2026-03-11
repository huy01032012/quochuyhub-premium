if not game:IsLoaded() then
	game.Loaded:Wait()
end

repeat task.wait() until game.Players.LocalPlayer

print("quochuyhub-premium loading...")

-- quochuyhub-premium UI V3

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

-------------------------------------------------
-- BLUR BACKGROUND
-------------------------------------------------

local blur = Instance.new("BlurEffect")
blur.Size = 18
blur.Parent = Lighting

-------------------------------------------------
-- LOADING SCREEN
-------------------------------------------------

local loading = Instance.new("ScreenGui",game.CoreGui)

local loadFrame = Instance.new("Frame",loading)
loadFrame.Size = UDim2.new(0,400,0,200)
loadFrame.Position = UDim2.new(0.5,-200,0.5,-100)
loadFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)

Instance.new("UICorner",loadFrame)

local loadText = Instance.new("TextLabel",loadFrame)
loadText.Size = UDim2.new(1,0,1,0)
loadText.BackgroundTransparency = 1
loadText.TextScaled = true
loadText.TextColor3 = Color3.fromRGB(255,210,60)
loadText.Text = "quochuyhub-premium\nLoading..."

task.wait(2)

loadText.Text = "Welcome "..player.Name
task.wait(1)

loading:Destroy()

-------------------------------------------------
-- CONFIG SAVE SYSTEM
-------------------------------------------------

local configFile = "quochuyhub_config.json"

local config = {
	speed = 16
}

pcall(function()
	if readfile and isfile(configFile) then
		config = HttpService:JSONDecode(readfile(configFile))
	end
end)

local function saveConfig()

	if writefile then
		writefile(configFile,HttpService:JSONEncode(config))
	end

end

-------------------------------------------------
-- MAIN GUI
-------------------------------------------------

local gui = Instance.new("ScreenGui",game.CoreGui)

local main = Instance.new("Frame",gui)
main.Size = UDim2.new(0,650,0,420)
main.Position = UDim2.new(0.5,-325,1,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)

Instance.new("UICorner",main)

local stroke = Instance.new("UIStroke",main)
stroke.Color = Color3.fromRGB(255,210,60)

-------------------------------------------------
-- OPEN ANIMATION
-------------------------------------------------

TweenService:Create(
	main,
	TweenInfo.new(0.5,Enum.EasingStyle.Quad),
	{Position = UDim2.new(0.5,-325,0.5,-210)}
):Play()

-------------------------------------------------
-- DRAGGABLE GUI
-------------------------------------------------

local dragging = false
local dragStart
local startPos

main.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end

end)

main.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end

end)

UIS.InputChanged:Connect(function(input)

	if dragging then

		local delta = input.Position - dragStart

		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)

	end

end)

-------------------------------------------------
-- SIDEBAR
-------------------------------------------------

local sidebar = Instance.new("Frame",main)
sidebar.Size = UDim2.new(0,160,1,0)
sidebar.BackgroundColor3 = Color3.fromRGB(30,30,30)

local title = Instance.new("TextLabel",sidebar)
title.Size = UDim2.new(1,0,0,50)
title.Text = "quochuyhub"
title.BackgroundTransparency = 1
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255,210,60)

-------------------------------------------------
-- CONTENT AREA
-------------------------------------------------

local content = Instance.new("Frame",main)
content.Size = UDim2.new(1,-160,1,0)
content.Position = UDim2.new(0,160,0,0)
content.BackgroundTransparency = 1

-------------------------------------------------
-- TAB SYSTEM
-------------------------------------------------

local icons = {
	Main = "rbxassetid://7733960981",
	Player = "rbxassetid://7734056608",
	Misc = "rbxassetid://7734010485"
}

local tabs = {}
local tabFrames = {}

local function createTab(name,order)

	local btn = Instance.new("TextButton",sidebar)
	btn.Size = UDim2.new(1,0,0,40)
	btn.Position = UDim2.new(0,0,0,60+(order*45))
	btn.Text = "  "..name
	btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
	btn.TextColor3 = Color3.new(1,1,1)

	local icon = Instance.new("ImageLabel",btn)
	icon.Size = UDim2.new(0,20,0,20)
	icon.Position = UDim2.new(0,5,0.5,-10)
	icon.BackgroundTransparency = 1
	icon.Image = icons[name]

	local frame = Instance.new("Frame",content)
	frame.Size = UDim2.new(1,0,1,0)
	frame.Visible = false
	frame.BackgroundTransparency = 1

	tabFrames[name] = frame

	btn.MouseButton1Click:Connect(function()

		for _,v in pairs(tabFrames) do
			v.Visible = false
		end

		frame.Position = UDim2.new(0.1,0,0,0)
		frame.Visible = true

		TweenService:Create(
			frame,
			TweenInfo.new(0.25),
			{Position = UDim2.new(0,0,0,0)}
		):Play()

	end)

	return frame
end

-------------------------------------------------
-- CREATE TABS
-------------------------------------------------

local mainTab = createTab("Main",1)
local playerTab = createTab("Player",2)
local miscTab = createTab("Misc",3)

tabFrames["Main"].Visible = true

-------------------------------------------------
-- TOGGLE SYSTEM
-------------------------------------------------

local function createToggle(parent,text,callback)

	local toggle = Instance.new("TextButton",parent)
	toggle.Size = UDim2.new(0,220,0,40)
	toggle.Position = UDim2.new(0,20,0,20)
	toggle.Text = text.." : OFF"
	toggle.BackgroundColor3 = Color3.fromRGB(45,45,45)

	local state = false

	toggle.MouseButton1Click:Connect(function()

		state = not state

		toggle.Text = text.." : "..(state and "ON" or "OFF")

		callback(state)

	end)

end

-------------------------------------------------
-- SLIDER SYSTEM
-------------------------------------------------

local function createSlider(parent,text,min,max,callback)

	local slider = Instance.new("TextButton",parent)
	slider.Size = UDim2.new(0,220,0,40)
	slider.Position = UDim2.new(0,20,0,80)

	local value = min

	slider.Text = text.." : "..value

	slider.MouseButton1Click:Connect(function()

		value += 5
		if value > max then value = min end

		slider.Text = text.." : "..value

		callback(value)

		config.speed = value
		saveConfig()

	end)

end

-------------------------------------------------
-- NOTIFICATION
-------------------------------------------------

local function Notify(text)

	game.StarterGui:SetCore("SendNotification",{
		Title = "quochuyhub-premium",
		Text = text,
		Duration = 4
	})

end

-------------------------------------------------
-- EXAMPLE UI
-------------------------------------------------

createToggle(mainTab,"Example Toggle",function(v)
	print("toggle:",v)
end)

createSlider(playerTab,"Speed",10,100,function(v)
	print("speed:",v)
end)

Notify("UI Loaded Successfully")
