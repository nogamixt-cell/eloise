local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Settings = {
    Aimbot = false, Part = "Head", FOV = 120, FOVColor = Color3.fromRGB(200, 100, 255),
    ShowFOV = true, TeamCheck = true, Smooth = 0.25, MaxDist = 1500,
    ESP = true, Box = true, Lines = true, Health = true, Skeleton = true, Names = true, ESPTeamCheck = true,
    BoxColor = Color3.fromRGB(255, 50, 100), LineColor = Color3.fromRGB(255, 255, 255),
    HealthColor = Color3.fromRGB(0, 255, 100), SkelColor = Color3.fromRGB(255, 255, 0),
    Hitbox = false, HitboxSize = 15, Spin = false, SpinSpeed = 20,
    Fly = false, FlySpeed = 50, Speed = false, SpeedValue = 50, Noclip = false,
    Jerkoff = false,
}

local old = PlayerGui:FindFirstChild("EloiseGUI")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "EloiseGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = PlayerGui

local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0.92, 0, 0.8, 0)
menu.Position = UDim2.new(0.04, 0, 0.1, 0)
menu.BackgroundColor3 = Color3.fromRGB(18, 13, 30)
menu.BorderSizePixel = 0
menu.Visible = true
Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 14)

local topBar = Instance.new("Frame", menu)
topBar.Size = UDim2.new(1, 0, 0, 44)
topBar.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
topBar.BorderSizePixel = 0
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 16, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ELOISE GONCALVES"
title.Font = Enum.Font.GothamBlack
title.TextSize = 15
title.TextColor3 = Color3.new(1, 1, 1)
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -40, 0.5, -16)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 100)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBlack
closeBtn.TextSize = 18
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

local ball = Instance.new("TextButton", gui)
ball.Size = UDim2.new(0, 56, 0, 56)
ball.Position = UDim2.new(0, 15, 0.5, -28)
ball.BackgroundColor3 = Color3.fromRGB(180, 100, 255)
ball.BorderSizePixel = 0
ball.Text = "ELOISE"
ball.TextColor3 = Color3.new(1, 1, 1)
ball.Font = Enum.Font.GothamBlack
ball.TextSize = 10
ball.Visible = false
Instance.new("UICorner", ball).CornerRadius = UDim.new(1, 0)

local content = Instance.new("ScrollingFrame", menu)
content.Size = UDim2.new(1, -16, 1, -56)
content.Position = UDim2.new(0, 8, 0, 48)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y

local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0, 6)

local pad = Instance.new("UIPadding", content)
pad.PaddingLeft = UDim.new(0, 4)
pad.PaddingRight = UDim.new(0, 4)
pad.PaddingTop = UDim.new(0, 4)
pad.PaddingBottom = UDim.new(0, 4)

local function section(text)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.new(1, -8, 0, 24)
    f.BackgroundTransparency = 1
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, 0, 1, 0)
    l.Position = UDim2.new(0, 4, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = "--- " .. text .. " ---"
    l.Font = Enum.Font.GothamBlack
    l.TextSize = 11
    l.TextColor3 = Color3.fromRGB(180, 100, 255)
    l.TextXAlignment = Enum.TextXAlignment.Left
end

local function toggle(text, def, cb)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.new(1, -8, 0, 40)
    f.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
    f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -70, 1, 0)
    l.Position = UDim2.new(0, 14, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.GothamBold
    l.TextSize = 12
    l.TextColor3 = Color3.new(1, 1, 1)
    l.TextXAlignment = Enum.TextXAlignment.Left
    local sw = Instance.new("Frame", f)
    sw.Size = UDim2.new(0, 42, 0, 22)
    sw.Position = UDim2.new(1, -56, 0.5, -11)
    sw.BackgroundColor3 = def and Color3.fromRGB(180, 100, 255) or Color3.fromRGB(50, 45, 65)
    sw.BorderSizePixel = 0
    Instance.new("UICorner", sw).CornerRadius = UDim.new(1, 0)
    local st = def
    local btn = Instance.new("TextButton", f)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.MouseButton1Click:Connect(function()
        st = not st
        TweenService:Create(sw, TweenInfo.new(0.2), {BackgroundColor3 = st and Color3.fromRGB(180, 100, 255) or Color3.fromRGB(50, 45, 65)}):Play()
        if cb then cb(st) end
    end)
end

local function slider(text, min, max, def, cb)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.new(1, -8, 0, 50)
    f.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
    f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -90, 0, 20)
    l.Position = UDim2.new(0, 14, 0, 4)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.GothamBold
    l.TextSize = 12
    l.TextColor3 = Color3.new(1, 1, 1)
    l.TextXAlignment = Enum.TextXAlignment.Left
    local v = Instance.new("TextLabel", f)
    v.Size = UDim2.new(0, 80, 0, 20)
    v.Position = UDim2.new(1, -92, 0, 4)
    v.BackgroundTransparency = 1
    v.Text = tostring(def)
    v.Font = Enum.Font.GothamBold
    v.TextSize = 12
    v.TextColor3 = Color3.fromRGB(180, 100, 255)
    v.TextXAlignment = Enum.TextXAlignment.Right
    local bb = Instance.new("Frame", f)
    bb.Size = UDim2.new(1, -28, 0, 6)
    bb.Position = UDim2.new(0, 14, 1, -14)
    bb.BackgroundColor3 = Color3.fromRGB(50, 45, 65)
    bb.BorderSizePixel = 0
    Instance.new("UICorner", bb).CornerRadius = UDim.new(1, 0)
    local bf = Instance.new("Frame", bb)
    bf.Size = UDim2.new((def - min) / (max - min), 0, 1, 0)
    bf.BackgroundColor3 = Color3.fromRGB(180, 100, 255)
    bf.BorderSizePixel = 0
    Instance.new("UICorner", bf).CornerRadius = UDim.new(1, 0)
    local dragging = false
    local function update(x)
        local r = math.clamp((x - bb.AbsolutePosition.X) / math.max(bb.AbsoluteSize.X, 1), 0, 1)
        local n = min + (max - min) * r
        n = math.floor(n * 100 + 0.5) / 100
        v.Text = tostring(n)
        bf.Size = UDim2.new(r, 0, 1, 0)
        if cb then cb(n) end
    end
    local h = Instance.new("TextButton", bb)
    h.Size = UDim2.new(1, 0, 3, 0)
    h.Position = UDim2.new(0, 0, -1, 0)
    h.BackgroundTransparency = 1
    h.Text = ""
    h.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update(i.Position.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
            update(i.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

local function button(text, cb, color)
    local b = Instance.new("TextButton", content)
    b.Size = UDim2.new(1, -8, 0, 40)
    b.BackgroundColor3 = color or Color3.fromRGB(180, 100, 255)
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function() cb() end)
end

section("AIMBOT")
toggle("Ativar Aimbot", false, function(v) Settings.Aimbot = v end)
toggle("Team Check", true, function(v) Settings.TeamCheck = v end)
slider("Suavidade", 0.05, 1, 0.25, function(v) Settings.Smooth = v end)
slider("Tamanho FOV", 20, 500, 120, function(v) Settings.FOV = v end)

section("ESP")
toggle("Ativar ESP", true, function(v) Settings.ESP = v; if not v and clearESP then clearESP() end end)
toggle("Ignorar Time no ESP", true, function(v) Settings.ESPTeamCheck = v end)
toggle("Caixa", true, function(v) Settings.Box = v end)
toggle("Linhas", true, function(v) Settings.Lines = v end)
toggle("Barra de Vida", true, function(v) Settings.Health = v end)
toggle("Esqueleto", true, function(v) Settings.Skeleton = v end)
toggle("Nome + HP", true, function(v) Settings.Names = v end)

section("COMBATE")
toggle("Hitbox Aumentada", false, function(v) Settings.Hitbox = v end)
slider("Tamanho Hitbox", 5, 50, 15, function(v) Settings.HitboxSize = v end)
toggle("Pal do Neblu na Eloise", false, function(v) Settings.Spin = v end)
slider("Velocidade Spin", 5, 60, 20, function(v) Settings.SpinSpeed = v end)

section("MOVIMENTO")
toggle("Ativar Fly", false, function(v) Settings.Fly = v; if toggleFly then toggleFly(v) end end)
slider("Velocidade Fly", 10, 200, 50, function(v) Settings.FlySpeed = v end)
toggle("Ativar Speed", false, function(v) 
    Settings.Speed = v
    if LocalPlayer.Character then
        local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = v and Settings.SpeedValue or 16 end
    end
end)
slider("Valor Speed", 16, 200, 50, function(v) 
    Settings.SpeedValue = v
    if Settings.Speed and LocalPlayer.Character then
        local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = v end
    end
end)
toggle("Ativar Noclip", false, function(v) Settings.Noclip = v; if toggleNoclip then toggleNoclip(v) end end)

section("TROLL")
toggle("Jerkoff", false, function(v) Settings.Jerkoff = v; if toggleJerkoff then toggleJerkoff(v) end end)
button("Matar Todos", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local h = p.Character:FindFirstChildOfClass("Humanoid")
            if h then h.Health = 0 end
        end
    end
end, Color3.fromRGB(255, 50, 80))

closeBtn.MouseButton1Click:Connect(function() menu.Visible = false; ball.Visible = true end)
ball.MouseButton1Click:Connect(function() menu.Visible = true; ball.Visible = false end)

local hasDrawing = false
pcall(function() local d = Drawing.new("Circle"); d:Remove(); hasDrawing = true end)

local fovCircle
if hasDrawing then
    pcall(function()
        fovCircle = Drawing.new("Circle")
        fovCircle.Thickness = 2
        fovCircle.Filled = false
    end)
end

local function getTarget()
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local best, bestD = nil, Settings.FOV
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local h = p.Character:FindFirstChildOfClass("Humanoid")
            if h and h.Health > 0 and not (Settings.TeamCheck and p.Team == LocalPlayer.Team) then
                local part = p.Character:FindFirstChild(Settings.Part) or p.Character:FindFirstChild("Head")
                if part then
                    local dist = (part.Position - Camera.CFrame.Position).Magnitude
                    if dist <= Settings.MaxDist then
                        local sp, on = Camera:WorldToViewportPoint(part.Position)
                        if on then
                            local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                            if d < bestD then
                                bestD = d
                                best = part
                            end
                        end
                    end
                end
            end
        end
    end
    return best
end

local espData = {}
local skelPairs = {
    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
    {"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},
    {"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},
    {"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},
    {"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"}
}

function clearESP()
    for p, d in pairs(espData) do
        if d.BB then d.BB:Destroy() end
        if d.Line then d.Line:Remove() end
        for _, l in ipairs(d.Skel or {}) do l:Remove() end
    end
    espData = {}
end

local function mkESP(p)
    if not p.Character then return end
    local head = p.Character:FindFirstChild("Head")
    if not head then return end
    
    local bb = Instance.new("BillboardGui", head)
    bb.Size = UDim2.new(0, 60, 0, 80)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    
    local box = Instance.new("Frame", bb)
    box.BackgroundTransparency = 1
    box.BorderSizePixel = 2
    box.BorderColor3 = Settings.BoxColor
    box.Size = UDim2.new(1, 0, 1, 0)
    
    local hp = Instance.new("Frame", bb)
    hp.BackgroundColor3 = Settings.HealthColor
    hp.BorderSizePixel = 0
    hp.Size = UDim2.new(0, 4, 1, 0)
    hp.Position = UDim2.new(1, 4, 0, 0)
    
    local nm = Instance.new("TextLabel", bb)
    nm.BackgroundTransparency = 1
    nm.Size = UDim2.new(1, 0, 0, 15)
    nm.Position = UDim2.new(0, 0, 1, 2)
    nm.Font = Enum.Font.GothamBold
    nm.TextSize = 12
    nm.TextStrokeTransparency = 0
    nm.TextColor3 = Color3.new(1, 1, 1)
    nm.Text = p.Name
    
    local line, skel = nil, {}
    if hasDrawing then
        pcall(function() line = Drawing.new("Line"); line.Thickness = 1.5 end)
        for i = 1, #skelPairs do
            pcall(function()
                local l = Drawing.new("Line")
                l.Thickness = 1
                l.Visible = false
                skel[i] = l
            end)
        end
    end
    espData[p] = {BB = bb, Box = box, HP = hp, Nm = nm, Line = line, Skel = skel, Head = head}
end

local flyBV, flyBG
function toggleFly(on)
    if on then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            flyBV = Instance.new("BodyVelocity", hrp)
            flyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            flyBV.Velocity = Vector3.zero
            flyBG = Instance.new("BodyGyro", hrp)
            flyBG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            flyBG.P = 10000
            flyBG.CFrame = hrp.CFrame
        end
    else
        if flyBV then flyBV:Destroy(); flyBV = nil end
        if flyBG then flyBG:Destroy(); flyBG = nil end
    end
end

local ncC
function toggleNoclip(on)
    if ncC then ncC:Disconnect(); ncC = nil end
    if on then
        ncC = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, pt in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if pt:IsA("BasePart") then pt.CanCollide = false end
                end
            end
        end)
    end
end

local jkC
local originalC0 = {}
function toggleJerkoff(on)
    if jkC then jkC:Disconnect(); jkC = nil end
    if on then
        jkC = RunService.RenderStepped:Connect(function()
            if LocalPlayer.Character then
                for _, m in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if m:IsA("Motor6D") then
                        if not originalC0[m] then originalC0[m] = m.C0 end
                        m.C0 = originalC0[m] * CFrame.Angles(
                            math.random(-1, 1), 
                            math.random(-1, 1), 
                            math.random(-1, 1)
                        )
                    end
                end
            end
        end)
    else
        for m, c0 in pairs(originalC0) do
            if m.Parent then m.C0 = c0 end
        end
        originalC0 = {}
    end
end

RunService.RenderStepped:Connect(function()
    if Settings.Aimbot then
        pcall(function()
            local t = getTarget()
            if t then
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, t.Position), Settings.Smooth)
            end
        end)
    end
    
    if Settings.Spin and LocalPlayer.Character then
        pcall(function()
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(Settings.SpinSpeed), 0) end
        end)
    end
    
    if Settings.Fly and flyBV and flyBG and LocalPlayer.Character then
        pcall(function()
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local hu = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hu then
                local v = hu.MoveDirection * Settings.FlySpeed
                if hu.Jump then v = v + Vector3.new(0, Settings.FlySpeed, 0) end
                flyBV.Velocity = v
                flyBG.CFrame = Camera.CFrame
            end
        end)
    end
end)

RunService.Heartbeat:Connect(function()
    if Settings.Hitbox then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                    hrp.Transparency = 0.7
                    hrp.CanCollide = false
                end
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if not Settings.ESP then 
        clearESP() 
        return 
    end
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hu = p.Character:FindFirstChildOfClass("Humanoid")
            local head = p.Character:FindFirstChild("Head")
            local isTeammate = (p.Team == LocalPlayer.Team)
            
            if Settings.ESPTeamCheck and isTeammate then
                if espData[p] then
                    if espData[p].BB then espData[p].BB:Destroy() end
                    if espData[p].Line then espData[p].Line:Remove() end
                    for _, l in ipairs(espData[p].Skel or {}) do l:Remove() end
                    espData[p] = nil
                end
            elseif hu and hu.Health > 0 and head then
                if not espData[p] or espData[p].Head ~= head then
                    if espData[p] then
                        if espData[p].BB then espData[p].BB:Destroy() end
                        if espData[p].Line then espData[p].Line:Remove() end
                        for _, l in ipairs(espData[p].Skel or {}) do l:Remove() end
                    end
                    mkESP(p)
                end
            else
                if espData[p] then
                    if espData[p].BB then espData[p].BB:Destroy() end
                    if espData[p].Line then espData[p].Line:Remove() end
                    for _, l in ipairs(espData[p].Skel or {}) do l:Remove() end
                    espData[p] = nil
                end
            end
        end
    end
    
    for p, d in pairs(espData) do
        local hu = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
        local head = p.Character and p.Character:FindFirstChild("Head")
        if hu and hu.Health > 0 and head and d.BB and d.Box then
            d.
