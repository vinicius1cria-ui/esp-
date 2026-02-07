local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("PlayersList_System") then
    CoreGui:FindFirstChild("PlayersList_System"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PlayersList_System"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 300)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "TELEPORT LIST"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "PlayerScroll"
ScrollingFrame.Size = UDim2.new(1, -10, 1, -45)
ScrollingFrame.Position = UDim2.new(0, 5, 0, 40)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 2
ScrollingFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function TeleportToPlayer(targetPlayer)
    local localPlayer = Players.LocalPlayer
    if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetPos = targetPlayer.Character.HumanoidRootPart.CFrame
            localPlayer.Character.HumanoidRootPart.CFrame = targetPos
        end
    end
end

local function UpdateList()
    for _, item in pairs(ScrollingFrame:GetChildren()) do
        if item:IsA("TextButton") then
            item:Destroy()
        end
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            local PlayerBtn = Instance.new("TextButton")
            PlayerBtn.Name = p.Name
            PlayerBtn.Size = UDim2.new(1, -10, 0, 30)
            PlayerBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            PlayerBtn.Text = "  " .. p.DisplayName
            PlayerBtn.TextColor3 = Color3.new(1, 1, 1)
            PlayerBtn.TextXAlignment = Enum.TextXAlignment.Left
            PlayerBtn.Font = Enum.Font.Gotham
            PlayerBtn.TextSize = 14
            PlayerBtn.Parent = ScrollingFrame

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 4)
            BtnCorner.Parent = PlayerBtn

            PlayerBtn.MouseButton1Click:Connect(function()
                TeleportToPlayer(p)
            end)
        end
    end
end

Players.PlayerAdded:Connect(UpdateList)
Players.PlayerRemoving:Connect(UpdateList)
UpdateList()

RunService.RenderStepped:Connect(function()
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
end)
