-- QUOCHUY HUB / GAME TOOL MAIN

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-------------------------------------------------
-- GLOBAL SETTINGS
-------------------------------------------------

getgenv().Settings = {
AutoFarm = false,
AutoBoss = false,
AutoEvents = false
}

-------------------------------------------------
-- SAFE PLAYER FUNCTIONS
-------------------------------------------------

local function GetCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function GetRoot()
    local char = GetCharacter()
    return char:WaitForChild("HumanoidRootPart")
end

-------------------------------------------------
-- QUEST TABLE (EXPANDABLE)
-------------------------------------------------

local QuestTable = {

-- Example progression
{Min = 1, Max = 9, Enemy = "Bandit"},
{Min = 10, Max = 19, Enemy = "Monkey"},
{Min = 20, Max = 39, Enemy = "Gorilla"},
{Min = 40, Max = 59, Enemy = "Pirate"},
{Min = 60, Max = 99, Enemy = "DesertBandit"},

}

-------------------------------------------------
-- LEVEL SYSTEM
-------------------------------------------------

local function GetLevel()

local data = LocalPlayer:FindFirstChild("Data")
if not data then return 1 end

local level = data:FindFirstChild("Level")
if not level then return 1 end

return level.Value

end

local function GetQuest()

local level = GetLevel()

for _,quest in pairs(QuestTable) do

if level >= quest.Min and level <= quest.Max then
return quest
end

end

return nil

end

-------------------------------------------------
-- SIMPLE EVENT DETECTOR
-------------------------------------------------

local function DetectFullMoon()

if Lighting.ClockTime == 0 then
print("Full Moon detected in game world")
end

end

-------------------------------------------------
-- EVENT LOOP
-------------------------------------------------

task.spawn(function()

while true do
task.wait(5)

if getgenv().Settings.AutoEvents then
DetectFullMoon()
end

end

end)

-------------------------------------------------
-- DEBUG INFO
-------------------------------------------------

print("QuocHuy main.lua loaded successfully")
