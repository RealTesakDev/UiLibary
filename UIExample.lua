-- 1. Load the Sirius Sense Library
local Sense = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Sirius/request/library/sense/source.lua'))()

-- 2. Configure shared settings
Sense.sharedSettings.textSize = 13
Sense.sharedSettings.textFont = 2
Sense.sharedSettings.limitDistance = true
Sense.sharedSettings.maxDistance = 1000
Sense.sharedSettings.textColor = Color3.new(1, 1, 1) -- Default text color

-- 3. Load the UI Library
local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local PepsisWorld = library:CreateWindow({
    Name = "Pepsi's World",
    Themeable = {
        Info = "Discord Server: VzYTJ7Y"
    }
})

-- 4. Create a General Tab
local GeneralTab = PepsisWorld:CreateTab({
    Name = "General"
})

-- 5. Create an ESP Settings Section
local ESPSettingsSection = GeneralTab:CreateSection({
    Name = "ESP Settings"
})

ESPSettingsSection:AddToggle({
    Name = "Enable Enemy ESP",
    Flag = "ESPSettings_EnableEnemyESP",
    Callback = function(value)
        Sense.teamSettings.enemy.enabled = value
    end
})

-- 6. Create a Box Settings Section
local BoxSettingsSection = GeneralTab:CreateSection({
    Name = "Box Settings"
})

BoxSettingsSection:AddToggle({
    Name = "Show Enemy Box",
    Flag = "BoxSettings_ShowEnemyBox",
    Callback = function(value)
        Sense.teamSettings.enemy.box = value
    end
})

BoxSettingsSection:AddColorPicker({
    Name = "Enemy Box Color",
    Flag = "BoxSettings_EnemyBoxColor",
    Default = Color3.new(0, 0.25, 0.75), -- Blue box color
    Callback = function(value)
        Sense.teamSettings.enemy.boxColor[1] = value
    end
})

BoxSettingsSection:AddToggle({
    Name = "Fill Box",
    Flag = "BoxSettings_FillBox",
    Callback = function(value)
        Sense.teamSettings.enemy.boxFill = value
    end
})

BoxSettingsSection:AddColorPicker({
    Name = "Box Fill Color",
    Flag = "BoxSettings_BoxFillColor",
    Default = Color3.new(0, 0.25, 0.75), -- Blue fill color
    Callback = function(value)
        Sense.teamSettings.enemy.boxFillColor[1] = value
    end
})

-- 7. Create a Name Settings Section
local NameSettingsSection = GeneralTab:CreateSection({
    Name = "Name Settings"
})

NameSettingsSection:AddToggle({
    Name = "Show Enemy Name",
    Flag = "NameSettings_ShowEnemyName",
    Callback = function(value)
        Sense.teamSettings.enemy.name = value
    end
})

NameSettingsSection:AddColorPicker({
    Name = "Enemy Name Color",
    Flag = "NameSettings_EnemyNameColor",
    Default = Color3.new(1, 1, 1), -- White name color
    Callback = function(value)
        Sense.teamSettings.enemy.nameColor[1] = value
    end
})

-- 8. Create a Distance Settings Section
local DistanceSettingsSection = GeneralTab:CreateSection({
    Name = "Distance Settings"
})

DistanceSettingsSection:AddToggle({
    Name = "Show Enemy Distance",
    Flag = "DistanceSettings_ShowEnemyDistance",
    Callback = function(value)
        Sense.teamSettings.enemy.distance = value
    end
})

DistanceSettingsSection:AddColorPicker({
    Name = "Enemy Distance Color",
    Flag = "DistanceSettings_EnemyDistanceColor",
    Default = Color3.new(1, 1, 1), -- White distance color
    Callback = function(value)
        Sense.teamSettings.enemy.distanceColor[1] = value
    end
})

-- 9. Create a Health Bar Settings Section
local HealthBarSettingsSection = GeneralTab:CreateSection({
    Name = "Health Bar Settings"
})

HealthBarSettingsSection:AddToggle({
    Name = "Show Enemy Health Bar",
    Flag = "HealthBarSettings_ShowEnemyHealthBar",
    Callback = function(value)
        Sense.teamSettings.enemy.healthBar = value
    end
})

HealthBarSettingsSection:AddColorPicker({
    Name = "Health Bar Color (Healthy)",
    Flag = "HealthBarSettings_HealthyColor",
    Default = Color3.new(0, 1, 0), -- Green for healthy
    Callback = function(value)
        Sense.teamSettings.enemy.healthyColor = value
    end
})

HealthBarSettingsSection:AddColorPicker({
    Name = "Health Bar Color (Dying)",
    Flag = "HealthBarSettings_DyingColor",
    Default = Color3.new(1, 0, 0), -- Red for dying
    Callback = function(value)
        Sense.teamSettings.enemy.dyingColor = value
    end
})

-- 10. Create Other Settings Section
local OtherSettingsSection = GeneralTab:CreateSection({
    Name = "Other Settings"
})

OtherSettingsSection:AddToggle({
    Name = "Enable Box Outlines",
    Flag = "OtherSettings_EnableBoxOutline",
    Callback = function(value)
        Sense.teamSettings.enemy.boxOutline = value
    end
})

OtherSettingsSection:AddColorPicker({
    Name = "Box Outline Color",
    Flag = "OtherSettings_BoxOutlineColor",
    Default = Color3.new(0, 0, 0), -- Black outline for boxes
    Callback = function(value)
        Sense.teamSettings.enemy.boxOutlineColor[1] = value
    end
})

OtherSettingsSection:AddToggle({
    Name = "Show Chams",
    Flag = "OtherSettings_ShowChams",
    Callback = function(value)
        Sense.teamSettings.enemy.chams = value
    end
})

OtherSettingsSection:AddColorPicker({
    Name = "Chams Fill Color",
    Flag = "OtherSettings_ChamsFillColor",
    Default = Color3.new(1, 0, 0), -- Red fill color for chams
    Callback = function(value)
        Sense.teamSettings.enemy.chamsFillColor[1] = value
    end
})

OtherSettingsSection:AddColorPicker({
    Name = "Chams Outline Color",
    Flag = "OtherSettings_ChamsOutlineColor",
    Default = Color3.new(0, 0, 0), -- Black outline color for chams
    Callback = function(value)
        Sense.teamSettings.enemy.chamsOutlineColor[1] = value
    end
})

OtherSettingsSection:AddToggle({
    Name = "Show Weapon Info",
    Flag = "OtherSettings_ShowWeaponInfo",
    Callback = function(value)
        Sense.teamSettings.enemy.weapon = value
    end
})

OtherSettingsSection:AddToggle({
    Name = "Show 3D Boxes",
    Flag = "OtherSettings_Show3DBoxes",
    Callback = function(value)
        Sense.teamSettings.enemy.box3d = value
    end
})

OtherSettingsSection:AddToggle({
    Name = "Show Off-Screen Arrows",
    Flag = "OtherSettings_ShowOffScreenArrows",
    Callback = function(value)
        Sense.teamSettings.enemy.offScreenArrow = value
    end
})

-- 11. Add sliders for max distance, arrow size, and off-screen arrow settings
local DistanceSliderSection = GeneralTab:CreateSection({
    Name = "Distance and Arrow Size"
})

DistanceSliderSection:AddSlider({
    Name = "Max Distance",
    Flag = "DistanceSlider_MaxDistance",
    Value = 1000,
    Min = 0,
    Max = 5000,
    Callback = function(value)
        Sense.sharedSettings.maxDistance = value
    end
})

DistanceSliderSection:AddSlider({
    Name = "Off-Screen Arrow Size",
    Flag = "DistanceSlider_ArrowSize",
    Value = 15,
    Min = 5,
    Max = 50,
    Callback = function(value)
        Sense.teamSettings.enemy.offScreenArrowSize = value
    end
})

-- 12. Off-Screen Arrow Settings Section
local OffScreenArrowSection = GeneralTab:CreateSection({
    Name = "Off-Screen Arrow Settings"
})

OffScreenArrowSection:AddColorPicker({
    Name = "Off-Screen Arrow Color",
    Flag = "OffScreenArrowColor",
    Default = Color3.new(1, 1, 0), -- Yellow for arrows
    Callback = function(value)
        Sense.teamSettings.enemy.offScreenArrowColor[1] = value
    end
})

OffScreenArrowSection:AddSlider({
    Name = "Off-Screen Arrow Radius",
    Flag = "OffScreenArrowRadius",
    Value = 50,
    Min = 20,
    Max = 100,
    Callback = function(value)
        Sense.teamSettings.enemy.offScreenArrowRadius = value
    end
})

OffScreenArrowSection:AddToggle({
    Name = "Off-Screen Arrow Outline",
    Flag = "OffScreenArrowOutline",
    Callback = function(value)
        Sense.teamSettings.enemy.offScreenArrowOutline = value
    end
})

OffScreenArrowSection:AddColorPicker({
    Name = "Off-Screen Arrow Outline Color",
    Flag = "OffScreenArrowOutlineColor",
    Default = Color3.new(0, 0, 0), -- Black outline color for arrows
    Callback = function(value)
        Sense.teamSettings.enemy.offScreenArrowOutlineColor[1] = value
    end
})

-- 13. Text Settings Section
local TextSettingsSection = GeneralTab:CreateSection({
    Name = "Text Settings"
})

TextSettingsSection:AddSlider({
    Name = "Text Size",
    Flag = "TextSettings_TextSize",
    Value = 13,
    Min = 5,
    Max = 30,
    Callback = function(value)
        Sense.sharedSettings.textSize = value
    end
})

TextSettingsSection:AddColorPicker({
    Name = "Text Color",
    Flag = "TextSettings_TextColor",
    Default = Color3.new(1, 1, 1), -- White color
    Callback = function(value)
        Sense.sharedSettings.textColor = value
    end
})

-- 14. Create a Save/Load Settings Button
local SaveLoadSection = GeneralTab:CreateSection({
    Name = "Save/Load Settings"
})

SaveLoadSection:AddButton({
    Name = "Save Settings",
    Callback = function()
        -- Implement your save functionality here
        print("Settings saved!")
    end
})

SaveLoadSection:AddButton({
    Name = "Load Settings",
    Callback = function()
        -- Implement your load functionality here
        print("Settings loaded!")
    end
})

-- 15. Create a Toggle All ESP
local ToggleAllESPSection = GeneralTab:CreateSection({
    Name = "Toggle All ESP"
})

ToggleAllESPSection:AddToggle({
    Name = "Enable All ESP",
    Flag = "ToggleAllESP_EnableAllESP",
    Callback = function(value)
        -- Toggle all ESPs here
        Sense.teamSettings.enemy.enabled = value
        -- Repeat for other ESPs as needed
    end
})

-- 14. Finalize the UI
PepsisWorld:Show()
Sense.Load()
