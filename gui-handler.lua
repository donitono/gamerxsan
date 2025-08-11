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
        Background = Color3.fromRGB(47, 47, 47),
        Primary = Color3.fromRGB(0, 162, 255),
        Success = Color3.fromRGB(0, 255, 0),
        Danger = Color3.fromRGB(255, 0, 0),
        Warning = Color3.fromRGB(255, 165, 0),
        Text = Color3.fromRGB(255, 255, 255),
        Black = Color3.fromRGB(0, 0, 0),
        Purple = Color3.fromRGB(255, 0, 255),
        Dark = Color3.fromRGB(128, 0, 128)
    },
    
    Fonts = {
        Primary = Enum.Font.SourceSansBold,
        Title = Enum.Font.GothamBold
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
    }
}

-- ===================================================================
--                         UTILITY FUNCTIONS
-- ===================================================================

local function createUICorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 0)
    corner.Parent = parent
    return corner
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
    -- Create label
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.BackgroundTransparency = 1
    label.Position = GUIStyles.Positions.ButtonText
    label.Size = UDim2.new(0.415, 0, 0.568, 0)
    label.Font = GUIStyles.Fonts.Primary
    label.Text = labelText
    label.TextColor3 = GUIStyles.Colors.Text
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Create button
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.BackgroundTransparency = 1
    button.Position = GUIStyles.Positions.ToggleButton
    button.Size = GUIStyles.Sizes.ToggleButton
    button.ZIndex = 2
    button.Font = GUIStyles.Fonts.Primary
    button.Text = settingValue and "ON" or "OFF"
    button.TextColor3 = GUIStyles.Colors.Text
    button.TextScaled = true
    
    -- Create indicator
    local indicator = Instance.new("Frame")
    indicator.Parent = parent
    indicator.BackgroundColor3 = settingValue and GUIStyles.Colors.Success or GUIStyles.Colors.Black
    indicator.BorderSizePixel = 0
    indicator.Position = GUIStyles.Positions.Indicator
    indicator.Size = GUIStyles.Sizes.Indicator
    
    createUICorner(indicator)
    
    return button, indicator, label
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
    local adminButton, adminIndicator = createToggleSystem(adminFrame, "ADMIN DETECTION :", SecuritySettings.AdminDetection)
    adminButton.Name = "AdminDetectionButton"
    adminIndicator.Name = "AdminDetectionWarna"

    -- Proximity Alert Frame
    local proximityFrame = createStyledFrame(layoutFrame, "ProximityAlertFrame", GUIStyles.Sizes.ButtonFrame)
    local proximityButton, proximityIndicator = createToggleSystem(proximityFrame, "PROXIMITY ALERT :", SecuritySettings.PlayerProximityAlert)
    proximityButton.Name = "ProximityAlertButton"
    proximityIndicator.Name = "ProximityAlertWarna"

    -- Auto Hide Frame
    local autoHideFrame = createStyledFrame(layoutFrame, "AutoHideFrame", GUIStyles.Sizes.ButtonFrame)
    local autoHideButton, autoHideIndicator = createToggleSystem(autoHideFrame, "AUTO HIDE ON ADMIN :", SecuritySettings.AutoHideOnAdmin)
    autoHideButton.Name = "AutoHideButton"
    autoHideIndicator.Name = "AutoHideWarna"

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
        adminIndicator = adminIndicator,
        proximityButton = proximityButton,
        proximityIndicator = proximityIndicator,
        autoHideButton = autoHideButton,
        autoHideIndicator = autoHideIndicator,
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
    local luckButton, luckIndicator = createToggleSystem(luckFrame, "LUCK BOOST :", false)
    luckButton.Name = "LuckBoostButton"
    luckIndicator.Name = "LuckBoostWarna"

    -- Weather Boost Frame
    local weatherFrame = createStyledFrame(layoutFrame, "WeatherBoostFrame", GUIStyles.Sizes.ButtonFrame)
    local weatherButton, weatherIndicator = createToggleSystem(weatherFrame, "WEATHER BOOST :", false)
    weatherButton.Name = "WeatherBoostButton"
    weatherIndicator.Name = "WeatherBoostWarna"

    -- Smart Fishing Frame
    local smartFrame = createStyledFrame(layoutFrame, "SmartFishingFrame", GUIStyles.Sizes.ButtonFrame)
    local smartButton, smartIndicator = createToggleSystem(smartFrame, "SMART FISHING :", false)
    smartButton.Name = "SmartFishingButton"
    smartIndicator.Name = "SmartFishingWarna"

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
        luckIndicator = luckIndicator,
        weatherButton = weatherButton,
        weatherIndicator = weatherIndicator,
        smartButton = smartButton,
        smartIndicator = smartIndicator,
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
    -- Create enhanced floating toggle button
    local FloatingButton = Instance.new("Frame")
    FloatingButton.Name = "FloatingButton"
    FloatingButton.Parent = parent
    FloatingButton.BackgroundColor3 = GUIStyles.Colors.Primary
    FloatingButton.BackgroundTransparency = 0.2
    FloatingButton.BorderSizePixel = 0
    FloatingButton.Position = UDim2.new(0, 20, 0.5, -30)
    FloatingButton.Size = GUIStyles.Sizes.FloatingButton
    FloatingButton.ZIndex = 100
    FloatingButton.Active = true
    
    createUICorner(FloatingButton, 30)
    
    -- Add shadow effect
    local FloatingShadow = Instance.new("Frame")
    FloatingShadow.Name = "FloatingShadow"
    FloatingShadow.Parent = parent
    FloatingShadow.BackgroundColor3 = GUIStyles.Colors.Black
    FloatingShadow.BackgroundTransparency = 0.7
    FloatingShadow.BorderSizePixel = 0
    FloatingShadow.Position = UDim2.new(0, 22, 0.5, -28)
    FloatingShadow.Size = GUIStyles.Sizes.FloatingButton
    FloatingShadow.ZIndex = 99
    
    createUICorner(FloatingShadow, 30)
    
    local FloatingButtonText = Instance.new("TextLabel")
    FloatingButtonText.Name = "FloatingButtonText"
    FloatingButtonText.Parent = FloatingButton
    FloatingButtonText.BackgroundTransparency = 1
    FloatingButtonText.Size = UDim2.new(1, 0, 1, 0)
    FloatingButtonText.Font = GUIStyles.Fonts.Primary
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
    
    -- Add tooltip for floating button
    local FloatingTooltip = Instance.new("Frame")
    FloatingTooltip.Name = "FloatingTooltip"
    FloatingTooltip.Parent = parent
    FloatingTooltip.BackgroundColor3 = GUIStyles.Colors.Black
    FloatingTooltip.BackgroundTransparency = 0.2
    FloatingTooltip.BorderSizePixel = 0
    FloatingTooltip.Position = UDim2.new(0, 90, 0.5, -15)
    FloatingTooltip.Size = UDim2.new(0, 120, 0, 30)
    FloatingTooltip.ZIndex = 105
    FloatingTooltip.Visible = false
    
    createUICorner(FloatingTooltip, 5)
    
    local FloatingTooltipText = Instance.new("TextLabel")
    FloatingTooltipText.Name = "FloatingTooltipText"
    FloatingTooltipText.Parent = FloatingTooltip
    FloatingTooltipText.BackgroundTransparency = 1
    FloatingTooltipText.Size = UDim2.new(1, 0, 1, 0)
    FloatingTooltipText.Font = GUIStyles.Fonts.Primary
    FloatingTooltipText.Text = "Click to toggle GUI"
    FloatingTooltipText.TextColor3 = GUIStyles.Colors.Text
    FloatingTooltipText.TextScaled = true
    FloatingTooltipText.ZIndex = 106

    return {
        button = FloatingButton,
        shadow = FloatingShadow,
        text = FloatingButtonText,
        clickButton = FloatingButtonClick,
        tooltip = FloatingTooltip,
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
    
    element.MouseEnter:Connect(function()
        element:TweenSize(hoverSize, "Out", "Quad", duration or 0.2, true)
        element.BackgroundTransparency = 0.1
    end)
    
    element.MouseLeave:Connect(function()
        element:TweenSize(normalSize, "Out", "Quad", duration or 0.2, true)
        element.BackgroundTransparency = 0.2
    end)
end

-- ===================================================================
--                         UPDATE FUNCTIONS
-- ===================================================================

function GUIHandler.updateToggleButton(button, indicator, state)
    button.Text = state and "ON" or "OFF"
    indicator.BackgroundColor3 = state and GUIStyles.Colors.Success or GUIStyles.Colors.Black
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

function GUIHandler.makeDraggable(element, shadowElement)
    local UserInputService = game:GetService("UserInputService")
    local dragging = false
    local dragStart = nil
    local startPos = nil
    local shadowStartPos = nil
    
    element.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = element.Position
            if shadowElement then
                shadowStartPos = shadowElement.Position
            end
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            element.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
            
            if shadowElement and shadowStartPos then
                shadowElement.Position = UDim2.new(
                    shadowStartPos.X.Scale,
                    shadowStartPos.X.Offset + delta.X,
                    shadowStartPos.Y.Scale,
                    shadowStartPos.Y.Offset + delta.Y
                )
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
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
    
    -- Add animations
    GUIHandler.addPulseAnimation(guiComponents.floating.button)
    GUIHandler.addHoverEffect(
        guiComponents.floating.button, 
        UDim2.new(0, 70, 0, 70), 
        UDim2.new(0, 60, 0, 60)
    )
    
    -- Make floating button draggable
    GUIHandler.makeDraggable(guiComponents.floating.button, guiComponents.floating.shadow)
    
    return guiComponents
end

-- ===================================================================
--                         EXPORT MODULE
-- ===================================================================

return GUIHandler
