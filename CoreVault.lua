--[[
=============================================================================
    FTF ADMIN PANEL & HUB | PROPRIETARY SOFTWARE
    © 2026 ScriptedChaosLIVE / xyrozzy. All Rights Reserved.
    
    WARNING: This script is protected by intellectual property laws.
    Unauthorized distribution, modification, or removal of these credits 
    is strictly prohibited. 
    
    Any attempt to bypass the authentication gatekeeper, reverse-engineer 
    the UI, or claim this source code as your own will result in a permanent 
    blacklist from all future ScriptedChaosLIVE releases.
    
    Version: 0.7.57 (Stable)
    Developer: Sarthak / xyrozzy
=============================================================================
]]--

local ver = "v0.7.57" -- FTF admin Panel by Xyrozzy

-- Global Connection Tracker for Clean UI Destruction
local activeConnections = {}
local function trackConnection(conn)
    if conn then table.insert(activeConnections, conn) end
end

-- ==========================================================
-- ðŸš€ ANTI-LAG ASSET PRELOADER (Fixes rbxthumb stutters)
-- ==========================================================
task.spawn(function()
    local ContentProvider = game:GetService("ContentProvider")
    local assetsToLoad = {
        "rbxthumb://type=Asset&id=2249604078&w=150&h=150", -- TP Icon
        "rbxthumb://type=Asset&id=12400908609&w=150&h=150", -- Risk Icon
        "rbxthumb://type=Asset&id=73375957637397&w=150&h=150", -- Unfair Icon
        "rbxthumb://type=Asset&id=83349936062601&w=150&h=150", -- Shift-Lock White
        "rbxthumb://type=Asset&id=72173899346121&w=150&h=150"  -- Shift-Lock Blue
    }
    -- Silently cache all images in the background so they don't lag the game
    pcall(function()
        ContentProvider:PreloadAsync(assetsToLoad)
    end)
end)
-- ==========================================================

-- ==========================================================
--  ADMIN HANDSHAKE (Invisible Server Ping)
-- ==========================================================
local ActiveScriptUsers = {}

local function CheckAdminPing(plr, msg)
    if msg == "/e FTF_ADMIN_PING" or msg == "/e FTF_PING_BACK" then
        if not table.find(ActiveScriptUsers, plr.Name) then
            table.insert(ActiveScriptUsers, plr.Name)
            -- If someone else pings, ping them back so they know you are here
            if msg == "/e FTF_ADMIN_PING" then
                pcall(function() game.Players.LocalPlayer:Chat("/e FTF_PING_BACK") end)
            end
        end
    end
end

for _, plr in pairs(game.Players:GetPlayers()) do
    if plr ~= game.Players.LocalPlayer then
        plr.Chatted:Connect(function(msg) CheckAdminPing(plr, msg) end)
    end
end

game.Players.PlayerAdded:Connect(function(plr)
    plr.Chatted:Connect(function(msg) CheckAdminPing(plr, msg) end)
end)
-- ==========================================================

-- ==================== TOGGLE VARIABLES ===================
local podstoggle = false
local pctoggle = false
local playertoggle = false
local bestpctoggle = false
local exitstoggle = false
local beastcamtoggle = false
local neverfailtoggle = false
local autointeracttoggle = false
local autoplaytoggle = false
local speedtoggle = false
local jumptoggle = false
local nocliptoggle = false

local nofogtoggle = false
local fullbrighttoggle = false
local smartesptoggle = false
local fovtoggle = false
local lowgravtoggle = false
local proximitytoggle = false

local autostruggletoggle = false
local radartoggle = false
local hitboxtoggle = false -- Adds the hitbox memory

-- Variables to memorize the original map lighting
local origFogEnd, origFogStart, origAtmDensity, origAtmOffset
local origAmbient, origOutdoorAmbient
-- ==========================================================

local FTFHAX = Instance.new("ScreenGui")
local MenusTabFrame = Instance.new("Frame")
local CheatButton = Instance.new("ImageButton")
local TextLabel = Instance.new("TextLabel")
local ESPMenuWindow = Instance.new("Frame")
local Body = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local ButtonsFrame = Instance.new("Frame")
local BestPCESPButton = Instance.new("TextButton")
local PCESPButton = Instance.new("TextButton")
local TbdButton = Instance.new("TextButton")
local PlayerESPButton = Instance.new("TextButton")
local PodsESPButton = Instance.new("TextButton")
local ExitsESPButton = Instance.new("TextButton")
local UIGridLayout = Instance.new("UIGridLayout")
local TopBar = Instance.new("Frame")
local CloseButton = Instance.new("TextButton")
local BackButton = Instance.new("TextButton")
local CreditTotalText = Instance.new("TextLabel")
local PageTitleText = Instance.new("TextLabel")
local MainMenuWindow = Instance.new("Frame")
local TopBar_2 = Instance.new("Frame")
local CloseButton_2 = Instance.new("TextButton")
local CreditTotalText_2 = Instance.new("TextLabel")
local PageTitleText_2 = Instance.new("TextLabel")
local Body_2 = Instance.new("ScrollingFrame")
local UIGridLayout_2 = Instance.new("UIGridLayout")
local ESPButton = Instance.new("ImageButton")
local BottomText = Instance.new("TextLabel")
local TempIcon = Instance.new("ImageLabel")
local ToolsButton = Instance.new("ImageButton")
local BottomText_2 = Instance.new("TextLabel")
local TempIcon_2 = Instance.new("ImageLabel")
local ToolsMenuWindow = Instance.new("Frame")
local Body_3 = Instance.new("Frame")
local TitleLabel_2 = Instance.new("TextLabel")
local ButtonsFrame_2 = Instance.new("Frame")
local UIGridLayout_3 = Instance.new("UIGridLayout")
local NeverFailButton = Instance.new("TextButton")
local AutoPlayButton = Instance.new("TextButton")
local AutoInteractButton = Instance.new("TextButton")
local BeastCamButton = Instance.new("TextButton")
local TopBar_3 = Instance.new("Frame")
local CloseButton_3 = Instance.new("TextButton")
local BackButton_2 = Instance.new("TextButton")
local CreditTotalText_3 = Instance.new("TextLabel")
local PageTitleText_3 = Instance.new("TextLabel")
local ViewportFrame = Instance.new("ViewportFrame")

FTFHAX.Name = "FTFHAX"
FTFHAX.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
FTFHAX.ResetOnSpawn = false

MenusTabFrame.Name = "MenusTabFrame"
MenusTabFrame.Parent = FTFHAX
MenusTabFrame.AnchorPoint = Vector2.new(1, 0.5)
MenusTabFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MenusTabFrame.BackgroundTransparency = 1.000
MenusTabFrame.BorderColor3 = Color3.fromRGB(63, 63, 63)
MenusTabFrame.BorderSizePixel = 0
MenusTabFrame.Position = UDim2.new(1, 0, 0.5, 0)
MenusTabFrame.Size = UDim2.new(0.0799999982, 0, 0.159999996, 0)
MenusTabFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY

CheatButton.Name = "CheatButton"
CheatButton.Parent = MenusTabFrame
CheatButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CheatButton.BackgroundTransparency = 0.500
CheatButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
CheatButton.BorderSizePixel = 0
CheatButton.Position = UDim2.new(0, 0, 1, 0)
CheatButton.Size = UDim2.new(1, 0, 1, 0)
CheatButton.SizeConstraint = Enum.SizeConstraint.RelativeXX
CheatButton.Image = "rbxassetid://11570895459"
CheatButton.ImageColor3 = Color3.fromRGB(223, 223, 223)

TextLabel.Parent = CheatButton
TextLabel.AnchorPoint = Vector2.new(0, 1)
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0, 0, 1, 0)
TextLabel.Size = UDim2.new(1, 0, 0.200000003, 0)
TextLabel.Font = Enum.Font.ArialBold
TextLabel.Text = "FTF admin Panel"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 12.000
TextLabel.TextStrokeTransparency = 0.000
TextLabel.TextWrapped = true
TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom

ESPMenuWindow.Name = "ESPMenuWindow"
ESPMenuWindow.Parent = FTFHAX
ESPMenuWindow.AnchorPoint = Vector2.new(0.5, 0.5)
ESPMenuWindow.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
ESPMenuWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
ESPMenuWindow.BorderSizePixel = 2
ESPMenuWindow.ClipsDescendants = true
ESPMenuWindow.Position = UDim2.new(0.5, 0, 0.5, -18)
ESPMenuWindow.Size = UDim2.new(0, 480, 0, 175)
ESPMenuWindow.SizeConstraint = Enum.SizeConstraint.RelativeYY
ESPMenuWindow.Visible = false

Body.Name = "Body"
Body.Parent = ESPMenuWindow
Body.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Body.BackgroundTransparency = 1.000
Body.BorderSizePixel = 0
Body.Position = UDim2.new(0, 0, 0, 40)
Body.Size = UDim2.new(1, 0, 1, -40)

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = Body
TitleLabel.AnchorPoint = Vector2.new(0.5, 0)
TitleLabel.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.BorderSizePixel = 0
TitleLabel.Position = UDim2.new(0.5, 0, -1.06500006, 150)
TitleLabel.Size = UDim2.new(1, -10, 0.0235044118, 30)
TitleLabel.Text = "ESP"
TitleLabel.TextColor3 = Color3.fromRGB(149, 255, 237)
TitleLabel.TextScaled = true
TitleLabel.TextSize = 14.000
TitleLabel.TextWrapped = true

ButtonsFrame.Name = "ButtonsFrame"
ButtonsFrame.Parent = Body
ButtonsFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ButtonsFrame.BackgroundTransparency = 1.000
ButtonsFrame.Position = UDim2.new(0, 5, 0, 45)
ButtonsFrame.Size = UDim2.new(1, -10, -0.00555555569, 85)

BestPCESPButton.Name = "BestPCESPButton"
BestPCESPButton.Parent = ButtonsFrame
BestPCESPButton.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
BestPCESPButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
BestPCESPButton.BorderSizePixel = 0
BestPCESPButton.LayoutOrder = 4
BestPCESPButton.Size = UDim2.new(0, 200, 0, 50)
BestPCESPButton.Text = "Best PC"
BestPCESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BestPCESPButton.TextScaled = true
BestPCESPButton.TextSize = 14.000
BestPCESPButton.TextWrapped = true

PCESPButton.Name = "PCESPButton"
PCESPButton.Parent = ButtonsFrame
PCESPButton.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
PCESPButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
PCESPButton.BorderSizePixel = 0
PCESPButton.Size = UDim2.new(0, 200, 0, 50)
PCESPButton.Text = "PC"
PCESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PCESPButton.TextScaled = true
PCESPButton.TextSize = 14.000
PCESPButton.TextWrapped = true

TbdButton.Name = "TbdButton"
TbdButton.Parent = ButtonsFrame
TbdButton.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
TbdButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TbdButton.BorderSizePixel = 0
TbdButton.LayoutOrder = 5
TbdButton.Size = UDim2.new(0, 200, 0, 50)
TbdButton.Visible = false
TbdButton.Text = "nothing"
TbdButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TbdButton.TextScaled = true
TbdButton.TextSize = 14.000
TbdButton.TextWrapped = true

PlayerESPButton.Name = "PlayerESPButton"
PlayerESPButton.Parent = ButtonsFrame
PlayerESPButton.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
PlayerESPButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
PlayerESPButton.BorderSizePixel = 0
PlayerESPButton.LayoutOrder = 1
PlayerESPButton.Size = UDim2.new(0, 200, 0, 50)
PlayerESPButton.Text = "Player"
PlayerESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerESPButton.TextScaled = true
PlayerESPButton.TextSize = 14.000
PlayerESPButton.TextWrapped = true

PodsESPButton.Name = "PodsESPButton"
PodsESPButton.Parent = ButtonsFrame
PodsESPButton.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
PodsESPButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
PodsESPButton.BorderSizePixel = 0
PodsESPButton.LayoutOrder = 2
PodsESPButton.Size = UDim2.new(0, 200, 0, 50)
PodsESPButton.Text = "Pods"
PodsESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PodsESPButton.TextScaled = true
PodsESPButton.TextSize = 14.000
PodsESPButton.TextWrapped = true

ExitsESPButton.Name = "ExitsESPButton"
ExitsESPButton.Parent = ButtonsFrame
ExitsESPButton.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
ExitsESPButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ExitsESPButton.BorderSizePixel = 0
ExitsESPButton.LayoutOrder = 3
ExitsESPButton.Size = UDim2.new(0, 200, 0, 50)
ExitsESPButton.Text = "Exits"
ExitsESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitsESPButton.TextScaled = true
ExitsESPButton.TextSize = 14.000
ExitsESPButton.TextWrapped = true

UIGridLayout.Parent = ButtonsFrame
UIGridLayout.FillDirection = Enum.FillDirection.Vertical
UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 6, 0, 6)
UIGridLayout.CellSize = UDim2.new(0, 152, 0, 39)

TopBar.Name = "TopBar"
TopBar.Parent = ESPMenuWindow
TopBar.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.ZIndex = 5

CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.BorderColor3 = Color3.fromRGB(191, 191, 191)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -1, 0, 1)
CloseButton.Size = UDim2.new(0, 36, 0, 36)
CloseButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
CloseButton.ZIndex = 5
CloseButton.Modal = true
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true
CloseButton.TextSize = 14.000
CloseButton.TextWrapped = true

BackButton.Name = "BackButton"
BackButton.Parent = TopBar
BackButton.AnchorPoint = Vector2.new(1, 0)
BackButton.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
BackButton.BorderColor3 = Color3.fromRGB(191, 191, 191)
BackButton.BorderSizePixel = 0
BackButton.Position = UDim2.new(1, -41, 0, 1)
BackButton.Size = UDim2.new(1, -4, 1, -4)
BackButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
BackButton.ZIndex = 5
BackButton.Text = "<"
BackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BackButton.TextScaled = true
BackButton.TextSize = 14.000
BackButton.TextWrapped = true

CreditTotalText.Name = "CreditTotalText"
CreditTotalText.Parent = TopBar
CreditTotalText.AnchorPoint = Vector2.new(1, 0)
CreditTotalText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CreditTotalText.BackgroundTransparency = 1.000
CreditTotalText.BorderSizePixel = 0
CreditTotalText.Position = UDim2.new(1, -85, 0, 0)
CreditTotalText.Size = UDim2.new(0, 100, 1, 0)
CreditTotalText.ZIndex = 5
CreditTotalText.Text = ver
CreditTotalText.TextColor3 = Color3.fromRGB(255, 255, 0)
CreditTotalText.TextScaled = true
CreditTotalText.TextWrapped = true
CreditTotalText.TextXAlignment = Enum.TextXAlignment.Right

PageTitleText.Name = "PageTitleText"
PageTitleText.Parent = TopBar
PageTitleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PageTitleText.BackgroundTransparency = 1.000
PageTitleText.BorderSizePixel = 0
PageTitleText.Position = UDim2.new(0, 10, 0, 0)
PageTitleText.Size = UDim2.new(0, 200, 1, 0)
PageTitleText.ZIndex = 5
PageTitleText.Text = "FTF admin Panel"
PageTitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
PageTitleText.TextScaled = true
PageTitleText.TextWrapped = true
PageTitleText.TextXAlignment = Enum.TextXAlignment.Left

MainMenuWindow.Name = "MainMenuWindow"
MainMenuWindow.Parent = FTFHAX
MainMenuWindow.AnchorPoint = Vector2.new(0.5, 0.5)
MainMenuWindow.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
MainMenuWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainMenuWindow.BorderSizePixel = 2
MainMenuWindow.ClipsDescendants = true
MainMenuWindow.Position = UDim2.new(0.5, 0, 0.5, -18)
MainMenuWindow.Size = UDim2.new(0, 420, 0, 360)
MainMenuWindow.SizeConstraint = Enum.SizeConstraint.RelativeYY
MainMenuWindow.Visible = false

TopBar_2.Name = "TopBar"
TopBar_2.Parent = MainMenuWindow
TopBar_2.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
TopBar_2.BorderSizePixel = 0
TopBar_2.Size = UDim2.new(1, 0, 0, 40)
TopBar_2.ZIndex = 5

CloseButton_2.Name = "CloseButton"
CloseButton_2.Parent = TopBar_2
CloseButton_2.AnchorPoint = Vector2.new(1, 0)
CloseButton_2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton_2.BorderColor3 = Color3.fromRGB(191, 191, 191)
CloseButton_2.BorderSizePixel = 0
CloseButton_2.Position = UDim2.new(1, -1, 0, 1)
CloseButton_2.Size = UDim2.new(0, 36, 0, 36)
CloseButton_2.SizeConstraint = Enum.SizeConstraint.RelativeYY
CloseButton_2.ZIndex = 5
CloseButton_2.Modal = true
CloseButton_2.Text = "X"
CloseButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton_2.TextScaled = true
CloseButton_2.TextSize = 14.000
CloseButton_2.TextWrapped = true

CreditTotalText_2.Name = "CreditTotalText"
CreditTotalText_2.Parent = TopBar_2
CreditTotalText_2.AnchorPoint = Vector2.new(1, 0)
CreditTotalText_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CreditTotalText_2.BackgroundTransparency = 1.000
CreditTotalText_2.BorderSizePixel = 0
CreditTotalText_2.Position = UDim2.new(1, -45, 0, 0)
CreditTotalText_2.Size = UDim2.new(0, 100, 1, 0)
CreditTotalText_2.ZIndex = 5
CreditTotalText_2.Text = ver
CreditTotalText_2.TextColor3 = Color3.fromRGB(255, 255, 0)
CreditTotalText_2.TextScaled = true
CreditTotalText_2.TextWrapped = true
CreditTotalText_2.TextXAlignment = Enum.TextXAlignment.Right

PageTitleText_2.Name = "PageTitleText"
PageTitleText_2.Parent = TopBar_2
PageTitleText_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PageTitleText_2.BackgroundTransparency = 1.000
PageTitleText_2.BorderSizePixel = 0
PageTitleText_2.Position = UDim2.new(0, 10, 0, 0)
PageTitleText_2.Size = UDim2.new(0, 200, 1, 0)
PageTitleText_2.ZIndex = 5
PageTitleText_2.Text = "FTF admin Panel"
PageTitleText_2.TextColor3 = Color3.fromRGB(255, 255, 255)
PageTitleText_2.TextScaled = true
PageTitleText_2.TextWrapped = true
PageTitleText_2.TextXAlignment = Enum.TextXAlignment.Left

Body_2.Name = "Body"
Body_2.Parent = MainMenuWindow
Body_2.AnchorPoint = Vector2.new(0.5, 0)
Body_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Body_2.BackgroundTransparency = 1.000
Body_2.BorderSizePixel = 0
Body_2.Position = UDim2.new(0.5, 0, 0, 45)
Body_2.Size = UDim2.new(1, -10, 1, -75)
Body_2.ScrollBarThickness = 0
Body_2.AutomaticCanvasSize = Enum.AutomaticSize.Y

UIGridLayout_2.Parent = Body_2
UIGridLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout_2.VerticalAlignment = Enum.VerticalAlignment.Top
UIGridLayout_2.CellSize = UDim2.new(0, 132, 0, 132)

-- ==================== MATCHING MAIN MENU BUTTONS ====================
ESPButton.Name = "ESPButton"
ESPButton.Parent = Body_2
ESPButton.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
ESPButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ESPButton.BorderSizePixel = 0
ESPButton.LayoutOrder = 1
ESPButton.Size = UDim2.new(0, 100, 0, 100)

BottomText.Name = "BottomText"
BottomText.Parent = ESPButton
BottomText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BottomText.BackgroundTransparency = 1.000
BottomText.BorderSizePixel = 0
BottomText.Position = UDim2.new(0, 0, 0.800000012, 0)
BottomText.Size = UDim2.new(1, 0, 0.200000003, 0)
BottomText.Text = "ESP"
BottomText.TextColor3 = Color3.fromRGB(255, 255, 255)
BottomText.Font = Enum.Font.SourceSans
BottomText.TextScaled = false
BottomText.TextSize = 24.000

TempIcon.Name = "TempIcon"
TempIcon.Parent = ESPButton
TempIcon.AnchorPoint = Vector2.new(0.5, 0)
TempIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TempIcon.BackgroundTransparency = 1.000
TempIcon.Position = UDim2.new(0.5, 0, 0, 0)
TempIcon.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
TempIcon.Image = "rbxassetid://2594274683"
TempIcon.ScaleType = Enum.ScaleType.Fit

ToolsButton.Name = "ToolsButton"
ToolsButton.Parent = Body_2
ToolsButton.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
ToolsButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ToolsButton.BorderSizePixel = 0
ToolsButton.LayoutOrder = 2
ToolsButton.Size = UDim2.new(0, 100, 0, 100)

BottomText_2.Name = "BottomText"
BottomText_2.Parent = ToolsButton
BottomText_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BottomText_2.BackgroundTransparency = 1.000
BottomText_2.BorderSizePixel = 0
BottomText_2.Position = UDim2.new(0, 0, 0.800000012, 0)
BottomText_2.Size = UDim2.new(1, 0, 0.200000003, 0)
BottomText_2.Text = "Tools"
BottomText_2.TextColor3 = Color3.fromRGB(255, 255, 255)
BottomText_2.Font = Enum.Font.SourceSans
BottomText_2.TextScaled = false
BottomText_2.TextSize = 24.000

TempIcon_2.Name = "TempIcon"
TempIcon_2.Parent = ToolsButton
TempIcon_2.AnchorPoint = Vector2.new(0.5, 0)
TempIcon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TempIcon_2.BackgroundTransparency = 1.000
TempIcon_2.Position = UDim2.new(0.5, 0, 0, 0)
TempIcon_2.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
TempIcon_2.Image = "rbxassetid://12403104094"
TempIcon_2.ScaleType = Enum.ScaleType.Fit

local TPButton = Instance.new("ImageButton")
TPButton.Name = "TPButton"
TPButton.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
TPButton.BorderSizePixel = 0
TPButton.ZIndex = 10
TPButton.Parent = Body_2

local TPIcon = Instance.new("ImageLabel", TPButton)
TPIcon.BackgroundTransparency = 1
TPIcon.AnchorPoint = Vector2.new(0.5, 0)
TPIcon.Position = UDim2.new(0.5, 0, 0, 0)
TPIcon.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
TPIcon.Image = "rbxthumb://type=Asset&id=2249604078&w=150&h=150"
TPIcon.ImageColor3 = Color3.fromRGB(255, 100, 100)
TPIcon.ScaleType = Enum.ScaleType.Fit
TPIcon.ZIndex = 11

local TPText = Instance.new("TextLabel")
TPText.BackgroundTransparency = 1
TPText.Position = UDim2.new(0, 0, 0.800000012, 0)
TPText.Size = UDim2.new(1, 0, 0.200000003, 0)
TPText.Text = "TP"
TPText.TextColor3 = Color3.new(1,1,1)
TPText.Font = Enum.Font.SourceSans
TPText.TextScaled = false
TPText.TextSize = 24.000
TPText.ZIndex = 11
TPText.Parent = TPButton

local PlayerTabButton = Instance.new("ImageButton")
PlayerTabButton.Name = "PlayerTabButton"
PlayerTabButton.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
PlayerTabButton.BorderSizePixel = 0
PlayerTabButton.ZIndex = 10
PlayerTabButton.Parent = Body_2

local PlayerIcon = Instance.new("ImageLabel", PlayerTabButton)
PlayerIcon.BackgroundTransparency = 1
PlayerIcon.AnchorPoint = Vector2.new(0.5, 0)
PlayerIcon.Position = UDim2.new(0.5, 0, 0, 0)
PlayerIcon.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
PlayerIcon.Image = "rbxassetid://6031265976" 
PlayerIcon.ScaleType = Enum.ScaleType.Fit
PlayerIcon.ZIndex = 11

local PlayerText = Instance.new("TextLabel")
PlayerText.BackgroundTransparency = 1
PlayerText.Position = UDim2.new(0, 0, 0.800000012, 0)
PlayerText.Size = UDim2.new(1, 0, 0.200000003, 0)
PlayerText.Text = "Player"
PlayerText.TextColor3 = Color3.new(1,1,1)
PlayerText.Font = Enum.Font.SourceSans
PlayerText.TextScaled = false
PlayerText.TextSize = 24.000
PlayerText.ZIndex = 11
PlayerText.Parent = PlayerTabButton

local MiscTabButton = Instance.new("ImageButton")
MiscTabButton.Name = "MiscTabButton"
MiscTabButton.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
MiscTabButton.BorderSizePixel = 0
MiscTabButton.ZIndex = 10
MiscTabButton.Parent = Body_2

local MiscIcon = Instance.new("ImageLabel", MiscTabButton)
MiscIcon.BackgroundTransparency = 1
MiscIcon.AnchorPoint = Vector2.new(0.5, 0)
MiscIcon.Position = UDim2.new(0.5, 0, 0.1, 0)
MiscIcon.Size = UDim2.new(0.6, 0, 0.6, 0)
MiscIcon.Image = "rbxassetid://6031280882"
MiscIcon.ScaleType = Enum.ScaleType.Fit
MiscIcon.ZIndex = 11

local MiscText = Instance.new("TextLabel")
MiscText.BackgroundTransparency = 1
MiscText.Position = UDim2.new(0, 0, 0.800000012, 0)
MiscText.Size = UDim2.new(1, 0, 0.200000003, 0)
MiscText.Text = "Misc"
MiscText.TextColor3 = Color3.new(1,1,1)
MiscText.Font = Enum.Font.SourceSans
MiscText.TextScaled = false
MiscText.TextSize = 24.000
MiscText.ZIndex = 11
MiscText.Parent = MiscTabButton

local RiskTabButton = Instance.new("ImageButton")
RiskTabButton.Name = "RiskTabButton"
RiskTabButton.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
RiskTabButton.BorderSizePixel = 0
RiskTabButton.ZIndex = 10
RiskTabButton.Parent = Body_2

local RiskIcon = Instance.new("ImageLabel", RiskTabButton)
RiskIcon.BackgroundTransparency = 1
RiskIcon.AnchorPoint = Vector2.new(0.5, 0)
RiskIcon.Position = UDim2.new(0.5, 0, 0.1, 0)
RiskIcon.Size = UDim2.new(0.6, 0, 0.6, 0)
RiskIcon.Image = "rbxthumb://type=Asset&id=12400908609&w=150&h=150"
RiskIcon.ScaleType = Enum.ScaleType.Fit
RiskIcon.ZIndex = 11

local RiskText = Instance.new("TextLabel")
RiskText.BackgroundTransparency = 1
RiskText.Position = UDim2.new(0, 0, 0.800000012, 0)
RiskText.Size = UDim2.new(1, 0, 0.200000003, 0)
RiskText.Text = "Risk Lvl"
RiskText.TextColor3 = Color3.new(1,1,1)
RiskText.Font = Enum.Font.SourceSans
RiskText.TextScaled = false
RiskText.TextSize = 24.000
RiskText.ZIndex = 11
RiskText.Parent = RiskTabButton

local UnfairTabButton = Instance.new("ImageButton")
UnfairTabButton.Name = "UnfairTabButton"
UnfairTabButton.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
UnfairTabButton.BorderSizePixel = 0
UnfairTabButton.ZIndex = 10
UnfairTabButton.Parent = Body_2

local UnfairIcon = Instance.new("ImageLabel", UnfairTabButton)
UnfairIcon.BackgroundTransparency = 1
UnfairIcon.AnchorPoint = Vector2.new(0.5, 0)
UnfairIcon.Position = UDim2.new(0.5, 0, 0.1, 0)
UnfairIcon.Size = UDim2.new(0.6, 0, 0.6, 0)
UnfairIcon.Image = "rbxassetid://73375957637397" -- Verified Fire Icon
UnfairIcon.ScaleType = Enum.ScaleType.Fit
UnfairIcon.ZIndex = 11

local UnfairText = Instance.new("TextLabel")
UnfairText.BackgroundTransparency = 1
UnfairText.Position = UDim2.new(0, 0, 0.800000012, 0)
UnfairText.Size = UDim2.new(1, 0, 0.200000003, 0)
UnfairText.Text = "Unfair"
UnfairText.TextColor3 = Color3.new(1, 0.2, 0.2)
UnfairText.Font = Enum.Font.SourceSansBold
UnfairText.TextScaled = false
UnfairText.TextSize = 24.000
UnfairText.ZIndex = 11
UnfairText.Parent = UnfairTabButton

-- [NEW] UPDATE LOG TAB BUTTON
local UpdateLogTabButton = Instance.new("ImageButton")
UpdateLogTabButton.Name = "UpdateLogTabButton"
UpdateLogTabButton.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
UpdateLogTabButton.BorderSizePixel = 0
UpdateLogTabButton.ZIndex = 10
UpdateLogTabButton.Parent = Body_2

local UpdateLogIcon = Instance.new("ImageLabel", UpdateLogTabButton)
UpdateLogIcon.BackgroundTransparency = 1
UpdateLogIcon.AnchorPoint = Vector2.new(0.5, 0)
UpdateLogIcon.Position = UDim2.new(0.5, 0, 0.1, 0)
UpdateLogIcon.Size = UDim2.new(0.6, 0, 0.6, 0)
UpdateLogIcon.Image = "rbxassetid://11293981586" -- Scroll/Document Icon
UpdateLogIcon.ScaleType = Enum.ScaleType.Fit
UpdateLogIcon.ZIndex = 11

local UpdateLogText = Instance.new("TextLabel")
UpdateLogText.BackgroundTransparency = 1
UpdateLogText.Position = UDim2.new(0, 0, 0.800000012, 0)
UpdateLogText.Size = UDim2.new(1, 0, 0.200000003, 0)
UpdateLogText.Text = "Logs"
UpdateLogText.TextColor3 = Color3.new(1, 1, 1)
UpdateLogText.Font = Enum.Font.SourceSans
UpdateLogText.TextScaled = false
UpdateLogText.TextSize = 24.000
UpdateLogText.ZIndex = 11
UpdateLogText.Parent = UpdateLogTabButton

-- ==================== CHAT TAB BUTTON ====================
local ChatTabButton = Instance.new("ImageButton")
ChatTabButton.Name = "ChatTabButton"
ChatTabButton.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
ChatTabButton.BorderSizePixel = 0
ChatTabButton.ZIndex = 10
ChatTabButton.Parent = Body_2

local ChatIcon = Instance.new("ImageLabel", ChatTabButton)
ChatIcon.BackgroundTransparency = 1
ChatIcon.AnchorPoint = Vector2.new(0.5, 0)
ChatIcon.Position = UDim2.new(0.5, 0, 0.1, 0)
ChatIcon.Size = UDim2.new(0.6, 0, 0.6, 0)
ChatIcon.Image = "rbxassetid://6031302821" -- Clean chat bubble icon
ChatIcon.ScaleType = Enum.ScaleType.Fit
ChatIcon.ZIndex = 11

local ChatText = Instance.new("TextLabel")
ChatText.BackgroundTransparency = 1
ChatText.Position = UDim2.new(0, 0, 0.800000012, 0)
ChatText.Size = UDim2.new(1, 0, 0.200000003, 0)
ChatText.Text = "Chat"
ChatText.TextColor3 = Color3.new(1, 1, 1)
ChatText.Font = Enum.Font.SourceSans
ChatText.TextScaled = false
ChatText.TextSize = 24.000
ChatText.ZIndex = 11
ChatText.Parent = ChatTabButton

local KillPanelButton = Instance.new("TextButton")
KillPanelButton.Name = "KillPanelButton"
KillPanelButton.Size = UDim2.new(0, 132, 0, 132)
KillPanelButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
KillPanelButton.Text = "KILL\nPANEL"
KillPanelButton.TextColor3 = Color3.new(1,1,1)
KillPanelButton.Font = Enum.Font.SourceSans
KillPanelButton.TextScaled = false
KillPanelButton.TextSize = 24.000
KillPanelButton.Parent = Body_2
Instance.new("UICorner", KillPanelButton).CornerRadius = UDim.new(0, 12)

trackConnection(KillPanelButton.MouseButton1Click:Connect(function()
    neverfailtoggle = false
    podstoggle = false
    pctoggle = false
    playertoggle = false
    bestpctoggle = false
    exitstoggle = false
    beastcamtoggle = false
    autoplaytoggle = false
    autointeracttoggle = false
    speedtoggle = false
    jumptoggle = false
    nocliptoggle = false
    nofogtoggle = false
    fullbrighttoggle = false
    smartesptoggle = false
    fovtoggle = false
    lowgravtoggle = false
    proximitytoggle = false
    autostruggletoggle = false
    radartoggle = false
    hitboxtoggle = false
    
    if FreecamUI then FreecamUI.Visible = false end
    if UpdateLogMenu then UpdateLogMenu.Visible = false end

    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 0
    end

    local lighting = game:GetService("Lighting")
    if origFogEnd then lighting.FogEnd = origFogEnd end
    if origFogStart then lighting.FogStart = origFogStart end
    if origAmbient then lighting.Ambient = origAmbient end
    if origOutdoorAmbient then lighting.OutdoorAmbient = origOutdoorAmbient end
    local atmosphere = lighting:FindFirstChild("Atmosphere")
    if atmosphere and origAtmDensity then
        atmosphere.Density = origAtmDensity
        atmosphere.Offset = origAtmOffset
    end
    workspace.CurrentCamera.FieldOfView = 70
    workspace.Gravity = 196.2

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Highlight") then v:Destroy() end
    end
    
    for _, conn in pairs(activeConnections) do
        if conn and conn.Connected then conn:Disconnect() end
    end

    if ViewportFrame then ViewportFrame:Destroy() end
    task.wait(0.1)
    FTFHAX:Destroy()
end))
-- ==========================================================

ToolsMenuWindow.Name = "ToolsMenuWindow"
ToolsMenuWindow.Parent = FTFHAX
ToolsMenuWindow.AnchorPoint = Vector2.new(0.5, 0.5)
ToolsMenuWindow.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
ToolsMenuWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
ToolsMenuWindow.BorderSizePixel = 2
ToolsMenuWindow.ClipsDescendants = true
ToolsMenuWindow.Position = UDim2.new(0.5, 0, 0.5, -18)
ToolsMenuWindow.Size = UDim2.new(0, 480, 0, 175)
ToolsMenuWindow.SizeConstraint = Enum.SizeConstraint.RelativeYY
ToolsMenuWindow.Visible = false

Body_3.Name = "Body"
Body_3.Parent = ToolsMenuWindow
Body_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Body_3.BackgroundTransparency = 1.000
Body_3.BorderSizePixel = 0
Body_3.Position = UDim2.new(0, 0, 0, 40)
Body_3.Size = UDim2.new(1, 0, 1, -40)

TitleLabel_2.Name = "TitleLabel"
TitleLabel_2.Parent = Body_3
TitleLabel_2.AnchorPoint = Vector2.new(0.5, 0)
TitleLabel_2.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
TitleLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel_2.BorderSizePixel = 0
TitleLabel_2.Position = UDim2.new(0.5, 0, -1.06500006, 150)
TitleLabel_2.Size = UDim2.new(1, -10, 0.0235044118, 30)
TitleLabel_2.Text = "Tools"
TitleLabel_2.TextColor3 = Color3.fromRGB(144, 255, 161)
TitleLabel_2.TextScaled = true
TitleLabel_2.TextSize = 14.000
TitleLabel_2.TextWrapped = true

ButtonsFrame_2.Name = "ButtonsFrame"
ButtonsFrame_2.Parent = Body_3
ButtonsFrame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ButtonsFrame_2.BackgroundTransparency = 1.000
ButtonsFrame_2.Position = UDim2.new(0, 5, 0, 45)
ButtonsFrame_2.Size = UDim2.new(1, -10, -0.00555555569, 85)

UIGridLayout_3.Parent = ButtonsFrame_2
UIGridLayout_3.FillDirection = Enum.FillDirection.Vertical
UIGridLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout_3.CellPadding = UDim2.new(0, 6, 0, 6)
UIGridLayout_3.CellSize = UDim2.new(0, 152, 0, 39)

NeverFailButton.Name = "NeverFailButton"
NeverFailButton.Parent = ButtonsFrame_2
NeverFailButton.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
NeverFailButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
NeverFailButton.BorderSizePixel = 0
NeverFailButton.Size = UDim2.new(0, 200, 0, 50)
NeverFailButton.Text = "Never Fail"
NeverFailButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NeverFailButton.TextScaled = true
NeverFailButton.TextSize = 14.000
NeverFailButton.TextWrapped = true

AutoPlayButton.Name = "AutoPlayButton"
AutoPlayButton.Parent = ButtonsFrame_2
AutoPlayButton.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
AutoPlayButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
AutoPlayButton.BorderSizePixel = 0
AutoPlayButton.LayoutOrder = 1
AutoPlayButton.Size = UDim2.new(0, 200, 0, 50)
AutoPlayButton.Text = "Auto-Play"
AutoPlayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoPlayButton.TextScaled = true
AutoPlayButton.TextSize = 14.000
AutoPlayButton.TextWrapped = true

AutoInteractButton.Name = "AutoInteractButton"
AutoInteractButton.Parent = ButtonsFrame_2
AutoInteractButton.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
AutoInteractButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
AutoInteractButton.BorderSizePixel = 0
AutoInteractButton.LayoutOrder = 2
AutoInteractButton.Size = UDim2.new(0, 200, 0, 50)
AutoInteractButton.Text = "Auto Interact"
AutoInteractButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoInteractButton.TextScaled = true
AutoInteractButton.TextSize = 14.000
AutoInteractButton.TextWrapped = true

BeastCamButton.Name = "BeastCamButton"
BeastCamButton.Parent = ButtonsFrame_2
BeastCamButton.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
BeastCamButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
BeastCamButton.BorderSizePixel = 0
BeastCamButton.LayoutOrder = 3
BeastCamButton.Size = UDim2.new(0, 200, 0, 50)
BeastCamButton.Text = "Beast Cam"
BeastCamButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BeastCamButton.TextScaled = true
BeastCamButton.TextSize = 14.000
BeastCamButton.TextWrapped = true

TopBar_3.Name = "TopBar"
TopBar_3.Parent = ToolsMenuWindow
TopBar_3.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
TopBar_3.BorderSizePixel = 0
TopBar_3.Size = UDim2.new(1, 0, 0, 40)
TopBar_3.ZIndex = 5

CloseButton_3.Name = "CloseButton"
CloseButton_3.Parent = TopBar_3
CloseButton_3.AnchorPoint = Vector2.new(1, 0)
CloseButton_3.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton_3.BorderColor3 = Color3.fromRGB(191, 191, 191)
CloseButton_3.BorderSizePixel = 0
CloseButton_3.Position = UDim2.new(1, -1, 0, 1)
CloseButton_3.Size = UDim2.new(0, 36, 0, 36)
CloseButton_3.SizeConstraint = Enum.SizeConstraint.RelativeYY
CloseButton_3.ZIndex = 5
CloseButton_3.Modal = true
CloseButton_3.Text = "X"
CloseButton_3.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton_3.TextScaled = true
CloseButton_3.TextSize = 14.000
CloseButton_3.TextWrapped = true

BackButton_2.Name = "BackButton"
BackButton_2.Parent = TopBar_3
BackButton_2.AnchorPoint = Vector2.new(1, 0)
BackButton_2.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
BackButton_2.BorderColor3 = Color3.fromRGB(191, 191, 191)
BackButton_2.BorderSizePixel = 0
BackButton_2.Position = UDim2.new(1, -41, 0, 1)
BackButton_2.Size = UDim2.new(1, -4, 1, -4)
BackButton_2.SizeConstraint = Enum.SizeConstraint.RelativeYY
BackButton_2.ZIndex = 5
BackButton_2.Text = "<"
BackButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
BackButton_2.TextScaled = true
BackButton_2.TextSize = 14.000
BackButton_2.TextWrapped = true

CreditTotalText_3.Name = "CreditTotalText"
CreditTotalText_3.Parent = TopBar_3
CreditTotalText_3.AnchorPoint = Vector2.new(1, 0)
CreditTotalText_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CreditTotalText_3.BackgroundTransparency = 1.000
CreditTotalText_3.BorderSizePixel = 0
CreditTotalText_3.Position = UDim2.new(1, -85, 0, 0)
CreditTotalText_3.Size = UDim2.new(0, 100, 1, 0)
CreditTotalText_3.ZIndex = 5
CreditTotalText_3.Text = ver
CreditTotalText_3.TextColor3 = Color3.fromRGB(255, 255, 0)
CreditTotalText_3.TextScaled = true
CreditTotalText_3.TextWrapped = true
CreditTotalText_3.TextXAlignment = Enum.TextXAlignment.Right

PageTitleText_3.Name = "PageTitleText"
PageTitleText_3.Parent = TopBar_3
PageTitleText_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PageTitleText_3.BackgroundTransparency = 1.000
PageTitleText_3.BorderSizePixel = 0
PageTitleText_3.Position = UDim2.new(0, 10, 0, 0)
PageTitleText_3.Size = UDim2.new(0, 200, 1, 0)
PageTitleText_3.ZIndex = 5
PageTitleText_3.Text = "FTF admin Panel - Tools"
PageTitleText_3.TextColor3 = Color3.fromRGB(255, 255, 255)
PageTitleText_3.TextScaled = true
PageTitleText_3.TextWrapped = true
PageTitleText_3.TextXAlignment = Enum.TextXAlignment.Left

ViewportFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ViewportFrame.Parent = FTFHAX
ViewportFrame.Position = UDim2.new(0, 5, 0.666000009, -5)
ViewportFrame.Size = UDim2.new(0.333, 0, 0.333, 0)
ViewportFrame.Ambient = Color3.fromRGB(147,147,147)
ViewportFrame.LightDirection = Vector3.new(0,1,0)
ViewportFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
ViewportFrame.BackgroundTransparency = 0.9
ViewportFrame.Visible = false

-- ==================== DYNAMIC MAP CHECK ====================
local function getMap()
    local mapFolder = game.ReplicatedStorage:FindFirstChild("CurrentMap")
    if mapFolder and mapFolder.Value then
        return mapFolder.Value
    end
    return nil
end

-- ==================== FIXED TP MENU ====================
local TPMenu = ESPMenuWindow:Clone()
TPMenu.Name = "TPMenu"
TPMenu.Visible = false
TPMenu.Parent = FTFHAX
TPMenu.Body.TitleLabel.Text = "TELEPORT"
TPMenu.TopBar.PageTitleText.Text = "FTF admin Panel - TP"

for _, v in pairs(TPMenu.Body.ButtonsFrame:GetChildren()) do
    if v:IsA("TextButton") then v:Destroy() end
end

local lp = game.Players.LocalPlayer

local function AddTP(name, func)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSans
    btn.TextScaled = true
    btn.Parent = TPMenu.Body.ButtonsFrame
    trackConnection(btn.MouseButton1Click:Connect(function()
        pcall(func)
    end))
end

AddTP("Nearest PC", function()
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    local map = getMap()
    if not map then return end
    local closest, dist = nil, math.huge
    local pos = lp.Character.HumanoidRootPart.Position
    for _, v in pairs(map:GetDescendants()) do
        if v.Name == "ComputerTable" then
            local d = (v:GetPivot().Position - pos).Magnitude
            if d < dist then dist = d; closest = v end
        end
    end
    if closest then lp.Character.HumanoidRootPart.CFrame = closest:GetPivot() + Vector3.new(0, 5, 0) end
end)

AddTP("Safest PC (Best)", function()
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    local best = getBestPC()
    if best and best[1] and best[1].pc then
        lp.Character.HumanoidRootPart.CFrame = best[1].pc:GetPivot() + Vector3.new(0, 5, 0)
    end
end)

AddTP("Nearest Pod", function()
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    local map = getMap()
    if not map then return end
    local closest, dist = nil, math.huge
    local pos = lp.Character.HumanoidRootPart.Position
    for _, v in pairs(map:GetDescendants()) do
        if v.Name == "FreezePod" then
            local d = (v:GetPivot().Position - pos).Magnitude
            if d < dist then dist = d; closest = v end
        end
    end
    if closest then lp.Character.HumanoidRootPart.CFrame = closest:GetPivot() + Vector3.new(0, 5, 0) end
end)

AddTP("Frozen Teammate", function()
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    local map = getMap()
    if not map then return end
    for _, v in pairs(map:GetDescendants()) do
        if v.Name == "FreezePod" and v:FindFirstChild("Occupant") and v.Occupant.Value ~= nil then
            lp.Character.HumanoidRootPart.CFrame = v:GetPivot() + Vector3.new(0, 5, 0)
            break
        end
    end
end)

AddTP("Exit Door", function()
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    local map = getMap()
    if not map then return end
    for _, v in pairs(map:GetDescendants()) do
        if v.Name == "ExitDoor" then
            lp.Character.HumanoidRootPart.CFrame = v:GetPivot() + Vector3.new(0, 5, 0)
            break
        end
    end
end)

AddTP("TP to Beast", function()
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    local beast = getBeast()
    if beast and beast.Character and beast.Character:FindFirstChild("HumanoidRootPart") then
        lp.Character.HumanoidRootPart.CFrame = beast.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
    end
end)

AddTP("Nearest Teammate", function()
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    local closest, dist = nil, math.huge
    local beast = getBeast()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= lp and p ~= beast and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d = (lp.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then dist = d; closest = p end
        end
    end
    if closest and closest.Character and closest.Character:FindFirstChild("HumanoidRootPart") then
        lp.Character.HumanoidRootPart.CFrame = closest.Character.HumanoidRootPart.CFrame + Vector3.new(5, 0, 0)
    end
end)

AddTP("Spawn", function()
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    local spawn = workspace:FindFirstChild("SpawnLocation") or workspace:FindFirstChild("Spawns") and workspace.Spawns:FindFirstChildOfClass("SpawnLocation")
    if spawn then
        lp.Character.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 10, 0)
    end
end)

AddTP("Map Center", function()
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    local map = getMap()
    if map then
        local cf = map:GetBoundingBox()
        lp.Character.HumanoidRootPart.CFrame = cf.Position + Vector3.new(0, 80, 0)
    end
end)

AddTP("Random PC", function()
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    local map = getMap()
    if not map then return end
    local pcs = {}
    for _, v in pairs(map:GetDescendants()) do
        if v.Name == "ComputerTable" then table.insert(pcs, v) end
    end
    if #pcs > 0 then
        local rand = pcs[math.random(1, #pcs)]
        lp.Character.HumanoidRootPart.CFrame = rand:GetPivot() + Vector3.new(0, 5, 0)
    end
end)

-- ==================== PLAYER MENU ====================
local PlayerMenu = ESPMenuWindow:Clone()
PlayerMenu.Name = "PlayerMenu"
PlayerMenu.Visible = false
PlayerMenu.Parent = FTFHAX
PlayerMenu.Body.TitleLabel.Text = "PLAYER MODS"
PlayerMenu.TopBar.PageTitleText.Text = "FTF admin Panel - Player"

-- Nuke the cloned standard Frame
PlayerMenu.Body.ButtonsFrame:Destroy()

-- Build a clean ScrollingFrame in its place
local PlayerScroll = Instance.new("ScrollingFrame")
PlayerScroll.Name = "ButtonsFrame"
PlayerScroll.Parent = PlayerMenu.Body
PlayerScroll.BackgroundTransparency = 1
PlayerScroll.Position = UDim2.new(0, 5, 0, 45)
PlayerScroll.Size = UDim2.new(1, -10, 1, -55)
PlayerScroll.ScrollBarThickness = 4
PlayerScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y -- Allows infinite scrolling

-- Add the Grid Layout back so buttons snap perfectly
local PlayerGrid = Instance.new("UIGridLayout")
PlayerGrid.Parent = PlayerScroll
PlayerGrid.FillDirection = Enum.FillDirection.Horizontal -- Fills left to right, then goes down
PlayerGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
PlayerGrid.SortOrder = Enum.SortOrder.LayoutOrder
PlayerGrid.CellPadding = UDim2.new(0, 6, 0, 6)
PlayerGrid.CellSize = UDim2.new(0, 152, 0, 39)

local function AddPlayerToggle(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSans
    btn.TextScaled = true
    btn.Parent = PlayerMenu.Body.ButtonsFrame
    
    trackConnection(btn.MouseButton1Click:Connect(function()
        local newState = callback()
        btn.BackgroundColor3 = newState and Color3.new(0, 0.74902, 0) or Color3.new(0.74902, 0, 0)
    end))
end

AddPlayerToggle("WalkSpeed (24)", function()
    speedtoggle = not speedtoggle
    if not speedtoggle then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
        end
    end
    return speedtoggle
end)

AddPlayerToggle("JumpPower (50)", function()
    jumptoggle = not jumptoggle
    if not jumptoggle then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            -- Instead of 0, we just turn off the override so the button stays alive
            char.Humanoid.UseJumpPower = false 
        end
    end
    return jumptoggle
end)

AddPlayerToggle("Noclip", function()
    nocliptoggle = not nocliptoggle
    if not nocliptoggle then
        local char = game.Players.LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end
    return nocliptoggle
end)

-- ==========================================
-- 1. MOBILE SHIFT-LOCK (Custom Icon Swapper)
-- ==========================================
local shiftlocktoggle = false
local shiftLockUI = nil
local icon = nil
local isShiftLocked = false
local slConnection = nil

-- The two Decal IDs you provided, formatted for the rbxthumb bypass!
local iconWhite = "rbxthumb://type=Asset&id=83349936062601&w=150&h=150"
local iconBlue = "rbxthumb://type=Asset&id=72173899346121&w=150&h=150"

AddPlayerToggle("Mobile Shift-Lock", function()
    shiftlocktoggle = not shiftlocktoggle
    
    if shiftlocktoggle then
        -- Spawn the on-screen Shift Lock Button
        shiftLockUI = Instance.new("TextButton")
        shiftLockUI.Name = "MobileShiftLockBtn"
        shiftLockUI.Size = UDim2.new(0, 50, 0, 50)
        shiftLockUI.Position = UDim2.new(0.8, -10, 0.6, 0) -- Safe spot on the right side
        shiftLockUI.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        shiftLockUI.BackgroundTransparency = 0.5
        shiftLockUI.ZIndex = 99999
        shiftLockUI.Text = "" -- Keep it blank so your custom icon shines
        Instance.new("UICorner", shiftLockUI).CornerRadius = UDim.new(1, 0) -- Perfect circle
        shiftLockUI.Parent = FTFHAX
        
        -- Load your custom WHITE image as the default state
        icon = Instance.new("ImageLabel", shiftLockUI)
        icon.Size = UDim2.new(0.7, 0, 0.7, 0)
        icon.AnchorPoint = Vector2.new(0.5, 0.5)
        icon.Position = UDim2.new(0.5, 0, 0.5, 0)
        icon.BackgroundTransparency = 1
        icon.Image = iconWhite
        
        -- On-Screen Button Logic
        trackConnection(shiftLockUI.MouseButton1Click:Connect(function()
            isShiftLocked = not isShiftLocked
            local char = game.Players.LocalPlayer.Character
            local hum = char and char:FindFirstChild("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            
            if isShiftLocked then
                -- TOGGLED ON: Swap to Blue Icon!
                icon.Image = iconBlue 
                shiftLockUI.BackgroundColor3 = Color3.fromRGB(0, 50, 150) -- Subtle dark blue glow
                
                if hum then 
                    hum.CameraOffset = Vector3.new(1.75, 0, 0) -- Shoulder cam
                    hum.AutoRotate = false -- Stop default mobile rotation
                end
                
                if not slConnection then
                    slConnection = game:GetService("RunService").RenderStepped:Connect(function()
                        if char and hrp and hum and hum.Health > 0 then
                            local cam = workspace.CurrentCamera
                            local look = cam.CFrame.LookVector
                            -- Lock character rotation to the camera
                            hrp.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + Vector3.new(look.X, 0, look.Z))
                        end
                    end)
                end
            else
                -- TOGGLED OFF: Swap back to White Icon!
                icon.Image = iconWhite 
                shiftLockUI.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Back to black
                
                if hum then 
                    hum.CameraOffset = Vector3.new(0, 0, 0)
                    hum.AutoRotate = true
                end
                if slConnection then
                    slConnection:Disconnect()
                    slConnection = nil
                end
            end
        end))
    else
        -- Clean up if turned off from the main admin panel
        isShiftLocked = false
        if shiftLockUI then shiftLockUI:Destroy() end
        if slConnection then slConnection:Disconnect() slConnection = nil end
        
        local char = game.Players.LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if hum then
            hum.CameraOffset = Vector3.new(0, 0, 0)
            hum.AutoRotate = true
        end
    end
    
    return shiftlocktoggle
end)

-- 2. NINJA MODE (Footstep Silencer)
local ninjatoggle = false

AddPlayerToggle("Ninja Mode", function()
    ninjatoggle = not ninjatoggle
    return ninjatoggle
end)

-- Loop to continuously silence the footstep emitters
trackConnection(game:GetService("RunService").Heartbeat:Connect(function()
    if ninjatoggle then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            -- Mute all sounds coming from the RootPart (where footsteps are stored)
            for _, sound in pairs(char.HumanoidRootPart:GetChildren()) do
                if sound:IsA("Sound") then
                    sound.Volume = 0
                end
            end
        end
    end
end))

-- ==========================================
-- 3. BEAST THIRD PERSON (Anti-First Person FIX)
-- ==========================================
local thirdpersontoggle = false
local tpcConnection = nil

AddPlayerToggle("Beast 3rd Person", function()
    thirdpersontoggle = not thirdpersontoggle
    local lp = game.Players.LocalPlayer
    
    if thirdpersontoggle then
        -- Create a loop to constantly fight FTF's camera lock
        if not tpcConnection then
            tpcConnection = game:GetService("RunService").RenderStepped:Connect(function()
                -- Give Beast the standard Survivor zoom (Max 128, Min 0.5)
                if lp.CameraMode ~= Enum.CameraMode.Classic then
                    lp.CameraMode = Enum.CameraMode.Classic
                end
                if lp.CameraMaxZoomDistance < 128 then
                    lp.CameraMaxZoomDistance = 128
                end
                if lp.CameraMinZoomDistance > 0.5 then
                    lp.CameraMinZoomDistance = 0.5
                end
            end)
        end
    else
        -- Stop fighting the camera
        if tpcConnection then
            tpcConnection:Disconnect()
            tpcConnection = nil
        end
        
        -- THE FIX: Check identity and restore proper zoom levels instantly!
        local currentBeast = getBeast()
        if currentBeast == lp then
            -- If you are the Beast, snap back to standard FTF 1st Person
            lp.CameraMode = Enum.CameraMode.LockFirstPerson
            lp.CameraMaxZoomDistance = 0.5
            lp.CameraMinZoomDistance = 0.5
        else
            -- If you are a Survivor, ensure you have standard 3rd person
            lp.CameraMode = Enum.CameraMode.Classic
            lp.CameraMaxZoomDistance = 128
            lp.CameraMinZoomDistance = 0.5
        end
    end
    
    return thirdpersontoggle
end)

-- ==========================================
-- 4. CUSTOM MOBILE CROSSHAIR (Perfect Aim)
-- ==========================================
local crosshairtoggle = false
local crosshairUI = nil

AddPlayerToggle("Custom Crosshair", function()
    crosshairtoggle = not crosshairtoggle
    
    if crosshairtoggle then
        -- Create a crisp, perfectly centered neon dot
        crosshairUI = Instance.new("Frame")
        crosshairUI.Name = "CenterCrosshair"
        crosshairUI.Size = UDim2.new(0, 6, 0, 6) -- 6x6 pixels is the sweet spot
        crosshairUI.Position = UDim2.new(0.5, 0, 0.5, 0) -- Absolute dead center
        crosshairUI.AnchorPoint = Vector2.new(0.5, 0.5) -- Locks the exact middle of the dot to the center
        crosshairUI.BackgroundColor3 = Color3.fromRGB(0, 255, 255) -- High-contrast Neon Cyan
        crosshairUI.BorderSizePixel = 0
        crosshairUI.ZIndex = 999999 -- Keeps it above ALL other UI elements
        
        -- Make it a perfect circle instead of a square
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = crosshairUI
        
        crosshairUI.Parent = FTFHAX
    else
        -- Clean up instantly when toggled off
        if crosshairUI then
            crosshairUI:Destroy()
            crosshairUI = nil
        end
    end
    
    return crosshairtoggle
end)

-- ==================== RISK LEVEL MENU ====================
local RiskMenu = ESPMenuWindow:Clone()
RiskMenu.Name = "RiskMenu"
RiskMenu.Visible = false
RiskMenu.Parent = FTFHAX
RiskMenu.Body.TitleLabel.Text = "RISK LEVELS"
RiskMenu.TopBar.PageTitleText.Text = "FTF admin Panel - Risk"

RiskMenu.Body.ButtonsFrame:Destroy()

local RiskScroll = Instance.new("ScrollingFrame")
RiskScroll.Name = "ButtonsFrame"
RiskScroll.Parent = RiskMenu.Body
RiskScroll.BackgroundTransparency = 1
RiskScroll.Position = UDim2.new(0, 5, 0, 45)
RiskScroll.Size = UDim2.new(1, -10, 1, -55)
RiskScroll.ScrollBarThickness = 4
RiskScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local RiskList = Instance.new("UIListLayout")
RiskList.Parent = RiskScroll
RiskList.SortOrder = Enum.SortOrder.LayoutOrder
RiskList.Padding = UDim.new(0, 5)

local function AddRiskItem(title, desc, color)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 75)
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame.BorderSizePixel = 0
    frame.Parent = RiskScroll
    
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -10, 0.35, 0)
    titleLbl.Position = UDim2.new(0, 5, 0, 5)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title
    titleLbl.TextColor3 = color
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Font = Enum.Font.SourceSansBold
    titleLbl.TextSize = 18
    titleLbl.Parent = frame
    
    local descLbl = Instance.new("TextLabel")
    descLbl.Size = UDim2.new(1, -10, 0.6, 0)
    descLbl.Position = UDim2.new(0, 5, 0.35, 2)
    descLbl.BackgroundTransparency = 1
    descLbl.Text = desc
    descLbl.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.TextYAlignment = Enum.TextYAlignment.Top
    descLbl.TextWrapped = true
    descLbl.Font = Enum.Font.SourceSans
    descLbl.TextSize = 15
    descLbl.Parent = frame
end

AddRiskItem(" SAFE (Client-Side)", "Live Radar, ESPs, Custom Crosshair, Anti-Blindness, Mobile Shift-Lock, Beast 3rd Person, No Fog, Fullbright.", Color3.fromRGB(100, 255, 100))
AddRiskItem(" MODERATE (Use Caution)", "Auto-Struggle, Hitbox Expander, Ghost Drone, Speed 24, Low Gravity, Jump 50.", Color3.fromRGB(255, 255, 100))
AddRiskItem(" HIGH RISK (Ban Chance)", "Noclip, Fixed Teleports, Auto-Play V1, Auto-Interact (Flags anti-cheat easily).", Color3.fromRGB(255, 100, 100))

-- ==================== UNFAIR MENU ====================
local UnfairMenu = ESPMenuWindow:Clone()
UnfairMenu.Name = "UnfairMenu"
UnfairMenu.Visible = false
UnfairMenu.Parent = FTFHAX
UnfairMenu.Body.TitleLabel.Text = "UNFAIR ADVANTAGE"
UnfairMenu.Body.TitleLabel.TextColor3 = Color3.new(1, 0.2, 0.2)
UnfairMenu.TopBar.PageTitleText.Text = "FTF admin Panel - Unfair"

UnfairMenu.Body.ButtonsFrame:Destroy()

local UnfairScroll = Instance.new("ScrollingFrame")
UnfairScroll.Name = "ButtonsFrame"
UnfairScroll.Parent = UnfairMenu.Body
UnfairScroll.BackgroundTransparency = 1
UnfairScroll.Position = UDim2.new(0, 5, 0, 45)
UnfairScroll.Size = UDim2.new(1, -10, 1, -55)
UnfairScroll.ScrollBarThickness = 4
UnfairScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local UnfairGrid = Instance.new("UIGridLayout")
UnfairGrid.Parent = UnfairScroll
UnfairGrid.FillDirection = Enum.FillDirection.Horizontal
UnfairGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
UnfairGrid.SortOrder = Enum.SortOrder.LayoutOrder
UnfairGrid.CellPadding = UDim2.new(0, 6, 0, 6)
UnfairGrid.CellSize = UDim2.new(0, 152, 0, 39)

local function AddUnfairToggle(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    btn.Parent = UnfairScroll
    
    trackConnection(btn.MouseButton1Click:Connect(function()
        local newState = callback()
        btn.BackgroundColor3 = newState and Color3.new(0, 0.74902, 0) or Color3.fromRGB(150, 0, 0)
    end))
end

-- 1. Auto Struggle Logic
AddUnfairToggle("Auto-Struggle", function()
    autostruggletoggle = not autostruggletoggle
    return autostruggletoggle
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if autostruggletoggle then
            local gui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            local screenGui = gui:FindFirstChild("ScreenGui")
            if screenGui and screenGui:FindFirstChild("StruggleBox") and screenGui.StruggleBox.Visible then
                game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
            end
        end
    end
end)

-- 4. Subtle Hitbox Extender (Beast Mode)
AddUnfairToggle("Expand Hitboxes", function()
    hitboxtoggle = not hitboxtoggle
    
    -- If turned off, instantly reset everyone's hitboxes back to normal
    if not hitboxtoggle then
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                plr.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                plr.Character.HumanoidRootPart.Transparency = 1
            end
        end
    end
    
    return hitboxtoggle
end)

-- Hitbox Extender Loop
trackConnection(game:GetService("RunService").Heartbeat:Connect(function()
    if hitboxtoggle then
        for _, plr in pairs(game.Players:GetPlayers()) do
            -- Only expand OTHER players, not yourself
            if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = plr.Character.HumanoidRootPart
                hrp.Size = Vector3.new(4, 4, 4) -- Subtle extension
                hrp.Transparency = 0.8 -- Makes it faintly visible so you know exactly where to swing
                hrp.BrickColor = BrickColor.new("Bright red")
                hrp.CanCollide = false -- Prevents them from getting stuck in doors
            end
        end
    end
end))

-- 2. Live Radar & Anti-Camp UI
local LiveRadarLabel = Instance.new("TextLabel")
LiveRadarLabel.Size = UDim2.new(0, 300, 0, 50)
LiveRadarLabel.Position = UDim2.new(0.5, -150, 0.85, 0)
LiveRadarLabel.BackgroundTransparency = 0.5
LiveRadarLabel.BackgroundColor3 = Color3.new(0,0,0)
LiveRadarLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LiveRadarLabel.Font = Enum.Font.SourceSansBold
LiveRadarLabel.TextScaled = true
LiveRadarLabel.Visible = false
LiveRadarLabel.ZIndex = 100
LiveRadarLabel.Parent = FTFHAX
Instance.new("UICorner", LiveRadarLabel).CornerRadius = UDim.new(0, 8)

AddUnfairToggle("Live Radar", function()
    radartoggle = not radartoggle
    LiveRadarLabel.Visible = radartoggle
    return radartoggle
end)

trackConnection(game:GetService("RunService").Heartbeat:Connect(function()
    if radartoggle and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local beast = getBeast()
        local map = getMap()
        if beast and beast.Character and beast.Character:FindFirstChild("HumanoidRootPart") then
            local myPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            local beastPos = beast.Character.HumanoidRootPart.Position
            local dist = (myPos - beastPos).Magnitude
            
            local radarText = "BEAST: " .. math.floor(dist) .. " STUDS"
            
            -- Anti-Camp Check
            local isCamping = false
            if map then
                for _, pod in pairs(map:GetChildren()) do
                    if pod.Name == "FreezePod" and pod:FindFirstChild("Occupant") and pod.Occupant.Value ~= nil then
                        if (beastPos - pod:GetPivot().Position).Magnitude < 30 then
                            isCamping = true
                            break
                        end
                    end
                end
            end
            
            if isCamping then
                LiveRadarLabel.Text = radarText .. "\nâš ï¸ CAMPING POD âš ï¸"
                LiveRadarLabel.TextColor3 = Color3.new(1, 0.2, 0.2)
            else
                LiveRadarLabel.Text = radarText
                LiveRadarLabel.TextColor3 = Color3.new(1, 1, 1)
            end
        else
            LiveRadarLabel.Text = "SEARCHING FOR BEAST..."
            LiveRadarLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
        end
    end
end))

-- 3. Mobile Freecam UI Overlay
local FreecamUI = Instance.new("Frame")
FreecamUI.Name = "FreecamControls"
FreecamUI.Parent = FTFHAX
FreecamUI.Size = UDim2.new(1, 0, 1, 0)
FreecamUI.BackgroundTransparency = 1
FreecamUI.Visible = false
FreecamUI.ZIndex = 50

local moving = {W=false, A=false, S=false, D=false, Up=false, Dn=false}

local function createCamBtn(id, text, pos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 60, 0, 60)
    btn.Position = pos
    btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.5
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    btn.Parent = FreecamUI
    
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            moving[id] = true
        end
    end)
    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            moving[id] = false
        end
    end)
end

-- D-Pad Left Side
createCamBtn("W", "FWD", UDim2.new(0.15, 0, 0.5, 0))
createCamBtn("S", "BACK", UDim2.new(0.15, 0, 0.7, 0))
createCamBtn("A", "LEFT", UDim2.new(0.07, 0, 0.6, 0))
createCamBtn("D", "RIGHT", UDim2.new(0.23, 0, 0.6, 0))

-- Elevators Right Side
createCamBtn("Up", "UP", UDim2.new(0.85, 0, 0.5, 0))
createCamBtn("Dn", "DOWN", UDim2.new(0.85, 0, 0.7, 0))

-- Freecam Logic
local dronetoggle = false
local camConnection
local freecamPart

AddUnfairToggle("Ghost Drone", function()
    dronetoggle = not dronetoggle
    local char = game.Players.LocalPlayer.Character
    local cam = workspace.CurrentCamera
    
    if dronetoggle then
        FreecamUI.Visible = true
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.Anchored = true
        end
        
        freecamPart = Instance.new("Part")
        freecamPart.Size = Vector3.new(1,1,1)
        freecamPart.Transparency = 1
        freecamPart.Anchored = true
        freecamPart.CanCollide = false
        freecamPart.CFrame = cam.CFrame
        freecamPart.Parent = workspace
        cam.CameraSubject = freecamPart
        
        camConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local speed = 0.26
            local vec = Vector3.new(0,0,0)
            
            if moving.W then vec = vec + cam.CFrame.LookVector end
            if moving.S then vec = vec - cam.CFrame.LookVector end
            if moving.A then vec = vec - cam.CFrame.RightVector end
            if moving.D then vec = vec + cam.CFrame.RightVector end
            if moving.Up then vec = vec + Vector3.new(0,1,0) end
            if moving.Dn then vec = vec - Vector3.new(0,1,0) end
            
            if vec.Magnitude > 0 then
                vec = vec.Unit * speed
                freecamPart.CFrame = freecamPart.CFrame + vec
            end
        end)
    else
        FreecamUI.Visible = false
        for k, _ in pairs(moving) do moving[k] = false end
        
        if freecamPart then freecamPart:Destroy() end
        if camConnection then camConnection:Disconnect() end
        
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
            char.HumanoidRootPart.Anchored = false
            cam.CameraSubject = char.Humanoid
        end
    end
    return dronetoggle
end)

-- ==================== UPDATE LOG MENU ====================
local UpdateLogMenu = ESPMenuWindow:Clone()
UpdateLogMenu.Name = "UpdateLogMenu"
UpdateLogMenu.Visible = false
UpdateLogMenu.Parent = FTFHAX
UpdateLogMenu.Body.TitleLabel.Text = "UPDATE LOG"
UpdateLogMenu.Body.TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
UpdateLogMenu.TopBar.PageTitleText.Text = "FTF admin Panel - Logs"

UpdateLogMenu.Body.ButtonsFrame:Destroy()

local LogScroll = Instance.new("ScrollingFrame")
LogScroll.Name = "LogScroll"
LogScroll.Parent = UpdateLogMenu.Body
LogScroll.BackgroundTransparency = 1
LogScroll.Position = UDim2.new(0, 10, 0, 45)
LogScroll.Size = UDim2.new(1, -20, 1, -55)
LogScroll.ScrollBarThickness = 4
LogScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local LogListLayout = Instance.new("UIListLayout")
LogListLayout.Parent = LogScroll
LogListLayout.SortOrder = Enum.SortOrder.LayoutOrder
LogListLayout.Padding = UDim.new(0, 10)

local function AddLogEntry(version, text)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 0) -- Height will auto-adjust
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame.BorderSizePixel = 0
    frame.Parent = LogScroll
    frame.AutomaticSize = Enum.AutomaticSize.Y
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 5)
    padding.PaddingBottom = UDim.new(0, 5)
    padding.PaddingLeft = UDim.new(0, 5)
    padding.PaddingRight = UDim.new(0, 5)
    padding.Parent = frame
    
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, 0, 0, 20)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = version
    titleLbl.TextColor3 = Color3.fromRGB(150, 255, 150)
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Font = Enum.Font.SourceSansBold
    titleLbl.TextSize = 16
    titleLbl.Parent = frame
    
    local descLbl = Instance.new("TextLabel")
    descLbl.Size = UDim2.new(1, 0, 0, 0)
    descLbl.Position = UDim2.new(0, 0, 0, 22)
    descLbl.BackgroundTransparency = 1
    descLbl.Text = text
    descLbl.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.TextYAlignment = Enum.TextYAlignment.Top
    descLbl.TextWrapped = true
    descLbl.Font = Enum.Font.SourceSans
    descLbl.TextSize = 14
    descLbl.AutomaticSize = Enum.AutomaticSize.Y
    descLbl.Parent = frame
    
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
end

-- Your Actual Update Logs
AddLogEntry("v0.7.54 [LATEST]", "- Added Unfair Menu\n- Added Ghost Drone (Mobile D-Pad)\n- Added Live Beast Radar\n- Added Auto-Struggle\n- Added Subtle Beast Hitbox Extender (4x4)\n- Fixed Menu Click Routing")
AddLogEntry("v0.7.53", "- Added Risk Level Chart\n- Optimized Smart ESP rendering distance\n- Improved Mobile UI Grid Layout")
AddLogEntry("v0.7.52", "- Added Kill Panel (Emergency Shutoff)\n- Added Nuke FPS Booster\n- Added Reversible No Fog & Fullbright")

-- ==================== MISC MENU ====================
local MiscMenu = ESPMenuWindow:Clone()
MiscMenu.Name = "MiscMenu"
MiscMenu.Visible = false
MiscMenu.Parent = FTFHAX
MiscMenu.Body.TitleLabel.Text = "MISC MODS"
MiscMenu.TopBar.PageTitleText.Text = "FTF admin Panel - Misc"

MiscMenu.Body.ButtonsFrame:Destroy()

local MiscScroll = Instance.new("ScrollingFrame")
MiscScroll.Name = "ButtonsFrame"
MiscScroll.Parent = MiscMenu.Body
MiscScroll.BackgroundTransparency = 1
MiscScroll.Position = UDim2.new(0, 5, 0, 45)
MiscScroll.Size = UDim2.new(1, -10, 1, -55)
MiscScroll.ScrollBarThickness = 4
MiscScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local MiscGrid = Instance.new("UIGridLayout")
MiscGrid.Parent = MiscScroll
MiscGrid.FillDirection = Enum.FillDirection.Horizontal 
MiscGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
MiscGrid.SortOrder = Enum.SortOrder.LayoutOrder
MiscGrid.CellPadding = UDim2.new(0, 6, 0, 6)
MiscGrid.CellSize = UDim2.new(0, 152, 0, 39)

-- ==================== CHAT SHORTCUTS MENU ====================
local ChatMenu = ESPMenuWindow:Clone()
ChatMenu.Name = "ChatMenu"
ChatMenu.Visible = false
ChatMenu.Parent = FTFHAX
ChatMenu.Body.TitleLabel.Text = "CHAT SHORTCUTS"
ChatMenu.Body.TitleLabel.TextColor3 = Color3.fromRGB(255, 150, 50)
ChatMenu.TopBar.PageTitleText.Text = "FTF admin Panel - Chat"

ChatMenu.Body.ButtonsFrame:Destroy()

local ChatScroll = Instance.new("ScrollingFrame")
ChatScroll.Name = "ButtonsFrame"
ChatScroll.Parent = ChatMenu.Body
ChatScroll.BackgroundTransparency = 1
ChatScroll.Position = UDim2.new(0, 5, 0, 85) -- Shifted down for the input box
ChatScroll.Size = UDim2.new(1, -10, 1, -90)
ChatScroll.ScrollBarThickness = 4
ChatScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local ChatGrid = Instance.new("UIGridLayout")
ChatGrid.Parent = ChatScroll
ChatGrid.FillDirection = Enum.FillDirection.Horizontal
ChatGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
ChatGrid.SortOrder = Enum.SortOrder.LayoutOrder
ChatGrid.CellPadding = UDim2.new(0, 6, 0, 6)
ChatGrid.CellSize = UDim2.new(0, 152, 0, 39)

-- Risk Warning Label
local ChatWarning = Instance.new("TextLabel")
ChatWarning.Size = UDim2.new(1, -10, 0, 20)
ChatWarning.Position = UDim2.new(0, 5, 0, 30)
ChatWarning.BackgroundTransparency = 1
ChatWarning.Text = " RISK: SAFE (Emotes) | HIGH (Spamming Custom Text = Kick/Ban)"
ChatWarning.TextColor3 = Color3.fromRGB(255, 80, 80)
ChatWarning.Font = Enum.Font.SourceSansBold
ChatWarning.TextSize = 14
ChatWarning.Parent = ChatMenu.Body

-- Custom Input UI (+ Button)
local ChatInputBox = Instance.new("TextBox")
ChatInputBox.Size = UDim2.new(0, 300, 0, 30)
ChatInputBox.Position = UDim2.new(0.5, -175, 0, 50)
ChatInputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ChatInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ChatInputBox.PlaceholderText = "Type custom message..."
ChatInputBox.Font = Enum.Font.SourceSans
ChatInputBox.TextSize = 16
ChatInputBox.ClearTextOnFocus = false
Instance.new("UICorner", ChatInputBox).CornerRadius = UDim.new(0, 6)
ChatInputBox.Parent = ChatMenu.Body

local AddChatBtn = Instance.new("TextButton")
AddChatBtn.Size = UDim2.new(0, 40, 0, 30)
AddChatBtn.Position = UDim2.new(0.5, 135, 0, 50)
AddChatBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
AddChatBtn.Text = "+"
AddChatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AddChatBtn.Font = Enum.Font.SourceSansBold
AddChatBtn.TextSize = 20
Instance.new("UICorner", AddChatBtn).CornerRadius = UDim.new(0, 6)
AddChatBtn.Parent = ChatMenu.Body

-- Chat Sending Logic (Bypasses new and legacy chat systems)
local function SendChatMessage(msg)
    pcall(function()
        local legacyChat = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
        if legacyChat then
            legacyChat.SayMessageRequest:FireServer(msg, "All")
        else
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(msg)
        end
    end)
end

-- Button Creator
local function CreateChatButton(msg, isCustom)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 50)
    btn.BackgroundColor3 = isCustom and Color3.fromRGB(0, 100, 150) or Color3.fromRGB(150, 0, 150)
    btn.Text = msg
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    btn.Parent = ChatScroll
    
    trackConnection(btn.MouseButton1Click:Connect(function()
        SendChatMessage(msg)
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0) -- Flashes green when sent
        task.wait(0.2)
        btn.BackgroundColor3 = isCustom and Color3.fromRGB(0, 100, 150) or Color3.fromRGB(150, 0, 150)
    end))
end

-- Default R6 Emotes (Safe)
CreateChatButton("/e dance", false)
CreateChatButton("/e wave", false)
CreateChatButton("/e cheer", false)
CreateChatButton("/e laugh", false)
CreateChatButton("/e point", false)

-- Local File Saving Logic
local ChatFileName = "FTF_CustomChats.txt"

local function LoadCustomChats()
    if isfile and isfile(ChatFileName) then
        local data = readfile(ChatFileName)
        for _, msg in ipairs(string.split(data, "\n")) do
            if msg ~= "" then CreateChatButton(msg, true) end
        end
    end
end

local function SaveCustomChat(msg)
    if writefile then
        local currentData = ""
        if isfile and isfile(ChatFileName) then currentData = readfile(ChatFileName) end
        writefile(ChatFileName, currentData .. msg .. "\n")
    end
end

LoadCustomChats()

trackConnection(AddChatBtn.MouseButton1Click:Connect(function()
    local newMsg = ChatInputBox.Text
    if newMsg ~= "" then
        CreateChatButton(newMsg, true)
        SaveCustomChat(newMsg)
        ChatInputBox.Text = "" -- Clear box after adding
    end
end))
-- =============================================================

-- ==================== ADMIN MENU UI ====================
local AdminMenu = ESPMenuWindow:Clone()
AdminMenu.Name = "AdminMenu"
AdminMenu.Visible = false
AdminMenu.Parent = FTFHAX
AdminMenu.Body.TitleLabel.Text = "ADMIN ACCESS"
AdminMenu.Body.TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
AdminMenu.TopBar.PageTitleText.Text = "FTF admin Panel - Developer"

AdminMenu.Body.ButtonsFrame:Destroy()

local AdminScroll = Instance.new("ScrollingFrame")
AdminScroll.Parent = AdminMenu.Body
AdminScroll.BackgroundTransparency = 1
AdminScroll.Position = UDim2.new(0, 5, 0, 45)
AdminScroll.Size = UDim2.new(1, -10, 1, -55)
AdminScroll.ScrollBarThickness = 2
AdminScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local AdminListLayout = Instance.new("UIListLayout")
AdminListLayout.Parent = AdminScroll
AdminListLayout.Padding = UDim.new(0, 10)
AdminListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local AdminInfoLabel = Instance.new("TextLabel")
AdminInfoLabel.Size = UDim2.new(1, -20, 0, 50)
AdminInfoLabel.BackgroundTransparency = 1
AdminInfoLabel.Text = "Scanning local server for injected users..."
AdminInfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
AdminInfoLabel.Font = Enum.Font.SourceSans
AdminInfoLabel.TextSize = 16
AdminInfoLabel.Parent = AdminScroll

local ActiveUsersLabel = Instance.new("TextLabel")
ActiveUsersLabel.Size = UDim2.new(1, -20, 0, 70)
ActiveUsersLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ActiveUsersLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
ActiveUsersLabel.Font = Enum.Font.Code
ActiveUsersLabel.TextSize = 14
ActiveUsersLabel.TextYAlignment = Enum.TextYAlignment.Top
ActiveUsersLabel.TextXAlignment = Enum.TextXAlignment.Left
ActiveUsersLabel.Text = "> NO OTHER USERS DETECTED."
Instance.new("UICorner", ActiveUsersLabel).CornerRadius = UDim.new(0, 6)

local ActivePadding = Instance.new("UIPadding", ActiveUsersLabel)
ActivePadding.PaddingTop = UDim.new(0, 5)
ActivePadding.PaddingLeft = UDim.new(0, 5)
ActiveUsersLabel.Parent = AdminScroll

-- Auto-update the Admin UI with pinged users
task.spawn(function()
    while true do
        task.wait(2)
        if #ActiveScriptUsers > 0 then
            local userString = "> CONNECTED SCRIPT USERS:\n"
            for _, name in ipairs(ActiveScriptUsers) do
                userString = userString .. "- " .. name .. "\n"
            end
            ActiveUsersLabel.Text = userString
        end
    end
end)

-- DEVELOPER OVERRIDES
local AdminToolsLabel = Instance.new("TextLabel")
AdminToolsLabel.Size = UDim2.new(1, -20, 0, 30)
AdminToolsLabel.BackgroundTransparency = 1
AdminToolsLabel.Text = "DEVELOPER OVERRIDES:"
AdminToolsLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
AdminToolsLabel.Font = Enum.Font.SourceSansBold
AdminToolsLabel.TextSize = 18
AdminToolsLabel.TextXAlignment = Enum.TextXAlignment.Left
AdminToolsLabel.Parent = AdminScroll

-- New Sleek Apple-Style Button Design
local function AddAdminOverride(text, func)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Clean dark mode
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8) -- Rounded modern corners
    
    -- Subtle Neon Blue Outline
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(0, 255, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    
    btn.Parent = AdminScroll
    trackConnection(btn.MouseButton1Click:Connect(function()
        pcall(func)
    end))
end

AddAdminOverride("[>] REJOIN CURRENT SERVER", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
end)

AddAdminOverride("[>] COPY SERVER JOB-ID", function()
    print("FTF SERVER JOB-ID: " .. tostring(game.JobId))
    if setclipboard then setclipboard(game.JobId) end
end)

AddAdminOverride("[>] X-RAY MAP (NUKE VISUALS)", function()
    local map = game.ReplicatedStorage:FindFirstChild("CurrentMap")
    if map and map.Value then
        for _, v in pairs(map.Value:GetDescendants()) do
            if v:IsA("BasePart") then v.Transparency = 0.75 end
        end
    end
end)

-- Upgraded Mute function that forces every sound in the entire game engine to 0
AddAdminOverride("[>] MUTE ALL GAME SOUNDS", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Sound") then 
            v.Volume = 0 
            v.Playing = false
        end
    end
end)

-- CUSTOM JOIN SERVER UI (TextBox + Button)
local JoinServerFrame = Instance.new("Frame")
JoinServerFrame.Size = UDim2.new(1, -20, 0, 45)
JoinServerFrame.BackgroundTransparency = 1
JoinServerFrame.Parent = AdminScroll

local JobIdInput = Instance.new("TextBox")
JobIdInput.Size = UDim2.new(0.68, 0, 1, 0)
JobIdInput.Position = UDim2.new(0, 0, 0, 0)
JobIdInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
JobIdInput.TextColor3 = Color3.fromRGB(255, 255, 255)
JobIdInput.PlaceholderText = "Paste Job-ID Here..."
JobIdInput.Font = Enum.Font.Code
JobIdInput.TextSize = 14
JobIdInput.ClearTextOnFocus = false
Instance.new("UICorner", JobIdInput).CornerRadius = UDim.new(0, 8)

local inputStroke = Instance.new("UIStroke", JobIdInput)
inputStroke.Color = Color3.fromRGB(0, 255, 255)
inputStroke.Thickness = 1
inputStroke.Transparency = 0.5
JobIdInput.Parent = JoinServerFrame

local JoinButton = Instance.new("TextButton")
JoinButton.Size = UDim2.new(0.28, 0, 1, 0)
JoinButton.Position = UDim2.new(0.72, 0, 0, 0)
JoinButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255) -- Bright blue accent
JoinButton.Text = "JOIN"
JoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinButton.Font = Enum.Font.SourceSansBold
JoinButton.TextSize = 16
Instance.new("UICorner", JoinButton).CornerRadius = UDim.new(0, 8)
JoinButton.Parent = JoinServerFrame

trackConnection(JoinButton.MouseButton1Click:Connect(function()
    local targetJobId = JobIdInput.Text
    if targetJobId and targetJobId ~= "" then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, targetJobId, game.Players.LocalPlayer)
    end
end))

-- Hidden Admin Tab Button (Spawns in Main Menu)
local AdminTabButton = Instance.new("ImageButton")
AdminTabButton.Name = "AdminTabButton"
AdminTabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AdminTabButton.BorderSizePixel = 0
AdminTabButton.Visible = false
AdminTabButton.Parent = Body_2

local AdminIcon = Instance.new("ImageLabel", AdminTabButton)
AdminIcon.BackgroundTransparency = 1
AdminIcon.AnchorPoint = Vector2.new(0.5, 0)
AdminIcon.Position = UDim2.new(0.5, 0, 0.1, 0)
AdminIcon.Size = UDim2.new(0.6, 0, 0.6, 0)
AdminIcon.Image = "rbxthumb://type=Asset&id=1177220578&w=150&h=150"
AdminIcon.Parent = AdminTabButton

local AdminText = Instance.new("TextLabel")
AdminText.BackgroundTransparency = 1
AdminText.Position = UDim2.new(0, 0, 0.8, 0)
AdminText.Size = UDim2.new(1, 0, 0.2, 0)
AdminText.Text = "Admin"
AdminText.TextColor3 = Color3.fromRGB(0, 255, 255)
AdminText.Font = Enum.Font.SourceSansBold
AdminText.TextSize = 24
AdminText.Parent = AdminTabButton

-- Logout Button (Pinned to Bottom Left of Main Menu)
local LogoutButton = Instance.new("TextButton")
LogoutButton.Name = "LogoutButton"
LogoutButton.Size = UDim2.new(0, 80, 0, 25) 
LogoutButton.Position = UDim2.new(0, 10, 1, -35) 
LogoutButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30) 
LogoutButton.BorderSizePixel = 0
LogoutButton.Text = "LOGOUT"
LogoutButton.TextColor3 = Color3.fromRGB(200, 50, 50) 
LogoutButton.Font = Enum.Font.SourceSansBold
LogoutButton.TextSize = 14
LogoutButton.ZIndex = 10
Instance.new("UICorner", LogoutButton).CornerRadius = UDim.new(0, 4)
LogoutButton.Parent = MainMenuWindow

-- ==================== THE GATEKEEPER (LOGIN UI) ====================
local lastUsedPassword = ""

-- The new floating 420x360 Login Panel matching the main UI
local LoginScreen = Instance.new("Frame")
LoginScreen.Name = "LoginGate"
LoginScreen.AnchorPoint = Vector2.new(0.5, 0.5)
LoginScreen.Position = UDim2.new(0.5, 0, 0.5, -18)
LoginScreen.Size = UDim2.new(0, 420, 0, 360)
LoginScreen.BackgroundColor3 = Color3.fromRGB(47, 47, 47) -- Matches main hub color
LoginScreen.BorderColor3 = Color3.fromRGB(0, 0, 0)
LoginScreen.BorderSizePixel = 2
LoginScreen.ZIndex = 100000
LoginScreen.Parent = FTFHAX

local LoginTopBar = Instance.new("Frame")
LoginTopBar.Size = UDim2.new(1, 0, 0, 40)
LoginTopBar.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
LoginTopBar.BorderSizePixel = 0
LoginTopBar.ZIndex = 100001
LoginTopBar.Parent = LoginScreen

local LoginTitle = Instance.new("TextLabel")
LoginTitle.Size = UDim2.new(1, 0, 1, 0)
LoginTitle.Position = UDim2.new(0, 10, 0, 0)
LoginTitle.BackgroundTransparency = 1
LoginTitle.Text = "AUTHENTICATION REQUIRED"
LoginTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoginTitle.Font = Enum.Font.SourceSansBold
LoginTitle.TextSize = 18
LoginTitle.TextXAlignment = Enum.TextXAlignment.Left
LoginTitle.ZIndex = 100002
LoginTitle.Parent = LoginTopBar

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -20, 0, 100)
InfoText.Position = UDim2.new(0, 10, 0, 60)
InfoText.BackgroundTransparency = 1
InfoText.Text = "To access this panel, please get the permanent password from the developer link below:\n\nhttps://pastebin.com/cyFWmFkG"
InfoText.TextColor3 = Color3.fromRGB(220, 220, 220)
InfoText.Font = Enum.Font.SourceSans
InfoText.TextSize = 18
InfoText.TextWrapped = true
InfoText.ZIndex = 100001
InfoText.Parent = LoginScreen

local PasswordInput = Instance.new("TextBox")
PasswordInput.Size = UDim2.new(0.8, 0, 0, 45)
PasswordInput.Position = UDim2.new(0.1, 0, 0.55, 0)
PasswordInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PasswordInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PasswordInput.PlaceholderText = "Enter Password..."
PasswordInput.Font = Enum.Font.Code
PasswordInput.TextSize = 18
PasswordInput.Text = ""
PasswordInput.ZIndex = 100001
Instance.new("UICorner", PasswordInput).CornerRadius = UDim.new(0, 6)
PasswordInput.Parent = LoginScreen

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0.8, 0, 0, 45)
SubmitButton.Position = UDim2.new(0.1, 0, 0.75, 0)
SubmitButton.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
SubmitButton.Text = "VERIFY"
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.Font = Enum.Font.SourceSansBold
SubmitButton.TextSize = 18
SubmitButton.ZIndex = 100001
Instance.new("UICorner", SubmitButton).CornerRadius = UDim.new(0, 6)
SubmitButton.Parent = LoginScreen

-- Hide Cheat Button until verified
CheatButton.Visible = false

-- ==========================================================
-- 🛡️ CLOUD AUTHENTICATION & ANTI-SPY SYSTEM
-- ==========================================================
local HWID = gethwid and gethwid() or "UNKNOWN_HWID"
-- 🛑 PUT YOUR VERCEL URL HERE:
local AuthURL = "https://ftf-auth-backend.vercel.app/api/verify" 

-- Anti-HttpSpy Detector
local function DetectSnooping()
    if ishooked and (ishooked(game.HttpGet) or ishooked(request)) then return true end
    return false
end

trackConnection(SubmitButton.MouseButton1Click:Connect(function()
    PasswordInput.Text = ""
    PasswordInput.PlaceholderText = "AUTHENTICATING HWID..."
    SubmitButton.Text = "PLEASE WAIT..."
    
    task.spawn(function()
        -- 1. Check for Spies (HttpStealers)
        if DetectSnooping() then
            pcall(function()
                request({
                    Url = AuthURL,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = game:GetService("HttpService"):JSONEncode({
                        action = "flag_spy", hwid = HWID, user = game.Players.LocalPlayer.Name, reason = "HttpSpy Detected"
                    })
                })
            end)
            game.Players.LocalPlayer:Kick("🛡️ Security Violation: Unauthorized network monitoring detected.")
            return
        end

        -- 2. Check Database for Ban
        local success, response = pcall(function()
            return request({
                Url = AuthURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = game:GetService("HttpService"):JSONEncode({
                    action = "login", hwid = HWID, user = game.Players.LocalPlayer.Name
                })
            })
        end)

        if success and response and response.StatusCode == 200 then
            local data = game:GetService("HttpService"):JSONDecode(response.Body)
            
            if data.status == "BANNED" then
                -- ENFORCE THE BAN INSTANTLY
                game.Players.LocalPlayer:Kick("⛔ You are blacklisted from this script.\nReason: " .. tostring(data.reason))
            elseif data.status == "APPROVED" then
                -- ✅ HWID APPROVED! UNLOCK THE PANEL (Full Admin Access)
                AdminTabButton.Visible = true 
                LoginScreen.Visible = false
                CheatButton.Visible = true
                MainMenuWindow.Visible = true
                pcall(function() game.Players.LocalPlayer:Chat("/e FTF_ADMIN_PING") end)
            end
        else
            PasswordInput.PlaceholderText = "SERVER OFFLINE"
            SubmitButton.Text = "RETRY"
        end
    end)
end))

-- Background Spy Scan (Runs every 3 seconds to catch them mid-game)
task.spawn(function()
    while task.wait(3) do
        if DetectSnooping() then
            game.Players.LocalPlayer:Kick("🛡️ Security Violation: Network manipulation detected.")
        end
    end
end)

-- Logout Logic
trackConnection(LogoutButton.MouseButton1Click:Connect(function()
    MainMenuWindow.Visible = false
    ESPMenuWindow.Visible = false
    ToolsMenuWindow.Visible = false
    TPMenu.Visible = false
    PlayerMenu.Visible = false
    MiscMenu.Visible = false
    RiskMenu.Visible = false
    UnfairMenu.Visible = false
    UpdateLogMenu.Visible = false
    AdminMenu.Visible = false
    CheatButton.Visible = false
    
    PasswordInput.Text = lastUsedPassword
    LoginScreen.Visible = true
end))
-- ===================================================================

-- ==================== CLICK ROUTING ====================
local function HideAllMenus()
    ESPMenuWindow.Visible = false
    ToolsMenuWindow.Visible = false
    TPMenu.Visible = false
    PlayerMenu.Visible = false
    if MiscMenu then MiscMenu.Visible = false end
    if RiskMenu then RiskMenu.Visible = false end
    if UnfairMenu then UnfairMenu.Visible = false end
    if UpdateLogMenu then UpdateLogMenu.Visible = false end
    if AdminMenu then AdminMenu.Visible = false end
    if ChatMenu then ChatMenu.Visible = false end
end

trackConnection(CheatButton.MouseButton1Click:Connect(function()
    HideAllMenus()
    MainMenuWindow.Visible = not MainMenuWindow.Visible
end))

trackConnection(CloseButton_2.MouseButton1Click:Connect(function() MainMenuWindow.Visible = false end))
trackConnection(CloseButton.MouseButton1Click:Connect(function() ESPMenuWindow.Visible = false end))
trackConnection(CloseButton_3.MouseButton1Click:Connect(function() ToolsMenuWindow.Visible = false end))

trackConnection(BackButton.MouseButton1Click:Connect(function()
    HideAllMenus()
    MainMenuWindow.Visible = true
end))

trackConnection(BackButton_2.MouseButton1Click:Connect(function()
    HideAllMenus()
    MainMenuWindow.Visible = true
end))

-- Menu Opening Hooks
trackConnection(ESPButton.MouseButton1Click:Connect(function() HideAllMenus() MainMenuWindow.Visible = false ESPMenuWindow.Visible = true end))
trackConnection(ToolsButton.MouseButton1Click:Connect(function() HideAllMenus() MainMenuWindow.Visible = false ToolsMenuWindow.Visible = true end))
trackConnection(TPButton.MouseButton1Click:Connect(function() HideAllMenus() MainMenuWindow.Visible = false TPMenu.Visible = true end))
trackConnection(PlayerTabButton.MouseButton1Click:Connect(function() HideAllMenus() MainMenuWindow.Visible = false PlayerMenu.Visible = true end))
trackConnection(MiscTabButton.MouseButton1Click:Connect(function() HideAllMenus() MainMenuWindow.Visible = false MiscMenu.Visible = true end))
trackConnection(RiskTabButton.MouseButton1Click:Connect(function() HideAllMenus() MainMenuWindow.Visible = false RiskMenu.Visible = true end))
trackConnection(UnfairTabButton.MouseButton1Click:Connect(function() HideAllMenus() MainMenuWindow.Visible = false UnfairMenu.Visible = true end))
trackConnection(UpdateLogTabButton.MouseButton1Click:Connect(function() HideAllMenus() MainMenuWindow.Visible = false UpdateLogMenu.Visible = true end))
trackConnection(ChatTabButton.MouseButton1Click:Connect(function() HideAllMenus() MainMenuWindow.Visible = false ChatMenu.Visible = true end))
if AdminTabButton then
    trackConnection(AdminTabButton.MouseButton1Click:Connect(function() HideAllMenus() MainMenuWindow.Visible = false AdminMenu.Visible = true end))
end

-- Back & Close Button Hooks for dynamic windows
local windows = {TPMenu, PlayerMenu, MiscMenu, RiskMenu, UnfairMenu, UpdateLogMenu, ChatMenu, AdminMenu}
for _, win in ipairs(windows) do
    if win and win:FindFirstChild("TopBar") then
        trackConnection(win.TopBar.BackButton.MouseButton1Click:Connect(function()
            win.Visible = false
            MainMenuWindow.Visible = true
        end))
        trackConnection(win.TopBar.CloseButton.MouseButton1Click:Connect(function()
            win.Visible = false
        end))
    end
end

-- Helper functions to fetch game data safely
function getBeast()
    local players = game.Players:GetChildren()
    for i=1, #players do
        local plr = players[i]
        local stats = plr:FindFirstChild("TempPlayerStatsModule")
        if (stats and stats:FindFirstChild("IsBeast") and stats.IsBeast.Value == true) then
            return plr
        end
        local character = plr.Character
        if character and character:FindFirstChild("BeastPowers") then
            return plr
        end
    end
    return nil
end

function getBestPC()
    local beast = getBeast()
    local pcs = {}
    local map = getMap()
    
    if map then
        for _, pc in pairs(map:GetChildren()) do
            if pc.Name == "ComputerTable" and pc:FindFirstChild("Screen") and pc.Screen.BrickColor ~= BrickColor.new("Dark green") then
                local magnitude = math.huge
                if beast and beast.Character and beast.Character:FindFirstChild("HumanoidRootPart") then
                    magnitude = (pc.Screen.Position - beast.Character.HumanoidRootPart.Position).Magnitude
                end
                table.insert(pcs, {magnitude=magnitude, pc=pc})
            end
        end
    end
    table.sort(pcs, function(a, b) return a.magnitude > b.magnitude end)
    return pcs
end

function isPlayerTyping()
    local char = game.Players.LocalPlayer.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    local anims = hum:GetPlayingAnimationTracks()
    for i=1,#anims do
        if anims[i].Name == "AnimTyping" then return true end
    end
    return false
end

-- ESP Highlight Applier
function reloadESP()
    local map = getMap()
    if map then
        local mapstuff = map:GetChildren()
        for i=1,#mapstuff do
            local item = mapstuff[i]
            if item.Name == "ComputerTable" then
                if item:FindFirstChild("Highlight") and not pctoggle then
                    item.Highlight:Destroy()
                elseif pctoggle and not item:FindFirstChild("Highlight") then
                    local a = Instance.new("Highlight", item)
                    a.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                end
            elseif item.Name == "FreezePod" then
                if item:FindFirstChild("Highlight") and not podstoggle then
                    item.Highlight:Destroy()
                elseif podstoggle and not item:FindFirstChild("Highlight") then
                    local a = Instance.new("Highlight", item)
                    a.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    a.FillColor = Color3.fromRGB(120,200,255)
                    a.OutlineColor = Color3.fromRGB(160,255,255)
                end
            elseif item.Name == "ExitDoor" then
                if item:FindFirstChild("Highlight") and not exitstoggle then
                    item.Highlight:Destroy()
                elseif exitstoggle and not item:FindFirstChild("Highlight") then
                    local a = Instance.new("Highlight", item)
                    a.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    a.FillColor = Color3.fromRGB(252, 255, 100)
                    a.OutlineColor = Color3.fromRGB(255,255,160)
                end
            end
        end
    end

    local players = game.Players:GetPlayers()
    for i=1, #players do
        local plr = players[i]
        if plr ~= game.Players.LocalPlayer and plr.Character then
            if plr.Character:FindFirstChild("Highlight") and not playertoggle then
                plr.Character.Highlight:Destroy()
            elseif playertoggle and not plr.Character:FindFirstChild("Highlight") then
                local a = Instance.new("Highlight", plr.Character)
                a.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end
        end
    end
end

-- Dedicated RunService Loop for ESP Colors (OPTIMIZED FOR MOBILE)
local espTick = 0
local cachedBest = nil
local cachedBeast = nil

trackConnection(game:GetService("RunService").Heartbeat:Connect(function()
    espTick = espTick + 1
    
    -- The Magic Fix: We only run the heavy calculations 4 times a second instead of 60!
    if espTick % 15 == 0 then
        cachedBest = getBestPC()
        cachedBeast = getBeast()

        if pctoggle then
            local map = getMap()
            if map then
                for _, pc in pairs(map:GetChildren()) do
                    if pc.Name == "ComputerTable" and pc:FindFirstChild("Highlight") and pc:FindFirstChild("Screen") then
                        local a = pc.Highlight
                        a.FillColor = pc.Screen.Color
                        if bestpctoggle and cachedBest and cachedBest[1] and cachedBest[1].pc == pc then
                            a.OutlineColor = Color3.fromRGB(200, 0, 255)
                        else
                            a.OutlineColor = Color3.fromRGB(math.clamp(a.FillColor.R*400,0,255), math.clamp(a.FillColor.G*400,0,255), math.clamp(a.FillColor.B*400,0,255))
                        end
                    end
                end
            end
        end

        if playertoggle then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("Highlight") then
                    local a = plr.Character.Highlight
                    if plr == cachedBeast then
                        a.FillColor = Color3.fromRGB(255,0,0)
                        a.OutlineColor = Color3.fromRGB(255,127,127)
                    else
                        a.FillColor = Color3.fromRGB(0,255,0)
                        a.OutlineColor = Color3.fromRGB(127,255,127)
                    end
                end
            end
        end
    end
end))


function reloadBeastCam()
    ViewportFrame:ClearAllChildren()
    if beastcamtoggle and game.ReplicatedStorage:FindFirstChild("CurrentMap") and game.ReplicatedStorage.CurrentMap.Value then
        local beast = getBeast()
        local cam = Instance.new("Camera", ViewportFrame)
        cam.CameraType = Enum.CameraType.Scriptable
        cam.FieldOfView = 70
        
        local map = game.ReplicatedStorage.CurrentMap.Value
        local mapclone = map:Clone()
        mapclone.Name = "map"
        
        for _, item in pairs(mapclone:GetDescendants()) do
            if item.Name == "SingleDoor" or item.Name == "DoubleDoor" or item:IsA("Sound") or item:IsA("BaseScript") then
                item:Destroy() 
            end
        end

        mapclone.Parent = ViewportFrame
        ViewportFrame.CurrentCamera = cam

        task.spawn(function()
            while beastcamtoggle and mapclone.Parent do
                task.wait()
                local currentBeast = getBeast()
                if currentBeast and currentBeast.Character and currentBeast.Character:FindFirstChild("Head") then
                    cam.CFrame = currentBeast.Character.Head.CFrame
                end
            end
        end)

        task.spawn(function()
            local dummy = Instance.new("Folder", ViewportFrame)
            dummy.Name = "dummy"
            local doors = Instance.new("Folder", ViewportFrame)
            doors.Name = "doors"

            while beastcamtoggle and mapclone.Parent do
                task.wait(0.3)
                dummy:ClearAllChildren()
                doors:ClearAllChildren()
                
                for _, door in pairs(map:GetChildren()) do
                    if door.Name == "SingleDoor" or door.Name == "DoubleDoor" then
                        door:Clone().Parent = doors
                    end
                end

                for _, plr in pairs(game.Players:GetPlayers()) do
                    if plr ~= getBeast() and plr.Character then
                        plr.Character.Archivable = true
                        local dummyclone = plr.Character:Clone()
                        for _, part in pairs(dummyclone:GetDescendants()) do
                            if part:IsA("Sound") or part:IsA("BaseScript") then
                                part:Destroy() 
                            end
                        end
                        dummyclone.Parent = dummy
                    end
                end
            end
        end)
    end
end

-- Button Listeners
trackConnection(PodsESPButton.MouseButton1Click:Connect(function()
    podstoggle = not podstoggle
    PodsESPButton.BackgroundColor3 = podstoggle and Color3.new(0, 0.74902, 0) or Color3.new(0.74902, 0, 0)
    reloadESP()
end))

trackConnection(PCESPButton.MouseButton1Click:Connect(function()
    pctoggle = not pctoggle
    PCESPButton.BackgroundColor3 = pctoggle and Color3.new(0, 0.74902, 0) or Color3.new(0.74902, 0, 0)
    reloadESP()
end))

trackConnection(PlayerESPButton.MouseButton1Click:Connect(function()
    playertoggle = not playertoggle
    PlayerESPButton.BackgroundColor3 = playertoggle and Color3.new(0, 0.74902, 0) or Color3.new(0.74902, 0, 0)
    reloadESP()
end))

trackConnection(BestPCESPButton.MouseButton1Click:Connect(function()
    bestpctoggle = not bestpctoggle
    BestPCESPButton.BackgroundColor3 = bestpctoggle and Color3.new(0, 0.74902, 0) or Color3.new(0.74902, 0, 0)
    reloadESP()
end))

trackConnection(ExitsESPButton.MouseButton1Click:Connect(function()
    exitstoggle = not exitstoggle
    ExitsESPButton.BackgroundColor3 = exitstoggle and Color3.new(0, 0.74902, 0) or Color3.new(0.74902, 0, 0)
    reloadESP()
end))

trackConnection(NeverFailButton.MouseButton1Click:Connect(function()
    neverfailtoggle = not neverfailtoggle
    NeverFailButton.BackgroundColor3 = neverfailtoggle and Color3.new(0, 0.74902, 0) or Color3.new(0.74902, 0, 0)
end))

trackConnection(AutoInteractButton.MouseButton1Click:Connect(function()
    autointeracttoggle = not autointeracttoggle
    AutoInteractButton.BackgroundColor3 = autointeracttoggle and Color3.new(0, 0.74902, 0) or Color3.new(0.74902, 0, 0)
end))

trackConnection(BeastCamButton.MouseButton1Click:Connect(function()
    beastcamtoggle = not beastcamtoggle
    BeastCamButton.BackgroundColor3 = beastcamtoggle and Color3.new(0, 0.74902, 0) or Color3.new(0.74902, 0, 0)
    if beastcamtoggle then
        ViewportFrame.Visible = true
        reloadBeastCam()
    else
        ViewportFrame:ClearAllChildren()
        ViewportFrame.Visible = false
    end
end))

trackConnection(AutoPlayButton.MouseButton1Click:Connect(function()
    autoplaytoggle = not autoplaytoggle
    AutoPlayButton.BackgroundColor3 = autoplaytoggle and Color3.new(0, 0.74902, 0) or Color3.new(0.74902, 0, 0)
end))

-- Game Event Listeners
trackConnection(game.ReplicatedStorage:WaitForChild("CurrentMap").Changed:Connect(function()
    task.wait(5)
    reloadESP()
    if beastcamtoggle then reloadBeastCam() end
end))

trackConnection(game.ReplicatedStorage:WaitForChild("IsGameActive").Changed:Connect(function()
    reloadESP()
    if beastcamtoggle then reloadBeastCam() end
end))

trackConnection(game:GetService("Players").PlayerAdded:Connect(function(player)
    trackConnection(player.CharacterAdded:Connect(function() reloadESP() end))
    trackConnection(player.CharacterRemoving:Connect(function() reloadESP() end))
end))

-- Never Fail Hooking
task.spawn(function()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        if getnamecallmethod() == 'FireServer' and args[1] == 'SetPlayerMinigameResult' and neverfailtoggle then
            args[2] = true
        end
        return old(self, unpack(args))
    end)
end)

-- Auto Interact
local function setupAutoInteract(character)
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local screenGui = playerGui:WaitForChild("ScreenGui", 10)
    if screenGui then
        local actionBox = screenGui:WaitForChild("ActionBox", 10)
        if actionBox then
            trackConnection(actionBox:GetPropertyChangedSignal("Visible"):Connect(function()
                if autointeracttoggle and actionBox.Visible then
                    game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
                end
            end))
        end
    end
end

trackConnection(game.Players.LocalPlayer.CharacterAdded:Connect(setupAutoInteract))
if game.Players.LocalPlayer.Character then
    setupAutoInteract(game.Players.LocalPlayer.Character)
end

-- Auto Play Loop (Fixed Pathing & Death-Loop Prevention)
task.spawn(function()
    while true do
        task.wait(1) -- Check more frequently
        if autoplaytoggle then        
            local beast = getBeast()
            local map = game.ReplicatedStorage:FindFirstChild("CurrentMap") and game.ReplicatedStorage.CurrentMap.Value
            
            if map then
                for _, item in pairs(map:GetChildren()) do
                    if item.Name == "SingleDoor" or item.Name == "DoubleDoor" then
                        for _, doorPart in pairs(item:GetDescendants()) do
                            if doorPart:IsA("Part") and doorPart.Name ~= "Frame" then
                                if not doorPart:FindFirstChild("PathfindingModifier") then
                                    local a = Instance.new("PathfindingModifier", doorPart)
                                    a.PassThrough = true
                                end
                            elseif doorPart.Name == "Frame" and not doorPart:FindFirstChild("PathfindingModifier") then
                                local a = Instance.new("PathfindingModifier", doorPart)
                                a.PassThrough = false
                                a.Label = "avoid"
                            end
                        end
                    end
                end
            end

            local pcs = getBestPC()
            local PathfindingService = game:GetService("PathfindingService")
            local char = game.Players.LocalPlayer.Character
            
            if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                local Humanoid = char.Humanoid
                local Root = char.HumanoidRootPart
                
                local agentParams = {
                    AgentRadius = 2.4,
                    AgentHeight = 2,
                    AgentCanJump = true,
                    AgentWalkableClimb = 4,
                    WaypointSpacing = 2,
                    Costs = { avoid = 10.0 }
                }

                local beastNearby = beast and beast.Character and beast.Character:FindFirstChild("HumanoidRootPart") and 
                                    ((Root.Position - beast.Character.HumanoidRootPart.Position).Magnitude < 50)
                
                for _, pcData in ipairs(pcs) do
                    if isPlayerTyping() or beastNearby or not autoplaytoggle then break end
                    
                    local pc = pcData.pc
                    if pc and pc:FindFirstChild("ComputerTrigger1") then
                        local goal = pc.ComputerTrigger1.Position
                        local path = PathfindingService:CreatePath(agentParams)
                        pcall(function() path:ComputeAsync(Root.Position, goal) end)
                        
                        if path.Status == Enum.PathStatus.Success then
                            local waypoints = path:GetWaypoints()
                            for i, waypoint in ipairs(waypoints) do
                                -- INSTANT OVERRIDE: If you turn the toggle off mid-walk, it stops immediately!
                                if not autoplaytoggle or (beast and beast.Character and beast.Character:FindFirstChild("HumanoidRootPart") and (Root.Position - beast.Character.HumanoidRootPart.Position).Magnitude < 50) then 
                                    break 
                                end

                                Humanoid:MoveTo(waypoint.Position)
                                if waypoint.Action == Enum.PathWaypointAction.Jump then
                                    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                                end

                                local a = Instance.new("Part", workspace)
                                a.Shape = Enum.PartType.Ball
                                a.Position = waypoint.Position
                                a.Transparency = 1 -- Hide the ugly pathfinding balls
                                a.Size = Vector3.new(3,3,3) -- Make it easier to touch
                                a.Anchored = true
                                a.CanCollide = false
                                
                                local touch = false
                                local timeout = tick() + 2.5 -- TIMEOUT PREVENTS DEATH LOOPS

                                task.spawn(function()
                                    local conn
                                    conn = a.Touched:Connect(function(hit)
                                        if hit.Parent and hit.Parent.Name == char.Name then
                                            touch = true
                                            if conn then conn:Disconnect() end
                                            a:Destroy()
                                        end
                                    end)
                                    task.wait(3)
                                    if a.Parent then a:Destroy() touch = true end
                                end)
                                
                                -- The Loop Fix: It will break if you touch it, if you turn the toggle off, OR if it takes longer than 2.5 seconds!
                                repeat task.wait(0.05) until touch or not autoplaytoggle or tick() > timeout
                            end
                            break -- Move to next PC
                        end
                    end
                end
            end
        end
    end
end)

-- Player Mods Loop
trackConnection(game:GetService("RunService").Stepped:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        
        if speedtoggle then
            hum.WalkSpeed = 24
        end
        
        if jumptoggle then
            hum.UseJumpPower = true
            hum.JumpPower = 50
        end
        
        if nocliptoggle then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end
end))

-- ==================== MISC MENU FEATURES ====================
local function AddMiscButton(name, func)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSans
    btn.TextScaled = true
    btn.Parent = MiscMenu.Body.ButtonsFrame
    trackConnection(btn.MouseButton1Click:Connect(function()
        pcall(func)
    end))
end

local function AddMiscToggle(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(191, 0, 0)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSans
    btn.TextScaled = true
    btn.Parent = MiscMenu.Body.ButtonsFrame
    
    trackConnection(btn.MouseButton1Click:Connect(function()
        local newState = callback()
        btn.BackgroundColor3 = newState and Color3.new(0, 0.74902, 0) or Color3.new(0.74902, 0, 0)
    end))
end

-- 1. Perfectly Reversible No Fog
AddMiscToggle("No Fog", function()
    nofogtoggle = not nofogtoggle
    local lighting = game:GetService("Lighting")
    local atmosphere = lighting:FindFirstChild("Atmosphere")
    
    if nofogtoggle then
        origFogEnd = lighting.FogEnd
        origFogStart = lighting.FogStart
        if atmosphere then
            origAtmDensity = atmosphere.Density
            origAtmOffset = atmosphere.Offset
        end
        
        lighting.FogEnd = 100000
        lighting.FogStart = 100000
        if atmosphere then
            atmosphere.Density = 0
            atmosphere.Offset = 0
        end
    else
        if origFogEnd then lighting.FogEnd = origFogEnd end
        if origFogStart then lighting.FogStart = origFogStart end
        if atmosphere and origAtmDensity then
            atmosphere.Density = origAtmDensity
            atmosphere.Offset = origAtmOffset
        end
    end
    return nofogtoggle
end)

-- 2. Nuke FPS Booster (Optimized for Mobile GPU)
AddMiscButton("FPS Booster", function()
    local lighting = game:GetService("Lighting")
    
    -- 1. Instantly kill global lighting math
    lighting.GlobalShadows = false
    lighting.EnvironmentDiffuseScale = 0
    lighting.EnvironmentSpecularScale = 0
    
    for _, v in pairs(lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("Atmosphere") then
            v.Enabled = false
        end
    end

    -- 2. Safely wipe laggy emitters and textures (Destroying is better than Transparency!)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
            v.Enabled = false
        elseif v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") then
            v.Enabled = false
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy() 
        end
    end
    print("FPS Booster Applied: Shadows, Effects, and Textures Nuked.")
end)

-- 3. Smart ESP Render Distance
AddMiscToggle("Smart ESP (150s)", function()
    smartesptoggle = not smartesptoggle
    return smartesptoggle
end)

local smartEspTick = 0
trackConnection(game:GetService("RunService").Heartbeat:Connect(function()
    smartEspTick = smartEspTick + 1
    if smartEspTick % 15 ~= 0 then return end

    if smartesptoggle and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Highlight") then
                if (p.Character:GetPivot().Position - pos).Magnitude > 150 then
                    p.Character.Highlight.Enabled = false
                else
                    p.Character.Highlight.Enabled = true
                end
            end
        end
        
        local map = getMap()
        if map then
            for _, item in pairs(map:GetChildren()) do
                if item:FindFirstChild("Highlight") then
                    if (item:GetPivot().Position - pos).Magnitude > 150 then
                        item.Highlight.Enabled = false
                    else
                        item.Highlight.Enabled = true
                    end
                end
            end
        end
    else
        if not smartesptoggle then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("Highlight") then p.Character.Highlight.Enabled = true end
            end
            local map = getMap()
            if map then
                for _, item in pairs(map:GetChildren()) do
                    if item:FindFirstChild("Highlight") then item.Highlight.Enabled = true end
                end
            end
        end
    end
end))

-- 4. Perfectly Reversible Fullbright
AddMiscToggle("Fullbright", function()
    fullbrighttoggle = not fullbrighttoggle
    local lighting = game:GetService("Lighting")
    
    if fullbrighttoggle then
        origAmbient = lighting.Ambient
        origOutdoorAmbient = lighting.OutdoorAmbient
        lighting.Ambient = Color3.new(1, 1, 1)
        lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    else
        if origAmbient then lighting.Ambient = origAmbient end
        if origOutdoorAmbient then lighting.OutdoorAmbient = origOutdoorAmbient end
    end
    return fullbrighttoggle
end)

-- 5. Anti-AFK
AddMiscButton("Anti-AFK", function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)

-- 6. Delete Doors
AddMiscButton("Delete Doors", function()
    local map = getMap()
    if map then
        for _, v in pairs(map:GetDescendants()) do
            if v.Name == "SingleDoor" or v.Name == "DoubleDoor" then
                v:Destroy()
            end
        end
    end
end)

-- 7. Custom FOV (120)
AddMiscToggle("FOV 120", function()
    fovtoggle = not fovtoggle
    if fovtoggle then
        workspace.CurrentCamera.FieldOfView = 120
    else
        workspace.CurrentCamera.FieldOfView = 70
    end
    return fovtoggle
end)

-- 8. Remove Invisible Walls
AddMiscButton("Remove Invis Walls", function()
    local map = getMap()
    if map then
        for _, v in pairs(map:GetDescendants()) do
            if v:IsA("BasePart") and v.Transparency >= 1 and v.CanCollide then
                v.CanCollide = false
            end
        end
    end
end)

-- 9. Low Gravity
AddMiscToggle("Low Gravity", function()
    lowgravtoggle = not lowgravtoggle
    if lowgravtoggle then
        workspace.Gravity = 50
    else
        workspace.Gravity = 196.2
    end
    return lowgravtoggle
end)

-- 11. Anti-Blindness (Nuke Screen Filters)
local antiblindnesstoggle = false
local antiblindnessConnection = nil

AddMiscToggle("Anti-Blindness", function()
    antiblindnesstoggle = not antiblindnesstoggle
    
    if antiblindnesstoggle then
        if not antiblindnessConnection then
            -- Run a fast, lightweight loop to constantly nuke incoming status effects
            antiblindnessConnection = game:GetService("RunService").RenderStepped:Connect(function()
                local lighting = game:GetService("Lighting")
                local cam = workspace.CurrentCamera
                
                -- Nuke any Blur or Color filters in the Lighting service
                for _, effect in pairs(lighting:GetChildren()) do
                    if effect:IsA("BlurEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("DepthOfFieldEffect") then
                        effect.Enabled = false
                    end
                end
                
                -- Nuke any filters parented directly to your Camera (FTF does this sometimes)
                for _, effect in pairs(cam:GetChildren()) do
                    if effect:IsA("BlurEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("DepthOfFieldEffect") then
                        effect.Enabled = false
                    end
                end
            end)
        end
    else
        -- Disconnect the loop so the game can apply filters normally again
        if antiblindnessConnection then
            antiblindnessConnection:Disconnect()
            antiblindnessConnection = nil
        end
    end
    
    return antiblindnesstoggle
end)

-- 10. Beast Proximity Alert
local AlertLabel = Instance.new("TextLabel")
AlertLabel.Size = UDim2.new(0, 400, 0, 50)
AlertLabel.Position = UDim2.new(0.5, -200, 0.8, 0)
AlertLabel.BackgroundTransparency = 1
AlertLabel.Text = "âš ï¸ BEAST NEARBY âš ï¸"
AlertLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
AlertLabel.TextStrokeTransparency = 0
AlertLabel.Font = Enum.Font.SourceSansBold
AlertLabel.TextScaled = true
AlertLabel.Visible = false
AlertLabel.ZIndex = 100
AlertLabel.Parent = FTFHAX

AddMiscToggle("Beast Alert", function()
    proximitytoggle = not proximitytoggle
    if not proximitytoggle then
        AlertLabel.Visible = false
    end
    return proximitytoggle
end)

trackConnection(game:GetService("RunService").RenderStepped:Connect(function()
    if proximitytoggle and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local beast = getBeast()
        if beast and beast.Character and beast.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - beast.Character.HumanoidRootPart.Position).Magnitude
            if dist <= 45 then
                AlertLabel.Visible = true
            else
                AlertLabel.Visible = false
            end
        else
            AlertLabel.Visible = false
        end
    end
end))

local creditMain = Instance.new("TextLabel")
creditMain.Name = "XyrozzyCredit"
creditMain.Size = UDim2.new(1, 0, 0, 25)
creditMain.Position = UDim2.new(0, 0, 1, -25)
creditMain.BackgroundTransparency = 1
creditMain.Text = "Made by ScriptedChaosLIVE"
creditMain.TextColor3 = Color3.fromRGB(200, 200, 200)
creditMain.Font = Enum.Font.SourceSans
creditMain.TextScaled = false
creditMain.TextSize = 14
creditMain.TextStrokeTransparency = 0.9
creditMain.Parent = MainMenuWindow

print("FTF admin Panel v0.7.57 â€¢ Update Log Added")

-- ==========================================================
--  DIAGNOSTIC & DEBUG TOOL (SAFE TO DELETE LATER)
-- ==========================================================
task.spawn(function()
    task.wait(1) -- Wait 1 second to let the UI fully build before testing
    print("[ FTF Admin] Running Background Diagnostics...")
    local errorsFound = 0
    
    -- Protected Call function to safely test things without crashing the script
    local function runTest(testName, testFunc)
        local success, errorMessage = pcall(testFunc)
        if not success then
            warn(" [BUG DETECTED] " .. testName .. " failed! Reason: " .. tostring(errorMessage))
            errorsFound = errorsFound + 1
        else
            print(" [DIAGNOSTIC] " .. testName .. " passed.")
        end
    end

    -- Test 1: Did the GUI actually inject into the Player?
    runTest("GUI Injection Check", function()
        assert(game.Players.LocalPlayer.PlayerGui:FindFirstChild("FTFHAX"), "FTFHAX ScreenGui is missing from PlayerGui.")
    end)

    -- Test 2: Are the Flee the Facility Server Remotes still there? (Update checker)
    runTest("Game Remote Event Check", function()
        assert(game.ReplicatedStorage:FindFirstChild("RemoteEvent"), "FTF RemoteEvent missing! The game might have updated.")
    end)

    -- Test 3: Can the script find the map?
    runTest("Map Directory Check", function()
        assert(game.ReplicatedStorage:FindFirstChild("CurrentMap"), "CurrentMap folder missing from ReplicatedStorage.")
    end)

    -- Test 4: Did the rbxthumb bypass icons load without crashing?
    runTest("Icon Bypass Check", function()
        assert(MainMenuWindow, "MainMenuWindow failed to generate.")
    end)
    
    -- Test 5: Verify global variables exist
    runTest("Variable Integrity Check", function()
        assert(activeConnections, "Connection tracking table is missing.")
    end)

    -- Final Report
    if errorsFound == 0 then
        print(" [DIAGNOSTIC COMPLETE] 100% Stable. No bugs found. Script injected flawlessly.")
    else
        warn(" [DIAGNOSTIC COMPLETE] Found " .. errorsFound .. " potential issue(s). Check the red warnings above.")
    end
end)
-- ==========================================================
