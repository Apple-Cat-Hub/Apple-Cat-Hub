--[[
    🍎 Apple Cat Hub - Blox Fruits UI (Toggle có ảnh)
    Author: namggfggl30
    Toggle: RightShift
--]]

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ===== THEME =====
local C = {
    Title       = "🍎 Apple Cat Hub",
    Subtitle    = "Blox Fruit",
    Size        = UDim2.fromOffset(620, 400),
    SidebarW    = 175,

    Bg          = Color3.fromRGB(18, 12, 12),
    Sidebar     = Color3.fromRGB(12, 8, 8),
    Topbar      = Color3.fromRGB(12, 8, 8),
    Element     = Color3.fromRGB(32, 22, 22),
    Row         = Color3.fromRGB(40, 26, 26),
    RowHover    = Color3.fromRGB(52, 32, 32),
    Section     = Color3.fromRGB(26, 16, 16),
    Input       = Color3.fromRGB(24, 16, 16),

    Red         = Color3.fromRGB(255, 70, 70),
    RedSoft     = Color3.fromRGB(230, 90, 90),

    Text        = Color3.fromRGB(240, 235, 235),
    TextDim     = Color3.fromRGB(180, 165, 165),
    SubDim      = Color3.fromRGB(140, 120, 120),

    RedBorder   = Color3.fromRGB(180, 50, 50),
    SoftBorder  = Color3.fromRGB(60, 40, 40),

    Font        = Enum.Font.Gotham,
    FontBold    = Enum.Font.GothamBold,
}

-- ⭐ ID ẢNH CHO NÚT TOGGLE (thay bằng ID của bạn)
local ICON_TOGGLE_OFF = "rbxassetid://109364250143878"  -- ảnh khi tắt
local ICON_TOGGLE_ON  = "rbxassetid://109364250143878"  -- ảnh khi bật

-- ===== UTILS =====
local function new(class, props)
    local i = Instance.new(class)
    for k,v in pairs(props or {}) do i[k] = v end
    return i
end

local function corner(p, r)
    return new("UICorner", {CornerRadius = UDim.new(0, r or 4), Parent = p})
end

local function stroke(p, c, t, trans)
    return new("UIStroke", {
        Color = c or C.SoftBorder,
        Thickness = t or 1,
        Transparency = trans or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = p
    })
end

local function drag(frame, handle)
    local dragging, start, pos0
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            start = input.Position
            pos0 = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - start
            frame.Position = UDim2.new(pos0.X.Scale, pos0.X.Offset + d.X, pos0.Y.Scale, pos0.Y.Offset + d.Y)
        end
    end)
end

-- ===== BUILD =====
local function createHub()
    local gui = new("ScreenGui", {
        Name = "AppleCatHub",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = LocalPlayer:WaitForChild("PlayerGui"),
    })

    -- MAIN
    local main = new("Frame", {
        Size = C.Size,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = C.Bg,
        BorderSizePixel = 0,
        Parent = gui,
    })
    corner(main, 6)
    stroke(main, C.RedBorder, 1, 0.4)

    -- ===== TOPBAR =====
    local topbar = new("Frame", {
        Size = UDim2.new(1, 0, 0, 28),
        BackgroundColor3 = C.Topbar,
        BorderSizePixel = 0,
        Parent = main,
    })
    corner(topbar, 6)
    new("Frame", {
        Size = UDim2.new(1, 0, 0, 8),
        Position = UDim2.new(0, 0, 1, -8),
        BackgroundColor3 = C.Topbar,
        BorderSizePixel = 0,
        Parent = topbar,
    })

    new("TextLabel", {
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = C.Title .. "  •  " .. C.Subtitle,
        TextColor3 = C.Red,
        Font = C.FontBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = topbar,
    })

    drag(main, topbar)

    -- ===== SIDEBAR =====
    local sidebar = new("Frame", {
        Size = UDim2.new(0, C.SidebarW, 1, -28),
        Position = UDim2.new(0, 0, 0, 28),
        BackgroundColor3 = C.Sidebar,
        BorderSizePixel = 0,
        Parent = main,
    })
    corner(sidebar, 6)
    new("Frame", {
        Size = UDim2.new(0, 8, 1, 0),
        Position = UDim2.new(1, -8, 0, 0),
        BackgroundColor3 = C.Sidebar,
        BorderSizePixel = 0,
        Parent = sidebar,
    })

    -- Search box
    local searchWrap = new("Frame", {
        Size = UDim2.new(1, -14, 0, 24),
        Position = UDim2.new(0, 7, 0, 7),
        BackgroundColor3 = C.Element,
        BorderSizePixel = 0,
        Parent = sidebar,
    })
    corner(searchWrap, 3)
    stroke(searchWrap, C.SoftBorder, 1, 0.3)

    new("TextLabel", {
        Size = UDim2.fromOffset(14, 14),
        Position = UDim2.new(0, 5, 0.5, -7),
        BackgroundTransparency = 1,
        Text = "🔍",
        TextSize = 8,
        Parent = searchWrap,
    })
    new("TextLabel", {
        Size = UDim2.new(1, -24, 1, 0),
        Position = UDim2.new(0, 22, 0, 0),
        BackgroundTransparency = 1,
        Text = "Search section or Fun",
        TextColor3 = C.SubDim,
        Font = C.Font,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = searchWrap,
    })

    -- Thanh tab
    local tabHolder = new("Frame", {
        Size = UDim2.new(1, -8, 1, -42),
        Position = UDim2.new(0, 4, 0, 38),
        BackgroundTransparency = 1,
        Parent = sidebar,
    })

    -- ===== CONTENT =====
    local content = new("Frame", {
        Size = UDim2.new(1, -(C.SidebarW.Offset + 10), 1, -38),
        Position = UDim2.new(0, C.SidebarW.Offset + 6, 0, 36),
        BackgroundTransparency = 1,
        Parent = main,
    })

    -- Header
    local header = new("Frame", {
        Size = UDim2.new(1, 0, 0, 22),
        BackgroundColor3 = C.Section,
        BorderSizePixel = 0,
        Parent = content,
    })
    corner(header, 3)
    stroke(header, C.SoftBorder, 1, 0.3)

    new("TextLabel", {
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = "Sea Event Tab",
        TextColor3 = C.Text,
        Font = C.FontBold,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = header,
    })

    local searchIcon = new("Frame", {
        Size = UDim2.fromOffset(18, 18),
        Position = UDim2.new(1, -24, 0.5, -9),
        BackgroundColor3 = C.Element,
        BorderSizePixel = 0,
        Parent = header,
    })
    corner(searchIcon, 3)
    new("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "🔍",
        TextSize = 8,
        TextColor3 = C.TextDim,
        Parent = searchIcon,
    })

    -- Page
    local pageHolder = new("Frame", {
        Size = UDim2.new(1, 0, 1, -28),
        Position = UDim2.new(0, 0, 0, 28),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = content,
    })
    new("UIListLayout", {
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = pageHolder,
    })

    -- ===== ADD TOGGLE (có ảnh) =====
    local function addToggle(name, default)
        local on = default or false

        local row = new("Frame", {
            Size = UDim2.new(1, 0, 0, 28),
            BackgroundColor3 = C.Row,
            BorderSizePixel = 0,
            Parent = pageHolder,
        })
        corner(row, 3)
        stroke(row, C.SoftBorder, 1, 0.4)

        new("TextLabel", {
            Size = UDim2.new(1, -44, 1, 0),
            Position = UDim2.new(0, 10, 0, 0),
            BackgroundTransparency = 1,
            Text = name,
            TextColor3 = C.Text,
            Font = C.FontBold,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = row,
        })

        -- ⭐ Nút toggle có ảnh
        local btn = new("TextButton", {
            Size = UDim2.fromOffset(20, 20),
            Position = UDim2.new(1, -28, 0.5, -10),
            BackgroundColor3 = C.Element,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            Parent = row,
        })
        corner(btn, 3)
        stroke(btn, C.Red, 1)

        local icon = new("ImageLabel", {
            Size = UDim2.new(1, -2, 1, -2),
            Position = UDim2.new(0, 1, 0, 1),
            BackgroundTransparency = 1,
            Image = on and ICON_TOGGLE_ON or ICON_TOGGLE_OFF,
            ImageColor3 = on and C.Red or C.TextDim,
            ScaleType = Enum.ScaleType.Fit,
            Parent = btn,
        })

        -- Click tick
        btn.MouseButton1Click:Connect(function()
            on = not on
            icon.Image = on and ICON_TOGGLE_ON or ICON_TOGGLE_OFF
            icon.ImageColor3 = on and C.Red or C.TextDim
        end)
    end

    -- ===== DEMO TOGGLE =====
    addToggle("Teleport To Kitsune Island", false)
    addToggle("Hop Server [ Next Night or Near Full Moon > 2m ]", false)
    addToggle("Auto Spawn Kitsune Island", true)
    addToggle("Auto Summon Soul Ember", false)
    addToggle("Auto Collect Soul Ember", true)

    -- ===== TOGGLE UI =====
    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            gui.Enabled = not gui.Enabled
        end
    end)

    return gui
end

createHub()
