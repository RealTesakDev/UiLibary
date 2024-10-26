-- Core Silent Aim Settings
local SilentAimSettings = {
    Enabled = false,
    TeamCheck = false,
    VisibleCheck = false, 
    TargetPart = "HumanoidRootPart",
    SilentAimMethod = "Raycast",
    FOVRadius = 130,
    FOVVisible = false,
    ShowSilentAimTarget = false,
    MouseHitPrediction = false,
    MouseHitPredictionAmount = 0.165,
    HitChance = 100
}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Drawing Objects (for FOV circle and target indicator)
local mouse_text = Drawing.new("Text")
mouse_text.Visible = false
mouse_text.ZIndex = 999
mouse_text.Color = Color3.fromRGB(54, 57, 241)
mouse_text.Size = 20
mouse_text.Center = true
mouse_text.Text = "Target"
mouse_text.Font = Drawing.Fonts.UI

local fov_circle = Drawing.new("Circle")
fov_circle.Thickness = 1
fov_circle.NumSides = 100
fov_circle.Radius = 180
fov_circle.Filled = false
fov_circle.Visible = false
fov_circle.ZIndex = 999
fov_circle.Transparency = 1
fov_circle.Color = Color3.fromRGB(54, 57, 241)

-- Utility Functions
local function CalculateChance(Percentage)
    Percentage = math.floor(Percentage)
    local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100
    return chance <= Percentage / 100
end

local function getMousePosition()
    return UserInputService:GetMouseLocation()
end

local function IsPlayerVisible(Player)
    local PlayerCharacter = Player.Character
    local LocalPlayerCharacter = LocalPlayer.Character
    
    if not (PlayerCharacter and LocalPlayerCharacter) then return false end
    
    local PlayerRoot = PlayerCharacter:FindFirstChild(SilentAimSettings.TargetPart) or PlayerCharacter:FindFirstChild("HumanoidRootPart")
    if not PlayerRoot then return false end
    
    local ObscuringObjects = Camera:GetPartsObscuringTarget({PlayerRoot.Position, LocalPlayerCharacter.PrimaryPart.Position}, {LocalPlayerCharacter, PlayerCharacter})
    return #ObscuringObjects == 0
end

local function getClosestPlayer()
    local Closest
    local DistanceToMouse
    for _, Player in next, Players:GetPlayers() do
        if Player == LocalPlayer then continue end
        if SilentAimSettings.TeamCheck and Player.Team == LocalPlayer.Team then continue end

        local Character = Player.Character
        if not Character then continue end
        
        if SilentAimSettings.VisibleCheck and not IsPlayerVisible(Player) then continue end

        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        local Humanoid = Character:FindFirstChild("Humanoid")
        if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

        local ScreenPosition, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart.Position)
        if not OnScreen then continue end

        local Distance = (getMousePosition() - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
        if Distance <= (DistanceToMouse or SilentAimSettings.FOVRadius or 2000) then
            Closest = Character[SilentAimSettings.TargetPart]
            DistanceToMouse = Distance
        end
    end
    return Closest
end

local function getDirection(Origin, Position)
    return (Position - Origin).Unit * 1000
end

-- Main Silent Aim Hook
local ExpectedArguments = {
    FindPartOnRayWithIgnoreList = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Ray", "table", "boolean", "boolean"
        }
    },
    FindPartOnRayWithWhitelist = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Ray", "table", "boolean"
        }
    },
    FindPartOnRay = {
        ArgCountRequired = 2,
        Args = {
            "Instance", "Ray", "Instance", "boolean", "boolean"
        }
    },
    Raycast = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Vector3", "Vector3", "RaycastParams"
        }
    }
}

-- Hook the game's namecall method
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = getnamecallmethod()
    local Arguments = {...}
    local self = Arguments[1]
    local chance = CalculateChance(SilentAimSettings.HitChance)
    
    if SilentAimSettings.Enabled and self == workspace and not checkcaller() and chance == true then
        if Method == "FindPartOnRayWithIgnoreList" and SilentAimSettings.SilentAimMethod == Method then
            local HitPart = getClosestPlayer()
            if HitPart then
                local Origin = Arguments[2].Origin
                local Direction = getDirection(Origin, HitPart.Position)
                Arguments[2] = Ray.new(Origin, Direction)
                return oldNamecall(unpack(Arguments))
            end
        end
        -- Add similar blocks for other methods (Raycast, FindPartOnRay, etc.)
    end
    return oldNamecall(...)
end))

-- Hook mouse behavior
local oldIndex = nil 
oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, Index)
    local Mouse = LocalPlayer:GetMouse()
    
    if self == Mouse and not checkcaller() and SilentAimSettings.Enabled and SilentAimSettings.SilentAimMethod == "Mouse.Hit/Target" then
        local HitPart = getClosestPlayer()
         
        if HitPart then
            if Index == "Target" or Index == "target" then 
                return HitPart
            elseif Index == "Hit" or Index == "hit" then 
                return ((SilentAimSettings.MouseHitPrediction and (HitPart.CFrame + (HitPart.Velocity * SilentAimSettings.MouseHitPredictionAmount))) or (not SilentAimSettings.MouseHitPrediction and HitPart.CFrame))
            end
        end
    end
    return oldIndex(self, Index)
end))

-- Update loop for FOV circle and target indicator
RunService.RenderStepped:Connect(function()
    if SilentAimSettings.ShowSilentAimTarget and SilentAimSettings.Enabled then
        local target = getClosestPlayer()
        if target then
            local Root = target.Parent.PrimaryPart or target
            local RootToViewportPoint, IsOnScreen = Camera:WorldToViewportPoint(Root.Position)
            
            mouse_text.Visible = IsOnScreen
            mouse_text.Position = Vector2.new(RootToViewportPoint.X, RootToViewportPoint.Y - 20)
        else 
            mouse_text.Visible = false 
        end
    end
    
    if SilentAimSettings.FOVVisible then 
        fov_circle.Visible = true
        fov_circle.Position = getMousePosition()
    else
        fov_circle.Visible = false
    end
end)

-- Function to update settings (call this from your UI)
local function UpdateSilentAimSettings(newSettings)
    for setting, value in pairs(newSettings) do
        if SilentAimSettings[setting] ~= nil then
            SilentAimSettings[setting] = value
        end
    end
end

return {
    Settings = SilentAimSettings,
    UpdateSettings = UpdateSilentAimSettings
}
