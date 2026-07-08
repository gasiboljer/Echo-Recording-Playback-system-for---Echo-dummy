local tool = script.Parent
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local RemoteEvent = game.ReplicatedStorage:WaitForChild("VacuumEvent")
tool.Activated:Connect(function()
	RemoteEvent:FireServer(mouse.Hit.Position)
end)