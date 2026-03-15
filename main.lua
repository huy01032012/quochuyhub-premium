-- QUOCHUY HUB FULL

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TPService = game:GetService("TeleportService")
local Http = game:GetService("HttpService")

local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()

local Remotes = RS:WaitForChild("Remotes")
local CommF = Remotes:WaitForChild("CommF_")

-------------------------------------------------
-- SETTINGS
-------------------------------------------------

getgenv().AutoFarm=false
getgenv().AutoBoss=false
getgenv().AutoSeaBeast=false
getgenv().AutoLeviathan=false
getgenv().AutoKitsune=false
getgenv().AutoVolcano=false
getgenv().FruitSniper=false

-------------------------------------------------
-- RAYFIELD GUI
-------------------------------------------------

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
Name = "QuocHuy Hub",
LoadingTitle = "BloxFruit Clone Hub",
LoadingSubtitle = "Auto System"
})

local Main = Window:CreateTab("Main",4483362458)

Main:CreateToggle({
Name="Auto Farm",
CurrentValue=false,
Callback=function(v)
getgenv().AutoFarm=v
end
})

Main:CreateToggle({
Name="Auto Boss",
CurrentValue=false,
Callback=function(v)
getgenv().AutoBoss=v
end
})

Main:CreateToggle({
Name="Auto Sea Beast",
CurrentValue=false,
Callback=function(v)
getgenv().AutoSeaBeast=v
end
})

Main:CreateToggle({
Name="Fruit Sniper",
CurrentValue=false,
Callback=function(v)
getgenv().FruitSniper=v
end
})

-------------------------------------------------
-- QUEST TABLE (LEVEL SYSTEM)
-------------------------------------------------

local QuestTable={

{Min=1,Max=9,Mob="Bandit",Quest="BanditQuest1",Level=1},
{Min=10,Max=14,Mob="Monkey",Quest="JungleQuest",Level=1},
{Min=15,Max=29,Mob="Gorilla",Quest="JungleQuest",Level=2},
{Min=30,Max=39,Mob="Pirate",Quest="BuggyQuest1",Level=1},
{Min=40,Max=59,Mob="Brute",Quest="BuggyQuest1",Level=2},

{Min=60,Max=74,Mob="Desert Bandit",Quest="DesertQuest",Level=1},
{Min=75,Max=89,Mob="Desert Officer",Quest="DesertQuest",Level=2},

{Min=90,Max=99,Mob="Snow Bandit",Quest="SnowQuest",Level=1},
{Min=100,Max=119,Mob="Snowman",Quest="SnowQuest",Level=2},

{Min=700,Max=724,Mob="Raider",Quest="Area1Quest",Level=1},
{Min=725,Max=774,Mob="Mercenary",Quest="Area1Quest",Level=2},

{Min=1500,Max=1524,Mob="Pirate Millionaire",Quest="PiratePortQuest",Level=1},
{Min=1525,Max=1574,Mob="Pistol Billionaire",Quest="PiratePortQuest",Level=2}

}

-------------------------------------------------
-- LEVEL FUNCTIONS
-------------------------------------------------

function GetLevel()
return LP.Data.Level.Value
end

function GetQuest()

local Level=GetLevel()

for i,v in pairs(QuestTable) do
if Level>=v.Min and Level<=v.Max then
return v
end
end

end

-------------------------------------------------
-- AUTO FARM
-------------------------------------------------

task.spawn(function()

while task.wait() do

if getgenv().AutoFarm then

local Quest=GetQuest()

for i,v in pairs(workspace.Enemies:GetChildren()) do

if v.Name==Quest.Mob and v:FindFirstChild("Humanoid") then

repeat task.wait()

Char.HumanoidRootPart.CFrame=
v.HumanoidRootPart.CFrame*CFrame.new(0,0,5)

until v.Humanoid.Health<=0

end
end

end

end

end)

-------------------------------------------------
-- AUTO BOSS
-------------------------------------------------

task.spawn(function()

while task.wait() do

if getgenv().AutoBoss then

for i,v in pairs(workspace.Enemies:GetChildren()) do

if string.find(v.Name,"Boss") then

repeat task.wait()

Char.HumanoidRootPart.CFrame=
v.HumanoidRootPart.CFrame*CFrame.new(0,10,0)

until v.Humanoid.Health<=0

end
end

end

end

end)

-------------------------------------------------
-- AUTO SEA BEAST
-------------------------------------------------

task.spawn(function()

while task.wait() do

if getgenv().AutoSeaBeast then

if workspace:FindFirstChild("SeaBeasts") then

for i,v in pairs(workspace.SeaBeasts:GetChildren()) do

repeat task.wait()

Char.HumanoidRootPart.CFrame=
v.HumanoidRootPart.CFrame*CFrame.new(0,50,0)

until v.Humanoid.Health<=0

end

end

end

end

end)

-------------------------------------------------
-- AUTO LEVIATHAN
-------------------------------------------------

task.spawn(function()

while task.wait() do

if getgenv().AutoLeviathan then

if workspace:FindFirstChild("Leviathan") then

local boss=workspace.Leviathan

repeat task.wait()

Char.HumanoidRootPart.CFrame=
boss.HumanoidRootPart.CFrame*CFrame.new(0,60,0)

until boss.Humanoid.Health<=0

end

end

end

end)

-------------------------------------------------
-- AUTO KITSUNE
-------------------------------------------------

task.spawn(function()

while task.wait() do

if getgenv().AutoKitsune then

if workspace:FindFirstChild("KitsuneIsland") then

Char.HumanoidRootPart.CFrame=
workspace.KitsuneIsland.CFrame

end

end

end

end)

-------------------------------------------------
-- VOLCANO EVENT
-------------------------------------------------

task.spawn(function()

while task.wait() do

if getgenv().AutoVolcano then

if workspace:FindFirstChild("VolcanoIsland") then

local island=workspace.VolcanoIsland

for i,v in pairs(island:GetChildren()) do

if v.Name=="Golem" then

repeat task.wait()

Char.HumanoidRootPart.CFrame=
v.HumanoidRootPart.CFrame

until v.Humanoid.Health<=0

end

end

end

end

end

end)

-------------------------------------------------
-- FRUIT SNIPER + SERVER HOP
-------------------------------------------------

task.spawn(function()

while task.wait(10) do

if getgenv().FruitSniper then

local found=false

for i,v in pairs(workspace:GetChildren()) do

if string.find(v.Name,"Fruit") then

Char.HumanoidRootPart.CFrame=v.CFrame
found=true

end
end

if not found then

local servers=Http:JSONDecode(game:HttpGet(
"https://games.roblox.com/v1/games/"..
game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))

for i,v in pairs(servers.data) do

if v.playing<v.maxPlayers then

TPService:TeleportToPlaceInstance(game.PlaceId,v.id)

end
end

end

end

end

end)
