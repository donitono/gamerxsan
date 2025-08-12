-- ===================================================================
--                        GUI HANDLER TEST SCRIPT
--                    Test untuk memastikan GUI berfungsi
-- ===================================================================

-- Load GUI Handler Module (local file)
local GUIHandler = loadstring(readfile("gui-handler.lua"))()

print("🔧 GUI Handler loaded successfully!")

-- Test Settings
local SecuritySettings = {
    AdminDetection = false,
    PlayerProximityAlert = false,
    AutoHideOnAdmin = false
}

local Settings = {
    LuckBoost = false,
    WeatherBoost = false,
    SmartFishing = false,
    MinFishValue = 100,
    FishValueFilter = false
}

-- Test GUI Creation
print("🎨 Creating test GUI...")

-- Create test ScreenGui
local testGui = Instance.new("ScreenGui")
testGui.Name = "TestGUI"
testGui.Parent = game.Players.LocalPlayer.PlayerGui

-- Create test frame
local testFrame = Instance.new("Frame")
testFrame.Name = "TestFrame"
testFrame.Parent = testGui
testFrame.Size = UDim2.new(1, 0, 1, 0)
testFrame.BackgroundTransparency = 1

-- Create GUI components
local guiComponents = GUIHandler.createCompleteGUI(testFrame, SecuritySettings, Settings)

print("✅ GUI components created!")

-- Test notification function
local function createNotification(text, color)
    print("📢 Notification: " .. text)
    -- Create simple notification
    local notification = Instance.new("TextLabel")
    notification.Parent = testGui
    notification.Size = UDim2.new(0, 300, 0, 50)
    notification.Position = UDim2.new(0.5, -150, 0, 20)
    notification.BackgroundColor3 = color or Color3.fromRGB(0, 150, 255)
    notification.Text = text
    notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    notification.TextScaled = true
    notification.Font = Enum.Font.GothamBold
    
    -- Auto destroy after 3 seconds
    game:GetService("Debris"):AddItem(notification, 3)
end

-- Setup callbacks
local callbacks = {
    createNotification = createNotification,
    updateTitle = function(title)
        print("📝 Title updated: " .. title)
    end
}

-- Setup event handlers
local connections = {}
connections = GUIHandler.setupEventHandlers(guiComponents, SecuritySettings, Settings, connections, callbacks)

print("🔗 Event handlers connected!")

-- Test panel switcher
local showGUIPanel = GUIHandler.createPanelSwitcher(guiComponents, callbacks)

-- Show security panel by default
showGUIPanel("Security")

print("🎯 Test completed! GUI should be visible and functional.")
print("🔧 Try clicking the buttons to test functionality.")
print("🎮 Use floating button to hide/show GUI.")

-- Test button functionality
wait(2)
createNotification("🎉 GUI Test Ready! Click buttons to test.", Color3.fromRGB(0, 255, 0))
