local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- CONFIGURAÇÃO DA VELOCIDADE
_G.SpeedEnabled = false
_G.SpeedValue = 50

-- LIMPEZA
if lp.PlayerGui:FindFirstChild("KingSpeed") then lp.PlayerGui.KingSpeed:Destroy() end

-- UI BASE
local sg = Instance.new("ScreenGui", lp.PlayerGui)
sg.Name = "KingSpeed"
sg.ResetOnSpawn = false

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 200, 0, 150)
main.Position = UDim2.new(0.2, 0, 0.2, 0)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.Active = true
main.Draggable = true

-- BOTÃO MINIMIZAR
local min = Instance.new("TextButton", main)
min.Size = UDim2.new(0, 40, 0, 30)
min.Text = "-"
min.MouseButton1Click:Connect(function()
    main.Visible = false
    -- Criar botão de abrir se fechar
end)

-- TOGGLE SPEED
local toggle = Instance.new("TextButton", main)
toggle.Size = UDim2.new(0.8, 0, 0, 30)
toggle.Position = UDim2.new(0.1, 0, 0.2, 0)
toggle.Text = "SPEED: OFF"
toggle.MouseButton1Click:Connect(function()
    _G.SpeedEnabled = not _G.SpeedEnabled
    toggle.Text = _G.SpeedEnabled and "SPEED: ON" or "SPEED: OFF"
end)

-- AJUSTAR VELOCIDADE
local plus = Instance.new("TextButton", main)
plus.Size = UDim2.new(0, 40, 0, 30)
plus.Position = UDim2.new(0.6, 0, 0.6, 0)
plus.Text = "+"
plus.MouseButton1Click:Connect(function() _G.SpeedValue = _G.SpeedValue + 5 end)

local minus = Instance.new("TextButton", main)
minus.Size = UDim2.new(0, 40, 0, 30)
minus.Position = UDim2.new(0.1, 0, 0.6, 0)
minus.Text = "-"
minus.MouseButton1Click:Connect(function() _G.SpeedValue = _G.SpeedValue - 5 end)

-- LÓGICA
RunService.Stepped:Connect(function()
    if _G.SpeedEnabled and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = _G.SpeedValue
    end
end)

