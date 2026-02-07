local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer

-- Limpar versões antigas
if CoreGui:FindFirstChild("PlayersList_System") then
    CoreGui:FindFirstChild("PlayersList_System"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "PlayersList_System"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 220, 0, 520)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -35, 0, 35)
Title.Position = UDim2.new(0, 5, 0, 0)
Title.Text = "sharopin God 2.0"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- EFEITO RGB
spawn(function()
    while wait() do
        local hue = tick() % 5 / 5
        Title.TextColor3 = Color3.fromHSV(hue, 1, 1)
    end
end)

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Visible = true

-- BOTÃO MINIMIZAR
local Minimized = false
local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0, 2)
MinBtn.Text = "_"
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

MinBtn.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    ContentFrame.Visible = not Minimized
    MainFrame.Size = Minimized and UDim2.new(0, 220, 0, 35) or UDim2.new(0, 220, 0, 520)
    MinBtn.Text = Minimized and "+" or "_"
end)

-- SISTEMA DE FLY
local flying = false
local flySpeed = 50
local bv, bg

local function startFly()
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    flying = true
    local root = lp.Character.HumanoidRootPart
    bv = Instance.new("BodyVelocity", root)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bg = Instance.new("BodyGyro", root)
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bg.P = 9e4
    lp.Character.Humanoid.PlatformStand = true
    spawn(function()
        while flying do
            RunService.RenderStepped:Wait()
            bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeed
            bg.CFrame = workspace.CurrentCamera.CFrame
        end
    end)
end

local function stopFly()
    flying = false
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.PlatformStand = false
    end
end

-- BOTOES DO MENU
local FlyBtn = Instance.new("TextButton", ContentFrame)
FlyBtn.Size = UDim2.new(0.9, 0, 0, 30)
FlyBtn.Position = UDim2.new(0.05, 0, 0, 5)
FlyBtn.Text = "FLY: OFF"
FlyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FlyBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", FlyBtn)

FlyBtn.MouseButton1Click:Connect(function()
    if flying then stopFly() FlyBtn.Text="FLY: OFF" FlyBtn.BackgroundColor3=Color3.fromRGB(60,60,60)
    else startFly() FlyBtn.Text="FLY: ON" FlyBtn.BackgroundColor3=Color3.fromRGB(0,150,0) end
end)

local SpeedLabel = Instance.new("TextLabel", ContentFrame)
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 40)
SpeedLabel.Text = "Velocidade Fly: "..flySpeed
SpeedLabel.TextColor3 = Color3.new(1,1,1)
SpeedLabel.BackgroundTransparency = 1

local IncF = Instance.new("TextButton", ContentFrame)
IncF.Size = UDim2.new(0.43, 0, 0, 25)
IncF.Position = UDim2.new(0.05, 0, 0, 60)
IncF.Text = "Speed +"
IncF.BackgroundColor3 = Color3.fromRGB(40,40,40)
IncF.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", IncF)
IncF.MouseButton1Click:Connect(function() flySpeed = flySpeed + 10 SpeedLabel.Text = "Velocidade Fly: "..flySpeed end)

local DecF = Instance.new("TextButton", ContentFrame)
DecF.Size = UDim2.new(0.43, 0, 0, 25)
DecF.Position = UDim2.new(0.52, 0, 0, 60)
DecF.Text = "Speed -"
DecF.BackgroundColor3 = Color3.fromRGB(40,40,40)
DecF.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", DecF)
DecF.MouseButton1Click:Connect(function() flySpeed = math.max(10, flySpeed - 10) SpeedLabel.Text = "Velocidade Fly: "..flySpeed end)

local GhostBtn = Instance.new("TextButton", ContentFrame)
GhostBtn.Size = UDim2.new(0.9, 0, 0, 30)
GhostBtn.Position = UDim2.new(0.05, 0, 0, 95)
GhostBtn.Text = "GHOST MODE: OFF"
GhostBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
GhostBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", GhostBtn)

local gActive = false
GhostBtn.MouseButton1Click:Connect(function()
    gActive = not gActive
    GhostBtn.Text = gActive and "GHOST MODE: ON" or "GHOST MODE: OFF"
    GhostBtn.BackgroundColor3 = gActive and Color3.fromRGB(130,0,255) or Color3.fromRGB(60,60,60)
    if lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then v.Transparency = gActive and 0.95 or 0
            elseif v:IsA("Decal") then v.Transparency = gActive and 1 or 0 end
        end
    end
end)

_G.MasterSwitch = true
local Mast = Instance.new("TextButton", ContentFrame)
Mast.Size = UDim2.new(0.9, 0, 0, 30)
Mast.Position = UDim2.new(0.05, 0, 0, 130)
Mast.Text = "ESP: ATIVADO"
Mast.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
Mast.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Mast)
Mast.MouseButton1Click:Connect(function()
    _G.MasterSwitch = not _G.MasterSwitch
    Mast.Text = _G.MasterSwitch and "ESP: ATIVADO" or "ESP: DESATIVADO"
    Mast.BackgroundColor3 = _G.MasterSwitch and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

local Scroll = Instance.new("ScrollingFrame", ContentFrame)
Scroll.Size = UDim2.new(1, -10, 0, 230)
Scroll.Position = UDim2.new(0, 5, 0, 170)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 5)

-- ESP E LISTA
local function CreateESP(p)
    local b = Instance.new("BoxHandleAdornment", CoreGui)
    b.AlwaysOnTop = true; b.ZIndex = 10; b.Transparency = 0.5; b.Size = Vector3.new(4,6,1)
    RunService.RenderStepped:Connect(function()
        if _G.MasterSwitch and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            b.Adornee = p.Character.HumanoidRootPart
            b.Color3 = (p.Team == lp.Team) and Color3.new(0,1,0) or Color3.new(1,0,0)
        else b.Adornee = nil end
    end)
end

local function UpdateList()
    for _, v in pairs(Scroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp then
            local btn = Instance.new("TextButton", Scroll)
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Text = "TP: "..p.DisplayName
            btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
            btn.TextColor3 = Color3.new(1,1,1)
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
RunService.RenderStepped:Connect(function() Scroll.CanvasSize = UDim2.new(0,0,0, Layout.AbsoluteContentSize.Y) end)
