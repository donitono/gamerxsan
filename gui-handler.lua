-- ===================================================================
--                        GUI HANDLER MODULE
--                    Zayros FISH-IT V2.0 GUI System
-- ===================================================================

local GUIHandler = {}

-- ===================================================================
--                           GUI STYLES & CONSTANTS
-- ===================================================================

local GUIStyles = {
    Colors = {
        Background = Color3.fromRGB(30, 30, 35),        -- Darker background
        Primary = Color3.fromRGB(64, 156, 255),         -- Modern blue
        Secondary = Color3.fromRGB(128, 90, 213),       -- Purple accent
        Success = Color3.fromRGB(34, 197, 94),          -- Green success
        Danger = Color3.fromRGB(239, 68, 68),           -- Red danger
        Warning = Color3.fromRGB(245, 158, 11),         -- Orange warning
        Text = Color3.fromRGB(248, 250, 252),           -- Light text
        TextSecondary = Color3.fromRGB(148, 163, 184),  -- Gray text
        Black = Color3.fromRGB(15, 15, 20),             -- True black
        Purple = Color3.fromRGB(147, 51, 234),          -- Accent purple
        Dark = Color3.fromRGB(51, 65, 85),              -- Dark gray
        Border = Color3.fromRGB(71, 85, 105),           -- Border color
        Hover = Color3.fromRGB(45, 45, 55)              -- Hover state
    },
    
    Fonts = {
        Primary = Enum.Font.GothamSemibold,
        Title = Enum.Font.GothamBold,
        Body = Enum.Font.Gotham
    },
    
    Sizes = {
        ButtonFrame = UDim2.new(0.898, 0, 0.106, 0),
        ToggleButton = UDim2.new(0.207, 0, 0.784, 0),
        Indicator = UDim2.new(0.257, 0, 0.730, 0),
        FloatingButton = UDim2.new(0, 60, 0, 60)
    },
    
    Positions = {
        ButtonText = UDim2.new(0.030, 0, 0.216, 0),
        ToggleButton = UDim2.new(0.738, 0, 0.108, 0),
        Indicator = UDim2.new(0.719, 0, 0.135, 0)
    },
    
    -- New: Animation settings
    Animations = {
        Fast = 0.15,
        Normal = 0.3,
        Slow = 0.5
    },
    
    -- New: Border radius settings
    BorderRadius = {
        Small = 6,
        Medium = 8,
        Large = 12,
        XLarge = 16
    }
}

-- ===================================================================
--                         UTILITY FUNCTIONS
-- ===================================================================

local function createUICorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or GUIStyles.BorderRadius.Medium)
    corner.Parent = parent
    return corner
end

local function createGradient(parent, color1, color2, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    }
    gradient.Rotation = rotation or 90
    gradient.Parent = parent
    return gradient
end

local function createShadow(parent, element)
    local shadow = Instance.new("Frame")
    shadow.Name = element.Name .. "Shadow"
    shadow.Parent = parent
    shadow.BackgroundColor3 = GUIStyles.Colors.Black
    shadow.BackgroundTransparency = 0.8
    shadow.BorderSizePixel = 0
    shadow.Position = UDim2.new(
        element.Position.X.Scale, element.Position.X.Offset + 2,
        element.Position.Y.Scale, element.Position.Y.Offset + 2
    )
    shadow.Size = element.Size
    shadow.ZIndex = element.ZIndex - 1
    
    createUICorner(shadow, GUIStyles.BorderRadius.Medium)
    return shadow
end

local function createBorder(parent, thickness, color)
    local border = Instance.new("UIStroke")
    border.Thickness = thickness or 1
    border.Color = color or GUIStyles.Colors.Border
    border.Transparency = 0.3
    border.Parent = parent
    return border
end

local function createStyledFrame(parent, name, size, position, backgroundColor)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Parent = parent
    frame.BackgroundColor3 = backgroundColor or GUIStyles.Colors.Background
    frame.BorderSizePixel = 0
    frame.Size = size
    if position then
        frame.Position = position
    end
    
    createUICorner(frame)
    return frame
end

local function createToggleSystem(parent, labelText, settingValue)
    -- Create main container with better styling
    local container = Instance.new("Frame")
    container.Parent = parent
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, 0, 1, 0)
    
    -- Create label with better typography
    local label = Instance.new("TextLabel")
    label.Parent = container
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0.030, 0, 0, 0)
    label.Size = UDim2.new(0.600, 0, 1, 0)
    label.Font = GUIStyles.Fonts.Primary
    label.Text = labelText
    label.TextColor3 = GUIStyles.Colors.Text
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    
    -- Create modern toggle switch background
    local toggleBg = Instance.new("Frame")
    toggleBg.Parent = container
    toggleBg.BackgroundColor3 = settingValue and GUIStyles.Colors.Success or GUIStyles.Colors.Dark
    toggleBg.BorderSizePixel = 0
    toggleBg.Position = UDim2.new(0.700, 0, 0.2, 0)
    toggleBg.Size = UDim2.new(0.15, 0, 0.6, 0)
    
    createUICorner(toggleBg, GUIStyles.BorderRadius.XLarge)
    createBorder(toggleBg, 2, settingValue and GUIStyles.Colors.Success or GUIStyles.Colors.Border)
    
    -- Create toggle circle/indicator
    local indicator = Instance.new("Frame")
    indicator.Parent = toggleBg
    indicator.BackgroundColor3 = GUIStyles.Colors.Text
    indicator.BorderSizePixel = 0
    indicator.Position = settingValue and UDim2.new(0.55, 0, 0.1, 0) or UDim2.new(0.05, 0, 0.1, 0)
    indicator.Size = UDim2.new(0.4, 0, 0.8, 0)
    
    createUICorner(indicator, GUIStyles.BorderRadius.XLarge)
    
    -- Create invisible button for clicking
    local button = Instance.new("TextButton")
    button.Parent = container
    button.BackgroundTransparency = 1
    button.Size = UDim2.new(1, 0, 1, 0)
    button.ZIndex = 2
    button.Font = GUIStyles.Fonts.Primary
    button.Text = ""
    
    -- Create status text
    local statusText = Instance.new("TextLabel")
    statusText.Parent = container
    statusText.BackgroundTransparency = 1
    statusText.Position = UDim2.new(0.870, 0, 0, 0)
    statusText.Size = UDim2.new(0.100, 0, 1, 0)
    statusText.Font = GUIStyles.Fonts.Body
    statusText.Text = settingValue and "ON" or "OFF"
    statusText.TextColor3 = settingValue and GUIStyles.Colors.Success or GUIStyles.Colors.TextSecondary
    statusText.TextScaled = true
    statusText.TextXAlignment = Enum.TextXAlignment.Center
    
    return button, toggleBg, label, indicator, statusText
end

-- ===================================================================
--                         PANEL CREATORS
-- ===================================================================

function GUIHandler.createSecurityPanel(parent, SecuritySettings)
    local SecurityFrame = Instance.new("ScrollingFrame")
    SecurityFrame.Name = "SecurityFrame"
    SecurityFrame.Parent = parent
    SecurityFrame.Active = true
    SecurityFrame.BackgroundTransparency = 1
    SecurityFrame.Position = UDim2.new(0.376, 0, 0.147, 0)
    SecurityFrame.Size = UDim2.new(0.624, 0, 0.853, 0)
    SecurityFrame.Visible = false
    SecurityFrame.ZIndex = 2
    SecurityFrame.ScrollBarThickness = 6

    local layoutFrame = createStyledFrame(SecurityFrame, "SecurityListLayoutFrame", 
        UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0.022, 0))
    layoutFrame.BackgroundTransparency = 1

    local listLayout = Instance.new("UIListLayout")
    listLayout.Name = "ListLayoutSecurity"
    listLayout.Parent = layoutFrame
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 8)

    -- Admin Detection Frame
    local adminFrame = createStyledFrame(layoutFrame, "AdminDetectionFrame", GUIStyles.Sizes.ButtonFrame)
    local adminButton, adminToggleBg, adminLabel, adminIndicator, adminStatusText = createToggleSystem(adminFrame, "ADMIN DETECTION :", SecuritySettings.AdminDetection)
    adminButton.Name = "AdminDetectionButton"
    adminToggleBg.Name = "AdminDetectionToggleBg"
    adminIndicator.Name = "AdminDetectionIndicator"

    -- Proximity Alert Frame
    local proximityFrame = createStyledFrame(layoutFrame, "ProximityAlertFrame", GUIStyles.Sizes.ButtonFrame)
    local proximityButton, proximityToggleBg, proximityLabel, proximityIndicator, proximityStatusText = createToggleSystem(proximityFrame, "PROXIMITY ALERT :", SecuritySettings.PlayerProximityAlert)
    proximityButton.Name = "ProximityAlertButton"
    proximityToggleBg.Name = "ProximityAlertToggleBg"
    proximityIndicator.Name = "ProximityAlertIndicator"

    -- Auto Hide Frame
    local autoHideFrame = createStyledFrame(layoutFrame, "AutoHideFrame", GUIStyles.Sizes.ButtonFrame)
    local autoHideButton, autoHideToggleBg, autoHideLabel, autoHideIndicator, autoHideStatusText = createToggleSystem(autoHideFrame, "AUTO HIDE ON ADMIN :", SecuritySettings.AutoHideOnAdmin)
    autoHideButton.Name = "AutoHideButton"
    autoHideToggleBg.Name = "AutoHideToggleBg"
    autoHideIndicator.Name = "AutoHideIndicator"

    -- Security Statistics Frame
    local statsFrame = createStyledFrame(layoutFrame, "SecurityStatsFrame", GUIStyles.Sizes.ButtonFrame)
    
    local statsText = Instance.new("TextLabel")
    statsText.Name = "SecurityStatsText"
    statsText.Parent = statsFrame
    statsText.BackgroundTransparency = 1
    statsText.Position = UDim2.new(0.030, 0, 0.216, 0)
    statsText.Size = UDim2.new(0.940, 0, 0.568, 0)
    statsText.Font = GUIStyles.Fonts.Primary
    statsText.Text = "🔒 Admins: 0 | 📡 Alerts: 0 | 🙈 Auto-Hides: 0"
    statsText.TextColor3 = GUIStyles.Colors.Text
    statsText.TextScaled = true

    return {
        frame = SecurityFrame,
        adminButton = adminButton,
        adminToggleBg = adminToggleBg,
        adminIndicator = adminIndicator,
        adminStatusText = adminStatusText,
        proximityButton = proximityButton,
        proximityToggleBg = proximityToggleBg,
        proximityIndicator = proximityIndicator,
        proximityStatusText = proximityStatusText,
        autoHideButton = autoHideButton,
        autoHideToggleBg = autoHideToggleBg,
        autoHideIndicator = autoHideIndicator,
        autoHideStatusText = autoHideStatusText,
        statsText = statsText
    }
end

function GUIHandler.createAdvancedPanel(parent, Settings)
    local AdvancedFrame = Instance.new("ScrollingFrame")
    AdvancedFrame.Name = "AdvancedFrame"
    AdvancedFrame.Parent = parent
    AdvancedFrame.Active = true
    AdvancedFrame.BackgroundTransparency = 1
    AdvancedFrame.Position = UDim2.new(0.376, 0, 0.147, 0)
    AdvancedFrame.Size = UDim2.new(0.624, 0, 0.853, 0)
    AdvancedFrame.Visible = false
    AdvancedFrame.ZIndex = 2
    AdvancedFrame.ScrollBarThickness = 6

    local layoutFrame = createStyledFrame(AdvancedFrame, "AdvancedListLayoutFrame",
        UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0.022, 0))
    layoutFrame.BackgroundTransparency = 1

    local listLayout = Instance.new("UIListLayout")
    listLayout.Name = "ListLayoutAdvanced"
    listLayout.Parent = layoutFrame
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 8)

    -- Luck Boost Frame
    local luckFrame = createStyledFrame(layoutFrame, "LuckBoostFrame", GUIStyles.Sizes.ButtonFrame)
    local luckButton, luckToggleBg, luckLabel, luckIndicator, luckStatusText = createToggleSystem(luckFrame, "LUCK BOOST :", false)
    luckButton.Name = "LuckBoostButton"
    luckToggleBg.Name = "LuckBoostToggleBg"
    luckIndicator.Name = "LuckBoostIndicator"

    -- Weather Boost Frame
    local weatherFrame = createStyledFrame(layoutFrame, "WeatherBoostFrame", GUIStyles.Sizes.ButtonFrame)
    local weatherButton, weatherToggleBg, weatherLabel, weatherIndicator, weatherStatusText = createToggleSystem(weatherFrame, "WEATHER BOOST :", false)
    weatherButton.Name = "WeatherBoostButton"
    weatherToggleBg.Name = "WeatherBoostToggleBg"
    weatherIndicator.Name = "WeatherBoostIndicator"

    -- Smart Fishing Frame
    local smartFrame = createStyledFrame(layoutFrame, "SmartFishingFrame", GUIStyles.Sizes.ButtonFrame)
    local smartButton, smartToggleBg, smartLabel, smartIndicator, smartStatusText = createToggleSystem(smartFrame, "SMART FISHING :", false)
    smartButton.Name = "SmartFishingButton"
    smartToggleBg.Name = "SmartFishingToggleBg"
    smartIndicator.Name = "SmartFishingIndicator"

    -- Fish Value Filter Frame
    local fishValueFrame = createStyledFrame(layoutFrame, "FishValueFrame", GUIStyles.Sizes.ButtonFrame)
    
    local fishValueLabel = Instance.new("TextLabel")
    fishValueLabel.Parent = fishValueFrame
    fishValueLabel.BackgroundTransparency = 1
    fishValueLabel.Position = GUIStyles.Positions.ButtonText
    fishValueLabel.Size = UDim2.new(0.415, 0, 0.568, 0)
    fishValueLabel.Font = GUIStyles.Fonts.Primary
    fishValueLabel.Text = "MIN FISH VALUE:"
    fishValueLabel.TextColor3 = GUIStyles.Colors.Text
    fishValueLabel.TextScaled = true
    fishValueLabel.TextXAlignment = Enum.TextXAlignment.Left

    local fishValueTextBox = Instance.new("TextBox")
    fishValueTextBox.Name = "FishValueTextBox"
    fishValueTextBox.Parent = fishValueFrame
    fishValueTextBox.BackgroundColor3 = GUIStyles.Colors.Black
    fishValueTextBox.BorderSizePixel = 0
    fishValueTextBox.Position = GUIStyles.Positions.Indicator
    fishValueTextBox.Size = GUIStyles.Sizes.Indicator
    fishValueTextBox.ZIndex = 3
    fishValueTextBox.Font = GUIStyles.Fonts.Primary
    fishValueTextBox.PlaceholderText = "100"
    fishValueTextBox.Text = ""
    fishValueTextBox.TextColor3 = GUIStyles.Colors.Text
    fishValueTextBox.TextScaled = true
    
    createUICorner(fishValueTextBox)

    -- Advanced Statistics Frame
    local advStatsFrame = createStyledFrame(layoutFrame, "AdvancedStatsFrame", GUIStyles.Sizes.ButtonFrame)
    
    local advStatsText = Instance.new("TextLabel")
    advStatsText.Name = "AdvancedStatsText"
    advStatsText.Parent = advStatsFrame
    advStatsText.BackgroundTransparency = 1
    advStatsText.Position = UDim2.new(0.030, 0, 0.216, 0)
    advStatsText.Size = UDim2.new(0.940, 0, 0.568, 0)
    advStatsText.Font = GUIStyles.Fonts.Primary
    advStatsText.Text = "💰 Money: ₡0 | 🏆 Rare: 0 | 👑 Legendary: 0"
    advStatsText.TextColor3 = GUIStyles.Colors.Text
    advStatsText.TextScaled = true

    return {
        frame = AdvancedFrame,
        luckButton = luckButton,
        luckToggleBg = luckToggleBg,
        luckIndicator = luckIndicator,
        luckStatusText = luckStatusText,
        weatherButton = weatherButton,
        weatherToggleBg = weatherToggleBg,
        weatherIndicator = weatherIndicator,
        weatherStatusText = weatherStatusText,
        smartButton = smartButton,
        smartToggleBg = smartToggleBg,
        smartIndicator = smartIndicator,
        smartStatusText = smartStatusText,
        fishValueTextBox = fishValueTextBox,
        advStatsText = advStatsText
    }
end

function GUIHandler.createBoatPanel(parent)
    local boats = {
        {name = "Small Boat", value = "SmallDinghy"},
        {name = "Kayak", value = "Kayak"},
        {name = "Jetski", value = "JetSki"},
        {name = "Highfield Boat", value = "HighFieldBoat"},
        {name = "Speed Boat", value = "SpeedBoat"},
        {name = "Fishing Boat", value = "FishingBoat"},
        {name = "Mini Yacht", value = "MiniYacht"},
        {name = "Hyper Boat", value = "HyperBoat"},
        {name = "Frozen Boat", value = "FrozenBoat"},
        {name = "Cruiser Boat", value = "CruiserBoat"}
    }

    local layoutFrame = createStyledFrame(parent, "ListLayoutBoatFrame",
        UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0.022, 0))
    layoutFrame.BackgroundTransparency = 1

    local listLayout = Instance.new("UIListLayout")
    listLayout.Name = "ListLayoutBoat"
    listLayout.Parent = layoutFrame
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 8)

    -- Despawn Boat
    local despawnFrame = createStyledFrame(layoutFrame, "DespawnBoat", GUIStyles.Sizes.ButtonFrame)
    
    local despawnText = Instance.new("TextLabel")
    despawnText.Parent = despawnFrame
    despawnText.BackgroundTransparency = 1
    despawnText.Position = UDim2.new(0.012, 0, 0.216, 0)
    despawnText.Size = UDim2.new(0.970, 0, 0.568, 0)
    despawnText.Font = GUIStyles.Fonts.Primary
    despawnText.Text = "Despawn Boat"
    despawnText.TextColor3 = GUIStyles.Colors.Text
    despawnText.TextScaled = true

    local despawnButton = Instance.new("TextButton")
    despawnButton.Name = "DespawnBoatButton"
    despawnButton.Parent = despawnFrame
    despawnButton.BackgroundTransparency = 1
    despawnButton.Size = UDim2.new(1, 0, 1, 0)
    despawnButton.ZIndex = 2
    despawnButton.Font = GUIStyles.Fonts.Primary
    despawnButton.Text = ""

    local boatButtons = {despawnButton = despawnButton}

    -- Create boat spawn buttons
    for _, boat in ipairs(boats) do
        local boatFrame = createStyledFrame(layoutFrame, boat.value, GUIStyles.Sizes.ButtonFrame)

        local boatButton = Instance.new("TextButton")
        boatButton.Name = boat.value .. "Button"
        boatButton.Parent = boatFrame
        boatButton.BackgroundTransparency = 1
        boatButton.Size = UDim2.new(1, 0, 1, 0)
        boatButton.ZIndex = 2
        boatButton.Font = GUIStyles.Fonts.Primary
        boatButton.Text = ""

        local boatText = Instance.new("TextLabel")
        boatText.Name = boat.value .. "Text"
        boatText.Parent = boatFrame
        boatText.BackgroundTransparency = 1
        boatText.Position = UDim2.new(0.287, 0, 0.216, 0)
        boatText.Size = UDim2.new(0.415, 0, 0.568, 0)
        boatText.Font = GUIStyles.Fonts.Primary
        boatText.Text = boat.name
        boatText.TextColor3 = GUIStyles.Colors.Text
        boatText.TextScaled = true

        boatButtons[boat.value] = boatButton
    end

    return boatButtons
end

function GUIHandler.createFloatingButton(parent)
    -- Create enhanced floating toggle button with modern design
    local FloatingButton = Instance.new("Frame")
    FloatingButton.Name = "FloatingButton"
    FloatingButton.Parent = parent
    FloatingButton.BackgroundColor3 = GUIStyles.Colors.Primary
    FloatingButton.BackgroundTransparency = 0.1
    FloatingButton.BorderSizePixel = 0
    FloatingButton.Position = UDim2.new(0, 20, 0.5, -35)
    FloatingButton.Size = UDim2.new(0, 70, 0, 70)
    FloatingButton.ZIndex = 100
    FloatingButton.Active = true
    
    createUICorner(FloatingButton, GUIStyles.BorderRadius.XLarge)
    createBorder(FloatingButton, 2, GUIStyles.Colors.Primary)
    createGradient(FloatingButton, GUIStyles.Colors.Primary, GUIStyles.Colors.Secondary, 45)
    
    -- Add multiple shadow layers for depth
    local FloatingShadow1 = Instance.new("Frame")
    FloatingShadow1.Name = "FloatingShadow1"
    FloatingShadow1.Parent = parent
    FloatingShadow1.BackgroundColor3 = GUIStyles.Colors.Black
    FloatingShadow1.BackgroundTransparency = 0.7
    FloatingShadow1.BorderSizePixel = 0
    FloatingShadow1.Position = UDim2.new(0, 24, 0.5, -31)
    FloatingShadow1.Size = UDim2.new(0, 70, 0, 70)
    FloatingShadow1.ZIndex = 98
    createUICorner(FloatingShadow1, GUIStyles.BorderRadius.XLarge)
    
    local FloatingShadow2 = Instance.new("Frame")
    FloatingShadow2.Name = "FloatingShadow2"
    FloatingShadow2.Parent = parent
    FloatingShadow2.BackgroundColor3 = GUIStyles.Colors.Black
    FloatingShadow2.BackgroundTransparency = 0.9
    FloatingShadow2.BorderSizePixel = 0
    FloatingShadow2.Position = UDim2.new(0, 26, 0.5, -29)
    FloatingShadow2.Size = UDim2.new(0, 70, 0, 70)
    FloatingShadow2.ZIndex = 97
    createUICorner(FloatingShadow2, GUIStyles.BorderRadius.XLarge)
    
    -- Enhanced icon with better positioning
    local FloatingButtonText = Instance.new("TextLabel")
    FloatingButtonText.Name = "FloatingButtonText"
    FloatingButtonText.Parent = FloatingButton
    FloatingButtonText.BackgroundTransparency = 1
    FloatingButtonText.Size = UDim2.new(0.8, 0, 0.8, 0)
    FloatingButtonText.Position = UDim2.new(0.1, 0, 0.1, 0)
    FloatingButtonText.Font = GUIStyles.Fonts.Title
    FloatingButtonText.Text = "🎣"
    FloatingButtonText.TextColor3 = GUIStyles.Colors.Text
    FloatingButtonText.TextScaled = true
    FloatingButtonText.ZIndex = 101
    
    local FloatingButtonClick = Instance.new("TextButton")
    FloatingButtonClick.Name = "FloatingButtonClick"
    FloatingButtonClick.Parent = FloatingButton
    FloatingButtonClick.BackgroundTransparency = 1
    FloatingButtonClick.Size = UDim2.new(1, 0, 1, 0)
    FloatingButtonClick.Text = ""
    FloatingButtonClick.ZIndex = 102
    
    -- Enhanced tooltip with modern styling
    local FloatingTooltip = Instance.new("Frame")
    FloatingTooltip.Name = "FloatingTooltip"
    FloatingTooltip.Parent = parent
    FloatingTooltip.BackgroundColor3 = GUIStyles.Colors.Background
    FloatingTooltip.BackgroundTransparency = 0.1
    FloatingTooltip.BorderSizePixel = 0
    FloatingTooltip.Position = UDim2.new(0, 100, 0.5, -20)
    FloatingTooltip.Size = UDim2.new(0, 140, 0, 40)
    FloatingTooltip.ZIndex = 105
    FloatingTooltip.Visible = false
    
    createUICorner(FloatingTooltip, GUIStyles.BorderRadius.Medium)
    createBorder(FloatingTooltip, 1, GUIStyles.Colors.Border)
    
    -- Add subtle shadow to tooltip
    local TooltipShadow = Instance.new("Frame")
    TooltipShadow.Name = "TooltipShadow"
    TooltipShadow.Parent = parent
    TooltipShadow.BackgroundColor3 = GUIStyles.Colors.Black
    TooltipShadow.BackgroundTransparency = 0.8
    TooltipShadow.BorderSizePixel = 0
    TooltipShadow.Position = UDim2.new(0, 102, 0.5, -18)
    TooltipShadow.Size = UDim2.new(0, 140, 0, 40)
    TooltipShadow.ZIndex = 104
    TooltipShadow.Visible = false
    createUICorner(TooltipShadow, GUIStyles.BorderRadius.Medium)
    
    local FloatingTooltipText = Instance.new("TextLabel")
    FloatingTooltipText.Name = "FloatingTooltipText"
    FloatingTooltipText.Parent = FloatingTooltip
    FloatingTooltipText.BackgroundTransparency = 1
    FloatingTooltipText.Size = UDim2.new(1, 0, 1, 0)
    FloatingTooltipText.Font = GUIStyles.Fonts.Body
    FloatingTooltipText.Text = "🎯 Toggle GUI Panel"
    FloatingTooltipText.TextColor3 = GUIStyles.Colors.Text
    FloatingTooltipText.TextScaled = true
    FloatingTooltipText.ZIndex = 106

    return {
        button = FloatingButton,
        shadow1 = FloatingShadow1,
        shadow2 = FloatingShadow2,
        text = FloatingButtonText,
        clickButton = FloatingButtonClick,
        tooltip = FloatingTooltip,
        tooltipShadow = TooltipShadow,
        tooltipText = FloatingTooltipText
    }
end

-- ===================================================================
--                         ANIMATION HELPERS
-- ===================================================================

function GUIHandler.addPulseAnimation(element, duration, transparency)
    local TweenService = game:GetService("TweenService")
    local pulseAnimation = TweenService:Create(
        element,
        TweenInfo.new(duration or 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true),
        {BackgroundTransparency = transparency or 0.4}
    )
    pulseAnimation:Play()
    return pulseAnimation
end

function GUIHandler.addHoverEffect(element, hoverSize, normalSize, duration)
    local TweenService = game:GetService("TweenService")
    
    local hoverTweenInfo = TweenInfo.new(
        duration or GUIStyles.Animations.Fast, 
        Enum.EasingStyle.Back, 
        Enum.EasingDirection.Out
    )
    
    local normalTweenInfo = TweenInfo.new(
        duration or GUIStyles.Animations.Fast, 
        Enum.EasingStyle.Quad, 
        Enum.EasingDirection.Out
    )
    
    element.MouseEnter:Connect(function()
        -- Size animation
        element:TweenSize(hoverSize, "Out", "Back", duration or GUIStyles.Animations.Fast, true)
        
        -- Color/transparency animations
        if element.BackgroundTransparency then
            local hoverTween = TweenService:Create(element, hoverTweenInfo, {
                BackgroundTransparency = 0.05,
                BackgroundColor3 = element.BackgroundColor3:lerp(GUIStyles.Colors.Text, 0.1)
            })
            hoverTween:Play()
        end
        
        -- Add subtle glow effect
        if element:FindFirstChild("UIStroke") then
            local strokeTween = TweenService:Create(element.UIStroke, hoverTweenInfo, {
                Transparency = 0.1,
                Thickness = 2
            })
            strokeTween:Play()
        end
    end)
    
    element.MouseLeave:Connect(function()
        -- Return to normal
        element:TweenSize(normalSize, "Out", "Quad", duration or GUIStyles.Animations.Fast, true)
        
        if element.BackgroundTransparency then
            local normalTween = TweenService:Create(element, normalTweenInfo, {
                BackgroundTransparency = 0.1
            })
            normalTween:Play()
        end
        
        if element:FindFirstChild("UIStroke") then
            local strokeTween = TweenService:Create(element.UIStroke, normalTweenInfo, {
                Transparency = 0.3,
                Thickness = 1
            })
            strokeTween:Play()
        end
    end)
end

-- ===================================================================
--                         UPDATE FUNCTIONS
-- ===================================================================

function GUIHandler.updateToggleButton(button, toggleBg, state, indicator, statusText)
    local TweenService = game:GetService("TweenService")
    
    -- Animate toggle background color
    local bgColorTween = TweenService:Create(
        toggleBg,
        TweenInfo.new(GUIStyles.Animations.Fast, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = state and GUIStyles.Colors.Success or GUIStyles.Colors.Dark}
    )
    bgColorTween:Play()
    
    -- Animate indicator position
    if indicator then
        local indicatorTween = TweenService:Create(
            indicator,
            TweenInfo.new(GUIStyles.Animations.Fast, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Position = state and UDim2.new(0.55, 0, 0.1, 0) or UDim2.new(0.05, 0, 0.1, 0)}
        )
        indicatorTween:Play()
    end
    
    -- Update status text with animation
    if statusText then
        statusText.Text = state and "ON" or "OFF"
        local textColorTween = TweenService:Create(
            statusText,
            TweenInfo.new(GUIStyles.Animations.Fast, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {TextColor3 = state and GUIStyles.Colors.Success or GUIStyles.Colors.TextSecondary}
        )
        textColorTween:Play()
    end
    
    -- Update border color
    if toggleBg:FindFirstChild("UIStroke") then
        local borderTween = TweenService:Create(
            toggleBg.UIStroke,
            TweenInfo.new(GUIStyles.Animations.Fast, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Color = state and GUIStyles.Colors.Success or GUIStyles.Colors.Border}
        )
        borderTween:Play()
    end
end

function GUIHandler.updateStatsText(textLabel, stats)
    if stats.security then
        textLabel.Text = string.format("🔒 Admins: %d | 📡 Alerts: %d | 🙈 Auto-Hides: %d", 
            stats.AdminsDetected or 0, stats.ProximityAlerts or 0, stats.AutoHides or 0)
    elseif stats.advanced then
        textLabel.Text = string.format("💰 Money: ₡%d | 🏆 Rare: %d | 👑 Legendary: %d", 
            stats.moneyEarned or 0, stats.rareFishCaught or 0, stats.legendaryFishCaught or 0)
    end
end

-- ===================================================================
--                         DRAG FUNCTIONALITY
-- ===================================================================

function GUIHandler.makeDraggable(element, shadowElement1, shadowElement2)
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local dragging = false
    local dragStart = nil
    local startPos = nil
    local shadow1StartPos = nil
    local shadow2StartPos = nil
    
    element.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = element.Position
            if shadowElement1 then
                shadow1StartPos = shadowElement1.Position
            end
            if shadowElement2 then
                shadow2StartPos = shadowElement2.Position
            end
            
            -- Visual feedback when dragging starts
            local dragTween = TweenService:Create(
                element,
                TweenInfo.new(GUIStyles.Animations.Fast, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 75, 0, 75), BackgroundTransparency = 0.3}
            )
            dragTween:Play()
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging and startPos then
            local delta = input.Position - dragStart
            element.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
            
            if shadowElement1 and shadow1StartPos then
                shadowElement1.Position = UDim2.new(
                    shadow1StartPos.X.Scale,
                    shadow1StartPos.X.Offset + delta.X,
                    shadow1StartPos.Y.Scale,
                    shadow1StartPos.Y.Offset + delta.Y
                )
            end
            
            if shadowElement2 and shadow2StartPos then
                shadowElement2.Position = UDim2.new(
                    shadow2StartPos.X.Scale,
                    shadow2StartPos.X.Offset + delta.X,
                    shadow2StartPos.Y.Scale,
                    shadow2StartPos.Y.Offset + delta.Y
                )
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            
            -- Return to normal size and transparency
            local returnTween = TweenService:Create(
                element,
                TweenInfo.new(GUIStyles.Animations.Fast, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 70, 0, 70), BackgroundTransparency = 0.1}
            )
            returnTween:Play()
        end
    end)
end

-- ===================================================================
--                         EVENT HANDLERS
-- ===================================================================

function GUIHandler.setupEventHandlers(guiComponents, SecuritySettings, Settings, connections, callbacks)
    print("🔧 Setting up GUI Handler event handlers...")
    
    -- Security Panel Event Handlers
    if guiComponents.security and guiComponents.security.adminButton then
        connections[#connections + 1] = guiComponents.security.adminButton.MouseButton1Click:Connect(function()
            print("🔒 Admin Detection button clicked!")
            SecuritySettings.AdminDetection = not SecuritySettings.AdminDetection
            GUIHandler.updateToggleButton(
                guiComponents.security.adminButton, 
                guiComponents.security.adminToggleBg, 
                SecuritySettings.AdminDetection,
                guiComponents.security.adminIndicator,
                guiComponents.security.adminStatusText
            )
            if callbacks and callbacks.createNotification then
                callbacks.createNotification(SecuritySettings.AdminDetection and "🔒 Admin Detection enabled!" or "🔒 Admin Detection disabled!", SecuritySettings.AdminDetection and GUIStyles.Colors.Success or GUIStyles.Colors.Danger)
            end
        end)
        print("✅ Admin Detection button connected")
    end

    if guiComponents.security and guiComponents.security.proximityButton then
        connections[#connections + 1] = guiComponents.security.proximityButton.MouseButton1Click:Connect(function()
            print("📡 Proximity Alert button clicked!")
            SecuritySettings.PlayerProximityAlert = not SecuritySettings.PlayerProximityAlert
            GUIHandler.updateToggleButton(
                guiComponents.security.proximityButton, 
                guiComponents.security.proximityToggleBg, 
                SecuritySettings.PlayerProximityAlert,
                guiComponents.security.proximityIndicator,
                guiComponents.security.proximityStatusText
            )
            if callbacks and callbacks.createNotification then
                callbacks.createNotification(SecuritySettings.PlayerProximityAlert and "📡 Proximity Alert enabled!" or "📡 Proximity Alert disabled!", SecuritySettings.PlayerProximityAlert and GUIStyles.Colors.Success or GUIStyles.Colors.Danger)
            end
        end)
        print("✅ Proximity Alert button connected")
    end

    if guiComponents.security and guiComponents.security.autoHideButton then
        connections[#connections + 1] = guiComponents.security.autoHideButton.MouseButton1Click:Connect(function()
            print("🙈 Auto Hide button clicked!")
            SecuritySettings.AutoHideOnAdmin = not SecuritySettings.AutoHideOnAdmin
            GUIHandler.updateToggleButton(
                guiComponents.security.autoHideButton, 
                guiComponents.security.autoHideToggleBg, 
                SecuritySettings.AutoHideOnAdmin,
                guiComponents.security.autoHideIndicator,
                guiComponents.security.autoHideStatusText
            )
            if callbacks and callbacks.createNotification then
                callbacks.createNotification(SecuritySettings.AutoHideOnAdmin and "🙈 Auto Hide enabled!" or "🙈 Auto Hide disabled!", SecuritySettings.AutoHideOnAdmin and GUIStyles.Colors.Success or GUIStyles.Colors.Danger)
            end
        end)
        print("✅ Auto Hide button connected")
    end

    -- Advanced Panel Event Handlers
    if guiComponents.advanced and guiComponents.advanced.luckButton then
        connections[#connections + 1] = guiComponents.advanced.luckButton.MouseButton1Click:Connect(function()
            print("🍀 Luck Boost button clicked!")
            Settings.LuckBoost = not Settings.LuckBoost
            GUIHandler.updateToggleButton(
                guiComponents.advanced.luckButton, 
                guiComponents.advanced.luckToggleBg, 
                Settings.LuckBoost,
                guiComponents.advanced.luckIndicator,
                guiComponents.advanced.luckStatusText
            )
            if callbacks and callbacks.createNotification then
                callbacks.createNotification(Settings.LuckBoost and "🍀 Luck Boost enabled!" or "🍀 Luck Boost disabled!", Settings.LuckBoost and GUIStyles.Colors.Success or GUIStyles.Colors.Danger)
            end
        end)
        print("✅ Luck Boost button connected")
    end

    if guiComponents.advanced and guiComponents.advanced.weatherButton then
        connections[#connections + 1] = guiComponents.advanced.weatherButton.MouseButton1Click:Connect(function()
            print("🌦️ Weather Boost button clicked!")
            Settings.WeatherBoost = not Settings.WeatherBoost
            GUIHandler.updateToggleButton(
                guiComponents.advanced.weatherButton, 
                guiComponents.advanced.weatherToggleBg, 
                Settings.WeatherBoost,
                guiComponents.advanced.weatherIndicator,
                guiComponents.advanced.weatherStatusText
            )
            if callbacks and callbacks.createNotification then
                callbacks.createNotification(Settings.WeatherBoost and "🌦️ Weather Boost enabled!" or "🌦️ Weather Boost disabled!", Settings.WeatherBoost and GUIStyles.Colors.Success or GUIStyles.Colors.Danger)
            end
        end)
        print("✅ Weather Boost button connected")
    end

    if guiComponents.advanced and guiComponents.advanced.smartButton then
        connections[#connections + 1] = guiComponents.advanced.smartButton.MouseButton1Click:Connect(function()
            print("🧠 Smart Fishing button clicked!")
            Settings.SmartFishing = not Settings.SmartFishing
            GUIHandler.updateToggleButton(
                guiComponents.advanced.smartButton, 
                guiComponents.advanced.smartToggleBg, 
                Settings.SmartFishing,
                guiComponents.advanced.smartIndicator,
                guiComponents.advanced.smartStatusText
            )
            if callbacks and callbacks.createNotification then
                callbacks.createNotification(Settings.SmartFishing and "🧠 Smart Fishing enabled!" or "🧠 Smart Fishing disabled!", Settings.SmartFishing and GUIStyles.Colors.Success or GUIStyles.Colors.Danger)
            end
        end)
        print("✅ Smart Fishing button connected")
    end

    -- Fish Value TextBox Handler
    if guiComponents.advanced and guiComponents.advanced.fishValueTextBox then
        connections[#connections + 1] = guiComponents.advanced.fishValueTextBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                local value = tonumber(guiComponents.advanced.fishValueTextBox.Text)
                if value and value >= 10 and value <= 1000 then
                    Settings.MinFishValue = value
                    Settings.FishValueFilter = true
                    if callbacks and callbacks.createNotification then
                        callbacks.createNotification("💎 Min Fish Value set to ₡" .. value, GUIStyles.Colors.Primary)
                    end
                    guiComponents.advanced.fishValueTextBox.Text = ""
                else
                    if callbacks and callbacks.createNotification then
                        callbacks.createNotification("❌ Invalid value! Use 10-1000", GUIStyles.Colors.Danger)
                    end
                    guiComponents.advanced.fishValueTextBox.Text = ""
                end
            end
        end)
        print("✅ Fish Value TextBox connected")
    end

    -- Floating Button Event Handlers
    if guiComponents.floating and guiComponents.floating.clickButton then
        local isHidden = false
        connections[#connections + 1] = guiComponents.floating.clickButton.MouseButton1Click:Connect(function()
            print("🎣 Floating button clicked!")
            isHidden = not isHidden
            
            -- Hide/show all panels
            if guiComponents.security.frame.Parent then
                guiComponents.security.frame.Parent.Visible = not isHidden
            end
            
            if isHidden then
                guiComponents.floating.text.Text = "👁️"
                guiComponents.floating.button.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
                if callbacks and callbacks.createNotification then
                    callbacks.createNotification("📦 GUI Hidden - Click to show", GUIStyles.Colors.Warning)
                end
            else
                guiComponents.floating.text.Text = "🎣"
                guiComponents.floating.button.BackgroundColor3 = GUIStyles.Colors.Primary
                if callbacks and callbacks.createNotification then
                    callbacks.createNotification("📦 GUI Shown", GUIStyles.Colors.Success)
                end
            end
        end)
        print("✅ Floating button connected")
    end

    -- Floating Button Hover Effects
    if guiComponents.floating and guiComponents.floating.button then
        connections[#connections + 1] = guiComponents.floating.button.MouseEnter:Connect(function()
            guiComponents.floating.tooltip.Visible = true
            guiComponents.floating.tooltipShadow.Visible = true
            
            -- Animate tooltip appearance
            local TweenService = game:GetService("TweenService")
            guiComponents.floating.tooltip:TweenPosition(
                UDim2.new(0, 105, 0.5, -20),
                "Out", "Back", GUIStyles.Animations.Fast, true
            )
            guiComponents.floating.tooltipShadow:TweenPosition(
                UDim2.new(0, 107, 0.5, -18),
                "Out", "Back", GUIStyles.Animations.Fast, true
            )
            
            -- Scale effect on button
            guiComponents.floating.button:TweenSize(
                UDim2.new(0, 75, 0, 75),
                "Out", "Back", GUIStyles.Animations.Fast, true
            )
        end)

        connections[#connections + 1] = guiComponents.floating.button.MouseLeave:Connect(function()
            guiComponents.floating.tooltip.Visible = false
            guiComponents.floating.tooltipShadow.Visible = false
            
            -- Return to normal size
            guiComponents.floating.button:TweenSize(
                UDim2.new(0, 70, 0, 70),
                "Out", "Quad", GUIStyles.Animations.Fast, true
            )
        end)
        print("✅ Floating button hover effects connected")
    end

    print("🎉 All GUI Handler event handlers setup complete!")
    return connections
end

-- ===================================================================
--                         PANEL SWITCHER
-- ===================================================================

function GUIHandler.createPanelSwitcher(guiComponents, callbacks)
    local function showPanel(panelName)
        -- Hide all panels
        guiComponents.security.frame.Visible = false
        guiComponents.advanced.frame.Visible = false
        
        -- Show selected panel
        if panelName == "Security" then
            guiComponents.security.frame.Visible = true
        elseif panelName == "Advanced" then
            guiComponents.advanced.frame.Visible = true
        end
        
        -- Update title if callback provided
        if callbacks and callbacks.updateTitle then
            callbacks.updateTitle(panelName:upper())
        end
    end
    
    return showPanel
end

-- Add new teleport functions to GUIHandler
GUIHandler.createTeleportPanel = function(parent, tpFolder)
    -- Create modern teleport panel with categories
    local TeleportFrame = Instance.new("ScrollingFrame")
    TeleportFrame.Name = "TeleportFrame"
    TeleportFrame.Parent = parent
    TeleportFrame.Active = true
    TeleportFrame.BackgroundTransparency = 1
    TeleportFrame.Position = UDim2.new(0.376, 0, 0.147, 0)
    TeleportFrame.Size = UDim2.new(0.624, 0, 0.853, 0)
    TeleportFrame.Visible = false
    TeleportFrame.ZIndex = 2
    TeleportFrame.ScrollBarThickness = 6
    TeleportFrame.CanvasSize = UDim2.new(0, 0, 2, 0)

    local layoutFrame = createStyledFrame(TeleportFrame, "TeleportListLayoutFrame", 
        UDim2.new(1, 0, 2, 0), UDim2.new(0, 0, 0, 0))
    layoutFrame.BackgroundTransparency = 1

    local listLayout = Instance.new("UIListLayout")
    listLayout.Name = "ListLayoutTeleport"
    listLayout.Parent = layoutFrame
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 8)

    -- Islands data with categories and emojis
    local islandCategories = {
        {
            name = "🏝️ MAIN ISLANDS",
            color = GUIStyles.Colors.Primary,
            islands = {
                {name = "🏰 Kohana", value = "Kohana"},
                {name = "🌋 Crater Island", value = "Crater Island"},
                {name = "🏖️ Stingray Shore", value = "Stingray Shore"},
                {name = "🌴 Tropical Grove", value = "Tropical Grove"},
                {name = "🏔️ Mountain Top", value = "Mountain Top"},
                {name = "🦈 Shark Bay", value = "Shark Bay"}
            }
        },
        {
            name = "🌊 FISHING SPOTS",
            color = GUIStyles.Colors.Secondary,
            islands = {
                {name = "🎣 Deep Ocean", value = "Deep Ocean"},
                {name = "🐟 Shallow Waters", value = "Shallow Waters"},
                {name = "🦀 Coral Reef", value = "Coral Reef"},
                {name = "❄️ Frozen Lake", value = "Frozen Lake"},
                {name = "🔥 Volcanic Waters", value = "Volcanic Waters"},
                {name = "🕳️ Mysterious Cave", value = "Mysterious Cave"}
            }
        },
        {
            name = "🏪 SPECIAL LOCATIONS",
            color = GUIStyles.Colors.Warning,
            islands = {
                {name = "🛒 Market Place", value = "Market"},
                {name = "⚓ Harbor", value = "Harbor"},
                {name = "🏛️ Temple", value = "Temple"},
                {name = "🗼 Lighthouse", value = "Lighthouse"},
                {name = "🏭 Factory", value = "Factory"}
            }
        }
    }

    local teleportButtons = {}
    
    for categoryIndex, category in ipairs(islandCategories) do
        -- Create category header
        local categoryFrame = createStyledFrame(layoutFrame, category.name .. "Header", 
            UDim2.new(0.95, 0, 0, 50))
        categoryFrame.BackgroundColor3 = category.color
        categoryFrame.BackgroundTransparency = 0.1
        createBorder(categoryFrame, 2, category.color)
        
        local categoryText = Instance.new("TextLabel")
        categoryText.Parent = categoryFrame
        categoryText.BackgroundTransparency = 1
        categoryText.Size = UDim2.new(1, -20, 1, 0)
        categoryText.Position = UDim2.new(0, 10, 0, 0)
        categoryText.Font = GUIStyles.Fonts.Title
        categoryText.Text = category.name
        categoryText.TextColor3 = GUIStyles.Colors.Text
        categoryText.TextScaled = true
        categoryText.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Create islands in this category
        for _, island in ipairs(category.islands) do
            local islandFrame = createStyledFrame(layoutFrame, island.value .. "Frame", 
                UDim2.new(0.95, 0, 0, 60))
            islandFrame.BackgroundColor3 = GUIStyles.Colors.Background
            islandFrame.BackgroundTransparency = 0.3
            
            -- Add hover effect frame
            local hoverFrame = Instance.new("Frame")
            hoverFrame.Parent = islandFrame
            hoverFrame.BackgroundColor3 = category.color
            hoverFrame.BackgroundTransparency = 1
            hoverFrame.BorderSizePixel = 0
            hoverFrame.Size = UDim2.new(1, 0, 1, 0)
            hoverFrame.ZIndex = islandFrame.ZIndex + 1
            createUICorner(hoverFrame, GUIStyles.BorderRadius.Medium)
            
            -- Island name text
            local islandText = Instance.new("TextLabel")
            islandText.Parent = islandFrame
            islandText.BackgroundTransparency = 1
            islandText.Position = UDim2.new(0, 15, 0, 0)
            islandText.Size = UDim2.new(0.7, 0, 1, 0)
            islandText.Font = GUIStyles.Fonts.Primary
            islandText.Text = island.name
            islandText.TextColor3 = GUIStyles.Colors.Text
            islandText.TextScaled = true
            islandText.TextXAlignment = Enum.TextXAlignment.Left
            islandText.ZIndex = islandFrame.ZIndex + 2
            
            -- Teleport button
            local teleportButton = Instance.new("TextButton")
            teleportButton.Name = island.value .. "Button"
            teleportButton.Parent = islandFrame
            teleportButton.BackgroundColor3 = category.color
            teleportButton.BackgroundTransparency = 0.2
            teleportButton.BorderSizePixel = 0
            teleportButton.Position = UDim2.new(0.75, 0, 0.15, 0)
            teleportButton.Size = UDim2.new(0.2, 0, 0.7, 0)
            teleportButton.Font = GUIStyles.Fonts.Primary
            teleportButton.Text = "🚀 TP"
            teleportButton.TextColor3 = GUIStyles.Colors.Text
            teleportButton.TextScaled = true
            teleportButton.ZIndex = islandFrame.ZIndex + 3
            
            createUICorner(teleportButton, GUIStyles.BorderRadius.Medium)
            createBorder(teleportButton, 1, category.color)
            
            -- Add hover effects
            teleportButton.MouseEnter:Connect(function()
                hoverFrame.BackgroundTransparency = 0.95
                local TweenService = game:GetService("TweenService")
                TweenService:Create(teleportButton, TweenInfo.new(0.2), {
                    BackgroundTransparency = 0.0,
                    Size = UDim2.new(0.22, 0, 0.8, 0)
                }):Play()
                TweenService:Create(islandText, TweenInfo.new(0.2), {
                    TextColor3 = category.color
                }):Play()
            end)
            
            teleportButton.MouseLeave:Connect(function()
                hoverFrame.BackgroundTransparency = 1
                local TweenService = game:GetService("TweenService")
                TweenService:Create(teleportButton, TweenInfo.new(0.2), {
                    BackgroundTransparency = 0.2,
                    Size = UDim2.new(0.2, 0, 0.7, 0)
                }):Play()
                TweenService:Create(islandText, TweenInfo.new(0.2), {
                    TextColor3 = GUIStyles.Colors.Text
                }):Play()
            end)
            
            teleportButtons[island.value] = teleportButton
        end
    end

    return {
        frame = TeleportFrame,
        buttons = teleportButtons
    }
end

GUIHandler.createPlayerTeleportPanel = function(parent, playersService)
    -- Create modern player teleport panel
    local PlayerTpFrame = Instance.new("ScrollingFrame")
    PlayerTpFrame.Name = "PlayerTpFrame"
    PlayerTpFrame.Parent = parent
    PlayerTpFrame.Active = true
    PlayerTpFrame.BackgroundTransparency = 1
    PlayerTpFrame.Position = UDim2.new(0.376, 0, 0.147, 0)
    PlayerTpFrame.Size = UDim2.new(0.624, 0, 0.853, 0)
    PlayerTpFrame.Visible = false
    PlayerTpFrame.ZIndex = 2
    PlayerTpFrame.ScrollBarThickness = 6

    local layoutFrame = createStyledFrame(PlayerTpFrame, "PlayerTpListLayoutFrame", 
        UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0))
    layoutFrame.BackgroundTransparency = 1

    local listLayout = Instance.new("UIListLayout")
    listLayout.Name = "ListLayoutPlayerTp"
    listLayout.Parent = layoutFrame
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 5)

    -- Search box
    local searchFrame = createStyledFrame(layoutFrame, "SearchFrame", 
        UDim2.new(0.95, 0, 0, 50))
    searchFrame.BackgroundColor3 = GUIStyles.Colors.Dark
    searchFrame.BackgroundTransparency = 0.3
    
    local searchIcon = Instance.new("TextLabel")
    searchIcon.Parent = searchFrame
    searchIcon.BackgroundTransparency = 1
    searchIcon.Position = UDim2.new(0, 10, 0, 0)
    searchIcon.Size = UDim2.new(0, 30, 1, 0)
    searchIcon.Font = GUIStyles.Fonts.Primary
    searchIcon.Text = "🔍"
    searchIcon.TextColor3 = GUIStyles.Colors.TextSecondary
    searchIcon.TextScaled = true
    
    local searchBox = Instance.new("TextBox")
    searchBox.Name = "PlayerSearchBox"
    searchBox.Parent = searchFrame
    searchBox.BackgroundTransparency = 1
    searchBox.Position = UDim2.new(0, 45, 0, 5)
    searchBox.Size = UDim2.new(1, -50, 1, -10)
    searchBox.Font = GUIStyles.Fonts.Body
    searchBox.PlaceholderText = "Search players..."
    searchBox.Text = ""
    searchBox.TextColor3 = GUIStyles.Colors.Text
    searchBox.TextScaled = true
    searchBox.TextXAlignment = Enum.TextXAlignment.Left

    local playerButtons = {}
    
    -- Function to refresh player list
    local function refreshPlayerList()
        -- Clear existing player buttons
        for _, button in pairs(playerButtons) do
            if button.Parent then
                button.Parent:Destroy()
            end
        end
        playerButtons = {}
        
        -- Get current players
        local players = playersService:GetPlayers()
        local searchTerm = searchBox.Text:lower()
        
        for _, player in ipairs(players) do
            -- Skip local player and filter by search
            if player ~= playersService.LocalPlayer then
                if searchTerm == "" or player.Name:lower():find(searchTerm) or 
                   player.DisplayName:lower():find(searchTerm) then
                    
                    local playerFrame = createStyledFrame(layoutFrame, player.Name .. "Frame", 
                        UDim2.new(0.95, 0, 0, 55))
                    playerFrame.BackgroundColor3 = GUIStyles.Colors.Background
                    playerFrame.BackgroundTransparency = 0.4
                    
                    -- Player avatar (placeholder)
                    local avatarFrame = Instance.new("Frame")
                    avatarFrame.Parent = playerFrame
                    avatarFrame.BackgroundColor3 = GUIStyles.Colors.Primary
                    avatarFrame.BorderSizePixel = 0
                    avatarFrame.Position = UDim2.new(0, 10, 0.1, 0)
                    avatarFrame.Size = UDim2.new(0, 40, 0.8, 0)
                    createUICorner(avatarFrame, GUIStyles.BorderRadius.Large)
                    
                    local avatarText = Instance.new("TextLabel")
                    avatarText.Parent = avatarFrame
                    avatarText.BackgroundTransparency = 1
                    avatarText.Size = UDim2.new(1, 0, 1, 0)
                    avatarText.Font = GUIStyles.Fonts.Title
                    avatarText.Text = player.Name:sub(1, 1):upper()
                    avatarText.TextColor3 = GUIStyles.Colors.Text
                    avatarText.TextScaled = true
                    
                    -- Player info
                    local playerName = Instance.new("TextLabel")
                    playerName.Parent = playerFrame
                    playerName.BackgroundTransparency = 1
                    playerName.Position = UDim2.new(0, 60, 0, 0)
                    playerName.Size = UDim2.new(0.5, 0, 0.6, 0)
                    playerName.Font = GUIStyles.Fonts.Primary
                    playerName.Text = player.DisplayName
                    playerName.TextColor3 = GUIStyles.Colors.Text
                    playerName.TextScaled = true
                    playerName.TextXAlignment = Enum.TextXAlignment.Left
                    
                    local playerUsername = Instance.new("TextLabel")
                    playerUsername.Parent = playerFrame
                    playerUsername.BackgroundTransparency = 1
                    playerUsername.Position = UDim2.new(0, 60, 0.6, 0)
                    playerUsername.Size = UDim2.new(0.5, 0, 0.4, 0)
                    playerUsername.Font = GUIStyles.Fonts.Body
                    playerUsername.Text = "@" .. player.Name
                    playerUsername.TextColor3 = GUIStyles.Colors.TextSecondary
                    playerUsername.TextScaled = true
                    playerUsername.TextXAlignment = Enum.TextXAlignment.Left
                    
                    -- Teleport button
                    local tpButton = Instance.new("TextButton")
                    tpButton.Name = player.Name .. "TpButton"
                    tpButton.Parent = playerFrame
                    tpButton.BackgroundColor3 = GUIStyles.Colors.Success
                    tpButton.BackgroundTransparency = 0.2
                    tpButton.BorderSizePixel = 0
                    tpButton.Position = UDim2.new(0.75, 0, 0.15, 0)
                    tpButton.Size = UDim2.new(0.2, 0, 0.7, 0)
                    tpButton.Font = GUIStyles.Fonts.Primary
                    tpButton.Text = "🚀"
                    tpButton.TextColor3 = GUIStyles.Colors.Text
                    tpButton.TextScaled = true
                    
                    createUICorner(tpButton, GUIStyles.BorderRadius.Medium)
                    
                    -- Add hover effect
                    tpButton.MouseEnter:Connect(function()
                        local TweenService = game:GetService("TweenService")
                        TweenService:Create(tpButton, TweenInfo.new(0.2), {
                            BackgroundTransparency = 0.0,
                            Size = UDim2.new(0.22, 0, 0.8, 0)
                        }):Play()
                    end)
                    
                    tpButton.MouseLeave:Connect(function()
                        local TweenService = game:GetService("TweenService")
                        TweenService:Create(tpButton, TweenInfo.new(0.2), {
                            BackgroundTransparency = 0.2,
                            Size = UDim2.new(0.2, 0, 0.7, 0)
                        }):Play()
                    end)
                    
                    playerButtons[player.Name] = tpButton
                end
            end
        end
        
        -- Update canvas size
        PlayerTpFrame.CanvasSize = UDim2.new(0, 0, 0, #playerButtons * 65 + 100)
    end
    
    -- Connect search functionality
    searchBox:GetPropertyChangedSignal("Text"):Connect(refreshPlayerList)
    
    -- Initial refresh
    refreshPlayerList()
    
    -- Auto-refresh every 5 seconds
    task.spawn(function()
        while PlayerTpFrame.Parent do
            task.wait(5)
            if PlayerTpFrame.Visible then
                refreshPlayerList()
            end
        end
    end)

    return {
        frame = PlayerTpFrame,
        buttons = playerButtons,
        searchBox = searchBox,
        refreshList = refreshPlayerList
    }
end

GUIHandler.createQuickTeleportBar = function(parent)
    -- Create quick access teleport bar at bottom
    local quickTpBar = createStyledFrame(parent, "QuickTeleportBar", 
        UDim2.new(0.9, 0, 0, 60), UDim2.new(0.05, 0, 0.9, 0))
    quickTpBar.BackgroundColor3 = GUIStyles.Colors.Dark
    quickTpBar.BackgroundTransparency = 0.1
    createBorder(quickTpBar, 2, GUIStyles.Colors.Primary)
    
    local quickLayout = Instance.new("UIListLayout")
    quickLayout.Parent = quickTpBar
    quickLayout.FillDirection = Enum.FillDirection.Horizontal
    quickLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    quickLayout.SortOrder = Enum.SortOrder.LayoutOrder
    quickLayout.Padding = UDim.new(0, 10)
    
    local quickPadding = Instance.new("UIPadding")
    quickPadding.Parent = quickTpBar
    quickPadding.PaddingLeft = UDim.new(0, 10)
    quickPadding.PaddingRight = UDim.new(0, 10)
    quickPadding.PaddingTop = UDim.new(0, 8)
    quickPadding.PaddingBottom = UDim.new(0, 8)
    
    -- Quick teleport destinations
    local quickDestinations = {
        {name = "🏰", text = "Kohana", value = "Kohana", color = GUIStyles.Colors.Primary},
        {name = "🌋", text = "Crater", value = "Crater Island", color = GUIStyles.Colors.Warning},
        {name = "🏖️", text = "Shore", value = "Stingray Shore", color = GUIStyles.Colors.Info},
        {name = "🎣", text = "Deep", value = "Deep Ocean", color = GUIStyles.Colors.Secondary},
        {name = "🛒", text = "Market", value = "Market", color = GUIStyles.Colors.Success}
    }
    
    local quickButtons = {}
    
    for _, dest in ipairs(quickDestinations) do
        local quickButton = Instance.new("TextButton")
        quickButton.Name = "Quick" .. dest.value
        quickButton.Parent = quickTpBar
        quickButton.BackgroundColor3 = dest.color
        quickButton.BackgroundTransparency = 0.3
        quickButton.BorderSizePixel = 0
        quickButton.Size = UDim2.new(0, 80, 1, 0)
        quickButton.Font = GUIStyles.Fonts.Body
        quickButton.Text = dest.name .. "\n" .. dest.text
        quickButton.TextColor3 = GUIStyles.Colors.Text
        quickButton.TextScaled = true
        
        createUICorner(quickButton, GUIStyles.BorderRadius.Medium)
        createBorder(quickButton, 1, dest.color)
        
        -- Add glow effect
        local glowFrame = Instance.new("Frame")
        glowFrame.Parent = quickButton
        glowFrame.BackgroundColor3 = dest.color
        glowFrame.BackgroundTransparency = 1
        glowFrame.BorderSizePixel = 0
        glowFrame.Position = UDim2.new(0, -2, 0, -2)
        glowFrame.Size = UDim2.new(1, 4, 1, 4)
        glowFrame.ZIndex = quickButton.ZIndex - 1
        createUICorner(glowFrame, GUIStyles.BorderRadius.Medium)
        
        -- Hover effects
        quickButton.MouseEnter:Connect(function()
            local TweenService = game:GetService("TweenService")
            TweenService:Create(quickButton, TweenInfo.new(0.2), {
                BackgroundTransparency = 0.1,
                Size = UDim2.new(0, 85, 1.1, 0)
            }):Play()
            TweenService:Create(glowFrame, TweenInfo.new(0.2), {
                BackgroundTransparency = 0.7
            }):Play()
        end)
        
        quickButton.MouseLeave:Connect(function()
            local TweenService = game:GetService("TweenService")
            TweenService:Create(quickButton, TweenInfo.new(0.2), {
                BackgroundTransparency = 0.3,
                Size = UDim2.new(0, 80, 1, 0)
            }):Play()
            TweenService:Create(glowFrame, TweenInfo.new(0.2), {
                BackgroundTransparency = 1
            }):Play()
        end)
        
        quickButtons[dest.value] = quickButton
    end
    
    return {
        frame = quickTpBar,
        buttons = quickButtons
    }
end

-- ===================================================================
--                         MAIN GUI CREATOR
-- ===================================================================

function GUIHandler.createCompleteGUI(parent, SecuritySettings, Settings)
    local guiComponents = {}
    
    -- Create Security Panel
    guiComponents.security = GUIHandler.createSecurityPanel(parent, SecuritySettings)
    
    -- Create Advanced Panel
    guiComponents.advanced = GUIHandler.createAdvancedPanel(parent, Settings)
    
    -- Create Floating Button
    guiComponents.floating = GUIHandler.createFloatingButton(parent)
    
    -- Add animations and effects
    GUIHandler.addPulseAnimation(guiComponents.floating.button, 2.5, 0.3)
    GUIHandler.addHoverEffect(
        guiComponents.floating.button, 
        UDim2.new(0, 75, 0, 75), 
        UDim2.new(0, 70, 0, 70),
        GUIStyles.Animations.Fast
    )
    
    -- Make floating button draggable with enhanced shadows
    GUIHandler.makeDraggable(guiComponents.floating.button, guiComponents.floating.shadow1, guiComponents.floating.shadow2)
    
    return guiComponents
end

-- ===================================================================
--                         EXPORT MODULE
-- ===================================================================

return GUIHandler
