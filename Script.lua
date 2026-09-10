-- NoClip + ESP Script
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- NoClip
local noclipEnabled = true
local function noclip()
    if noclipEnabled then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

game:GetService("RunService").Stepped:Connect(function()
    noclip()
end)

-- ESP
local espEnabled = true
local function createESP(target)
    if not target:FindFirstChild("ESPBox") then
        local box = Instance.new("BoxHandleAdornment")
        box.Name = "ESPBox"
        box.Size = target.Size + Vector3.new(1, 1, 1)
        box.Adornee = target
        box.AlwaysOnTop = true
        box.ZIndex = 5
        box.Color3 = Color3.new(1, 0, 0)
        box.Transparency = 0.5
        box.Parent = target
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if espEnabled then
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                createESP(plr.Character)
            end
        end
    end
end)
