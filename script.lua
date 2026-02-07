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
MainFrame.Size = UDim2.new(0, 220, 0, 460) -- Aumentei um pouco o tamanho para o novo botão
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -30, 0, 35)
Title.Text = "SHAROPIN GOD"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

spawn(function()
    while wait() do
        local hue = tick() % 5 / 5
        Title.TextColor3 = Color3.fromHSV(hue, 1, 1)
    end
end)

local Minimized = false
local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0, 2)
MinBtn.Text = "_"
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundTransparency = 1

MinBtn.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        ContentFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 220, 0, 35)
        MinBtn.Text = "+"
    else
        ContentFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 220, 0, 460)
        MinBtn.Text = "_"
    end
end)

_G.MasterSwitch = true
local MasterBtn = Instance.new("TextButton", ContentFrame)
MasterBtn.Size = UDim2.new(0.9, 0, 0, 35)
MasterBtn.Position = UDim2.new(0.05, 0, 0, 0)
MasterBtn.Text = "FUNÇÕES: ATIVADO"
MasterBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
MasterBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MasterBtn)

MasterBtn.MouseButton1Click:Connect(function()
    _G.MasterSwitch = not _G.MasterSwitch
    MasterBtn.Text = _G.MasterSwitch and "STATUS: ATIVADO" or "STATUS: DESATIVADO"
    MasterBtn.BackgroundColor3 = _G.MasterSwitch and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    if not _G.MasterSwitch and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = 16
    end
end)

-- BOTÃO DE INVISIBILIDADE (SEPARADO)
local Invisible = false
local InvisBtn = Instance.new("TextButton", ContentFrame)
InvisBtn.Size = UDim2.new(0.9, 0, 0, 30)
InvisBtn.Position = UDim2.new(0.05, 0, 0, 40)
InvisBtn.Text = "INVISÍVEL: OFF"
InvisBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
InvisBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", InvisBtn)

InvisBtn.MouseButton1Click:Connect(function()
    Invisible = not Invisible
    InvisBtn.Text = Invisible and "INVISÍVEL: ON" or "INVISÍVEL: OFF"
    InvisBtn.BackgroundColor3 = Invisible and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(60, 60, 60)
    
    local char = lp.Character
    if char and char:FindFirstChild("LowerTorso") then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            -- Técnica simples de invisibilidade local
            for _, v in pairs(char:GetChildren()) do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                    v.Transparency = Invisible and 1 or 0
                elseif v:IsA("Accessory") and v:FindFirstChild("Handle") then
                    v.Handle.Transparency = Invisible and 1 or 0
                end
            end
            if char:FindFirstChild("Head") and char.Head:FindFirstChild("face") then
                char.Head.face.Transparency = Invisible and 1 or 0
            end
        end
    end
end)

local SpeedBtn = Instance.new("TextButton", ContentFrame)
SpeedBtn.Size = UDim2.new(0.9, 0, 0, 30)
SpeedBtn.Position = UDim2.new(0.05, 0, 0, 75)
SpeedBtn.Text = "Velocidade: 50"
SpeedBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", SpeedBtn)

SpeedBtn.MouseButton1Click:Connect(function()
    if _G.MasterSwitch and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = 50
    end
end)

local Scroll = Instance.new("ScrollingFrame", ContentFrame)
Scroll.Size = UDim2.new(1, -10, 0, 240)
Scroll.Position = UDim2.new(0, 5, 0, 115)
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
        if _G.MasterSwitch and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            box.Adornee = player.Character.HumanoidRootPart
            box.Color3 = (player.Team == lp.Team) and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
        else
            box.Adornee = nil
        end
    end)
end

local function UpdateList()
    for _, item in pairs(Scroll:GetChildren()) do if item:IsA("TextButton") then item:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp then
            local btn = Instance.new("TextButton", Scroll)
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Text = "TP: " .. p.DisplayName
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            btn.TextColor3 = Color3.new(1, 1, 1)
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                if _G.MasterSwitch and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
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
