local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer

if CoreGui:FindFirstChild("PlayersList_System") then
    CoreGui:FindFirstChild("PlayersList_System"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "PlayersList_System"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 220, 0, 380)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "HUB - ESP POR TIME"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

local SpeedBtn = Instance.new("TextButton", MainFrame)
SpeedBtn.Size = UDim2.new(0.9, 0, 0, 30)
SpeedBtn.Position = UDim2.new(0.05, 0, 0, 40)
SpeedBtn.Text = "Velocidade: 50"
SpeedBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", SpeedBtn)

SpeedBtn.MouseButton1Click:Connect(function()
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = 50
    end
end)

local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -10, 0, 260)
Scroll.Position = UDim2.new(0, 5, 0, 80)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2

local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 5)

local function CreateESP(player)
    local box = Instance.new("BoxHandleAdornment", CoreGui)
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Transparency = 0.5
    box.Size = Vector3.new(4, 6, 1)

    RunService.RenderStepped:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            box.Adornee = player.Character.HumanoidRootPart
            
            -- Lógica de Cor por Time
            if player.Team == lp.Team then
                box.Color3 = Color3.new(0, 1, 0) -- Verde (Amigo)
            else
                box.Color3 = Color3.new(1, 0, 0) -- Vermelho (Inimigo)
            end
        else
            box.Adornee = nil
        end
    end)
end

local function UpdateList()
    for _, item in pairs(Scroll:GetChildren()) do
        if item:IsA("TextButton") then item:Destroy() end
    end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp then
            local btn = Instance.new("TextButton", Scroll)
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Text = "TP: " .. p.DisplayName
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            btn.TextColor3 = Color3.new(1, 1, 1)
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    lp.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                end
            end)
        end
    end
end

for _, p in pairs(Players:GetPlayers()) do if p ~= lp then CreateESP(p) end end
Players.PlayerAdded:Connect(function(p) CreateESP(p) UpdateList() end)
Players.PlayerRemoving:Connect(UpdateList)
UpdateList()

RunService.RenderStepped:Connect(function()
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
end)
