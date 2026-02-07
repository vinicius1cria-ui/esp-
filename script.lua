local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()

if CoreGui:FindFirstChild("PlayersList_System") then
    CoreGui:FindFirstChild("PlayersList_System"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "PlayersList_System"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 220, 0, 520) -- Aumentado para caber o Fly
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -30, 0, 35)
Title.Text = " Sharopin GOD"
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

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundTransparency = 1

-- SISTEMA DE FLY
local flying = false
local flySpeed = 50
local bv, bg

local function startFly()
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    flying = true
    local root = char.HumanoidRootPart
    
    bv = Instance.new("BodyVelocity", root)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Velocity = Vector3.new(0, 0, 0)
    
    bg = Instance.new("BodyGyro", root)
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bg.P = 9e4
    
    char.Humanoid.PlatformStand = true
    
    spawn(function()
        while flying do
            RunService.RenderStepped:Wait()
            bg.CFrame = workspace.CurrentCamera.CFrame
            local dir = Vector3.new(0,0,0)
            
            -- Controle simples: voa para onde a câmera aponta
            bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeed
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

-- BOTÃO FLY (LIGA/DESLIGA)
local FlyBtn = Instance.new("TextButton", ContentFrame)
FlyBtn.Size = UDim2.new(0.9, 0, 0, 30)
FlyBtn.Position = UDim2.new(0.05, 0, 0, 0)
FlyBtn.Text = "VOAR: OFF"
FlyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FlyBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", FlyBtn)

FlyBtn.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
        FlyBtn.Text = "VOAR: OFF"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    else
        startFly()
        FlyBtn.Text = "VOAR: ON"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    end
end)

-- CONTROLES DE VELOCIDADE DO FLY
local SpeedLabel = Instance.new("TextLabel", ContentFrame)
SpeedLabel.Size = UDim2.new(0.9, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0.05, 0, 0, 35)
SpeedLabel.Text = "Velocidade Fly: " .. flySpeed
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.BackgroundTransparency = 1

local IncFly = Instance.new("TextButton", ContentFrame)
IncFly.Size = UDim2.new(0.42, 0, 0, 25)
IncFly.Position = UDim2.new(0.05, 0, 0, 55)
IncFly.Text = "Aumentar +"
IncFly.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
IncFly.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", IncFly)

local DecFly = Instance.new("TextButton", ContentFrame)
DecFly.Size = UDim2.new(0.42, 0, 0, 25)
DecFly.Position = UDim2.new(0.53, 0, 0, 55)
DecFly.Text = "Diminuir -"
DecFly.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
DecFly.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", DecFly)

IncFly.MouseButton1Click:Connect(function()
    flySpeed = flySpeed + 10
    SpeedLabel.Text = "Velocidade Fly: " .. flySpeed
end)

DecFly.MouseButton1Click:Connect(function()
    flySpeed = math.max(10, flySpeed - 10)
    SpeedLabel.Text = "Velocidade Fly: " .. flySpeed
end)

-- FUNÇÕES ANTIGAS (Mantidas abaixo)
_G.MasterSwitch = true
local MasterBtn = Instance.new("TextButton", ContentFrame)
MasterBtn.Size = UDim2.new(0.9, 0, 0, 30)
MasterBtn.Position = UDim2.new(0.05, 0, 0, 90)
MasterBtn.Text = "STATUS: ATIVADO"
MasterBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
MasterBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MasterBtn)

MasterBtn.MouseButton1Click:Connect(function()
    _G.MasterSwitch = not _G.MasterSwitch
    MasterBtn.Text = _G.MasterSwitch and "STATUS: ATIVADO" or "STATUS: DESATIVADO"
    MasterBtn.BackgroundColor3 = _G.MasterSwitch and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
end)

local GhostBtn = Instance.new("TextButton", ContentFrame)
GhostBtn.Size = UDim2.new(0.9, 0, 0, 30)
GhostBtn.Position = UDim2.new(0.05, 0, 0, 125)
GhostBtn.Text = "GHOST MODE: OFF"
GhostBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
GhostBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", GhostBtn)

local GhostActive = false
GhostBtn.MouseButton1Click:Connect(function()
    GhostActive = not GhostActive
    GhostBtn.Text = GhostActive and "GHOST MODE: ON" or "GHOST MODE: OFF"
    GhostBtn.BackgroundColor3 = GhostActive and Color3.fromRGB(130, 0, 255) or Color3.fromRGB(60, 60, 60)
    if lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                v.Transparency = GhostActive and 0.95 or 0
            elseif v:IsA("Decal") then
                v.Transparency = GhostActive and 1 or 0
            end
        end
    end
end)

local Scroll = Instance.new("ScrollingFrame", ContentFrame)
Scroll.Size = UDim2.new(1, -10, 0, 200)
Scroll.Position = UDim2.new(0, 5, 0, 165)
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
        if _G.MasterSwitch and
                
