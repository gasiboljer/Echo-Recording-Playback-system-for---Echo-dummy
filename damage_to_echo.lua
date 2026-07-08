local function setupEchoCollision(echo, player)
	local echoRoot = echo:FindFirstChild("HumanoidRootPart") or echo.PrimaryPart
	local recentlyHit = {}
	local echoHealth = 3 

	echoRoot.Touched:Connect(function(hit)
		local character = hit.Parent
		local humanoid = character:FindFirstChild("Humanoid")

		if not humanoid then return end
		if recentlyHit[character] then return end

		recentlyHit[character] = true
		humanoid.Health = 0

		task.delay(1, function()
			recentlyHit[character] = nil
		end)
	end)

	local function damageEcho(amount)
		echoHealth = echoHealth - amount
		if echoHealth <= 0 then
			echo:Destroy()
		end
	end

	return damageEcho 
end