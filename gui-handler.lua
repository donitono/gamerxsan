-- ===================================================================
--                        GUI HANDLER MODULE
--                    Zayros FISH-IT V2.0 GUI System
--                       ✨ MODERN TOGGLE EDITION ✨
--
-- 🎨 Features:
-- • Ultra-modern toggle switches (iPhone 15 Pro style)
-- • Glass morphism effects with enhanced shadows
-- • Colorful icon system with dynamic glow effects
-- • Smooth spring animations with haptic feedback
-- • Premium dark theme with enhanced contrast
-- • Status indicators with pulse animations
-- ===================================================================

local GUIHandler = {}

-- ===================================================================
--                           GUI STYLES & CONSTANTS
-- ===================================================================

local GUIStyles = {
    Colors = {
        -- Premium Dark Theme (更专业的深色主题)
        Background = Color3.fromRGB(18, 18, 20),        -- Ultra dark background
        Surface = Color3.fromRGB(28, 28, 30),           -- Card/panel surface
        Primary = Color3.fromRGB(0, 122, 255),          -- iOS System Blue
        Secondary = Color3.fromRGB(88, 86, 214),        -- iOS System Purple
        Accent = Color3.fromRGB(255, 45, 85),           -- iOS System Pink
        Success = Color3.fromRGB(48, 209, 88),          -- iOS System Green
        Danger = Color3.fromRGB(255, 69, 58),           -- iOS System Red
        Warning = Color3.fromRGB(255, 159, 10),         -- iOS System Orange
        Info = Color3.fromRGB(90, 200, 250),            -- iOS System Light Blue
        
        -- Text Colors (更好的文字层次)
        Text = Color3.fromRGB(255, 255, 255),           -- Primary white text
        TextSecondary = Color3.fromRGB(152, 152, 157),  -- Secondary gray text
        TextTertiary = Color3.fromRGB(99, 99, 102),     -- Tertiary gray text
        TextDisabled = Color3.fromRGB(60, 60, 67),      -- Disabled text
        
        -- Interface Elements (更精细的界面元素)
        Black = Color3.fromRGB(0, 0, 0),                -- Pure black
        Dark = Color3.fromRGB(44, 44, 46),              -- Dark surface
        Border = Color3.fromRGB(58, 58, 60),            -- Border color
        BorderLight = Color3.fromRGB(72, 72, 74),       -- Light border
        Hover = Color3.fromRGB(54, 54, 56),             -- Hover state
        Active = Color3.fromRGB(64, 64, 67),            -- Active state
        
        -- Toggle & Interactive Elements (iOS风格的交互元素)
        ToggleOn = Color3.fromRGB(48, 209, 88),         -- Green when active
        ToggleOff = Color3.fromRGB(120, 120, 128),      -- Gray when inactive  
        ToggleTrack = Color3.fromRGB(39, 39, 41),       -- Toggle background track
        Separator = Color3.fromRGB(54, 54, 56),         -- Line separators
        
        -- Gradient Colors (渐变色彩)
        GradientStart = Color3.fromRGB(32, 32, 35),     -- Gradient start
        GradientEnd = Color3.fromRGB(24, 24, 27),       -- Gradient end
        
        -- Icon Theme Colors (彩色图标主题)
        IconBlue = Color3.fromRGB(52, 120, 246),        -- 蓝色图标
        IconPurple = Color3.fromRGB(159, 122, 234),     -- 紫色图标
        IconPink = Color3.fromRGB(245, 101, 101),       -- 粉色图标
        IconOrange = Color3.fromRGB(255, 159, 67),      -- 橙色图标
        IconGreen = Color3.fromRGB(72, 187, 120),       -- 绿色图标
        IconYellow = Color3.fromRGB(255, 206, 84),      -- 黄色图标
        IconRed = Color3.fromRGB(234, 84, 85),          -- 红色图标
        IconCyan = Color3.fromRGB(86, 204, 242),        -- 青色图标
    },
    
    Fonts = {
        Primary = Enum.Font.Gotham,                     -- Clean body font
        Title = Enum.Font.GothamMedium,                 -- Medium weight titles
        Body = Enum.Font.Gotham,                        -- Regular body text
        Icon = Enum.Font.GothamBold,                    -- Bold for icons
        Caption = Enum.Font.Gotham                      -- Regular for captions (GothamLight tidak valid)
    },
    
    -- Modern Icon System with Colors (现代化彩色图标系统)
    Icons = {
        Security = {
            text = "🛡️",
            color = "IconBlue",
            accent = Color3.fromRGB(52, 120, 246)
        },
        AutoFish = {
            text = "🎣",
            color = "IconGreen", 
            accent = Color3.fromRGB(72, 187, 120)
        },
        Reset = {
            text = "🔄",
            color = "IconOrange",
            accent = Color3.fromRGB(255, 159, 67)
        },
        Sell = {
            text = "💰",
            color = "IconYellow",
            accent = Color3.fromRGB(255, 206, 84)
        },
        Luck = {
            text = "🍀",
            color = "IconGreen",
            accent = Color3.fromRGB(72, 187, 120)
        },
        Weather = {
            text = "🌦️",
            color = "IconCyan",
            accent = Color3.fromRGB(86, 204, 242)
        },
        Smart = {
            text = "🧠",
            color = "IconPurple",
            accent = Color3.fromRGB(159, 122, 234)
        },
        Stats = {
            text = "📊",
            color = "IconPink",
            accent = Color3.fromRGB(245, 101, 101)
        },
        Teleport = {
            text = "🚀",
            color = "IconRed",
            accent = Color3.fromRGB(234, 84, 85)
        },
        Player = {
            text = "👤",
            color = "IconBlue",
            accent = Color3.fromRGB(52, 120, 246)
        }
    },
    
    Sizes = {
        ButtonFrame = UDim2.new(0.95, 0, 0.08, 0),         -- Wider and shorter for landscape
        ToggleButton = UDim2.new(0.207, 0, 0.784, 0),
        Indicator = UDim2.new(0.257, 0, 0.730, 0),
        FloatingButton = UDim2.new(0, 60, 0, 60),
        
        -- Modern iOS-style sizes optimized for landscape (针对横屏优化的现代化尺寸)
        RowHeight = 50,                                     -- Reduced height for landscape
        ToggleHeight = 32,                                  -- Toggle switch height  
        ToggleWidth = 52,                                   -- Toggle switch width
        IconSize = 24,                                      -- Slightly smaller icon size for landscape
        Padding = 16,                                       -- Reduced padding for landscape
        CardPadding = 12,                                   -- Smaller card padding
        SectionSpacing = 16,                                -- Reduced space between sections
        
        -- Glass Morphism Effects (玻璃态效果)
        BlurRadius = 20,                                    -- Background blur
        ShadowOffset = 3,                                   -- Smaller shadow for landscape
        BorderWidth = 1                                     -- Thin borders
    },
    
    -- Visual Effects (视觉效果)
    Effects = {
        -- Glass Morphism
        GlassTransparency = 0.15,                       -- Glass effect transparency
        BackdropBlur = 15,                              -- Backdrop blur intensity
        
        -- Shadows (阴影系统)
        ShadowLow = {
            offset = UDim2.new(0, 0, 0, 2),
            blur = 4,
            transparency = 0.25
        },
        ShadowMedium = {
            offset = UDim2.new(0, 0, 0, 4),
            blur = 8,
            transparency = 0.2
        },
        ShadowHigh = {
            offset = UDim2.new(0, 0, 0, 8),
            blur = 16,
            transparency = 0.15
        },
        
        -- Glow Effects (发光效果)
        GlowIntensity = 0.3,
        GlowSize = 2,
        
        -- Hover States (悬停状态)
        HoverScale = 1.05,                              -- Scale on hover
        HoverTransparency = 0.8,                        -- Transparency on hover
        
        -- Active States (激活状态)
        ActiveScale = 0.98,                             -- Scale when pressed
        ActiveTransparency = 0.9                        -- Transparency when pressed
    },
    
    Positions = {
        ButtonText = UDim2.new(0.030, 0, 0.216, 0),
        ToggleButton = UDim2.new(0.738, 0, 0.108, 0),
        Indicator = UDim2.new(0.719, 0, 0.135, 0)
    },
    
    -- Animation settings matching iOS smoothness
    Animations = {
        Fast = 0.15,
        Normal = 0.25,
        Slow = 0.4
    },
    
    -- Border radius matching iOS design
    BorderRadius = {
        Small = UDim.new(0, 8),                         -- Small radius
        Medium = UDim.new(0, 12),                       -- Medium radius
        Large = UDim.new(0, 16),                        -- Large radius
        XLarge = UDim.new(0, 20),                       -- Extra large
        Toggle = UDim.new(0, 16),                       -- Perfect for toggle switches
        Row = UDim.new(0, 12)                           -- Row containers
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

-- Glass Morphism Effect (玻璃态效果)
local function createGlassMorphism(parent, transparency, blurIntensity)
    -- Create backdrop blur effect
    local blurFrame = Instance.new("Frame")
    blurFrame.Name = "BlurBackdrop"
    blurFrame.Parent = parent
    blurFrame.Size = UDim2.new(1, 0, 1, 0)
    blurFrame.Position = UDim2.new(0, 0, 0, 0)
    blurFrame.BackgroundColor3 = GUIStyles.Colors.Surface
    blurFrame.BackgroundTransparency = transparency or GUIStyles.Effects.GlassTransparency
    blurFrame.BorderSizePixel = 0
    blurFrame.ZIndex = parent.ZIndex - 1
    
    createUICorner(blurFrame, GUIStyles.BorderRadius.Large)
    createBorder(blurFrame, 1, GUIStyles.Colors.BorderLight)
    
    -- Add subtle gradient overlay
    createGradient(blurFrame, GUIStyles.Colors.GradientStart, GUIStyles.Colors.GradientEnd, 135)
    
    return blurFrame
end

-- Enhanced Shadow System (增强阴影系统)
local function createEnhancedShadow(parent, element, shadowType)
    local shadowConfig = GUIStyles.Effects[shadowType or "ShadowMedium"]
    
    local shadow = Instance.new("Frame")
    shadow.Name = element.Name .. "Shadow"
    shadow.Parent = parent
    shadow.BackgroundColor3 = GUIStyles.Colors.Black
    shadow.BackgroundTransparency = 1 - shadowConfig.transparency
    shadow.BorderSizePixel = 0
    shadow.Position = element.Position + shadowConfig.offset
    shadow.Size = element.Size
    shadow.ZIndex = element.ZIndex - 1
    
    createUICorner(shadow, GUIStyles.BorderRadius.Large)
    
    return shadow
end

-- Icon Container with Color (彩色图标容器)
local function createIconContainer(parent, iconData, size)
    local container = Instance.new("Frame")
    container.Name = "IconContainer"
    container.Parent = parent
    container.BackgroundColor3 = iconData.accent
    container.BackgroundTransparency = 0.8
    container.BorderSizePixel = 0
    container.Size = size or UDim2.new(0, GUIStyles.Sizes.IconSize + 8, 0, GUIStyles.Sizes.IconSize + 8)
    
    createUICorner(container, GUIStyles.BorderRadius.Medium)
    
    local icon = Instance.new("TextLabel")
    icon.Name = "Icon"
    icon.Parent = container
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(0.8, 0, 0.8, 0)
    icon.Position = UDim2.new(0.1, 0, 0.1, 0)
    icon.Font = GUIStyles.Fonts.Icon
    icon.Text = iconData.text
    icon.TextColor3 = iconData.accent
    icon.TextScaled = true
    icon.ZIndex = container.ZIndex + 1
    
    return container, icon
end

-- Animated Card Component (动画卡片组件)
local function createAnimatedCard(parent, name, size, position)
    local card = createStyledFrame(parent, name, size, position, GUIStyles.Colors.Surface)
    card.BackgroundTransparency = 0.05
    
    -- Add glass morphism
    createGlassMorphism(card, 0.1, 15)
    
    -- Add enhanced shadow
    createEnhancedShadow(parent, card, "ShadowMedium")
    
    -- Add subtle border
    createBorder(card, 1, GUIStyles.Colors.BorderLight)
    
    return card
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

local function createToggleSystem(parent, labelText, settingValue, iconData)
    -- Create modern card container with glass morphism
    local container = Instance.new("Frame")
    container.Parent = parent
    container.BackgroundColor3 = GUIStyles.Colors.Surface
    container.BackgroundTransparency = 0.03
    container.BorderSizePixel = 0
    container.Size = UDim2.new(1, 0, 1, 0)
    createUICorner(container, GUIStyles.BorderRadius.Large)
    
    -- Add glass morphism effect
    createGlassMorphism(container, 0.08, 12)
    
    -- Add subtle border and shadow
    createBorder(container, 1, GUIStyles.Colors.BorderLight)
    createEnhancedShadow(parent, container, "ShadowLow")
    
    -- Modern colored icon container on the left (optimized for landscape)
    local iconContainer = Instance.new("Frame")
    iconContainer.Parent = container
    iconContainer.BackgroundColor3 = (iconData and iconData.accent) or GUIStyles.Colors.IconBlue
    iconContainer.BackgroundTransparency = 0.15
    iconContainer.BorderSizePixel = 0
    iconContainer.Position = UDim2.new(0, 12, 0.5, -12)  -- Smaller positioning for landscape
    iconContainer.Size = UDim2.new(0, 24, 0, 24)         -- Smaller icon for landscape
    createUICorner(iconContainer, GUIStyles.BorderRadius.Medium)
    
    -- Add subtle glow to icon container (smaller for landscape)
    local iconGlow = Instance.new("Frame")
    iconGlow.Parent = container
    iconGlow.BackgroundColor3 = (iconData and iconData.accent) or GUIStyles.Colors.IconBlue
    iconGlow.BackgroundTransparency = 0.85
    iconGlow.BorderSizePixel = 0
    iconGlow.Position = UDim2.new(0, 10, 0.5, -14)       -- Adjusted for smaller icon
    iconGlow.Size = UDim2.new(0, 28, 0, 28)              -- Smaller glow
    iconGlow.ZIndex = iconContainer.ZIndex - 1
    createUICorner(iconGlow, GUIStyles.BorderRadius.Large)
    
    -- Icon text
    local iconText = Instance.new("TextLabel")
    iconText.Parent = iconContainer
    iconText.BackgroundTransparency = 1
    iconText.Size = UDim2.new(0.7, 0, 0.7, 0)
    iconText.Position = UDim2.new(0.15, 0, 0.15, 0)
    iconText.Font = GUIStyles.Fonts.Icon
    iconText.Text = (iconData and iconData.text) or "⚙️"
    iconText.TextColor3 = GUIStyles.Colors.Text
    iconText.TextScaled = true
    iconText.ZIndex = iconContainer.ZIndex + 1
    
    -- Modern typography for label (compact for landscape)
    local label = Instance.new("TextLabel")
    label.Parent = container
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 45, 0, 4)     -- Adjusted for smaller icon
    label.Size = UDim2.new(1, -120, 0, 18)      -- Adjusted width and height for landscape
    label.Font = GUIStyles.Fonts.Primary
    label.Text = labelText
    label.TextColor3 = GUIStyles.Colors.Text
    label.TextSize = 14                          -- Slightly smaller text for landscape
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    
    -- Subtitle/description (compact for landscape)
    local subtitle = Instance.new("TextLabel")
    subtitle.Parent = container
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.new(0, 45, 0, 22)  -- Closer to main label
    subtitle.Size = UDim2.new(1, -120, 0, 12)    -- Smaller subtitle
    subtitle.Font = GUIStyles.Fonts.Caption
    subtitle.Text = settingValue and "Enabled" or "Disabled"
    subtitle.TextColor3 = settingValue and GUIStyles.Colors.Success or GUIStyles.Colors.TextSecondary
    subtitle.TextSize = 10                       -- Smaller subtitle text
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.TextYAlignment = Enum.TextYAlignment.Center
    
    -- Ultra-modern toggle switch (iPhone 15 Pro style) - Compact for landscape
    local toggleContainer = Instance.new("Frame")
    toggleContainer.Parent = container
    toggleContainer.BackgroundTransparency = 1
    toggleContainer.Position = UDim2.new(1, -75, 0.5, -15)  -- Adjusted for landscape
    toggleContainer.Size = UDim2.new(0, 60, 0, 30)          -- Slightly smaller for landscape
    
    local toggleBg = Instance.new("Frame")
    toggleBg.Name = labelText .. "ToggleBg"
    toggleBg.Parent = toggleContainer
    toggleBg.BackgroundColor3 = settingValue and GUIStyles.Colors.Success or Color3.fromRGB(200, 200, 200)  -- Light gray when off
    toggleBg.BackgroundTransparency = 0.05
    toggleBg.BorderSizePixel = 0
    toggleBg.Position = UDim2.new(0.5, -25, 0.5, -12)      -- Centered in smaller container
    toggleBg.Size = UDim2.new(0, 50, 0, 24)                 -- Compact toggle for landscape
    toggleBg.ZIndex = 2
    
    createUICorner(toggleBg, UDim.new(0, 12))  -- Smaller rounded ends for compact toggle
    
    -- Modern circular indicator with perfect positioning (compact)
    local indicator = Instance.new("Frame")
    indicator.Name = labelText .. "Indicator"
    indicator.Parent = toggleBg
    indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Pure white circle
    indicator.BorderSizePixel = 0
    indicator.Position = settingValue and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)  -- Adjusted for 50px wide toggle
    indicator.Size = UDim2.new(0, 18, 0, 18)  -- Smaller circle for landscape
    indicator.ZIndex = toggleBg.ZIndex + 2
    
    createUICorner(indicator, UDim.new(0, 9))  -- Perfect circle (half of 18px)
    
    -- Add subtle shadow to indicator for depth (compact)
    local indicatorShadow = Instance.new("Frame")
    indicatorShadow.Parent = toggleBg
    indicatorShadow.BackgroundColor3 = GUIStyles.Colors.Black
    indicatorShadow.BackgroundTransparency = 0.8  -- Lighter shadow
    indicatorShadow.BorderSizePixel = 0
    indicatorShadow.Position = indicator.Position + UDim2.new(0, 1, 0, 1)  -- Slight offset
    indicatorShadow.Size = UDim2.new(0, 18, 0, 18)
    indicatorShadow.ZIndex = indicator.ZIndex - 1
    createUICorner(indicatorShadow, UDim.new(0, 9))
    
    -- Add subtle inner highlight to indicator for iOS look (compact)
    local indicatorHighlight = Instance.new("Frame")
    indicatorHighlight.Parent = indicator
    indicatorHighlight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    indicatorHighlight.BackgroundTransparency = 0.3  -- Subtle highlight
    indicatorHighlight.BorderSizePixel = 0
    indicatorHighlight.Position = UDim2.new(0, 1, 0, 1)
    indicatorHighlight.Size = UDim2.new(1, -2, 0.3, 0)  -- Top highlight only, smaller
    indicatorHighlight.ZIndex = indicator.ZIndex + 1
    createUICorner(indicatorHighlight, UDim.new(0, 7))
    
    -- Status indicator dot (active state) - smaller for landscape
    local statusDot = Instance.new("Frame")
    statusDot.Name = "StatusDot"
    statusDot.Parent = iconContainer
    statusDot.BackgroundColor3 = settingValue and GUIStyles.Colors.Success or GUIStyles.Colors.TextSecondary
    statusDot.BackgroundTransparency = settingValue and 0.2 or 0.8
    statusDot.BorderSizePixel = 0
    statusDot.Position = UDim2.new(1, -6, 0, 1)      -- Adjusted for smaller icon
    statusDot.Size = UDim2.new(0, 6, 0, 6)           -- Smaller status dot
    statusDot.ZIndex = iconContainer.ZIndex + 2
    createUICorner(statusDot, UDim.new(0, 3))
    
    -- Invisible button for interaction with better hit area
    local button = Instance.new("TextButton")
    button.Parent = container
    button.BackgroundTransparency = 1
    button.Size = UDim2.new(1, 0, 1, 0)
    button.Text = ""
    button.ZIndex = 10
    
    -- Enhanced hover effects with modern animations
    local TweenService = game:GetService("TweenService")
    local hoverTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    button.MouseEnter:Connect(function()
        -- Container hover effect
        TweenService:Create(container, hoverTweenInfo, {
            BackgroundTransparency = 0.01,
            Size = UDim2.new(1, 2, 1, 2)
        }):Play()
        
        -- Icon glow effect (adjusted for smaller landscape icons)
        TweenService:Create(iconGlow, hoverTweenInfo, {
            BackgroundTransparency = 0.75,
            Size = UDim2.new(0, 32, 0, 32),  -- Adjusted for 28px base glow
            Position = UDim2.new(0, 8, 0.5, -16)  -- Adjusted for smaller position
        }):Play()
        
        -- Icon scale (adjusted for smaller landscape icons)
        TweenService:Create(iconContainer, hoverTweenInfo, {
            Size = UDim2.new(0, 26, 0, 26),  -- Slightly larger from 24px base
            Position = UDim2.new(0, 11, 0.5, -13)  -- Adjusted position
        }):Play()
        
        -- Label color enhancement
        TweenService:Create(label, hoverTweenInfo, {
            TextColor3 = (iconData and iconData.accent) or GUIStyles.Colors.Primary
        }):Play()
        
        -- Toggle hover effect (adjusted for compact toggle)
        TweenService:Create(toggleBg, hoverTweenInfo, {
            Size = UDim2.new(0, 52, 0, 26),  -- Slightly larger from 50x24 base
            Position = UDim2.new(0.5, -26, 0.5, -13)  -- Adjusted center position
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        -- Return to normal state
        TweenService:Create(container, hoverTweenInfo, {
            BackgroundTransparency = 0.03,
            Size = UDim2.new(1, 0, 1, 0)
        }):Play()
        
        TweenService:Create(iconGlow, hoverTweenInfo, {
            BackgroundTransparency = 0.85,
            Size = UDim2.new(0, 28, 0, 28),  -- Return to landscape base size
            Position = UDim2.new(0, 10, 0.5, -14)  -- Return to landscape base position
        }):Play()
        
        TweenService:Create(iconContainer, hoverTweenInfo, {
            Size = UDim2.new(0, 24, 0, 24),  -- Return to landscape base size
            Position = UDim2.new(0, 12, 0.5, -12)  -- Return to landscape base position
        }):Play()
        
        TweenService:Create(label, hoverTweenInfo, {
            TextColor3 = GUIStyles.Colors.Text
        }):Play()
        
        TweenService:Create(toggleBg, hoverTweenInfo, {
            Size = UDim2.new(0, 50, 0, 24),  -- Return to landscape compact size
            Position = UDim2.new(0.5, -25, 0.5, -12)  -- Return to landscape base position
        }):Play()
    end)
    
    return button, toggleBg, label, indicator, subtitle, iconContainer, statusDot, indicatorShadow
end

-- ===================================================================
--                         PANEL CREATORS
-- ===================================================================

function GUIHandler.createSecurityPanel(parent, SecuritySettings)
    -- Create clean iOS-style security panel
    local SecurityFrame = Instance.new("ScrollingFrame")
    SecurityFrame.Name = "SecurityFrame"
    SecurityFrame.Parent = parent
    SecurityFrame.Active = true
    SecurityFrame.BackgroundColor3 = GUIStyles.Colors.Background
    SecurityFrame.BackgroundTransparency = 0.05
    SecurityFrame.BorderSizePixel = 0
    SecurityFrame.Position = UDim2.new(0.25, 0, 0.12, 0)  -- Positioned more to left for landscape
    SecurityFrame.Size = UDim2.new(0.75, 0, 0.88, 0)      -- Much wider for horizontal layout
    SecurityFrame.Visible = false
    SecurityFrame.ZIndex = 2
    SecurityFrame.ScrollBarThickness = 6
    
    -- Add rounded corners to main panel
    createUICorner(SecurityFrame, GUIStyles.BorderRadius.Large)

    local layoutFrame = createStyledFrame(SecurityFrame, "SecurityListLayoutFrame", 
        UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0))
    layoutFrame.BackgroundTransparency = 1

    local listLayout = Instance.new("UIListLayout")
    listLayout.Name = "ListLayoutSecurity"
    listLayout.Parent = layoutFrame
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 2)  -- Tighter spacing like iOS
    
    -- Add padding to layout frame (optimized for landscape)
    local layoutPadding = Instance.new("UIPadding")
    layoutPadding.Parent = layoutFrame
    layoutPadding.PaddingTop = UDim.new(0, 8)      -- Reduced top padding
    layoutPadding.PaddingLeft = UDim.new(0, 12)    -- Reduced left padding
    layoutPadding.PaddingRight = UDim.new(0, 12)   -- Reduced right padding  
    layoutPadding.PaddingBottom = UDim.new(0, 8)   -- Reduced bottom padding

    -- Auto Fish Row with modern design and colored icon
    local adminFrame = createStyledFrame(layoutFrame, "AdminDetectionFrame", 
        UDim2.new(1, 0, 0, GUIStyles.Sizes.RowHeight))
    adminFrame.BackgroundTransparency = 1
    local adminButton, adminToggleBg, adminLabel, adminIndicator, adminSubtitle, adminIconContainer, adminStatusDot, adminIndicatorShadow = 
        createToggleSystem(adminFrame, "Auto Fish", SecuritySettings.AdminDetection, GUIStyles.Icons.AutoFish)
    adminButton.Name = "AdminDetectionButton"
    adminToggleBg.Name = "AdminDetectionToggleBg"
    adminIndicator.Name = "AdminDetectionIndicator"

    -- Reset Fish Row with modern design and colored icon
    local proximityFrame = createStyledFrame(layoutFrame, "ProximityAlertFrame", 
        UDim2.new(1, 0, 0, GUIStyles.Sizes.RowHeight))
    proximityFrame.BackgroundTransparency = 1
    local proximityButton, proximityToggleBg, proximityLabel, proximityIndicator, proximitySubtitle, proximityIconContainer, proximityStatusDot, proximityIndicatorShadow = 
        createToggleSystem(proximityFrame, "Reset Fish", SecuritySettings.PlayerProximityAlert, GUIStyles.Icons.Reset)
    proximityButton.Name = "ProximityAlertButton"
    proximityToggleBg.Name = "ProximityAlertToggleBg"
    proximityIndicator.Name = "ProximityAlertIndicator"

    -- Sell All Fishes Anywhere Row with modern design and colored icon
    local autoHideFrame = createStyledFrame(layoutFrame, "AutoHideFrame", 
        UDim2.new(1, 0, 0, GUIStyles.Sizes.RowHeight))
    autoHideFrame.BackgroundTransparency = 1
    local autoHideButton, autoHideToggleBg, autoHideLabel, autoHideIndicator, autoHideSubtitle, autoHideIconContainer, autoHideStatusDot, autoHideIndicatorShadow = 
        createToggleSystem(autoHideFrame, "Sell All Fishes Anywhere", SecuritySettings.AutoHideOnAdmin, GUIStyles.Icons.Sell)
    autoHideButton.Name = "AutoHideButton"
    autoHideToggleBg.Name = "AutoHideToggleBg"
    autoHideIndicator.Name = "AutoHideIndicator"

    -- Create Security Statistics Display
    local securityStatsFrame = createStyledFrame(layoutFrame, "SecurityStatsFrame", 
        UDim2.new(1, 0, 0, GUIStyles.Sizes.RowHeight))
    securityStatsFrame.BackgroundTransparency = 1
    
    local statsText = Instance.new("TextLabel")
    statsText.Name = "SecurityStatsText"
    statsText.Parent = securityStatsFrame
    statsText.BackgroundTransparency = 1
    statsText.Position = UDim2.new(0.030, 0, 0.216, 0)
    statsText.Size = UDim2.new(0.940, 0, 0.568, 0)
    statsText.Font = GUIStyles.Fonts.Primary
    statsText.Text = "🔒 Security Status: All Systems Active"
    statsText.TextColor3 = GUIStyles.Colors.Text
    statsText.TextScaled = true

    return {
        frame = SecurityFrame,
        adminButton = adminButton,
        adminToggleBg = adminToggleBg,
        adminIndicator = adminIndicator,
        adminSubtitle = adminSubtitle,
        adminIconContainer = adminIconContainer,
        adminStatusDot = adminStatusDot,
        adminIndicatorShadow = adminIndicatorShadow,
        proximityButton = proximityButton,
        proximityToggleBg = proximityToggleBg,
        proximityIndicator = proximityIndicator,
        proximitySubtitle = proximitySubtitle,
        proximityIconContainer = proximityIconContainer,
        proximityStatusDot = proximityStatusDot,
        proximityIndicatorShadow = proximityIndicatorShadow,
        autoHideButton = autoHideButton,
        autoHideToggleBg = autoHideToggleBg,
        autoHideIndicator = autoHideIndicator,
        autoHideSubtitle = autoHideSubtitle,
        autoHideIconContainer = autoHideIconContainer,
        autoHideStatusDot = autoHideStatusDot,
        autoHideIndicatorShadow = autoHideIndicatorShadow,
        statsText = statsText
    }
end

function GUIHandler.createAdvancedPanel(parent, Settings)
    local AdvancedFrame = Instance.new("ScrollingFrame")
    AdvancedFrame.Name = "AdvancedFrame"
    AdvancedFrame.Parent = parent
    AdvancedFrame.Active = true
    AdvancedFrame.BackgroundTransparency = 1
    AdvancedFrame.Position = UDim2.new(0.25, 0, 0.12, 0)  -- Positioned more to left for landscape
    AdvancedFrame.Size = UDim2.new(0.75, 0, 0.88, 0)      -- Much wider for horizontal layout
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
    listLayout.Padding = UDim.new(0, 4)  -- Reduced padding for landscape
    
    -- Add grid layout for landscape optimization
    local gridContainer = Instance.new("Frame")
    gridContainer.Name = "GridContainer"
    gridContainer.Parent = layoutFrame
    gridContainer.BackgroundTransparency = 1
    gridContainer.Size = UDim2.new(1, 0, 0, 58)  -- Single row with 3 columns
    gridContainer.LayoutOrder = 1
    
    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.Parent = gridContainer
    gridLayout.CellSize = UDim2.new(0.32, 0, 0, 50)  -- Three columns instead of two
    gridLayout.CellPadding = UDim2.new(0.01, 0, 0, 4) -- Smaller gaps
    gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    gridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    gridLayout.VerticalAlignment = Enum.VerticalAlignment.Top

    -- Luck Boost Frame with modern design and colored icon (in grid)
    local luckFrame = createStyledFrame(gridContainer, "LuckBoostFrame", UDim2.new(1, 0, 1, 0))
    luckFrame.LayoutOrder = 1
    local luckButton, luckToggleBg, luckLabel, luckIndicator, luckSubtitle, luckIconContainer, luckStatusDot, luckIndicatorShadow = 
        createToggleSystem(luckFrame, "Luck Boost", false, GUIStyles.Icons.Luck)
    luckButton.Name = "LuckBoostButton"
    luckToggleBg.Name = "LuckBoostToggleBg"
    luckIndicator.Name = "LuckBoostIndicator"

    -- Weather Boost Frame with modern design and colored icon (in grid)
    local weatherFrame = createStyledFrame(gridContainer, "WeatherBoostFrame", UDim2.new(1, 0, 1, 0))
    weatherFrame.LayoutOrder = 2
    local weatherButton, weatherToggleBg, weatherLabel, weatherIndicator, weatherSubtitle, weatherIconContainer, weatherStatusDot, weatherIndicatorShadow = 
        createToggleSystem(weatherFrame, "Weather Boost", false, GUIStyles.Icons.Weather)
    weatherButton.Name = "WeatherBoostButton"
    weatherToggleBg.Name = "WeatherBoostToggleBg"
    weatherIndicator.Name = "WeatherBoostIndicator"

    -- Smart Fishing Frame with modern design and colored icon (in grid)
    local smartFrame = createStyledFrame(gridContainer, "SmartFishingFrame", UDim2.new(1, 0, 1, 0))
    smartFrame.LayoutOrder = 3
    local smartButton, smartToggleBg, smartLabel, smartIndicator, smartSubtitle, smartIconContainer, smartStatusDot, smartIndicatorShadow = 
        createToggleSystem(smartFrame, "Smart Fishing", false, GUIStyles.Icons.Smart)
    smartButton.Name = "SmartFishingButton"
    smartToggleBg.Name = "SmartFishingToggleBg"
    smartIndicator.Name = "SmartFishingIndicator"

    -- Fish Value Filter Frame (horizontal layout)
    local fishValueFrame = createStyledFrame(layoutFrame, "FishValueFrame", UDim2.new(1, 0, 0, 45))
    fishValueFrame.LayoutOrder = 2
    
    local fishValueLabel = Instance.new("TextLabel")
    fishValueLabel.Parent = fishValueFrame
    fishValueLabel.BackgroundTransparency = 1
    fishValueLabel.Position = UDim2.new(0.03, 0, 0.2, 0)
    fishValueLabel.Size = UDim2.new(0.5, 0, 0.6, 0)  -- Half width for horizontal layout
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
    fishValueTextBox.Position = UDim2.new(0.55, 0, 0.25, 0)  -- Position to right side
    fishValueTextBox.Size = UDim2.new(0.25, 0, 0.5, 0)       -- Smaller for landscape
    fishValueTextBox.ZIndex = 3
    fishValueTextBox.Font = GUIStyles.Fonts.Primary
    fishValueTextBox.PlaceholderText = "100"
    fishValueTextBox.Text = ""
    fishValueTextBox.TextColor3 = GUIStyles.Colors.Text
    fishValueTextBox.TextScaled = true
    
    createUICorner(fishValueTextBox)

    -- Advanced Statistics Frame (compact for landscape)
    local advStatsFrame = createStyledFrame(layoutFrame, "AdvancedStatsFrame", UDim2.new(1, 0, 0, 40))
    advStatsFrame.LayoutOrder = 3
    
    local advStatsText = Instance.new("TextLabel")
    advStatsText.Name = "AdvancedStatsText"
    advStatsText.Parent = advStatsFrame
    advStatsText.BackgroundTransparency = 1
    advStatsText.Position = UDim2.new(0.03, 0, 0.25, 0)
    advStatsText.Size = UDim2.new(0.94, 0, 0.5, 0)  -- Reduced height for landscape
    advStatsText.Font = GUIStyles.Fonts.Primary
    advStatsText.Text = "💰 Money: ₡0 | 🏆 Rare: 0 | 👑 Legendary: 0"
    advStatsText.TextColor3 = GUIStyles.Colors.Text
    advStatsText.TextScaled = true

    return {
        frame = AdvancedFrame,
        luckButton = luckButton,
        luckToggleBg = luckToggleBg,
        luckIndicator = luckIndicator,
        luckSubtitle = luckSubtitle,
        luckIconContainer = luckIconContainer,
        luckStatusDot = luckStatusDot,
        luckIndicatorShadow = luckIndicatorShadow,
        weatherButton = weatherButton,
        weatherToggleBg = weatherToggleBg,
        weatherIndicator = weatherIndicator,
        weatherSubtitle = weatherSubtitle,
        weatherIconContainer = weatherIconContainer,
        weatherStatusDot = weatherStatusDot,
        weatherIndicatorShadow = weatherIndicatorShadow,
        smartButton = smartButton,
        smartToggleBg = smartToggleBg,
        smartIndicator = smartIndicator,
        smartSubtitle = smartSubtitle,
        smartIconContainer = smartIconContainer,
        smartStatusDot = smartStatusDot,
        smartIndicatorShadow = smartIndicatorShadow,
        fishValueTextBox = fishValueTextBox,
        advStatsText = advStatsText
    }
end

    return {
        frame = AdvancedFrame,
        luckButton = luckButton,
        luckToggleBg = luckToggleBg,
        luckIndicator = luckIndicator,
        luckSubtitle = luckSubtitle,
        luckIconContainer = luckIconContainer,
        luckStatusDot = luckStatusDot,
        luckIndicatorShadow = luckIndicatorShadow,
        weatherButton = weatherButton,
        weatherToggleBg = weatherToggleBg,
        weatherIndicator = weatherIndicator,
        weatherSubtitle = weatherSubtitle,
        weatherIconContainer = weatherIconContainer,
        weatherStatusDot = weatherStatusDot,
        weatherIndicatorShadow = weatherIndicatorShadow,
        smartButton = smartButton,
        smartToggleBg = smartToggleBg,
        smartIndicator = smartIndicator,
        smartSubtitle = smartSubtitle,
        smartIconContainer = smartIconContainer,
        smartStatusDot = smartStatusDot,
        smartIndicatorShadow = smartIndicatorShadow,
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
    -- Create enhanced floating toggle button with custom logo
    local FloatingButton = Instance.new("Frame")
    FloatingButton.Name = "FloatingButton"
    FloatingButton.Parent = parent
    FloatingButton.BackgroundColor3 = GUIStyles.Colors.Primary
    FloatingButton.BackgroundTransparency = 0.05  -- More solid for logo visibility
    FloatingButton.BorderSizePixel = 0
    FloatingButton.Position = UDim2.new(0, 20, 0.5, -40)  -- Slightly larger for better logo display
    FloatingButton.Size = UDim2.new(0, 80, 0, 80)  -- Increased size for logo
    FloatingButton.ZIndex = 100
    FloatingButton.Active = true
    
    createUICorner(FloatingButton, UDim.new(0, 40))  -- Perfect circle (40px radius for 80px button)
    createBorder(FloatingButton, 2, GUIStyles.Colors.Primary)
    
    -- Enhanced gradient background for logo contrast
    createGradient(FloatingButton, GUIStyles.Colors.Primary, GUIStyles.Colors.Secondary, 45)
    
    -- Add multiple shadow layers for depth
    local FloatingShadow1 = Instance.new("Frame")
    FloatingShadow1.Name = "FloatingShadow1"
    FloatingShadow1.Parent = parent
    FloatingShadow1.BackgroundColor3 = GUIStyles.Colors.Black
    FloatingShadow1.BackgroundTransparency = 0.7
    FloatingShadow1.BorderSizePixel = 0
    FloatingShadow1.Position = UDim2.new(0, 24, 0.5, -36)
    FloatingShadow1.Size = UDim2.new(0, 80, 0, 80)
    FloatingShadow1.ZIndex = 98
    createUICorner(FloatingShadow1, UDim.new(0, 40))  -- Perfect circle for shadow
    
    local FloatingShadow2 = Instance.new("Frame")
    FloatingShadow2.Name = "FloatingShadow2"
    FloatingShadow2.Parent = parent
    FloatingShadow2.BackgroundColor3 = GUIStyles.Colors.Black
    FloatingShadow2.BackgroundTransparency = 0.9
    FloatingShadow2.BorderSizePixel = 0
    FloatingShadow2.Position = UDim2.new(0, 26, 0.5, -34)
    FloatingShadow2.Size = UDim2.new(0, 80, 0, 80)
    FloatingShadow2.ZIndex = 97
    createUICorner(FloatingShadow2, UDim.new(0, 40))  -- Perfect circle for shadow
    
    -- Custom logo from GitHub (replaces emoji)
    local FloatingButtonLogo = Instance.new("ImageLabel")
    FloatingButtonLogo.Name = "FloatingButtonLogo"
    FloatingButtonLogo.Parent = FloatingButton
    FloatingButtonLogo.BackgroundTransparency = 1
    FloatingButtonLogo.Size = UDim2.new(0.7, 0, 0.7, 0)  -- Smaller to fit nicely with padding
    FloatingButtonLogo.Position = UDim2.new(0.15, 0, 0.15, 0)  -- Centered with padding
    FloatingButtonLogo.Image = "https://raw.githubusercontent.com/donitono/gamerxsan/main/logo.png"
    FloatingButtonLogo.ScaleType = Enum.ScaleType.Fit  -- Maintain aspect ratio
    FloatingButtonLogo.ImageColor3 = Color3.fromRGB(255, 255, 255)  -- White tint for visibility
    FloatingButtonLogo.ZIndex = 101
    
    -- Add subtle glow effect around logo
    local LogoGlow = Instance.new("Frame")
    LogoGlow.Name = "LogoGlow"
    LogoGlow.Parent = FloatingButton
    LogoGlow.BackgroundColor3 = GUIStyles.Colors.Text
    LogoGlow.BackgroundTransparency = 0.9
    LogoGlow.BorderSizePixel = 0
    LogoGlow.Size = UDim2.new(0.8, 0, 0.8, 0)
    LogoGlow.Position = UDim2.new(0.1, 0, 0.1, 0)
    LogoGlow.ZIndex = 100
    createUICorner(LogoGlow, UDim.new(0, 32))  -- Circular glow (80% of 40px radius)
    
    -- Fallback text (in case image fails to load)
    local FloatingButtonText = Instance.new("TextLabel")
    FloatingButtonText.Name = "FloatingButtonText"
    FloatingButtonText.Parent = FloatingButton
    FloatingButtonText.BackgroundTransparency = 1
    FloatingButtonText.Size = UDim2.new(0.6, 0, 0.6, 0)
    FloatingButtonText.Position = UDim2.new(0.2, 0, 0.2, 0)
    FloatingButtonText.Font = GUIStyles.Fonts.Title
    FloatingButtonText.Text = "GX"  -- Fallback text for your brand
    FloatingButtonText.TextColor3 = GUIStyles.Colors.Text
    FloatingButtonText.TextScaled = true
    FloatingButtonText.TextStrokeTransparency = 0.5
    FloatingButtonText.TextStrokeColor3 = GUIStyles.Colors.Black
    FloatingButtonText.ZIndex = 99  -- Behind logo
    FloatingButtonText.Visible = false  -- Hidden by default, shown if image fails
    
    local FloatingButtonClick = Instance.new("TextButton")
    FloatingButtonClick.Name = "FloatingButtonClick"
    FloatingButtonClick.Parent = FloatingButton
    FloatingButtonClick.BackgroundTransparency = 1
    FloatingButtonClick.Size = UDim2.new(1, 0, 1, 0)
    FloatingButtonClick.Text = ""
    FloatingButtonClick.ZIndex = 102
    
    -- Enhanced tooltip with branding
    local FloatingTooltip = Instance.new("Frame")
    FloatingTooltip.Name = "FloatingTooltip"
    FloatingTooltip.Parent = parent
    FloatingTooltip.BackgroundColor3 = GUIStyles.Colors.Background
    FloatingTooltip.BackgroundTransparency = 0.05
    FloatingTooltip.BorderSizePixel = 0
    FloatingTooltip.Position = UDim2.new(0, 110, 0.5, -20)
    FloatingTooltip.Size = UDim2.new(0, 160, 0, 40)
    FloatingTooltip.ZIndex = 105
    FloatingTooltip.Visible = false
    
    createUICorner(FloatingTooltip, GUIStyles.BorderRadius.Medium)
    createBorder(FloatingTooltip, 1, GUIStyles.Colors.Primary)
    
    -- Add subtle shadow to tooltip
    local TooltipShadow = Instance.new("Frame")
    TooltipShadow.Name = "TooltipShadow"
    TooltipShadow.Parent = parent
    TooltipShadow.BackgroundColor3 = GUIStyles.Colors.Black
    TooltipShadow.BackgroundTransparency = 0.8
    TooltipShadow.BorderSizePixel = 0
    TooltipShadow.Position = UDim2.new(0, 112, 0.5, -18)
    TooltipShadow.Size = UDim2.new(0, 160, 0, 40)
    TooltipShadow.ZIndex = 104
    TooltipShadow.Visible = false
    createUICorner(TooltipShadow, GUIStyles.BorderRadius.Medium)
    
    local FloatingTooltipText = Instance.new("TextLabel")
    FloatingTooltipText.Name = "FloatingTooltipText"
    FloatingTooltipText.Parent = FloatingTooltip
    FloatingTooltipText.BackgroundTransparency = 1
    FloatingTooltipText.Size = UDim2.new(1, 0, 1, 0)
    FloatingTooltipText.Font = GUIStyles.Fonts.Body
    FloatingTooltipText.Text = "� GamerXSan Panel"  -- Custom tooltip with your brand
    FloatingTooltipText.TextColor3 = GUIStyles.Colors.Text
    FloatingTooltipText.TextScaled = true
    FloatingTooltipText.ZIndex = 106
    
    -- Add image loading error handling
    FloatingButtonLogo.ImageRectSize = Vector2.new(0, 0)  -- Reset any crop
    
    -- Monitor image loading and show fallback if needed
    task.spawn(function()
        task.wait(3)  -- Wait 3 seconds for image to load
        if FloatingButtonLogo.Image == "" or FloatingButtonLogo.ImageTransparency == 1 then
            -- If image failed to load, show fallback text
            FloatingButtonText.Visible = true
            FloatingButtonLogo.Visible = false
            print("⚠️ Logo image failed to load, using fallback text")
        else
            print("✅ Logo image loaded successfully!")
        end
    end)

    return {
        button = FloatingButton,
        shadow1 = FloatingShadow1,
        shadow2 = FloatingShadow2,
        logo = FloatingButtonLogo,  -- New logo reference
        text = FloatingButtonText,  -- Fallback text
        glow = LogoGlow,           -- Glow effect
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

function GUIHandler.updateToggleButton(button, toggleBg, state, indicator, subtitle, iconContainer, statusDot, indicatorShadow)
    local TweenService = game:GetService("TweenService")
    local animationInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local fastInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    -- Animate toggle background color with modern transition
    local bgColorTween = TweenService:Create(
        toggleBg,
        animationInfo,
        {BackgroundColor3 = state and GUIStyles.Colors.Success or GUIStyles.Colors.ToggleOff}
    )
    bgColorTween:Play()
    
    -- Enhanced indicator animation with spring physics
    if indicator then
        local newPosition = state and UDim2.new(1, -28, 0.5, -13) or UDim2.new(0, 2, 0.5, -13)
        local indicatorTween = TweenService:Create(
            indicator,
            TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Position = newPosition}
        )
        indicatorTween:Play()
        
        -- Animate indicator shadow to follow
        if indicatorShadow then
            local shadowTween = TweenService:Create(
                indicatorShadow,
                TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Position = newPosition + UDim2.new(0, 1, 0, 2)}
            )
            shadowTween:Play()
        end
        
        -- Add brief scale animation for feedback
        local scaleTween = TweenService:Create(
            indicator,
            TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 28, 0, 28)}
        )
        scaleTween:Play()
        
        -- Return to normal size
        scaleTween.Completed:Connect(function()
            TweenService:Create(
                indicator,
                TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 26, 0, 26)}
            ):Play()
        end)
    end
    
    -- Update subtitle text with smooth color transition
    if subtitle then
        subtitle.Text = state and "Enabled" or "Disabled"
        local textColorTween = TweenService:Create(
            subtitle,
            fastInfo,
            {TextColor3 = state and GUIStyles.Colors.Success or GUIStyles.Colors.TextSecondary}
        )
        textColorTween:Play()
    end
    
    -- Update status dot with glow effect
    if statusDot then
        local dotTween = TweenService:Create(
            statusDot,
            fastInfo,
            {
                BackgroundColor3 = state and GUIStyles.Colors.Success or GUIStyles.Colors.TextSecondary,
                BackgroundTransparency = state and 0.2 or 0.8
            }
        )
        dotTween:Play()
        
        -- Add brief pulse effect when activated
        if state then
            local pulseTween = TweenService:Create(
                statusDot,
                TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                {BackgroundTransparency = 0.5}
            )
            pulseTween:Play()
            
            -- Stop pulse after 2 cycles
            task.wait(1.2)
            pulseTween:Cancel()
            TweenService:Create(statusDot, fastInfo, {BackgroundTransparency = 0.2}):Play()
        end
    end
    
    -- Update icon container glow based on state
    if iconContainer then
        local iconParent = iconContainer.Parent
        local iconGlow = iconParent:FindFirstChild("Frame") -- The glow frame
        if iconGlow and iconGlow ~= iconContainer then
            local glowTween = TweenService:Create(
                iconGlow,
                fastInfo,
                {BackgroundTransparency = state and 0.7 or 0.85}
            )
            glowTween:Play()
        end
    end
    
    -- Add subtle haptic feedback simulation
    if state then
        -- Brief container pulse for positive feedback
        local container = button.Parent
        local feedbackTween = TweenService:Create(
            container,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.01}
        )
        feedbackTween:Play()
        
        feedbackTween.Completed:Connect(function()
            TweenService:Create(
                container,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundTransparency = 0.03}
            ):Play()
        end)
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
                guiComponents.security.adminSubtitle,
                guiComponents.security.adminIconContainer,
                guiComponents.security.adminStatusDot,
                guiComponents.security.adminIndicatorShadow
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
                guiComponents.security.proximitySubtitle,
                guiComponents.security.proximityIconContainer,
                guiComponents.security.proximityStatusDot,
                guiComponents.security.proximityIndicatorShadow
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
                guiComponents.security.autoHideSubtitle,
                guiComponents.security.autoHideIconContainer,
                guiComponents.security.autoHideStatusDot,
                guiComponents.security.autoHideIndicatorShadow
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
                guiComponents.advanced.luckSubtitle,
                guiComponents.advanced.luckIconContainer,
                guiComponents.advanced.luckStatusDot,
                guiComponents.advanced.luckIndicatorShadow
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
                guiComponents.advanced.weatherSubtitle,
                guiComponents.advanced.weatherIconContainer,
                guiComponents.advanced.weatherStatusDot,
                guiComponents.advanced.weatherIndicatorShadow
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
                guiComponents.advanced.smartSubtitle,
                guiComponents.advanced.smartIconContainer,
                guiComponents.advanced.smartStatusDot,
                guiComponents.advanced.smartIndicatorShadow
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
            
            -- Animate tooltip appearance (adjusted position for larger button)
            local TweenService = game:GetService("TweenService")
            guiComponents.floating.tooltip:TweenPosition(
                UDim2.new(0, 115, 0.5, -20),  -- Adjusted for 80px button
                "Out", "Back", GUIStyles.Animations.Fast, true
            )
            guiComponents.floating.tooltipShadow:TweenPosition(
                UDim2.new(0, 117, 0.5, -18),  -- Adjusted for 80px button
                "Out", "Back", GUIStyles.Animations.Fast, true
            )
            
            -- Scale effect on button (updated for new size)
            guiComponents.floating.button:TweenSize(
                UDim2.new(0, 85, 0, 85),  -- Hover scale for 80px button
                "Out", "Back", GUIStyles.Animations.Fast, true
            )
            
            -- Add logo glow effect on hover
            if guiComponents.floating.logo then
                TweenService:Create(guiComponents.floating.logo, TweenInfo.new(0.2), {
                    ImageColor3 = GUIStyles.Colors.Primary,
                    Size = UDim2.new(0.75, 0, 0.75, 0)  -- Slightly larger on hover
                }):Play()
            end
            
            -- Enhance glow effect
            if guiComponents.floating.glow then
                TweenService:Create(guiComponents.floating.glow, TweenInfo.new(0.2), {
                    BackgroundTransparency = 0.7
                }):Play()
            end
        end)

        connections[#connections + 1] = guiComponents.floating.button.MouseLeave:Connect(function()
            guiComponents.floating.tooltip.Visible = false
            guiComponents.floating.tooltipShadow.Visible = false
            
            -- Return to normal size (updated for new size)
            guiComponents.floating.button:TweenSize(
                UDim2.new(0, 80, 0, 80),  -- Normal size for 80px button
                "Out", "Quad", GUIStyles.Animations.Fast, true
            )
            
            -- Return logo to normal state
            local TweenService = game:GetService("TweenService")
            if guiComponents.floating.logo then
                TweenService:Create(guiComponents.floating.logo, TweenInfo.new(0.2), {
                    ImageColor3 = Color3.fromRGB(255, 255, 255),  -- Back to white
                    Size = UDim2.new(0.7, 0, 0.7, 0)  -- Normal size
                }):Play()
            end
            
            -- Return glow to normal
            if guiComponents.floating.glow then
                TweenService:Create(guiComponents.floating.glow, TweenInfo.new(0.2), {
                    BackgroundTransparency = 0.9
                }):Play()
            end
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
--                         DEBUG FUNCTIONS
-- ===================================================================

function GUIHandler.debugGUI()
    print("🔧 GUI Handler Debug Information:")
    print("✅ GUIStyles loaded:", GUIStyles ~= nil)
    print("✅ Colors count:", #GUIStyles.Colors)
    print("✅ Fonts available:", GUIStyles.Fonts.Primary, GUIStyles.Fonts.Title)
    print("✅ Icons count:", #GUIStyles.Icons)
    print("✅ Border radius values:", GUIStyles.BorderRadius.Small, GUIStyles.BorderRadius.Medium)
    print("🎉 All GUI components loaded successfully!")
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
