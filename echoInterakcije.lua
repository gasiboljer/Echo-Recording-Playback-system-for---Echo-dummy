local function setupEchoCollision(echo, player)
	local echoRoot = echo:FindFirstChild("HumanoidRootPart") or echo.PrimaryPart
	local touched = false

	echoRoot.Touched:Connect(function(hit)
		if touched then return end

		local character = hit.Parent
		local humanoid = character:FindFirstChild("Humanoid")

		if character == player.Character and humanoid then
			touched = true
			humanoid.Health = 0 -- ubija igraca
			task.wait(1)
			touched = false
		end
	end)
end