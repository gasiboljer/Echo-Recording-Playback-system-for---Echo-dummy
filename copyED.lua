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