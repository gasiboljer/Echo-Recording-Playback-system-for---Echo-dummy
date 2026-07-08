local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local ECHO_DELAY = 10
local RECORD_RATE = 0.1
local playerHistory = {}

local function spawnEcho(player)
	local dummyTemplate = ServerStorage:FindFirstChild("EchoDummy")
	if not dummyTemplate then return end
	local echo = dummyTemplate:Clone()
	echo.Parent = workspace
	local echoRoot = echo:FindFirstChild("HumanoidRootPart") or echo.PrimaryPart
	task.spawn(function()
		while echo.Parent do
			local history = playerHistory[player]
			local targetTime = tick() - ECHO_DELAY
			for i, record in ipairs(history) do
				if record.time >= targetTime then
					echoRoot.CFrame = record.cframe
					break
				end
			end
			task.wait(RECORD_RATE)
		end
	end)
end
local function onPlayerAdded(player)
	playerHistory[player] = {}
	player.CharacterAdded:Connect(function(character)
		local root = character:WaitForChild("HumanoidRootPart")
		local elapsed = 0
		local connection
		connection = RunService.Heartbeat:Connect(function(deltaTime)
			if not character.Parent then
				connection:Disconnect()
				return
			end
			elapsed = elapsed + deltaTime
			if elapsed >= RECORD_RATE then
				elapsed = 0
				table.insert(playerHistory[player], {time = tick(), cframe = root.CFrame})
			end
		end)
		task.wait(ECHO_DELAY)
		spawnEcho(player)
	end)
end
Players.PlayerAdded:Connect(onPlayerAdded)