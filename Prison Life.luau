-- Fully developed by 9kwr , all right reserved. Code documentated for skids.

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

-- Services
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")

-- LocalPlayer
local localplayer = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- Global Settings Tables
getgenv().silentaim = {
    enabled = false,
    fov = 240,
    prediction = false,
    prediction_amount = 0.13,
    teamcheck = true,
    wallcheck = true,
    highlight = true,
    highlight_color = Color3.fromRGB(0, 200, 255),
    triggerbot = false,
    triggerbot_key = Enum.KeyCode.G,
    show_fov = true,
    fov_color = Color3.fromRGB(200, 200, 200),
    fov_filled = false,
    fov_transparency = 0.15,
    show_target = true,
    target_color = Color3.fromRGB(0, 200, 255),
    target_size = 25,
    target_thickness = 5,
    hitpart = "Head",
    shake_enabled = false,
    shake_x = 5,
    shake_y = 5,
    shake_z = 5,
    smoothing_enabled = false,
    smoothing_amount = 0.5,
}

getgenv().targetstrafe = {
    enabled = false,
    speed = 1.5,
    height = 0,
    distance = 10,
    strafe_key = Enum.KeyCode.C,
    auto_jump = false,
    visualize = true,
    visualize_color = Color3.fromRGB(255, 0, 255),
    randomize_direction = false,
}

getgenv().ESP = {
    Enabled = false,
    TeamCheck = true,
    MaxDistance = 200,
    FontSize = 11,
    FadeOut = {
        OnDistance = true,
        OnDeath = false,
        OnLeave = false,
    },
    Options = { 
        Teamcheck = false,
        TeamcheckRGB = Color3.fromRGB(0, 255, 0),
        Friendcheck = true,
        FriendcheckRGB = Color3.fromRGB(0, 255, 0),
        Highlight = false,
        HighlightRGB = Color3.fromRGB(255, 0, 0),
    },
    Drawing = {
        Chams = {
            Enabled = false,
            Thermal = true,
            FillRGB = Color3.fromRGB(119, 120, 255),
            Fill_Transparency = 100,
            OutlineRGB = Color3.fromRGB(119, 120, 255),
            Outline_Transparency = 100,
            VisibleCheck = true,
        },
        Names = {
            Enabled = true,
            RGB = Color3.fromRGB(255, 255, 255),
        },
        Flags = {
            Enabled = true,
        },
        Distances = {
            Enabled = true, 
            Position = "Text",
            RGB = Color3.fromRGB(255, 255, 255),
        },
        Weapons = {
            Enabled = false,
            WeaponTextRGB = Color3.fromRGB(119, 120, 255),
            Outlined = false,
            Gradient = false,
            GradientRGB1 = Color3.fromRGB(255, 255, 255),
            GradientRGB2 = Color3.fromRGB(119, 120, 255),
        },
        Healthbar = {
            Enabled = true,  
            HealthText = true,
            Lerp = false,
            HealthTextRGB = Color3.fromRGB(119, 120, 255),
            Width = 2.5,
            Gradient = true,
            GradientRGB1 = Color3.fromRGB(200, 0, 0),
            GradientRGB2 = Color3.fromRGB(60, 60, 125),
            GradientRGB3 = Color3.fromRGB(119, 120, 255), 
        },
        Boxes = {
            Animate = true,
            RotationSpeed = 300,
            Gradient = false,
            GradientRGB1 = Color3.fromRGB(119, 120, 255),
            GradientRGB2 = Color3.fromRGB(0, 0, 0), 
            GradientFill = true,
            GradientFillRGB1 = Color3.fromRGB(119, 120, 255),
            GradientFillRGB2 = Color3.fromRGB(0, 0, 0), 
            Filled = {
                Enabled = true,
                Transparency = 0.75,
                RGB = Color3.fromRGB(0, 0, 0),
            },
            Full = {
                Enabled = true,
                RGB = Color3.fromRGB(255, 255, 255),
            },
            Corner = {
                Enabled = false,
                RGB = Color3.fromRGB(255, 255, 255),
            },
        },
    },
    Connections = {
        RunService = RunService,
    },
    Fonts = {},
}

getgenv().visuals = {
    ambient_enabled = false,
    ambient_color = Color3.fromRGB(255, 255, 255),
    brightness_enabled = false,
    brightness = 1,
    clocktime_enabled = false,
    clocktime = 14,
    fog_enabled = false,
    fog_end = 100000,
    forcefield_enabled = false,
    forcefield_color = Color3.fromRGB(0, 170, 255),
    color_tint_enabled = false,
    color_tint = Color3.fromRGB(255, 255, 255),
    color_tint_intensity = 0.5,
    player_material_enabled = false,
    player_material = "Neon",
    tool_material_enabled = false,
    tool_material = "Neon",
    crosshair_enabled = false,
    crosshair_color = Color3.fromRGB(0, 255, 0),
    crosshair_size = 10,
    crosshair_spinning = false,
    crosshair_spin_speed = 5
}

-- Create Window
local Window = Library:CreateWindow({
    Title = 'Paradox',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Combat = Window:AddTab('Combat'),
    ESP = Window:AddTab('ESP'),
    Visuals = Window:AddTab('Visuals'),
    Misc = Window:AddTab('Misc'),
    Settings = Window:AddTab('UI Settings'),
}

-- ==================== SILENT AIM TAB ====================
local SilentAimMain = Tabs.Combat:AddLeftGroupbox('Silent Aim')

SilentAimMain:AddToggle('SilentAimEnabled', {
    Text = 'Enable Silent Aim',
    Default = false,
    Tooltip = 'Toggle silent aim on/off',
    Callback = function(Value)
        getgenv().silentaim.enabled = Value
    end
})

SilentAimMain:AddDivider()

SilentAimMain:AddDropdown('SilentAimHitpart', {
    Values = { 'Head', 'HumanoidRootPart', 'UpperTorso', 'LowerTorso' },
    Default = 1,
    Multi = false,
    Text = 'Target Hitpart',
    Tooltip = 'Which body part to aim at',
    Callback = function(Value)
        getgenv().silentaim.hitpart = Value
    end
})

SilentAimMain:AddSlider('SilentAimFOV', {
    Text = 'FOV Size',
    Default = 240,
    Min = 50,
    Max = 500,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        getgenv().silentaim.fov = Value
    end
})

SilentAimMain:AddToggle('SilentAimPrediction', {
    Text = 'Prediction',
    Default = false,
    Tooltip = 'Enable velocity prediction',
    Callback = function(Value)
        getgenv().silentaim.prediction = Value
    end
})

SilentAimMain:AddSlider('SilentAimPredictionAmount', {
    Text = 'Prediction Amount',
    Default = 0.13,
    Min = 0.01,
    Max = 0.5,
    Rounding = 2,
    Compact = false,
    Callback = function(Value)
        getgenv().silentaim.prediction_amount = Value
    end
})

SilentAimMain:AddToggle('SilentAimSmoothing', {
    Text = 'Smoothing',
    Default = false,
    Tooltip = 'Smooth aim transition',
    Callback = function(Value)
        getgenv().silentaim.smoothing_enabled = Value
    end
})

SilentAimMain:AddSlider('SilentAimSmoothingAmount', {
    Text = 'Smoothing Amount',
    Default = 0.5,
    Min = 0.1,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(Value)
        getgenv().silentaim.smoothing_amount = Value
    end
})

SilentAimMain:AddDivider()

SilentAimMain:AddToggle('SilentAimTeamCheck', {
    Text = 'Team Check',
    Default = true,
    Tooltip = 'Ignore teammates',
    Callback = function(Value)
        getgenv().silentaim.teamcheck = Value
    end
})

SilentAimMain:AddToggle('SilentAimWallCheck', {
    Text = 'Wall Check',
    Default = true,
    Tooltip = 'Only target visible players',
    Callback = function(Value)
        getgenv().silentaim.wallcheck = Value
    end
})

-- Silent Aim Advanced
local SilentAimAdvanced = Tabs.Combat:AddRightGroupbox('Silent Aim Advanced')

SilentAimAdvanced:AddToggle('SilentAimShake', {
    Text = 'Aim Shake',
    Default = false,
    Tooltip = 'Add random shake to aim',
    Callback = function(Value)
        getgenv().silentaim.shake_enabled = Value
    end
})

SilentAimAdvanced:AddSlider('SilentAimShakeX', {
    Text = 'Shake X',
    Default = 5,
    Min = 0,
    Max = 20,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().silentaim.shake_x = Value
    end
})

SilentAimAdvanced:AddSlider('SilentAimShakeY', {
    Text = 'Shake Y',
    Default = 5,
    Min = 0,
    Max = 20,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().silentaim.shake_y = Value
    end
})

SilentAimAdvanced:AddSlider('SilentAimShakeZ', {
    Text = 'Shake Z',
    Default = 5,
    Min = 0,
    Max = 20,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().silentaim.shake_z = Value
    end
})

SilentAimAdvanced:AddDivider()

SilentAimAdvanced:AddToggle('SilentAimTriggerbot', {
    Text = 'Triggerbot',
    Default = false,
    Tooltip = 'Auto shoot when locked on target',
    Callback = function(Value)
        getgenv().silentaim.triggerbot = Value
    end
})

SilentAimAdvanced:AddLabel('Triggerbot Toggle Key'):AddKeyPicker('TriggerbotKey', {
    Default = 'G',
    SyncToggleState = false,
    Mode = 'Toggle',
    Text = 'Triggerbot Toggle',
    NoUI = false,
})

-- Silent Aim Visuals
local SilentAimVisuals = Tabs.Combat:AddLeftGroupbox('Silent Aim Visuals')

SilentAimVisuals:AddToggle('ShowFOV', {
    Text = 'Show FOV Circle',
    Default = true,
    Tooltip = 'Display FOV circle',
    Callback = function(Value)
        getgenv().silentaim.show_fov = Value
    end
})

SilentAimVisuals:AddLabel('FOV Color'):AddColorPicker('FOVColor', {
    Default = Color3.fromRGB(200, 200, 200),
    Title = 'FOV Circle Color',
    Callback = function(Value)
        getgenv().silentaim.fov_color = Value
    end
})

SilentAimVisuals:AddToggle('FOVFilled', {
    Text = 'Filled FOV',
    Default = false,
    Tooltip = 'Fill the FOV circle',
    Callback = function(Value)
        getgenv().silentaim.fov_filled = Value
    end
})

SilentAimVisuals:AddSlider('FOVTransparency', {
    Text = 'Fill Transparency',
    Default = 0.15,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(Value)
        getgenv().silentaim.fov_transparency = Value
    end
})

SilentAimVisuals:AddDivider()

SilentAimVisuals:AddToggle('ShowTarget', {
    Text = 'Show Target Indicator',
    Default = true,
    Tooltip = 'Display triangle on locked target',
    Callback = function(Value)
        getgenv().silentaim.show_target = Value
    end
})

SilentAimVisuals:AddLabel('Target Color'):AddColorPicker('TargetColor', {
    Default = Color3.fromRGB(0, 200, 255),
    Title = 'Target Indicator Color',
    Callback = function(Value)
        getgenv().silentaim.target_color = Value
    end
})

SilentAimVisuals:AddSlider('TargetSize', {
    Text = 'Indicator Size',
    Default = 25,
    Min = 10,
    Max = 50,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        getgenv().silentaim.target_size = Value
    end
})

SilentAimVisuals:AddSlider('TargetThickness', {
    Text = 'Indicator Thickness',
    Default = 5,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        getgenv().silentaim.target_thickness = Value
    end
})

SilentAimVisuals:AddDivider()

SilentAimVisuals:AddToggle('SilentAimHighlight', {
    Text = 'Target Highlight',
    Default = true,
    Tooltip = 'Highlight locked target',
    Callback = function(Value)
        getgenv().silentaim.highlight = Value
    end
})

SilentAimVisuals:AddLabel('Highlight Color'):AddColorPicker('HighlightColor', {
    Default = Color3.fromRGB(0, 200, 255),
    Title = 'Highlight Color',
    Callback = function(Value)
        getgenv().silentaim.highlight_color = Value
    end
})

-- Target Strafe
local TargetStrafeMain = Tabs.Combat:AddRightGroupbox('Target Strafe')

TargetStrafeMain:AddToggle('TargetStrafeEnabled', {
    Text = 'Enable Target Strafe',
    Default = false,
    Tooltip = 'Automatically strafe around locked target',
    Callback = function(Value)
        getgenv().targetstrafe.enabled = Value
    end
})

TargetStrafeMain:AddLabel('Strafe Toggle Key'):AddKeyPicker('StrafeKey', {
    Default = 'C',
    SyncToggleState = false,
    Mode = 'Toggle',
    Text = 'Strafe Toggle',
    NoUI = false,
})

TargetStrafeMain:AddDivider()

TargetStrafeMain:AddSlider('StrafeSpeed', {
    Text = 'Strafe Speed',
    Default = 1.5,
    Min = 0.5,
    Max = 5,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().targetstrafe.speed = Value
    end
})

TargetStrafeMain:AddSlider('StrafeDistance', {
    Text = 'Strafe Distance',
    Default = 10,
    Min = 5,
    Max = 30,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        getgenv().targetstrafe.distance = Value
    end
})

TargetStrafeMain:AddSlider('StrafeHeight', {
    Text = 'Strafe Height',
    Default = 0,
    Min = -10,
    Max = 10,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        getgenv().targetstrafe.height = Value
    end
})

TargetStrafeMain:AddDivider()

TargetStrafeMain:AddToggle('StrafeAutoJump', {
    Text = 'Auto Jump',
    Default = false,
    Tooltip = 'Automatically jump while strafing',
    Callback = function(Value)
        getgenv().targetstrafe.auto_jump = Value
    end
})

TargetStrafeMain:AddToggle('StrafeRandomize', {
    Text = 'Randomize Direction',
    Default = false,
    Tooltip = 'Randomly change strafe direction',
    Callback = function(Value)
        getgenv().targetstrafe.randomize_direction = Value
    end
})

TargetStrafeMain:AddDivider()

TargetStrafeMain:AddToggle('StrafeVisualize', {
    Text = 'Visualize Path',
    Default = true,
    Tooltip = 'Show strafe path visualization',
    Callback = function(Value)
        getgenv().targetstrafe.visualize = Value
    end
})

TargetStrafeMain:AddLabel('Path Color'):AddColorPicker('StrafePathColor', {
    Default = Color3.fromRGB(255, 0, 255),
    Title = 'Strafe Path Color',
    Callback = function(Value)
        getgenv().targetstrafe.visualize_color = Value
    end
})

-- ==================== ESP TAB ====================
local ESPMain = Tabs.ESP:AddLeftGroupbox('ESP Settings')

ESPMain:AddToggle('ESPEnabled', {
    Text = 'Enable ESP',
    Default = false,
    Tooltip = 'Toggle ESP on/off',
    Callback = function(Value)
        getgenv().ESP.Enabled = Value
    end
})

ESPMain:AddSlider('ESPMaxDistance', {
    Text = 'Max Distance',
    Default = 200,
    Min = 50,
    Max = 1000,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        getgenv().ESP.MaxDistance = Value
    end
})

ESPMain:AddSlider('ESPFontSize', {
    Text = 'Font Size',
    Default = 11,
    Min = 8,
    Max = 20,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        getgenv().ESP.FontSize = Value
    end
})

ESPMain:AddToggle('ESPTeamCheck', {
    Text = 'Team Check',
    Default = true,
    Tooltip = 'Only show enemies',
    Callback = function(Value)
        getgenv().ESP.TeamCheck = Value
    end
})

ESPMain:AddToggle('ESPFadeDistance', {
    Text = 'Fade on Distance',
    Default = true,
    Tooltip = 'Fade ESP elements based on distance',
    Callback = function(Value)
        getgenv().ESP.FadeOut.OnDistance = Value
    end
})

ESPMain:AddToggle('ESPFriendCheck', {
    Text = 'Friend Check',
    Default = true,
    Tooltip = 'Show friend indicator',
    Callback = function(Value)
        getgenv().ESP.Options.Friendcheck = Value
    end
})

ESPMain:AddLabel('Friend Color'):AddColorPicker('FriendColor', {
    Default = Color3.fromRGB(0, 255, 0),
    Title = 'Friend Indicator Color',
    Callback = function(Value)
        getgenv().ESP.Options.FriendcheckRGB = Value
    end
})

-- ESP Names & Distance
local ESPText = Tabs.ESP:AddRightGroupbox('Names & Distance')

ESPText:AddToggle('ESPNames', {
    Text = 'Show Names',
    Default = true,
    Tooltip = 'Display player names',
    Callback = function(Value)
        getgenv().ESP.Drawing.Names.Enabled = Value
    end
})

ESPText:AddLabel('Name Color'):AddColorPicker('NameColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Name Text Color',
    Callback = function(Value)
        getgenv().ESP.Drawing.Names.RGB = Value
    end
})

ESPText:AddDivider()

ESPText:AddToggle('ESPDistance', {
    Text = 'Show Distance',
    Default = true,
    Tooltip = 'Display distance to players',
    Callback = function(Value)
        getgenv().ESP.Drawing.Distances.Enabled = Value
    end
})

ESPText:AddDropdown('ESPDistancePosition', {
    Values = { 'Text', 'Bottom' },
    Default = 1,
    Multi = false,
    Text = 'Distance Position',
    Tooltip = 'Where to show distance',
    Callback = function(Value)
        getgenv().ESP.Drawing.Distances.Position = Value
    end
})

ESPText:AddLabel('Distance Color'):AddColorPicker('DistanceColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Distance Text Color',
    Callback = function(Value)
        getgenv().ESP.Drawing.Distances.RGB = Value
    end
})

-- ESP Boxes
local ESPBoxes = Tabs.ESP:AddLeftGroupbox('Boxes')

ESPBoxes:AddToggle('ESPBoxes', {
    Text = 'Show Boxes',
    Default = true,
    Tooltip = 'Display boxes around players',
    Callback = function(Value)
        getgenv().ESP.Drawing.Boxes.Full.Enabled = Value
    end
})

ESPBoxes:AddToggle('ESPBoxesFilled', {
    Text = 'Filled Boxes',
    Default = true,
    Tooltip = 'Fill the boxes',
    Callback = function(Value)
        getgenv().ESP.Drawing.Boxes.Filled.Enabled = Value
    end
})

ESPBoxes:AddLabel('Fill Color'):AddColorPicker('BoxFillColor', {
    Default = Color3.fromRGB(0, 0, 0),
    Title = 'Box Fill Color',
    Transparency = 0.75,
    Callback = function(Value)
        getgenv().ESP.Drawing.Boxes.Filled.RGB = Value
    end
})

Options.BoxFillColor:OnChanged(function()
    getgenv().ESP.Drawing.Boxes.Filled.Transparency = Options.BoxFillColor.Transparency
end)

ESPBoxes:AddLabel('Outline Color'):AddColorPicker('BoxOutlineColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Box Outline Color',
    Callback = function(Value)
        getgenv().ESP.Drawing.Boxes.Full.RGB = Value
    end
})

ESPBoxes:AddToggle('ESPBoxesAnimate', {
    Text = 'Animate Boxes',
    Default = true,
    Tooltip = 'Rotating gradient animation',
    Callback = function(Value)
        getgenv().ESP.Drawing.Boxes.Animate = Value
    end
})

ESPBoxes:AddSlider('ESPBoxesRotation', {
    Text = 'Rotation Speed',
    Default = 300,
    Min = 50,
    Max = 1000,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        getgenv().ESP.Drawing.Boxes.RotationSpeed = Value
    end
})

ESPBoxes:AddToggle('ESPBoxGradient', {
    Text = 'Box Gradient',
    Default = false,
    Tooltip = 'Enable gradient on boxes',
    Callback = function(Value)
        getgenv().ESP.Drawing.Boxes.Gradient = Value
    end
})

ESPBoxes:AddToggle('ESPBoxGradientFill', {
    Text = 'Fill Gradient',
    Default = true,
    Tooltip = 'Enable gradient on fill',
    Callback = function(Value)
        getgenv().ESP.Drawing.Boxes.GradientFill = Value
    end
})

ESPBoxes:AddDivider()

ESPBoxes:AddToggle('ESPCornerBoxes', {
    Text = 'Corner Boxes',
    Default = false,
    Tooltip = 'Show corner-style boxes',
    Callback = function(Value)
        getgenv().ESP.Drawing.Boxes.Corner.Enabled = Value
    end
})

ESPBoxes:AddLabel('Corner Color'):AddColorPicker('CornerColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Corner Box Color',
    Callback = function(Value)
        getgenv().ESP.Drawing.Boxes.Corner.RGB = Value
    end
})

-- ESP Healthbar
local ESPHealth = Tabs.ESP:AddRightGroupbox('Healthbar')

ESPHealth:AddToggle('ESPHealthbar', {
    Text = 'Show Healthbar',
    Default = true,
    Tooltip = 'Display health bars',
    Callback = function(Value)
        getgenv().ESP.Drawing.Healthbar.Enabled = Value
    end
})

ESPHealth:AddSlider('ESPHealthbarWidth', {
    Text = 'Bar Width',
    Default = 2.5,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().ESP.Drawing.Healthbar.Width = Value
    end
})

ESPHealth:AddToggle('ESPHealthbarText', {
    Text = 'Health Text',
    Default = true,
    Tooltip = 'Show health percentage',
    Callback = function(Value)
        getgenv().ESP.Drawing.Healthbar.HealthText = Value
    end
})

ESPHealth:AddToggle('ESPHealthbarGradient', {
    Text = 'Gradient Colors',
    Default = true,
    Tooltip = 'Use gradient for healthbar',
    Callback = function(Value)
        getgenv().ESP.Drawing.Healthbar.Gradient = Value
    end
})

ESPHealth:AddToggle('ESPHealthbarLerp', {
    Text = 'Color Lerp',
    Default = false,
    Tooltip = 'Lerp health text color',
    Callback = function(Value)
        getgenv().ESP.Drawing.Healthbar.Lerp = Value
    end
})

ESPHealth:AddLabel('Healthbar Color'):AddColorPicker('HealthbarColor', {
    Default = Color3.fromRGB(119, 120, 255),
    Title = 'Healthbar Color',
    Callback = function(Value)
        getgenv().ESP.Drawing.Healthbar.HealthTextRGB = Value
    end
})

-- ESP Chams
local ESPChams = Tabs.ESP:AddLeftGroupbox('Chams/Highlight')

ESPChams:AddToggle('ESPChams', {
    Text = 'Enable Chams',
    Default = false,
    Tooltip = 'Highlight players through walls',
    Callback = function(Value)
        getgenv().ESP.Drawing.Chams.Enabled = Value
    end
})

ESPChams:AddLabel('Fill Color'):AddColorPicker('ChamsFillColor', {
    Default = Color3.fromRGB(119, 120, 255),
    Title = 'Chams Fill Color',
    Transparency = 1,
    Callback = function(Value)
        getgenv().ESP.Drawing.Chams.FillRGB = Value
    end
})

Options.ChamsFillColor:OnChanged(function()
    getgenv().ESP.Drawing.Chams.Fill_Transparency = Options.ChamsFillColor.Transparency * 100
end)

ESPChams:AddLabel('Outline Color'):AddColorPicker('ChamsOutlineColor', {
    Default = Color3.fromRGB(119, 120, 255),
    Title = 'Chams Outline Color',
    Transparency = 1,
    Callback = function(Value)
        getgenv().ESP.Drawing.Chams.OutlineRGB = Value
    end
})

Options.ChamsOutlineColor:OnChanged(function()
    getgenv().ESP.Drawing.Chams.Outline_Transparency = Options.ChamsOutlineColor.Transparency * 100
end)

ESPChams:AddToggle('ESPChamsThermal', {
    Text = 'Thermal Effect',
    Default = true,
    Tooltip = 'Breathing thermal effect',
    Callback = function(Value)
        getgenv().ESP.Drawing.Chams.Thermal = Value
    end
})

ESPChams:AddToggle('ESPChamsVisible', {
    Text = 'Visible Check',
    Default = true,
    Tooltip = 'Only show through walls',
    Callback = function(Value)
        getgenv().ESP.Drawing.Chams.VisibleCheck = Value
    end
})

-- ESP Weapons
local ESPWeapons = Tabs.ESP:AddRightGroupbox('Weapons & Flags')

ESPWeapons:AddToggle('ESPWeapons', {
    Text = 'Show Weapons',
    Default = false,
    Tooltip = 'Display weapon names',
    Callback = function(Value)
        getgenv().ESP.Drawing.Weapons.Enabled = Value
    end
})

ESPWeapons:AddLabel('Weapon Color'):AddColorPicker('WeaponColor', {
    Default = Color3.fromRGB(119, 120, 255),
    Title = 'Weapon Text Color',
    Callback = function(Value)
        getgenv().ESP.Drawing.Weapons.WeaponTextRGB = Value
    end
})

ESPWeapons:AddToggle('ESPWeaponGradient', {
    Text = 'Weapon Gradient',
    Default = false,
    Tooltip = 'Gradient on weapon text',
    Callback = function(Value)
        getgenv().ESP.Drawing.Weapons.Gradient = Value
    end
})

ESPWeapons:AddDivider()

ESPWeapons:AddToggle('ESPFlags', {
    Text = 'Show Flags',
    Default = true,
    Tooltip = 'Display player flags',
    Callback = function(Value)
        getgenv().ESP.Drawing.Flags.Enabled = Value
    end
})

-- ==================== VISUALS TAB ====================
local VisualsLighting = Tabs.Visuals:AddLeftGroupbox('Lighting')

VisualsLighting:AddToggle('WorldAmbient', {
    Text = 'Custom Ambient',
    Default = false,
    Tooltip = 'Change world ambient color',
    Callback = function(Value)
        getgenv().visuals.ambient_enabled = Value
        if not Value then
            Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        end
    end
})

VisualsLighting:AddLabel('Ambient Color'):AddColorPicker('AmbientColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Ambient Color',
    Callback = function(Value)
        getgenv().visuals.ambient_color = Value
    end
})

VisualsLighting:AddDivider()

VisualsLighting:AddToggle('WorldBrightness', {
    Text = 'Custom Brightness',
    Default = false,
    Tooltip = 'Change world brightness',
    Callback = function(Value)
        getgenv().visuals.brightness_enabled = Value
        if not Value then
            Lighting.Brightness = 1
        end
    end
})

VisualsLighting:AddSlider('Brightness', {
    Text = 'Brightness',
    Default = 1,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        getgenv().visuals.brightness = Value
    end
})

VisualsLighting:AddDivider()

VisualsLighting:AddToggle('WorldTime', {
    Text = 'Custom Time',
    Default = false,
    Tooltip = 'Change time of day',
    Callback = function(Value)
        getgenv().visuals.clocktime_enabled = Value
    end
})

VisualsLighting:AddSlider('ClockTime', {
    Text = 'Time',
    Default = 14,
    Min = 0,
    Max = 24,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        getgenv().visuals.clocktime = Value
    end
})

VisualsLighting:AddDivider()

VisualsLighting:AddToggle('WorldFog', {
    Text = 'Remove Fog',
    Default = false,
    Tooltip = 'Remove distance fog',
    Callback = function(Value)
        getgenv().visuals.fog_enabled = Value
        if not Value then
            Lighting.FogEnd = 100000
        end
    end
})

VisualsLighting:AddSlider('FogDistance', {
    Text = 'Fog Distance',
    Default = 100000,
    Min = 100,
    Max = 100000,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        getgenv().visuals.fog_end = Value
    end
})

-- Visuals Effects
local VisualsEffects = Tabs.Visuals:AddRightGroupbox('Effects')

VisualsEffects:AddToggle('ColorTint', {
    Text = 'Color Tint',
    Default = false,
    Tooltip = 'Apply color tint to the world',
    Callback = function(Value)
        getgenv().visuals.color_tint_enabled = Value
        if not Value and Lighting:FindFirstChild("ColorCorrection") then
            Lighting.ColorCorrection:Destroy()
        end
    end
})

VisualsEffects:AddLabel('Tint Color'):AddColorPicker('TintColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'World Tint Color',
    Callback = function(Value)
        getgenv().visuals.color_tint = Value
    end
})

VisualsEffects:AddSlider('TintIntensity', {
    Text = 'Tint Intensity',
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = false,
    Callback = function(Value)
        getgenv().visuals.color_tint_intensity = Value
    end
})

VisualsEffects:AddDivider()

VisualsEffects:AddToggle('SelfForcefield', {
    Text = 'Self Forcefield',
    Default = false,
    Tooltip = 'Add forcefield effect to yourself',
    Callback = function(Value)
        getgenv().visuals.forcefield_enabled = Value
        if not Value then
            if localplayer.Character then
                local ff = localplayer.Character:FindFirstChildOfClass("ForceField")
                if ff then ff:Destroy() end
            end
        end
    end
})

VisualsEffects:AddLabel('Forcefield Color'):AddColorPicker('ForcefieldColor', {
    Default = Color3.fromRGB(0, 170, 255),
    Title = 'Forcefield Color',
    Transparency = 0.5,
    Callback = function(Value)
        getgenv().visuals.forcefield_color = Value
    end
})

-- Visuals Material
local VisualsMaterial = Tabs.Visuals:AddLeftGroupbox('Materials')

VisualsMaterial:AddToggle('PlayerMaterial', {
    Text = 'Custom Player Material',
    Default = false,
    Tooltip = 'Change your character material',
    Callback = function(Value)
        getgenv().visuals.player_material_enabled = Value
    end
})

VisualsMaterial:AddDropdown('PlayerMaterialType', {
    Values = { 'Neon', 'ForceField', 'Glass', 'Plastic', 'Metal', 'Granite', 'Wood' },
    Default = 1,
    Multi = false,
    Text = 'Player Material',
    Tooltip = 'Material type for player',
    Callback = function(Value)
        getgenv().visuals.player_material = Value
    end
})

VisualsMaterial:AddDivider()

VisualsMaterial:AddToggle('ToolMaterial', {
    Text = 'Custom Tool Material',
    Default = false,
    Tooltip = 'Change tool material',
    Callback = function(Value)
        getgenv().visuals.tool_material_enabled = Value
    end
})

VisualsMaterial:AddDropdown('ToolMaterialType', {
    Values = { 'Neon', 'ForceField', 'Glass', 'Plastic', 'Metal', 'Granite', 'Wood' },
    Default = 1,
    Multi = false,
    Text = 'Tool Material',
    Tooltip = 'Material type for tools',
    Callback = function(Value)
        getgenv().visuals.tool_material = Value
    end
})

-- Visuals Crosshair
local VisualsCrosshair = Tabs.Visuals:AddRightGroupbox('Crosshair')

VisualsCrosshair:AddToggle('Crosshair', {
    Text = 'Enable Crosshair',
    Default = false,
    Tooltip = 'Show custom crosshair',
    Callback = function(Value)
        getgenv().visuals.crosshair_enabled = Value
    end
})

VisualsCrosshair:AddLabel('Crosshair Color'):AddColorPicker('CrosshairColor', {
    Default = Color3.fromRGB(0, 255, 0),
    Title = 'Crosshair Color',
    Callback = function(Value)
        getgenv().visuals.crosshair_color = Value
    end
})

VisualsCrosshair:AddSlider('CrosshairSize', {
    Text = 'Size',
    Default = 10,
    Min = 5,
    Max = 30,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        getgenv().visuals.crosshair_size = Value
    end
})

VisualsCrosshair:AddToggle('CrosshairSpin', {
    Text = 'Spinning Crosshair',
    Default = false,
    Tooltip = 'Make crosshair spin',
    Callback = function(Value)
        getgenv().visuals.crosshair_spinning = Value
    end
})

VisualsCrosshair:AddSlider('CrosshairSpinSpeed', {
    Text = 'Spin Speed',
    Default = 5,
    Min = 1,
    Max = 20,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        getgenv().visuals.crosshair_spin_speed = Value
    end
})

-- ==================== MISC TAB ====================
local MiscTP = Tabs.Misc:AddLeftGroupbox('Teleports')

local weaponTPDelay = 0.5

MiscTP:AddSlider('WeaponTPDelay', {
    Text = 'Weapon TP Delay',
    Default = 0.5,
    Min = 0.1,
    Max = 5,
    Rounding = 1,
    Compact = false,
    Tooltip = 'Time to stay at each weapon location',
    Callback = function(Value)
        weaponTPDelay = Value
    end
})

MiscTP:AddButton({
    Text = 'Get M4A1 + Remington 870',
    Func = function()
        if not localplayer.Character or not localplayer.Character:FindFirstChild("HumanoidRootPart") then
            print("Character not found!")
            return
        end
        
        local HRP = localplayer.Character.HumanoidRootPart
        local originalPosition = HRP.CFrame
        
        print("Starting weapon collection...")
        
        HRP.CFrame = CFrame.new(847, 101, 2217)
        task.wait(weaponTPDelay)
        
        HRP.CFrame = CFrame.new(821, 101, 2217)
        task.wait(weaponTPDelay)
        
        HRP.CFrame = originalPosition
        print("Weapon collection complete! Returned to original position.")
    end,
    DoubleClick = false,
    Tooltip = 'Teleports to weapon locations and returns'
})

MiscTP:AddDivider()

MiscTP:AddButton({
    Text = 'Back TP',
    Func = function()
        if localplayer.Character and localplayer.Character:FindFirstChild("HumanoidRootPart") then
            localplayer.Character.HumanoidRootPart.CFrame = CFrame.new(980, 101, 2327)
            print("Teleported to Back location")
        end
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Back (980, 101, 2327)'
})

MiscTP:AddButton({
    Text = 'Cafe TP',
    Func = function()
        if localplayer.Character and localplayer.Character:FindFirstChild("HumanoidRootPart") then
            localplayer.Character.HumanoidRootPart.CFrame = CFrame.new(879, 99, 2247)
            print("Teleported to Cafe")
        end
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Cafe (879, 99, 2247)'
})

MiscTP:AddButton({
    Text = 'Cells TP',
    Func = function()
        if localplayer.Character and localplayer.Character:FindFirstChild("HumanoidRootPart") then
            localplayer.Character.HumanoidRootPart.CFrame = CFrame.new(910, 99, 2477)
            print("Teleported to Cells")
        end
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Cells (910, 99, 2477)'
})

-- Misc Other
local MiscOther = Tabs.Misc:AddRightGroupbox('Player')

MiscOther:AddSlider('WalkSpeed', {
    Text = 'Walk Speed',
    Default = 16,
    Min = 16,
    Max = 200,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        if localplayer.Character and localplayer.Character:FindFirstChild("Humanoid") then
            localplayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})

MiscOther:AddSlider('JumpPower', {
    Text = 'Jump Power',
    Default = 50,
    Min = 50,
    Max = 200,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        if localplayer.Character and localplayer.Character:FindFirstChild("Humanoid") then
            localplayer.Character.Humanoid.JumpPower = Value
        end
    end
})

MiscOther:AddToggle('LockInput', {
    Text = 'Lock Speed & Disable Input',
    Default = false,
    Tooltip = 'Sets WalkSpeed to 24 and disables ClientInputHandler',
    Callback = function(enabled)
        local player = game.Players.LocalPlayer

        local function applyLock(character)
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local clientHandler = character:FindFirstChild("ClientInputHandler")

            if enabled then
                if humanoid then
                    humanoid.WalkSpeed = 24
                end
                if clientHandler then
                    clientHandler.Disabled = true
                end
            else
                if humanoid then
                    humanoid.WalkSpeed = 16
                end
                if clientHandler then
                    clientHandler.Disabled = false
                end
            end
        end

        if player.Character then
            applyLock(player.Character)
        end

        if enabled then
            player.CharacterAdded:Connect(applyLock)
        end
    end
})

MiscOther:AddToggle('Spinbot', {
    Text = 'Spinbot',
    Default = false,
    Tooltip = 'Continuously spins your character',
    Callback = function(enabled)
        getgenv().spinbot_enabled = enabled

        if enabled then
            getgenv().spinbot_connection = RunService.RenderStepped:Connect(function()
                if localplayer.Character and localplayer.Character:FindFirstChild("HumanoidRootPart") then
                    localplayer.Character.HumanoidRootPart.CFrame = localplayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(20), 0)
                end
            end)
        else
            if getgenv().spinbot_connection then
                getgenv().spinbot_connection:Disconnect()
                getgenv().spinbot_connection = nil
            end
        end
    end
})

MiscOther:AddToggle('JitterAA', {
    Text = 'Jitter AA',
    Default = false,
    Tooltip = 'Makes your character jitter with visuals',
    Callback = function(enabled)
        getgenv().jitter_aa_enabled = enabled

        if enabled then
            getgenv().jitter_connection = RunService.RenderStepped:Connect(function()
                if localplayer.Character and localplayer.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = localplayer.Character.HumanoidRootPart
                    local randomAngle = math.rad(math.random(-30, 30))
                    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, randomAngle, 0)
                    
                    if not hrp:FindFirstChild("JitterVisual") then
                        local part = Instance.new("Part")
                        part.Name = "JitterVisual"
                        part.Size = Vector3.new(1,1,1)
                        part.Anchored = true
                        part.CanCollide = false
                        part.Material = Enum.Material.Neon
                        part.Color = Color3.fromRGB(0,255,0)
                        part.Parent = hrp
                        part.CFrame = hrp.CFrame * CFrame.new(0,3,0)
                    else
                        hrp.JitterVisual.CFrame = hrp.CFrame * CFrame.new(0,3,0) * CFrame.Angles(0, tick()%360, 0)
                    end
                end
            end)
        else
            if getgenv().jitter_connection then
                getgenv().jitter_connection:Disconnect()
                getgenv().jitter_connection = nil
            end
            if localplayer.Character and localplayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = localplayer.Character.HumanoidRootPart
                if hrp:FindFirstChild("JitterVisual") then
                    hrp.JitterVisual:Destroy()
                end
            end
        end
    end
})

-- ==================== VISUALS UPDATE LOOP ====================
local crosshair_parts = {}

local function create_crosshair()
    local center = UIS:GetMouseLocation()
    
    if #crosshair_parts == 0 then
        for i = 1, 4 do
            local line = Drawing.new("Line")
            line.Thickness = 2
            line.Color = getgenv().visuals.crosshair_color
            line.Visible = true
            table.insert(crosshair_parts, line)
        end
    end
    
    local size = getgenv().visuals.crosshair_size
    local rotation = 0
    
    if getgenv().visuals.crosshair_spinning then
        rotation = tick() * getgenv().visuals.crosshair_spin_speed
    end
    
    local function rotate_point(x, y, angle)
        local cos_a = math.cos(angle)
        local sin_a = math.sin(angle)
        return x * cos_a - y * sin_a, x * sin_a + y * cos_a
    end
    
    local offsets = {
        {-size, 0, -size/3, 0},
        {size/3, 0, size, 0},
        {0, -size, 0, -size/3},
        {0, size/3, 0, size}
    }
    
    for i, line in ipairs(crosshair_parts) do
        local x1, y1 = rotate_point(offsets[i][1], offsets[i][2], rotation)
        local x2, y2 = rotate_point(offsets[i][3], offsets[i][4], rotation)
        
        line.From = Vector2.new(center.X + x1, center.Y + y1)
        line.To = Vector2.new(center.X + x2, center.Y + y2)
        line.Color = getgenv().visuals.crosshair_color
        line.Visible = getgenv().visuals.crosshair_enabled
    end
end

RunService.RenderStepped:Connect(function()
    -- Ambient
    if getgenv().visuals.ambient_enabled then
        Lighting.Ambient = getgenv().visuals.ambient_color
    end
    
    -- Brightness
    if getgenv().visuals.brightness_enabled then
        Lighting.Brightness = getgenv().visuals.brightness
    end
    
    -- Clock Time
    if getgenv().visuals.clocktime_enabled then
        Lighting.ClockTime = getgenv().visuals.clocktime
    end
    
    -- Fog
    if getgenv().visuals.fog_enabled then
        Lighting.FogEnd = getgenv().visuals.fog_end
    end
    
    -- Color Tint
    if getgenv().visuals.color_tint_enabled then
        if not Lighting:FindFirstChild("ColorCorrection") then
            local cc = Instance.new("ColorCorrectionEffect")
            cc.Name = "ColorCorrection"
            cc.Parent = Lighting
        end
        local cc = Lighting:FindFirstChild("ColorCorrection")
        if cc then
            cc.TintColor = getgenv().visuals.color_tint
            cc.Saturation = getgenv().visuals.color_tint_intensity
        end
    else
        if Lighting:FindFirstChild("ColorCorrection") then
            Lighting.ColorCorrection:Destroy()
        end
    end
    
    -- Forcefield
    if getgenv().visuals.forcefield_enabled and localplayer.Character then
        local ff = localplayer.Character:FindFirstChildOfClass("ForceField")
        if not ff then
            ff = Instance.new("ForceField")
            ff.Parent = localplayer.Character
        end
    elseif not getgenv().visuals.forcefield_enabled and localplayer.Character then
        local ff = localplayer.Character:FindFirstChildOfClass("ForceField")
        if ff then ff:Destroy() end
    end
    
    -- Player Material
    if getgenv().visuals.player_material_enabled and localplayer.Character then
        for _, part in ipairs(localplayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Material = Enum.Material[getgenv().visuals.player_material]
            end
        end
    end
    
    -- Tool Material
    if getgenv().visuals.tool_material_enabled and localplayer.Character then
        local tool = localplayer.Character:FindFirstChildOfClass("Tool")
        if tool then
            for _, part in ipairs(tool:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material[getgenv().visuals.tool_material]
                end
            end
        end
    end
    
    -- Crosshair
    create_crosshair()
end)

-- ==================== SILENT AIM IMPLEMENTATION ====================
local circle = Drawing.new("Circle")
circle.Thickness = 2.5
circle.NumSides = 25
circle.Filled = false
circle.Visible = false

local target_triangle = Drawing.new("Triangle")
target_triangle.Visible = false

local function validcharacter(char)
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Health > 0 and char:FindFirstChild("HumanoidRootPart")
end

local function notobstructed(dest, target)
    if not getgenv().silentaim.wallcheck then return true end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {localplayer.Character, target}
    local origin = camera.CFrame.Position
    local direction = (dest - origin).Unit * (dest - origin).Magnitude
    local result = Workspace:Raycast(origin, direction, params)
    return result == nil or result.Instance:IsDescendantOf(target)
end

local function closestplayer(distance)
    local closest, position
    local shortest = distance or math.huge
    local mousepos = UIS:GetMouseLocation()
    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= localplayer and validcharacter(v.Character) then
            if getgenv().silentaim.teamcheck and v.Team == localplayer.Team then
                continue
            end
            local pos, onscreen = camera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local mag = (Vector2.new(pos.X, pos.Y) - mousepos).Magnitude
            if onscreen and mag < shortest and notobstructed(v.Character.Head.Position, v.Character) then
                closest = v
                position = pos
                shortest = mag
            end
        end
    end
    return closest, position
end

local current_highlight
local function apply_highlight(char)
    if not getgenv().silentaim.highlight then return end
    if current_highlight then
        current_highlight:Destroy()
        current_highlight = nil
    end
    local highlight = Instance.new("Highlight")
    highlight.Adornee = char
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.FillColor = getgenv().silentaim.highlight_color
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.Parent = char
    current_highlight = highlight
end

local function clear_highlight()
    if current_highlight then
        current_highlight:Destroy()
        current_highlight = nil
    end
end

-- Hook
local rawmt = getrawmetatable(game)
local old = rawmt.__index
setreadonly(rawmt, false)

rawmt.__index = newcclosure(function(self, idx)
    if getgenv().silentaim.enabled and not checkcaller() then
        if typeof(self) == "Instance" and (self:IsA("Mouse") or self:IsA("PlayerMouse")) then
            if idx == "Hit" then
                local plr = closestplayer(getgenv().silentaim.fov)
                if plr and plr.Character and plr.Character:FindFirstChild(getgenv().silentaim.hitpart) then
                    local vel = plr.Character.PrimaryPart.AssemblyLinearVelocity
                    local predict = Vector3.new()
                    if getgenv().silentaim.prediction and vel.Magnitude > 0 then
                        predict = vel * getgenv().silentaim.prediction_amount
                    end
                    
                    local targetPos = plr.Character[getgenv().silentaim.hitpart].Position + predict
                    
                    if getgenv().silentaim.shake_enabled then
                        local shake = Vector3.new(
                            math.random(-getgenv().silentaim.shake_x, getgenv().silentaim.shake_x) / 10,
                            math.random(-getgenv().silentaim.shake_y, getgenv().silentaim.shake_y) / 10,
                            math.random(-getgenv().silentaim.shake_z, getgenv().silentaim.shake_z) / 10
                        )
                        targetPos = targetPos + shake
                    end
                    
                    return CFrame.new(targetPos)
                end
            end
        end
    end
    return old(self, idx)
end)

setreadonly(rawmt, true)

-- Triggerbot State
local triggerbot_disabled = false
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == getgenv().silentaim.triggerbot_key then
        triggerbot_disabled = not triggerbot_disabled
    end
end)

-- Silent Aim RenderStep
RunService.RenderStepped:Connect(function()
    if getgenv().silentaim.enabled then
        circle.Visible = getgenv().silentaim.show_fov
        circle.Radius = getgenv().silentaim.fov
        circle.Position = UIS:GetMouseLocation()
        circle.Color = getgenv().silentaim.fov_color
        circle.Filled = getgenv().silentaim.fov_filled
        circle.Transparency = getgenv().silentaim.fov_filled and (1 - getgenv().silentaim.fov_transparency) or 1
        
        local plr, pos = closestplayer(getgenv().silentaim.fov)
        if plr then
            if getgenv().silentaim.show_target then
                local size = getgenv().silentaim.target_size
                target_triangle.PointA = Vector2.new(pos.X - size, pos.Y + size)
                target_triangle.PointB = Vector2.new(pos.X + size, pos.Y + size)
                target_triangle.PointC = Vector2.new(pos.X, pos.Y - size)
                target_triangle.Color = getgenv().silentaim.target_color
                target_triangle.Thickness = getgenv().silentaim.target_thickness
                target_triangle.Visible = true
            else
                target_triangle.Visible = false
            end
            apply_highlight(plr.Character)
            
            if getgenv().silentaim.triggerbot and not triggerbot_disabled then
                mouse1press()
                task.wait()
                mouse1release()
            end
        else
            target_triangle.Visible = false
            clear_highlight()
        end
    else
        circle.Visible = false
        target_triangle.Visible = false
        clear_highlight()
    end
end)

-- ==================== TARGET STRAFE ====================
local strafe_angle = 0
local strafe_direction = 1
local strafe_visualizer

local strafe_disabled = false
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == getgenv().targetstrafe.strafe_key then
        strafe_disabled = not strafe_disabled
        if strafe_disabled and strafe_visualizer then
            strafe_visualizer:Destroy()
            strafe_visualizer = nil
        end
    end
end)

RunService.RenderStepped:Connect(function(dt)
    if getgenv().targetstrafe.enabled and not strafe_disabled then
        local target_plr = closestplayer(math.huge)
        
        if target_plr and target_plr.Character and target_plr.Character:FindFirstChild("HumanoidRootPart") then
            local target_hrp = target_plr.Character.HumanoidRootPart
            
            if localplayer.Character and localplayer.Character:FindFirstChild("HumanoidRootPart") then
                local my_hrp = localplayer.Character.HumanoidRootPart
                local humanoid = localplayer.Character:FindFirstChild("Humanoid")
                
                if getgenv().targetstrafe.randomize_direction and math.random(1, 100) <= 2 then
                    strafe_direction = strafe_direction * -1
                end
                
                strafe_angle = strafe_angle + (getgenv().targetstrafe.speed * strafe_direction * dt)
                
                local offset = CFrame.new(target_hrp.Position) * CFrame.Angles(0, strafe_angle, 0) * CFrame.new(0, getgenv().targetstrafe.height, getgenv().targetstrafe.distance)
                
                my_hrp.CFrame = CFrame.new(offset.Position, target_hrp.Position)
                
                if getgenv().targetstrafe.auto_jump and humanoid then
                    humanoid.Jump = true
                end
                
                if getgenv().targetstrafe.visualize then
                    if not strafe_visualizer or not strafe_visualizer.Parent then
                        strafe_visualizer = Instance.new("Part")
                        strafe_visualizer.Name = "StrafeVisualizer"
                        strafe_visualizer.Anchored = true
                        strafe_visualizer.CanCollide = false
                        strafe_visualizer.Material = Enum.Material.Neon
                        strafe_visualizer.Size = Vector3.new(0.5, 0.5, 0.5)
                        strafe_visualizer.Shape = Enum.PartType.Ball
                        strafe_visualizer.Transparency = 0.5
                        strafe_visualizer.Parent = Workspace
                    end
                    
                    strafe_visualizer.Color = getgenv().targetstrafe.visualize_color
                    strafe_visualizer.CFrame = CFrame.new(offset.Position)
                    
                    local particles = strafe_visualizer:FindFirstChildOfClass("ParticleEmitter")
                    if not particles then
                        particles = Instance.new("ParticleEmitter")
                        particles.Lifetime = NumberRange.new(0.5, 1)
                        particles.Rate = 20
                        particles.SpreadAngle = Vector2.new(360, 360)
                        particles.Speed = NumberRange.new(2, 5)
                        particles.Color = ColorSequence.new(getgenv().targetstrafe.visualize_color)
                        particles.LightEmission = 1
                        particles.Size = NumberSequence.new(0.2, 0)
                        particles.Parent = strafe_visualizer
                    end
                    particles.Color = ColorSequence.new(getgenv().targetstrafe.visualize_color)
                end
            end
        else
            if strafe_visualizer then
                strafe_visualizer:Destroy()
                strafe_visualizer = nil
            end
        end
    else
        if strafe_visualizer then
            strafe_visualizer:Destroy()
            strafe_visualizer = nil
        end
    end
end)

-- ==================== ESP IMPLEMENTATION ====================
local Cam = Workspace.CurrentCamera
local RotationAngle, Tick = -45, tick()

-- Functions
local Functions = {}
do
    function Functions:Create(Class, Properties)
        local _Instance = typeof(Class) == 'string' and Instance.new(Class) or Class
        for Property, Value in pairs(Properties) do
            _Instance[Property] = Value
        end
        return _Instance
    end
    
    function Functions:FadeOutOnDist(element, distance)
        local transparency = math.max(0.1, 1 - (distance / getgenv().ESP.MaxDistance))
        if element:IsA("TextLabel") then
            element.TextTransparency = 1 - transparency
        elseif element:IsA("ImageLabel") then
            element.ImageTransparency = 1 - transparency
        elseif element:IsA("UIStroke") then
            element.Transparency = 1 - transparency
        elseif element:IsA("Frame") then
            element.BackgroundTransparency = 1 - transparency
        elseif element:IsA("Highlight") then
            element.FillTransparency = 1 - transparency
            element.OutlineTransparency = 1 - transparency
        end
    end
end

do -- Initialize ESP
    local ScreenGui = Functions:Create("ScreenGui", {
        Parent = CoreGui,
        Name = "ESPHolder",
        ResetOnSpawn = false,
        IgnoreGuiInset = true
    })

    local DupeCheck = function(plr)
        if ScreenGui:FindFirstChild(plr.Name) then
            ScreenGui[plr.Name]:Destroy()
        end
    end

    local CreateESP = function(plr)
        coroutine.wrap(DupeCheck)(plr)
        
        local Name = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, -11), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = getgenv().ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
        local Distance = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 11), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = getgenv().ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
        local Weapon = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 31), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = getgenv().ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
        local Box = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.75, BorderSizePixel = 0})
        local Gradient1 = Functions:Create("UIGradient", {Parent = Box, Enabled = getgenv().ESP.Drawing.Boxes.GradientFill, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, getgenv().ESP.Drawing.Boxes.GradientFillRGB1), ColorSequenceKeypoint.new(1, getgenv().ESP.Drawing.Boxes.GradientFillRGB2)}})
        local Outline = Functions:Create("UIStroke", {Parent = Box, Enabled = getgenv().ESP.Drawing.Boxes.Gradient, Transparency = 0, Color = Color3.fromRGB(255, 255, 255), LineJoinMode = Enum.LineJoinMode.Miter})
        local Gradient2 = Functions:Create("UIGradient", {Parent = Outline, Enabled = getgenv().ESP.Drawing.Boxes.Gradient, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, getgenv().ESP.Drawing.Boxes.GradientRGB1), ColorSequenceKeypoint.new(1, getgenv().ESP.Drawing.Boxes.GradientRGB2)}})
        local Healthbar = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0})
        local BehindHealthbar = Functions:Create("Frame", {Parent = ScreenGui, ZIndex = -1, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0})
        local HealthbarGradient = Functions:Create("UIGradient", {Parent = Healthbar, Enabled = getgenv().ESP.Drawing.Healthbar.Gradient, Rotation = -90, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, getgenv().ESP.Drawing.Healthbar.GradientRGB1), ColorSequenceKeypoint.new(0.5, getgenv().ESP.Drawing.Healthbar.GradientRGB2), ColorSequenceKeypoint.new(1, getgenv().ESP.Drawing.Healthbar.GradientRGB3)}})
        local HealthText = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 31), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = getgenv().ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
        local Chams = Functions:Create("Highlight", {Parent = ScreenGui, FillTransparency = 1, OutlineTransparency = 0, OutlineColor = Color3.fromRGB(119, 120, 255), DepthMode = "AlwaysOnTop"})
        local WeaponIcon = Functions:Create("ImageLabel", {Parent = ScreenGui, BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(0, 40, 0, 40)})
        local Gradient3 = Functions:Create("UIGradient", {Parent = WeaponIcon, Rotation = -90, Enabled = getgenv().ESP.Drawing.Weapons.Gradient, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, getgenv().ESP.Drawing.Weapons.GradientRGB1), ColorSequenceKeypoint.new(1, getgenv().ESP.Drawing.Weapons.GradientRGB2)}})
        local LeftTop = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local LeftSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local RightTop = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local RightSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local BottomSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local BottomDown = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local BottomRightSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local BottomRightDown = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
        local Flag1 = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = getgenv().ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
        local Flag2 = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = getgenv().ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
        
        local Updater = function()
            local Connection
            local function HideESP()
                Box.Visible = false
                Name.Visible = false
                Distance.Visible = false
                Weapon.Visible = false
                Healthbar.Visible = false
                BehindHealthbar.Visible = false
                HealthText.Visible = false
                WeaponIcon.Visible = false
                LeftTop.Visible = false
                LeftSide.Visible = false
                BottomSide.Visible = false
                BottomDown.Visible = false
                RightTop.Visible = false
                RightSide.Visible = false
                BottomRightSide.Visible = false
                BottomRightDown.Visible = false
                Flag1.Visible = false
                Chams.Enabled = false
                Flag2.Visible = false
                if not plr then
                    Connection:Disconnect()
                end
            end
            
            Connection = getgenv().ESP.Connections.RunService.RenderStepped:Connect(function()
                if not getgenv().ESP.Enabled then
                    HideESP()
                    return
                end
                
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local HRP = plr.Character.HumanoidRootPart
                    local Humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                    if not Humanoid then HideESP() return end
                    
                    local Pos, OnScreen = Cam:WorldToViewportPoint(HRP.Position)
                    local Dist = (Cam.CFrame.Position - HRP.Position).Magnitude / 3.5714285714
                    
                    if OnScreen and Dist <= getgenv().ESP.MaxDistance then
                        local Size = HRP.Size.Y
                        local scaleFactor = (Size * Cam.ViewportSize.Y) / (Pos.Z * 2)
                        local w, h = 3 * scaleFactor, 4.5 * scaleFactor

                        if getgenv().ESP.FadeOut.OnDistance then
                            Functions:FadeOutOnDist(Box, Dist)
                            Functions:FadeOutOnDist(Outline, Dist)
                            Functions:FadeOutOnDist(Name, Dist)
                            Functions:FadeOutOnDist(Distance, Dist)
                            Functions:FadeOutOnDist(Weapon, Dist)
                            Functions:FadeOutOnDist(Healthbar, Dist)
                            Functions:FadeOutOnDist(BehindHealthbar, Dist)
                            Functions:FadeOutOnDist(HealthText, Dist)
                            Functions:FadeOutOnDist(WeaponIcon, Dist)
                            Functions:FadeOutOnDist(LeftTop, Dist)
                            Functions:FadeOutOnDist(LeftSide, Dist)
                            Functions:FadeOutOnDist(BottomSide, Dist)
                            Functions:FadeOutOnDist(BottomDown, Dist)
                            Functions:FadeOutOnDist(RightTop, Dist)
                            Functions:FadeOutOnDist(RightSide, Dist)
                            Functions:FadeOutOnDist(BottomRightSide, Dist)
                            Functions:FadeOutOnDist(BottomRightDown, Dist)
                            Functions:FadeOutOnDist(Chams, Dist)
                            Functions:FadeOutOnDist(Flag1, Dist)
                            Functions:FadeOutOnDist(Flag2, Dist)
                        end

                        if getgenv().ESP.TeamCheck and plr ~= localplayer and ((localplayer.Team ~= plr.Team and plr.Team) or (not localplayer.Team and not plr.Team)) then

                            Chams.Adornee = plr.Character
                            Chams.Enabled = getgenv().ESP.Drawing.Chams.Enabled
                            Chams.FillColor = getgenv().ESP.Drawing.Chams.FillRGB
                            Chams.OutlineColor = getgenv().ESP.Drawing.Chams.OutlineRGB
                            
                            if getgenv().ESP.Drawing.Chams.Thermal then
                                local breathe_effect = math.atan(math.sin(tick() * 2)) * 2 / math.pi
                                Chams.FillTransparency = getgenv().ESP.Drawing.Chams.Fill_Transparency * breathe_effect * 0.01
                                Chams.OutlineTransparency = getgenv().ESP.Drawing.Chams.Outline_Transparency * breathe_effect * 0.01
                            end
                            
                            if getgenv().ESP.Drawing.Chams.VisibleCheck then
                                Chams.DepthMode = "Occluded"
                            else
                                Chams.DepthMode = "AlwaysOnTop"
                            end

                            LeftTop.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled
                            LeftTop.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2)
                            LeftTop.Size = UDim2.new(0, w / 5, 0, 1)
                            LeftTop.BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB
                            
                            LeftSide.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled
                            LeftSide.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2)
                            LeftSide.Size = UDim2.new(0, 1, 0, h / 5)
                            LeftSide.BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB
                            
                            BottomSide.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled
                            BottomSide.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y + h / 2)
                            BottomSide.Size = UDim2.new(0, 1, 0, h / 5)
                            BottomSide.AnchorPoint = Vector2.new(0, 1)
                            BottomSide.BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB
                            
                            BottomDown.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled
                            BottomDown.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y + h / 2)
                            BottomDown.Size = UDim2.new(0, w / 5, 0, 1)
                            BottomDown.AnchorPoint = Vector2.new(0, 1)
                            BottomDown.BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB
                            
                            RightTop.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled
                            RightTop.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y - h / 2)
                            RightTop.Size = UDim2.new(0, w / 5, 0, 1)
                            RightTop.AnchorPoint = Vector2.new(1, 0)
                            RightTop.BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB
                            
                            RightSide.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled
                            RightSide.Position = UDim2.new(0, Pos.X + w / 2 - 1, 0, Pos.Y - h / 2)
                            RightSide.Size = UDim2.new(0, 1, 0, h / 5)
                            RightSide.AnchorPoint = Vector2.new(0, 0)
                            RightSide.BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB
                            
                            BottomRightSide.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled
                            BottomRightSide.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y + h / 2)
                            BottomRightSide.Size = UDim2.new(0, 1, 0, h / 5)
                            BottomRightSide.AnchorPoint = Vector2.new(1, 1)
                            BottomRightSide.BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB
                            
                            BottomRightDown.Visible = getgenv().ESP.Drawing.Boxes.Corner.Enabled
                            BottomRightDown.Position = UDim2.new(0, Pos.X + w / 2, 0, Pos.Y + h / 2)
                            BottomRightDown.Size = UDim2.new(0, w / 5, 0, 1)
                            BottomRightDown.AnchorPoint = Vector2.new(1, 1)
                            BottomRightDown.BackgroundColor3 = getgenv().ESP.Drawing.Boxes.Corner.RGB

                            Box.Position = UDim2.new(0, Pos.X - w / 2, 0, Pos.Y - h / 2)
                            Box.Size = UDim2.new(0, w, 0, h)
                            Box.Visible = getgenv().ESP.Drawing.Boxes.Full.Enabled

                            if getgenv().ESP.Drawing.Boxes.Filled.Enabled then
                                Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                if getgenv().ESP.Drawing.Boxes.GradientFill then
                                    Box.BackgroundTransparency = getgenv().ESP.Drawing.Boxes.Filled.Transparency
                                else
                                    Box.BackgroundTransparency = 1
                                end
                                Box.BorderSizePixel = 1
                            else
                                Box.BackgroundTransparency = 1
                            end
                            
                            RotationAngle = RotationAngle + (tick() - Tick) * getgenv().ESP.Drawing.Boxes.RotationSpeed * math.cos(math.pi / 4 * tick() - math.pi / 2)
                            if getgenv().ESP.Drawing.Boxes.Animate then
                                Gradient1.Rotation = RotationAngle
                                Gradient2.Rotation = RotationAngle
                            else
                                Gradient1.Rotation = -45
                                Gradient2.Rotation = -45
                            end
                            Tick = tick()
                            
                            Outline.Enabled = getgenv().ESP.Drawing.Boxes.Gradient
                            Gradient1.Enabled = getgenv().ESP.Drawing.Boxes.GradientFill
                            Gradient2.Enabled = getgenv().ESP.Drawing.Boxes.Gradient

                            local health = Humanoid.Health / Humanoid.MaxHealth
                            Healthbar.Visible = getgenv().ESP.Drawing.Healthbar.Enabled
                            Healthbar.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2 + h * (1 - health))  
                            Healthbar.Size = UDim2.new(0, getgenv().ESP.Drawing.Healthbar.Width, 0, h * health)  
                            
                            BehindHealthbar.Visible = getgenv().ESP.Drawing.Healthbar.Enabled
                            BehindHealthbar.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2)  
                            BehindHealthbar.Size = UDim2.new(0, getgenv().ESP.Drawing.Healthbar.Width, 0, h)
                            
                            HealthbarGradient.Enabled = getgenv().ESP.Drawing.Healthbar.Gradient
                            
                            if getgenv().ESP.Drawing.Healthbar.HealthText then
                                local healthPercentage = math.floor(Humanoid.Health / Humanoid.MaxHealth * 100)
                                HealthText.Position = UDim2.new(0, Pos.X - w / 2 - 6, 0, Pos.Y - h / 2 + h * (1 - healthPercentage / 100) + 3)
                                HealthText.Text = tostring(healthPercentage)
                                HealthText.Visible = Humanoid.Health < Humanoid.MaxHealth
                                HealthText.TextSize = getgenv().ESP.FontSize
                                if getgenv().ESP.Drawing.Healthbar.Lerp then
                                    local color = health >= 0.75 and Color3.fromRGB(0, 255, 0) or health >= 0.5 and Color3.fromRGB(255, 255, 0) or health >= 0.25 and Color3.fromRGB(255, 170, 0) or Color3.fromRGB(255, 0, 0)
                                    HealthText.TextColor3 = color
                                else
                                    HealthText.TextColor3 = getgenv().ESP.Drawing.Healthbar.HealthTextRGB
                                end
                            end

                            Name.Visible = getgenv().ESP.Drawing.Names.Enabled
                            Name.TextSize = getgenv().ESP.FontSize
                            Name.TextColor3 = getgenv().ESP.Drawing.Names.RGB
                            if getgenv().ESP.Options.Friendcheck and localplayer:IsFriendsWith(plr.UserId) then
                                Name.Text = string.format('(<font color="rgb(%d, %d, %d)">F</font>) %s', getgenv().ESP.Options.FriendcheckRGB.R * 255, getgenv().ESP.Options.FriendcheckRGB.G * 255, getgenv().ESP.Options.FriendcheckRGB.B * 255, plr.Name)
                            else
                                Name.Text = string.format('(<font color="rgb(%d, %d, %d)">E</font>) %s', 255, 0, 0, plr.Name)
                            end
                            Name.Position = UDim2.new(0, Pos.X, 0, Pos.Y - h / 2 - 11)
                            
                            if getgenv().ESP.Drawing.Distances.Enabled then
                                Distance.TextSize = getgenv().ESP.FontSize
                                Distance.TextColor3 = getgenv().ESP.Drawing.Distances.RGB
                                if getgenv().ESP.Drawing.Distances.Position == "Bottom" then
                                    Weapon.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 18)
                                    WeaponIcon.Position = UDim2.new(0, Pos.X - 21, 0, Pos.Y + h / 2 + 15)
                                    Distance.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 7)
                                    Distance.Text = string.format("%d meters", math.floor(Dist))
                                    Distance.Visible = true
                                elseif getgenv().ESP.Drawing.Distances.Position == "Text" then
                                    Weapon.Position = UDim2.new(0, Pos.X, 0, Pos.Y + h / 2 + 8)
                                    WeaponIcon.Position = UDim2.new(0, Pos.X - 21, 0, Pos.Y + h / 2 + 5)
                                    Distance.Visible = false
                                    if getgenv().ESP.Options.Friendcheck and localplayer:IsFriendsWith(plr.UserId) then
                                        Name.Text = string.format('(<font color="rgb(%d, %d, %d)">F</font>) %s [%d]', getgenv().ESP.Options.FriendcheckRGB.R * 255, getgenv().ESP.Options.FriendcheckRGB.G * 255, getgenv().ESP.Options.FriendcheckRGB.B * 255, plr.Name, math.floor(Dist))
                                    else
                                        Name.Text = string.format('(<font color="rgb(%d, %d, %d)">E</font>) %s [%d]', 255, 0, 0, plr.Name, math.floor(Dist))
                                    end
                                    Name.Visible = getgenv().ESP.Drawing.Names.Enabled
                                end
                            end

                            Weapon.Text = "none"
                            Weapon.TextSize = getgenv().ESP.FontSize
                            Weapon.TextColor3 = getgenv().ESP.Drawing.Weapons.WeaponTextRGB
                            Weapon.Visible = getgenv().ESP.Drawing.Weapons.Enabled
                        else
                            HideESP()
                        end
                    else
                        HideESP()
                    end
                else
                    HideESP()
                end
            end)
        end
        coroutine.wrap(Updater)()
    end
    
    for _, v in pairs(Players:GetPlayers()) do
        if v.Name ~= localplayer.Name then
            coroutine.wrap(CreateESP)(v)
        end      
    end
    
    Players.PlayerAdded:Connect(function(v)
        coroutine.wrap(CreateESP)(v)
    end)
end

-- ==================== UI SETTINGS ====================
local MenuGroup = Tabs.Settings:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { 
    Default = 'Insert', 
    NoUI = true, 
    Text = 'Menu keybind' 
})

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('CombatGUI')
SaveManager:SetFolder('CombatGUI/configs')

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

Library:SetWatermarkVisibility(true)

local FrameTimer = tick()
local FrameCounter = 0
local FPS = 60

local WatermarkConnection = RunService.RenderStepped:Connect(function()
    FrameCounter = FrameCounter + 1
    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter
        FrameTimer = tick()
        FrameCounter = 0
    end
    Library:SetWatermark(('Paradox | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ))
end)

Library.KeybindFrame.Visible = true

Library:OnUnload(function()
    WatermarkConnection:Disconnect()
    circle:Remove()
    target_triangle:Remove()
    if current_highlight then current_highlight:Destroy() end
    if strafe_visualizer then strafe_visualizer:Destroy() end
    for _, line in ipairs(crosshair_parts) do
        line:Remove()
    end
    if Lighting:FindFirstChild("ColorCorrection") then
        Lighting.ColorCorrection:Destroy()
    end
    if getgenv().spinbot_connection then
        getgenv().spinbot_connection:Disconnect()
    end
    if getgenv().jitter_connection then
        getgenv().jitter_connection:Disconnect()
    end
    getgenv().silentaim = nil
    getgenv().targetstrafe = nil
    getgenv().ESP = nil
    getgenv().visuals = nil
    print('Paradox Unloaded!')
    Library.Unloaded = true
end)

SaveManager:LoadAutoloadConfig()

print("=======================================")
print("Paradox Loaded!")
