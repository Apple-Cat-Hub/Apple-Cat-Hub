-- ============================================================
-- APPLE CAT HUB | BLOX FRUITS
-- Core: W-Azeox | UI: Rayfield
-- ============================================================

do
    ply = game.Players
    plr = ply.LocalPlayer
    Root = plr.Character.HumanoidRootPart
    replicated = game:GetService("ReplicatedStorage")
    Lv = game.Players.LocalPlayer.Data.Level.Value
    TeleportService = game:GetService("TeleportService")
    TW = game:GetService("TweenService")
    Lighting = game:GetService("Lighting")
    Enemies = workspace.Enemies
    vim1 = game:GetService("VirtualInputManager")
    vim2 = game:GetService("VirtualUser")
    TeamSelf = plr.Team
    RunSer = game:GetService("RunService")
    Stats = game:GetService("Stats")
    Energy = plr.Character.Energy.Value
    BringConnections = {}
    BossList = {}
    MaterialList = {}
    NPCList = {}
    shouldTween = false
    SoulGuitar = false
    KenTest = true
    debug = false
    Sec = 0.1
    Num_self = 25
    Past = {"Part","SpawnLocation","Terrain","WedgePart","MeshPart"}
end

repeat local start = plr.PlayerGui:WaitForChild("Main"):WaitForChild("Loading") and game:IsLoaded() wait() until start
World1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715
World2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
World3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089

Marines = function() replicated.Remotes.CommF_:InvokeServer("SetTeam","Marines") end
Pirates = function() replicated.Remotes.CommF_:InvokeServer("SetTeam","Pirates") end

if World1 then BossList = {"The Gorilla King","Bobby","The Saw","Yeti","Mob Leader","Vice Admiral","Saber Expert","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg","Ice Admiral","Greybeard"}
elseif World2 then BossList = {"Diamond","Jeremy","Orbitus","Don Swan","Smoke Admiral","Awakened Ice Admiral","Tide Keeper","Darkbeard","Cursed Captain","Order"}
elseif World3 then BossList = {"Stone","Hydra Leader","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen","Dough King","Longma","Soul Reaper","rip_indra True Form","Tyrant of the Skies"}
end

if World1 then MaterialList = {"Leather + Scrap Metal", "Angel Wings", "Magma Ore", "Fish Tail"}
elseif World2 then MaterialList = {"Leather + Scrap Metal", "Radioactive Material", "Ectoplasm", "Mystic Droplet", "Magma Ore", "Vampire Fang"}
elseif World3 then MaterialList = {"Scrap Metal", "Demonic Wisp", "Conjured Cocoa", "Dragon Scale", "Gunpowder", "Fish Tail", "Mini Tusk"}
end

DungeonTables = {"Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Human: Buddha","Sand","Bird: Phoenix","Dough"}
local mastery1 = {"Cookie Crafter"}
local mastery2 = {"Reborn Skeleton"}

local Remotes = {
    RFJobsRemoteFunction = replicated.Modules.Net["RF/JobsRemoteFunction"], 
    RFCraft = replicated:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/Craft")
}
EquipWeapon = function(text)
    if not text then return end
    if plr.Backpack:FindFirstChild(text) then plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(text)) end
  end
  
  weaponSc = function(weapon)
    for __in, v in pairs(plr.Backpack:GetChildren()) do
      if v:IsA("Tool") then if v.ToolTip == weapon then EquipWeapon(v.Name) end end
    end
  end
  
  local Attack = {}
  Attack.Alive = function(model) if not model then return end local Humanoid = model:FindFirstChild("Humanoid") return Humanoid and Humanoid.Health > 0 end
  Attack.Pos = function(model,dist) return (Root.Position - model.Position).Magnitude <= dist end
  Attack.Dist = function(model,dist) return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude <= dist end
  Attack.DistH = function(model,dist) return (Root.Position - model:FindFirstChild("HumanoidRootPart").Position).Magnitude > dist end
  
  Attack.Kill = function(model,Succes)
    if model and Succes then
    if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
    PosMon = model:GetAttribute("Locked").Position
    BringEnemy()
    EquipWeapon(_G.SelectWeapon)
    local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if not Equipped then return end
    local ToolTip = Equipped.ToolTip
    if ToolTip == "Blox Fruit" then _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,10,0) * CFrame.Angles(0,math.rad(90),0)) else _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0) * CFrame.Angles(0,math.rad(180),0))end
    if RandomCFrame then wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30 ,0)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25)) wait(.5)_tp(model.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))end
    end
  end
  
  Attack.Kill2 = function(model,Succes)
    if model and Succes then
    if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
    PosMon = model:GetAttribute("Locked").Position
    BringEnemy()
    EquipWeapon(_G.SelectWeapon)
    local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if not Equipped then return end
    local ToolTip = Equipped.ToolTip
    if ToolTip == "Blox Fruit" then _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,10,0) * CFrame.Angles(0,math.rad(90),0)) else _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,8) * CFrame.Angles(0,math.rad(180),0))end
    end
  end
  
  Attack.KillSea = function(model,Succes)
    if model and Succes then
    if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
    PosMon = model:GetAttribute("Locked").Position
    BringEnemy()
    EquipWeapon(_G.SelectWeapon)
    local Equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if not Equipped then return end
    if Equipped.ToolTip == "Blox Fruit" then _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,10,0)) else notween(model.HumanoidRootPart.CFrame * CFrame.new(0,50,8)) wait(.85) notween(model.HumanoidRootPart.CFrame * CFrame.new(0,400,0)) wait(1) end
    end
  end
  
  Attack.Sword = function(model,Succes)
    if model and Succes then
    if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
    PosMon = model:GetAttribute("Locked").Position
    BringEnemy()
    weaponSc("Sword")
    _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
    end
  end
  
  Attack.Mas = function(model,Succes)
    if model and Succes then
    if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
    PosMon = model:GetAttribute("Locked").Position
    BringEnemy()
      if model.Humanoid.Health <= HealthM then
        _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
        Useskills("Blox Fruit","Z") Useskills("Blox Fruit","X") Useskills("Blox Fruit","C")
      else
        weaponSc("Melee")
        _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
      end
    end
  end
  
  Attack.Masgun = function(model,Succes)
    if model and Succes then
    if not model:GetAttribute("Locked") then model:SetAttribute("Locked",model.HumanoidRootPart.CFrame) end
    PosMon = model:GetAttribute("Locked").Position
    BringEnemy()
      if model.Humanoid.Health <= HealthM then
        _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,35,8))
        Useskills("Gun","Z") Useskills("Gun","X")
      else
        weaponSc("Melee")
        _tp(model.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
      end
    end
  end
  
  statsSetings = function(Num, value)
    if Num == "Melee" then if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint","Melee",value) end
    elseif Num == "Defense" then if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint","Defense",value) end
    elseif Num == "Sword" then if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint","Sword",value) end
    elseif Num == "Gun" then if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint","Gun",value) end
    elseif Num == "Devil" then if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint","Demon Fruit",value) end end
  end
  
  Useskills = function(weapon, skill)
    if weapon == "Melee" then weaponSc("Melee")
      if skill == "Z" then vim1:SendKeyEvent(true, "Z", false, game) vim1:SendKeyEvent(false, "Z", false, game)
      elseif skill == "X" then vim1:SendKeyEvent(true, "X", false, game) vim1:SendKeyEvent(false, "X", false, game)
      elseif skill == "C" then vim1:SendKeyEvent(true, "C", false, game) vim1:SendKeyEvent(false, "C", false, game) end
    elseif weapon == "Sword" then weaponSc("Sword")
      if skill == "Z" then vim1:SendKeyEvent(true, "Z", false, game) vim1:SendKeyEvent(false, "Z", false, game)
      elseif skill == "X" then vim1:SendKeyEvent(true, "X", false, game) vim1:SendKeyEvent(false, "X", false, game) end
    elseif weapon == "Blox Fruit" then weaponSc("Blox Fruit")
      if skill == "Z" then vim1:SendKeyEvent(true, "Z", false, game) vim1:SendKeyEvent(false, "Z", false, game)
      elseif skill == "X" then vim1:SendKeyEvent(true, "X", false, game) vim1:SendKeyEvent(false, "X", false, game)
      elseif skill == "C" then vim1:SendKeyEvent(true, "C", false, game) vim1:SendKeyEvent(false, "C", false, game)        
      elseif skill == "V" then vim1:SendKeyEvent(true, "V", false, game) vim1:SendKeyEvent(false, "V", false, game) end
    elseif weapon == "Gun" then weaponSc("Gun")
      if skill == "Z" then vim1:SendKeyEvent(true, "Z", false, game) vim1:SendKeyEvent(false, "Z", false, game)
      elseif skill == "X" then vim1:SendKeyEvent(true, "X", false, game) vim1:SendKeyEvent(false, "X", false, game) end
    end
    if weapon == "nil" and skill == "Y" then vim1:SendKeyEvent(true, "Y", false, game) vim1:SendKeyEvent(false, "Y", false, game) end
  end
  BringEnemy = function(Mon)
    if not _B then return end
    if not Mon then 
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local closestDist = math.huge
        for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
            local hum = enemy:FindFirstChildOfClass("Humanoid")
            local root = enemy:FindFirstChild("HumanoidRootPart")
            if hum and root and hum.Health > 0 then
                local dist = (root.Position - hrp.Position).Magnitude
                if dist < closestDist then closestDist = dist Mon = enemy end
            end
        end
        if not Mon then return end
    end
    local AreaMob = false
    local function Mobs(enemy)
        local hum = enemy:FindFirstChildOfClass("Humanoid")
        local root = enemy:FindFirstChild("HumanoidRootPart")
        return hum and root and hum.Health > 0, root, hum
    end
    local function Network(part)
        if isnetworkowner then return isnetworkowner(part) end
        return part.ReceiveAge == 0 and not part.Anchored and part.Velocity.Magnitude > 0
    end
    pcall(function()
        if sethiddenproperty then sethiddenproperty(plr, "SimulationRadius", math.huge) end
        local targetPos = Mon.HumanoidRootPart.Position
        for _, v in ipairs(workspace.Enemies:GetChildren()) do
            if v ~= Mon then
                local alive, root, hum = Mobs(v)
                if alive and v.Name == Mon.Name then
                    local distance = (root.Position - targetPos).Magnitude
                    if distance <= 3000 then
                        local bv = root:FindFirstChild("BodyVelocity")
                        if not bv then
                            bv = Instance.new("BodyVelocity")
                            bv.Name = "BodyVelocity"
                            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                            bv.Velocity = Vector3.zero
                            bv.Parent = root
                        end
                        if distance <= 10 then AreaMob = true end
                        if not AreaMob and Network(root) then root.CFrame = CFrame.new(targetPos) end
                        root.CanCollide = false hum.WalkSpeed = 0 hum.JumpPower = 0
                    end
                end
            end
        end
        if Mon and Mon:FindFirstChild("HumanoidRootPart") then
            Mon.HumanoidRootPart.CanCollide = false
            Mon.Humanoid.WalkSpeed = 0
            Mon.Humanoid.JumpPower = 0
        end
    end)
end

GetBP = function(v) return plr.Backpack:FindFirstChild(v) or plr.Character:FindFirstChild(v) end
GetIn = function(Name)
  for _ ,v1 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
    if type(v1) == "table" then if v1.Name == Name or plr.Character:FindFirstChild(Name) or plr.Backpack:FindFirstChild(Name) then return true end end
  end
  return false
end
GetM = function(Name)
  for _,tab in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
    if type(tab) == "table" then if tab.Type == "Material" then if tab.Name == Name then return tab.Count end end end
  end
  return 0
end
GetWP = function(nametool)
  for _,v4 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
    if type(v4) == "table" then if v4.Type == "Sword" then
      if v4.Name == nametool or plr.Character:FindFirstChild(nametool) or plr.Backpack:FindFirstChild(nametool) then return true end
    end end
  end
  return false
end

UpdStFruit = function()
  for z,x in next, plr.Backpack:GetChildren() do
    StoreFruit = x:FindFirstChild("EatRemote", true)
    if StoreFruit then replicated.Remotes.CommF_:InvokeServer("StoreFruit",StoreFruit.Parent:GetAttribute("OriginalName"), plr.Backpack:FindFirstChild(x.Name)) end
  end
end

collectFruits = function(Succes)
  if Succes then local Character = plr.Character
    for _,v1 in pairs(workspace:GetChildren()) do if string.find(v1.Name, "Fruit") then v1.Handle.CFrame = Character.HumanoidRootPart.CFrame end end
  end
end

Getmoon = function()
  if World1 then return Lighting.FantasySky.MoonTextureId
  elseif World2 then return Lighting.FantasySky.MoonTextureId
  elseif World3 then return Lighting.Sky.MoonTextureId end
end

DropFruits = function()
  for _,v3 in next, plr.Backpack:GetChildren() do
    if string.find(v3.Name, "Fruit") then EquipWeapon(v3.Name) wait(.1)
      if plr.PlayerGui.Main.Dialogue.Visible == true then plr.PlayerGui.Main.Dialogue.Visible = false end 
      EquipWeapon(v3.Name) plr.Character:FindFirstChild(v3.Name).EatRemote:InvokeServer("Drop")
    end
  end
  for a,b2 in pairs(plr.Character:GetChildren()) do
    if string.find(b2.Name, "Fruit") then EquipWeapon(b2.Name) wait(.1)
      if plr.PlayerGui.Main.Dialogue.Visible == true then plr.PlayerGui.Main.Dialogue.Visible = false end 
      EquipWeapon(b2.Name) plr.Character:FindFirstChild(b2.Name).EatRemote:InvokeServer("Drop")
    end
  end
end

getInfinity_Ability = function(Method, Var)
  if not Root then return end
  if Method == "Soru" and Var then
    for _,gc in next, getgc() do
      if plr.Character.Soru then
        if ((typeof(gc) == "function") and (getfenv(gc).script == plr.Character.Soru)) then
          for _, v in next, getupvalues(gc) do
            if (typeof(v) == "table") then repeat wait(Sec) v.LastUse = 0 until not Var or (plr.Character.Humanoid.Health <= 0) end
          end
        end
      end
    end    
  elseif Method == "Energy" and Var then
    plr.Character.Energy.Changed:connect(function() if Var then plr.Character.Energy.Value = Energy end end)
  elseif Method == "Observation" and Var then plr.VisionRadius.Value = math.huge end
end

Hop = function()
  pcall(function()
    for count = math.random(1, math.random(40, 75)), 100 do
      local remote = replicated.__ServerBrowser:InvokeServer(count)
      for _, v in next, remote do if tonumber(v['Count']) < 12 then TeleportService:TeleportToPlaceInstance(game.PlaceId, _) end end    
    end
  end)
end

GetConnectionEnemies = function(a)
  for i,v in pairs(replicated:GetChildren()) do
    if v:IsA("Model") and ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then return v end
  end
  for i,v in next,game.Workspace.Enemies:GetChildren() do
    if v:IsA("Model") and ((typeof(a) == "table" and table.find(a, v.Name)) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then return v end
  end
end
LowCpu = function()
    local g = game local w = g.Workspace local l = g.Lighting local t = w.Terrain
    t.WaterWaveSize = 0 t.WaterWaveSpeed = 0 t.WaterReflectance = 0 t.WaterTransparency = 0
    l.GlobalShadows = false l.FogEnd = 9e9 l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    for i, v in pairs(g:GetDescendants()) do
      if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then v.Material = "Plastic" v.Reflectance = 0
      elseif v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1
      elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Lifetime = NumberRange.new(0)
      elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then v.Enabled = false end
    end
    for i, e in pairs(l:GetChildren()) do
      if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then e.Enabled = false end
    end
  end
  
  CheckF = function() if GetBP("Dragon-Dragon") or GetBP("Gas-Gas") or GetBP("Yeti-Yeti") or GetBP("Kitsune-Kitsune") or GetBP("T-Rex-T-Rex") then return true end end
  CheckBoat = function() for i, v in pairs(workspace.Boats:GetChildren()) do if tostring(v.Owner.Value) == tostring(plr.Name) then return v end end return false end
  CheckEnemiesBoat = function() for _,v in pairs(workspace.Enemies:GetChildren()) do if (v.Name == "FishBoat") and v:FindFirstChild("Health").Value > 0 then return true end end return false end
  CheckPirateGrandBrigade = function() for _,v in pairs(workspace.Enemies:GetChildren()) do if (v.Name == "PirateGrandBrigade" or v.Name == "PirateBrigade") and v:FindFirstChild("Health").Value > 0 then return true end end return false end
  CheckShark = function() for _,v in pairs(workspace.Enemies:GetChildren()) do if v.Name == "Shark" and Attack.Alive(v) then return true end end return false end
  CheckTerrorShark = function() for _,v in pairs(workspace.Enemies:GetChildren()) do if v.Name == "Terrorshark" and Attack.Alive(v) then return true end end return false end
  CheckPiranha = function() for _,v in pairs(workspace.Enemies:GetChildren()) do if v.Name == "Piranha" and Attack.Alive(v) then return true end end return false end
  CheckFishCrew = function() for _,v in pairs(workspace.Enemies:GetChildren()) do if (v.Name == "Fish Crew Member" or v.Name == "Haunted Crew Member") and Attack.Alive(v) then return true end end return false end
  CheckHauntedCrew = function() for _,v in pairs(workspace.Enemies:GetChildren()) do if (v.Name == "Haunted Crew Member") and Attack.Alive(v) then return true end end return false end
  CheckSeaBeast = function() if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then return true end return false end
  CheckLeviathan = function() if workspace.SeaBeasts:FindFirstChild("Leviathan") then return true end return false end
  
  local gg = getrawmetatable(game)
  local old = gg.__namecall
  setreadonly(gg, false)
  gg.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}    
    if tostring(method) == "FireServer" then
      if tostring(args[1]) == "RemoteEvent" then
        if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
          if (_G.FarmMastery_G and not SoulGuitar) or (_G.FarmMastery_Dev) or (_G.SeaBeast1 or _G.FishBoat or _G.PGB or _G.Leviathan1) then
            args[2] = MousePos
            return old(unpack(args))
          end
        end
      end
    end
    return old(...)
  end)
  setreadonly(gg, true)
  local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

function getdis(a,b)
    b = b or LocalPlayer.Character.HumanoidRootPart.CFrame
    local _a = CFrame.new(a.X, b.Y, a.Z)
    local _b = CFrame.new(b.X,b.Y,b.Z)
    return (_a.Position - _b.Position).Magnitude
end

function CanBypassTeleport(x) return false end
function BypassTP(x) end
function requestentrance(pos) end

_tp = function(target)
    local gg
    if typeof(target) == "Vector3" then gg = CFrame.new(target)
    elseif typeof(target) == "CFrame" then gg = target
    else gg = target and target.CFrame end
    if not gg then return end
    local character = plr.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = character.HumanoidRootPart
    local distance = (gg.Position - rootPart.Position).Magnitude
    local tweenInfo = TweenInfo.new(distance / 300, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = gg})    
    if plr.Character.Humanoid.Sit == true then rootPart.CFrame = CFrame.new(rootPart.Position.X, gg.Y, rootPart.Position.Z) end  
    tween:Play()    
    task.spawn(function() 
        while tween.PlaybackState == Enum.PlaybackState.Playing do 
            if not shouldTween then tween:Cancel() break end 
            task.wait(0.1) 
        end 
    end)
    return tween
end

old_tp = function(p) 
    local char = plr.Character
    if char and char:FindFirstChild("HumanoidRootPart") then char.HumanoidRootPart.CFrame = p end
end

notween = function(p) 
  if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
    plr.Character.HumanoidRootPart.CFrame = p 
  end
end

TeleportToTarget = function(targetCFrame) _tp(targetCFrame) end

local Quests = require(game:GetService("ReplicatedStorage"):WaitForChild("Quests"))
local GuideModule = require(game:GetService("ReplicatedStorage"):WaitForChild("GuideModule"))
local blacklistquest = {"MarineQuest","BartiloQuest","CitizenQuest","Trainees"}

CheckSea = function(b)
    if (game.PlaceId == 2753915549 or game.PlaceId == 85211729168715) and b == 1 then return true
    elseif (game.PlaceId == 4442272183 or game.PlaceId == 79091703265657) and b == 2 then return true
    elseif (game.PlaceId == 7449423635 or game.PlaceId == 100117331123089) and b == 3 then return true end
    return false
end

GetQuestPointFromNPC = function(npcName)
    for _, npc in pairs(workspace.NPCs:GetChildren()) do
        if npc.Name == npcName and npc:FindFirstChild("HumanoidRootPart") then return npc.HumanoidRootPart.CFrame end
    end
    for _, npc in pairs(replicated.NPCs:GetChildren()) do
        if npc.Name == npcName and npc:FindFirstChild("HumanoidRootPart") then return npc.HumanoidRootPart.CFrame end
    end
    return nil
end

GetQuests = function()
    local lvl = plr.Data.Level.Value
    local LevelReq = 0
    local mmb = {}
    if lvl >= 700 and CheckSea(1) then
        mmb["Mob"] = "Galley Captain" mmb["NameQuest"] = "FountainQuest" mmb["ID"] = 2 mmb["LevelReq"] = 700
    elseif lvl >= 1500 and CheckSea(2) then
        mmb["Mob"] = "Water Fighter" mmb["NameQuest"] = "ForgottenQuest" mmb["ID"] = 2 mmb["LevelReq"] = 1450
    else
        for r, v in pairs(Quests) do
            for id, v1 in pairs(v) do
                local LvReq = v1.LevelReq
                for nguoi, tinh in pairs(v1.Task) do
                    if lvl >= LvReq and LevelReq <= LvReq and v1.Task[nguoi] > 1 and not table.find(blacklistquest, r) then
                        LevelReq = LvReq
                        mmb["Mob"] = nguoi mmb["NameQuest"] = r mmb["ID"] = id mmb["LevelReq"] = LvReq
                    end
                end
            end
        end
    end
    return mmb
end

GetQuestPoint = function()
    if GuideModule and GuideModule.Data and GuideModule.Data.LastClosestNPC then
        return GetQuestPointFromNPC(GuideModule.Data.LastClosestNPC)
    end
    return nil
end

QuestNeta = function()
    local questData = GetQuests()
    return {[1] = questData.Mob, [2] = questData.ID, [3] = questData.NameQuest, [4] = questData.LevelReq, [5] = questData.Mob, [6] = GetQuestPoint()}
end
spawn(function()
    while task.wait() do
      pcall(function()
        if _G.Level or _G.AutoFarmNear or _G.AutoFarmChest or _G.Auto_Cake_Prince or _G.AutoFarm_Bone 
           or _G.FarmEliteHunt or _G.AutoFarmIsland or _G.AutoKillMob or _G.AutoFarmMaterials 
           or _G.AutoDoughKing or _G.AutoAttackDoughKing or _G.AutoRipIngay or _G.FarmTyrant 
           or _G.AutoFactory or _G.AutoRaidCastle or _G.AutoEctoplasm or _G.AutoBerry or _G.AutoBerryH 
           or _G.AutoFarmDungeon or _G.Raiding or _G.TpPly or _G.TPNpc or _G.TwFruits 
           or _G.FindMirage or _G.AutofindKitIs or _G.Prehis_Find or _G.SailBoats or _G.SailBoat_Hydra 
           or _G.AutoStartPrehistoric or _G.FrozenTP or _G.AutoMysticIsland or _G.HighestMirage or _G.FarmChestM then
          shouldTween = true
          if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if not plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
              local Noclip = Instance.new("BodyVelocity")
              Noclip.Name = "BodyClip"
              Noclip.Parent = plr.Character.HumanoidRootPart
              Noclip.MaxForce = Vector3.new(100000,100000,100000)
              Noclip.Velocity = Vector3.new(0,0,0)
            end        
            for _, no in pairs(plr.Character:GetDescendants()) do if no:IsA("BasePart") then no.CanCollide = false end end
          end
        else
          shouldTween = false
          if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then plr.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy() end
          end
        end
      end)
    end
  end)
  
  spawn(function()
    while task.wait(Sec) do
      pcall(function()
        if _G.Level then
          local char = plr.Character
          if not char then return end
          local Root = char:FindFirstChild("HumanoidRootPart")
          if not Root then return end
          local questData = QuestNeta()
          if not questData or not questData[1] then return end
          local questUI = plr.PlayerGui.Main.Quest
          local QuestTitle = questUI.Visible and questUI.Container.QuestTitle.Title.Text or ""
          if questUI.Visible and not string.find(QuestTitle, questData[1]) then
            replicated.Remotes.CommF_:InvokeServer("AbandonQuest") task.wait(0.2) return
          end
          if not questUI.Visible then
            local questPos = questData[6]
            if questPos then
              _tp(questPos) task.wait(2)
              if (Root.Position - questPos.Position).Magnitude <= 10 then
                pcall(function() replicated.Remotes.CommF_:InvokeServer("StartQuest", questData[3], questData[2]) end)
                task.wait(1)
              end
            end
            return
          end
          local enemyName = questData[1]
          for _, v in pairs(workspace.Enemies:GetChildren()) do
            if v.Name == enemyName and Attack.Alive(v) then
              repeat
                task.wait(Sec)
                _tp(v.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                Attack.Kill(v, _G.Level)
                if not questUI.Visible then break end
              until not _G.Level or not v.Parent or v.Humanoid.Health <= 0
              break
            end
          end
        end
      end)
    end
  end)
  
  spawn(function()
    while wait() do
      pcall(function()
        if _G.AutoFarmNear then
          for i,v in pairs(workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
              if v.Humanoid.Health > 0 then
                repeat wait() Attack.Kill(v,_G.AutoFarmNear) until not _G.AutoFarmNear or not v.Parent or v.Humanoid.Health <= 0
              end
            end
          end
        end
      end)
    end
  end)
  
  spawn(function()
    while wait(Sec) do
      pcall(function()
        if _G.AutoFactory then
          local v = GetConnectionEnemies("Core")
          if v then repeat wait() EquipWeapon(_G.SelectWeapon) _tp(CFrame.new(448.46756, 199.356781, -441.389252)) until v.Humanoid.Health <= 0 or _G.AutoFactory == false
          else _tp(CFrame.new(448.46756, 199.356781, -441.389252)) end
        end
      end)
    end
  end)
  
  spawn(function()
    while wait(Sec) do
      if _G.AutoRaidCastle then
        pcall(function()
          local CFrameCastleRaid = CFrame.new(-5496.17432, 313.768921, -2841.53027)
          if (CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 500 then
            for i,v in pairs(workspace.Enemies:GetChildren()) do
              if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 2000 then
                  repeat wait() Attack.Kill(v,_G.AutoRaidCastle) until not _G.AutoRaidCastle or not v.Parent or v.Humanoid.Health <= 0
                end
              end
            end
          else _tp(CFrameCastleRaid) end
        end)
      end
    end
  end)
  
  spawn(function()
    while wait(Sec) do
      pcall(function()
        if _G.AutoEctoplasm then
          local EctoTable = {"Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer","Arctic Warrior"}    
          local v = GetConnectionEnemies(EctoTable)
          if Attack.Alive(v) then repeat wait() Attack.Kill(v, _G.AutoEctoplasm) until not _G.AutoEctoplasm or not v.Parent or v.Humanoid.Health <= 0
          else replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125)) end
        end
      end)
    end
  end)
  
  spawn(function()
    while wait(Sec) do
      if _G.AutoFarmChest then
        pcall(function()
          local CollectionService = game:GetService("CollectionService")
          local Character = plr.Character or plr.CharacterAdded:Wait()                
          if not Character then return end                
          local Position = Character:GetPivot().Position
          local Chests = CollectionService:GetTagged("_ChestTagged")      
          local Distance, Nearest = math.huge, nil  
          for i = 1, #Chests do
            local Chest = Chests[i]
            local Magnitude = (Chest:GetPivot().Position - Position).Magnitude        
            if not Chest:GetAttribute("IsDisabled") and Magnitude < Distance then Distance = Magnitude Nearest = Chest end
          end
          if Nearest then _tp(Nearest:GetPivot()) end
        end)
      end
    end
  end)
  
  spawn(function()
    while wait(Sec) do
      if _G.AutoBerry then
        pcall(function()
          local BerryBush = game:GetService("CollectionService"):GetTagged("BerryBush")      
          for i = 1, #BerryBush do
            local Bush = BerryBush[i]        
            for AttributeName, BerryName in pairs(Bush:GetAttributes()) do
              if not BerryArray or table.find(BerryArray, BerryName) then           
                _tp(Bush.Parent:GetPivot())
                for j = 1, #BerryBush do
                  local Bush2 = BerryBush[j]        
                  for _, BerryChild in pairs(Bush2:GetChildren()) do
                    if not BerryArray or table.find(BerryArray, BerryChild.Name) then
                      _tp(BerryChild.WorldPivot)
                      fireproximityprompt(BerryChild.ProximityPrompt,math.huge)
                    end
                  end
                end      
              end
            end
          end      
        end)
      end
    end
  end)
  
  spawn(function()
    while wait() do
      if _G.AutoKillMob then
        pcall(function()
          if game:GetService("Workspace").Enemies:FindFirstChild(getgenv().SelectMob) then
            for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
              if v.Name == getgenv().SelectMob then
                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then                                
                  repeat game:GetService("RunService").Heartbeat:Wait() Attack.Kill(v,_G.AutoKillMob) until not _G.AutoKillMob or not v.Parent or v.Humanoid.Health <= 0                                
                end
              end
            end
          end
        end)
      end
    end
  end)
  spawn(function()
    while wait(1) do
      pcall(function()
        if _G.FarmEliteHunt then
          local questGui = plr.PlayerGui.Main.Quest
          local questTitle = questGui.Container.QuestTitle.Title.Text
          if not questGui.Visible then
            local result = replicated.Remotes.CommF_:InvokeServer("EliteHunter")
            if result == nil or string.find(result, "Cooldown") then wait(10) return end
            task.wait(1)
          else
            local eliteName = nil
            for _, name in pairs({"Diablo", "Urban", "Deandre"}) do
              if string.find(questTitle, name) then eliteName = name break end
            end
            if eliteName then
              local boss = nil
              for _, v in pairs(Enemies:GetChildren()) do if v.Name == eliteName and Attack.Alive(v) then boss = v break end end
              if boss and boss:FindFirstChild("HumanoidRootPart") then
                _tp(boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                repeat wait() Attack.Kill(boss, _G.FarmEliteHunt) until not _G.FarmEliteHunt or not boss.Parent or boss.Humanoid.Health <= 0 or not questGui.Visible
              end
            end
          end
        end
      end)
    end
  end)
  
  spawn(function()
      while task.wait() do
          if _G.Auto_Cake_Prince and not _G.AutoRaidCastle then
              pcall(function()
                  local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                  local questUI = plr.PlayerGui.Main.Quest
                  local enemies = workspace.Enemies
                  local cakeMap = workspace.Map:FindFirstChild("CakeLoaf")
                  local bigMirror = cakeMap and cakeMap:FindFirstChild("BigMirror")
                  if not root then return end
                  if _G.AcceptQuestC and questUI and not questUI.Visible then
                      local questPos = CFrame.new(-1927.92, 37.8, -12842.54)
                      _tp(questPos)
                      while (questPos.Position - root.Position).Magnitude > 50 do task.wait(0.2) end
                      local questData = {{"StartQuest", "CakeQuest2", 2},{"StartQuest", "CakeQuest2", 1},{"StartQuest", "CakeQuest1", 1},{"StartQuest", "CakeQuest1", 2}}
                      pcall(function() game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(questData[math.random(1, 4)])) end)
                  end
                  if not cakeMap then _tp(CFrame.new(-2077, 252, -12373)) task.wait(2) return end
                  if bigMirror and (bigMirror.Other.Transparency == 0 or enemies:FindFirstChild("Cake Prince")) then
                      local boss = GetConnectionEnemies("Cake Prince")
                      if boss then repeat task.wait() Attack.Kill2(boss, _G.Auto_Cake_Prince) until not _G.Auto_Cake_Prince or not boss.Parent or boss.Humanoid.Health <= 0
                      else _tp(CFrame.new(-2151.82, 149.32, -12404.91)) end
                  else
                      local CakeMobs = {"Cookie Crafter","Cake Guard","Baking Staff","Head Baker"}
                      local mob = GetConnectionEnemies(CakeMobs)
                      if mob then repeat task.wait() Attack.Kill(mob, _G.Auto_Cake_Prince) until not _G.Auto_Cake_Prince or not mob.Parent or mob.Humanoid.Health <= 0
                      else _tp(CFrame.new(-2077, 252, -12373)) end
                  end
              end)
          end
      end
  end)
  
  spawn(function()
      local BonesTable = {"Reborn Skeleton","Living Zombie","Demonic Soul","Possessed Mummy"}
      while wait(0.5) do
          if _G.AutoFarm_Bone then
            pcall(function()
              local bone = GetConnectionEnemies(BonesTable)
              if bone then repeat wait() Attack.Kill(bone, true) until not _G.AutoFarm_Bone or not bone.Parent or bone.Humanoid.Health <= 0
              else _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) end
            end)
          end
      end
  end)
  
  spawn(function()
    while wait(Sec) do
      pcall(function()
        if _G.AutoRipIngay then
          local v = GetConnectionEnemies("rip_indra")
          if not GetWP("Dark Dagger") or not GetIn("Valkyrie") and v then
            repeat wait() Attack.Kill(v,_G.AutoRipIngay) until not _G.AutoRipIngay or not v.Parent or v.Humanoid.Health <= 0
          else
            replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-5097.93164, 316.447021, -3142.66602))
            wait(.1)_tp(CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781))
          end
        end
      end)
    end
  end)
  
  spawn(function()
    while wait(Sec) do
      if _G.FarmMastery_Dev then
        pcall(function()
          if SelectIsland == "Cake" then         
            local v = GetConnectionEnemies(mastery1)
            if v then HealthM = v.Humanoid.MaxHealth * 70 / 100
              repeat wait() MousePos = v.HumanoidRootPart.Position Attack.Mas(v,_G.FarmMastery_Dev) until _G.FarmMastery_Dev == false or v.Humanoid.Health <= 0 or not v.Parent
            else _tp(CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375)) end
          elseif SelectIsland == "Bone" then
            local v = GetConnectionEnemies(mastery2)
            if v then HealthM = v.Humanoid.MaxHealth * 70 / 100
              repeat wait() MousePos = v.HumanoidRootPart.Position Attack.Mas(v,_G.FarmMastery_Dev) until _G.FarmMastery_Dev == false or v.Humanoid.Health <= 0 or not v.Parent
            else _tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)) end
          end
        end)
      end
    end
  end)
  
  spawn(function()
    while wait(Sec) do
      if _G.FarmMastery_G then
        pcall(function()
          local targetMob = SelectIsland == "Cake" and mastery1 or mastery2
          local v = GetConnectionEnemies(targetMob)
          if v then
            HealthM = v.Humanoid.MaxHealth * 70 / 100
            repeat wait()
              MousePos = v.HumanoidRootPart.Position
              Attack.Masgun(v,_G.FarmMastery_G)
              local RE_ShootGunEvent = replicated.Modules.Net["RE/ShootGunEvent"]
              if plr.Character:FindFirstChildOfClass("Tool") then
                if plr.Character:FindFirstChildOfClass("Tool").Name == 'Skull Guitar' then
                  SoulGuitar = true
                  plr.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)
                else
                  SoulGuitar = false
                  RE_ShootGunEvent:FireServer(MousePos, { v.HumanoidRootPart })
                end
                vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1) wait(0.05)
                vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1) wait(0.05)
              end
            until _G.FarmMastery_G == false or v.Humanoid.Health <= 0 or not v.Parent
            SoulGuitar = false
          else
            _tp(SelectIsland == "Cake" and CFrame.new(-1943.676513671875, 251.5095672607422, -12337.880859375) or CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
          end
        end)
      end
    end
  end)
  
  spawn(function()
    while wait(Sec) do
      pcall(function()
        if Boud then if not plr.Character:FindFirstChild("HasBuso") then replicated.Remotes.CommF_:InvokeServer("Buso") end end
      end)
    end
  end)
  
  spawn(function()
    while task.wait(Sec) do
      pcall(function()
        if _G.Safemode then
            local Calc_Health = plr.Character.Humanoid.Health / plr.Character.Humanoid.MaxHealth * 100
            if Calc_Health < Num_self then shouldTween=true _tp(plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,500,0)) else shouldTween=false end
        end
      end)
    end
  end)
  
  spawn(function()
      local vu = game:GetService("VirtualUser")
      repeat wait() until game:IsLoaded()
      game:GetService("Players").LocalPlayer.Idled:Connect(function()
          vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
          wait(1)
          vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
      end)
  end)
  
  task.spawn(function()
    RunSer.Heartbeat:Connect(function()
      pcall(function()      
        if not _G.Seriality then return end      
        local Pretool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if not Pretool then return end
        if Pretool.ToolTip == "Blox Fruit" then
          local LeftClickRemote = Pretool:FindFirstChild('LeftClickRemote')
          if LeftClickRemote then 
            LeftClickRemote:FireServer(Vector3.new(0.01,-500,0.01),1,true)
            LeftClickRemote:FireServer(false)
          end
        end      
      end)
    end)
  end)
  
  spawn(function()
    while task.wait(0.5) do
      pcall(function()
        if _G.ChooseWP == "Melee" then for _,v in pairs(plr.Backpack:GetChildren()) do if v.ToolTip == "Melee" then _G.SelectWeapon = v.Name end end
        elseif _G.ChooseWP == "Sword" then for _,v in pairs(plr.Backpack:GetChildren()) do if v.ToolTip == "Sword" then _G.SelectWeapon = v.Name end end
        elseif _G.ChooseWP == "Gun" then for _,v in pairs(plr.Backpack:GetChildren()) do if v.ToolTip == "Gun" then _G.SelectWeapon = v.Name end end
        elseif _G.ChooseWP == "Blox Fruit" then for _,v in pairs(plr.Backpack:GetChildren()) do if v.ToolTip == "Blox Fruit" then _G.SelectWeapon = v.Name end end end
      end)
    end
  end)
  
  spawn(function()
    while task.wait(1) do
      if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then Root = plr.Character.HumanoidRootPart end
    end
  end)
  function isnil(thing) return (thing == nil) end
local function round(n) return math.floor(tonumber(n) + 0.5) end
Number = math.random(1, 1000000)

EspPly = function()
  for _,v in next, game.Players:GetChildren() do
    pcall(function()
      if not isnil(v.Character) then
        if PlayerEsp then
          if not isnil(v.Character.Head) and not v.Character.Head:FindFirstChild('NameEsp'..Number) then
            local bill = Instance.new('BillboardGui',v.Character.Head)
            bill.Name = 'NameEsp'..Number
            bill.ExtentsOffset = Vector3.new(0, 1, 0)
            bill.Size = UDim2.new(1,200,1,30)
            bill.Adornee = v.Character.Head
            bill.AlwaysOnTop = true
            local name = Instance.new('TextLabel',bill)
            name.Font = Enum.Font.Code
            name.FontSize = "Size14"
            name.TextWrapped = true
            name.Text = (v.Name ..' \n'.. round((plr.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' M')
            name.Size = UDim2.new(1,0,1,0)
            name.TextYAlignment = 'Top'
            name.BackgroundTransparency = 1
            name.TextStrokeTransparency = 0.5
            if v.Team == TeamSelf then name.TextColor3 = Color3.new(0,0,254)
            else name.TextColor3 = Color3.new(255,0,0) end
          else
            if v.Character.Head:FindFirstChild('NameEsp'..Number) then
              v.Character.Head['NameEsp'..Number].TextLabel.Text = (v.Name ..' | '.. round((plr.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' M\nHealth : ' .. round(v.Character.Humanoid.Health*100/v.Character.Humanoid.MaxHealth) .. '%')
            end
          end
        else
          if v.Character.Head:FindFirstChild('NameEsp'..Number) then
            v.Character.Head:FindFirstChild('NameEsp'..Number):Destroy()
          end
        end
      end
    end)
  end
end

LocationEsp = function() 
  for _,v in next, workspace["_WorldOrigin"].Locations:GetChildren() do
    pcall(function()
      if IslandESP then 
        if (v.Name ~= "Sea") then
          if not v:FindFirstChild('NameEsp') then
            local bill = Instance.new('BillboardGui',v)
            bill.Name = 'NameEsp'
            bill.ExtentsOffset = Vector3.new(0, 1, 0)
            bill.Size = UDim2.new(1,200,1,30)
            bill.Adornee = v
            bill.AlwaysOnTop = true
            local name = Instance.new('TextLabel',bill)
            name.Font = Enum.Font.Code
            name.FontSize = "Size14"
            name.TextWrapped = true
            name.Size = UDim2.new(1,0,1,0)
            name.TextYAlignment = 'Top'
            name.BackgroundTransparency = 1
            name.TextStrokeTransparency = 0.5
            name.TextColor3 = Color3.fromRGB(98,252,252)
            name.Text = (v.Name ..'   \n'.. round((plr.Character.Head.Position - v.Position).Magnitude/3) ..' M')
          else
            v['NameEsp'].TextLabel.Text = (v.Name ..'   \n'.. round((plr.Character.Head.Position - v.Position).Magnitude/3) ..' M')
          end
        end
      else
        if v:FindFirstChild('NameEsp') then v:FindFirstChild('NameEsp'):Destroy() end
      end
    end)
  end
end

DevEsp = function()
  for i,v in next, workspace:GetChildren() do
    pcall(function()
      if DevilFruitESP then
        if string.find(v.Name, "Fruit") then   
          if not v.Handle:FindFirstChild('NameEsp'..Number) then
            local bill = Instance.new('BillboardGui',v.Handle)
            bill.Name = 'NameEsp'..Number
            bill.ExtentsOffset = Vector3.new(0, 1, 0)
            bill.Size = UDim2.new(1,200,1,30)
            bill.Adornee = v.Handle
            bill.AlwaysOnTop = true
            local name = Instance.new('TextLabel',bill)
            name.Font = Enum.Font.Code
            name.FontSize = "Size14"
            name.TextWrapped = true
            name.Size = UDim2.new(1,0,1,0)
            name.TextYAlignment = 'Top'
            name.BackgroundTransparency = 1
            name.TextStrokeTransparency = 0.5
            name.TextColor3 = Color3.fromRGB(255,255,255)
            name.Text = (v.Name ..' \n'.. round((plr.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
          else
            v.Handle['NameEsp'..Number].TextLabel.Text = ('[' ..v.Name ..']' ..'   \n'.. round((plr.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
          end
        end
      else
        if v:FindFirstChild('Handle') and v.Handle:FindFirstChild('NameEsp'..Number) then
          v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
        end
      end
    end)
  end
end

flowerEsp = function()
  for i,v in pairs(workspace:GetChildren()) do
    pcall(function()
      if v.Name == "Flower2" or v.Name == "Flower1" then
        if FlowerESP then 
          if not v:FindFirstChild('NameEsp'..Number) then
            local bill = Instance.new('BillboardGui',v)
            bill.Name = 'NameEsp'..Number
            bill.ExtentsOffset = Vector3.new(0, 1, 0)
            bill.Size = UDim2.new(1,200,1,30)
            bill.Adornee = v
            bill.AlwaysOnTop = true
            local name = Instance.new('TextLabel',bill)
            name.Font = Enum.Font.Code
            name.FontSize = "Size14"
            name.TextWrapped = true
            name.Size = UDim2.new(1,0,1,0)
            name.TextYAlignment = 'Top'
            name.BackgroundTransparency = 1
            name.TextStrokeTransparency = 0.5
            name.TextColor3 = Color3.fromRGB(88, 214, 252)
            if v.Name == "Flower1" then name.Text = ("Blue Flower" ..' \n'.. round((plr.Character.Head.Position - v.Position).Magnitude/3) ..' M')
            elseif v.Name == "Flower2" then name.Text = ("Red Flower" ..' \n'.. round((plr.Character.Head.Position - v.Position).Magnitude/3) ..' M') end
          else
            v['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((plr.Character.Head.Position - v.Position).Magnitude/3) ..' M')
          end
        else
          if v:FindFirstChild('NameEsp'..Number) then v:FindFirstChild('NameEsp'..Number):Destroy() end
        end
      end   
    end)
  end
end

EventIslandEsp = function()
  for i, v in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
    pcall(function()
      if EspEventIsland then
        if (v.Name == "Mirage Island" or v.Name =="Prehistoric Island" or v.Name =="Kitsune Island") then
          if not v:FindFirstChild("NameEsp") then
            local bill = Instance.new("BillboardGui", v)
            bill.Name = "NameEsp"
            bill.ExtentsOffset = Vector3.new(0, 1, 0)
            bill.Size = UDim2.new(1, 200, 1, 30)
            bill.Adornee = v
            bill.AlwaysOnTop = true
            local name = Instance.new("TextLabel", bill)
            name.Font = "Code"
            name.FontSize = "Size14"
            name.TextWrapped = true
            name.Size = UDim2.new(1, 0, 1, 0)
            name.TextYAlignment = "Top"
            name.BackgroundTransparency = 1
            name.TextStrokeTransparency = 0.5
            name.TextColor3 = Color3.fromRGB(80, 245, 245)
            name.Text = (v.Name .. "   \n" .. round((plr.Character.Head.Position - v.Position).Magnitude / 3) .. " M")
          else
            v.NameEsp.TextLabel.Text = v.Name .. "   \n" .. round((plr.Character.Head.Position - v.Position).Magnitude / 3) .. " M"
          end
        end
      else
        if v:FindFirstChild("NameEsp") then v:FindFirstChild("NameEsp"):Destroy() end
      end
    end)
  end
end

gearEsp = function()
  for _,v in pairs(workspace.Map.MysticIsland:GetDescendants()) do
    pcall(function()
      if ESPGear then
        if v.Name == "Part" and v.Material == Enum.Material.Neon then
          if not v:FindFirstChild("NameEsp") then
            local bill = Instance.new("BillboardGui", v)
            bill.Name = "NameEsp"
            bill.ExtentsOffset = Vector3.new(0, 1, 0)
            bill.Size = UDim2.new(1, 200, 1, 30)
            bill.Adornee = v
            bill.AlwaysOnTop = true
            local name = Instance.new("TextLabel", bill)
            name.Font = "Code"
            name.FontSize = "Size14"
            name.TextWrapped = true
            name.Size = UDim2.new(1, 0, 1, 0)
            name.TextYAlignment = "Top"
            name.BackgroundTransparency = 1
            name.TextStrokeTransparency = 0.5
            name.TextColor3 = Color3.fromRGB(80, 245, 245)
            name.Text = ("Gear" .."   \n" .. round((plr.Character.Head.Position - v.Position).Magnitude / 3).. " M")
          else
            v["NameEsp"].TextLabel.Text =("Gear" .."   \n" .. round((plr.Character.Head.Position - v.Position).Magnitude / 3).. " M")
          end
        end
      else
        if v:FindFirstChild("NameEsp") then v:FindFirstChild("NameEsp"):Destroy() end
      end
    end)
  end
end

AdvanFruitEsp = function()
  if advanEsp then     
    for _,v in pairs(replicated.NPCs:GetChildren()) do
      if v.Name == "Advanced Fruit Dealer" then
        if not workspace:FindFirstChild("Adv") then
          Adv = Instance.new("Part")
          Adv.Name = "Adv"
          Adv.Transparency = 1
          Adv.Size = Vector3.new(1,1,1)
          Adv.Anchored = true
          Adv.CanCollide = false
          Adv.Parent = workspace
          Adv.CFrame = v.HumanoidRootPart.CFrame    
        elseif workspace:FindFirstChild("Adv") then
          if not Adv:FindFirstChild("NameEsp") then
            local bill = Instance.new("BillboardGui", Adv)
            bill.Name = "NameEsp"
            bill.ExtentsOffset = Vector3.new(0, 1, 0)
            bill.Size = UDim2.new(1, 200, 1, 30)
            bill.Adornee = Adv
            bill.AlwaysOnTop = true
            local name = Instance.new("TextLabel", bill)
            name.Font = "Code"
            name.FontSize = "Size14"
            name.TextWrapped = true
            name.Size = UDim2.new(1, 0, 1, 0)
            name.TextYAlignment = "Top"
            name.BackgroundTransparency = 1
            name.TextStrokeTransparency = 0.5
            name.TextColor3 = Color3.fromRGB(80, 245, 245)
            name.Text = (v.Name .."   \n" ..round((plr.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude /3) .." M")
          else
            Adv["NameEsp"].TextLabel.Text = (v.Name .."   \n" ..round((plr.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude /3) .." M")    
          end                              
        end
      end
    end
  else
    if workspace:FindFirstChild("Adv") then workspace:FindFirstChild("Adv"):Destroy() end    
  end
end

HakiClorEsp = function()
  if ColorEsp then     
    for _,v in pairs(replicated.NPCs:GetChildren()) do
      if v.Name == "Barista Cousin" then
        if not workspace:FindFirstChild("Gay") then
          Gay = Instance.new("Part")
          Gay.Name = "Gay"
          Gay.Transparency = 1
          Gay.Size = Vector3.new(1,1,1)
          Gay.Anchored = true
          Gay.CanCollide = false
          Gay.Parent = workspace
          Gay.CFrame = v.HumanoidRootPart.CFrame    
        elseif workspace:FindFirstChild("Gay") then
          if not Gay:FindFirstChild("NameEsp") then
            local bill = Instance.new("BillboardGui", Gay)
            bill.Name = "NameEsp"
            bill.ExtentsOffset = Vector3.new(0, 1, 0)
            bill.Size = UDim2.new(1, 200, 1, 30)
            bill.Adornee = Gay
            bill.AlwaysOnTop = true
            local name = Instance.new("TextLabel", bill)
            name.Font = "Code"
            name.FontSize = "Size14"
            name.TextWrapped = true
            name.Size = UDim2.new(1, 0, 1, 0)
            name.TextYAlignment = "Top"
            name.BackgroundTransparency = 1
            name.TextStrokeTransparency = 0.5
            name.TextColor3 = Color3.fromRGB(80, 245, 245)
            name.Text = (v.Name .."   \n" ..round((plr.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude /3) .." M")
          else
            Gay["NameEsp"].TextLabel.Text = (v.Name .."   \n" ..round((plr.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude /3) .." M")    
          end                              
        end
      end
    end
  else
    if workspace:FindFirstChild("Gay") then workspace:FindFirstChild("Gay"):Destroy() end    
  end
end

LegenSword = function()
  if LegenS then     
    for _,v in pairs(replicated.NPCs:GetChildren()) do
      if v.Name == "Legendary Sword Dealer" then
        if not workspace:FindFirstChild("Lgd") then
          Lgd = Instance.new("Part")
          Lgd.Name = "Lgd"
          Lgd.Transparency = 1
          Lgd.Size = Vector3.new(1,1,1)
          Lgd.Anchored = true
          Lgd.CanCollide = false
          Lgd.Parent = workspace
          Lgd.CFrame = v.HumanoidRootPart.CFrame    
        elseif workspace:FindFirstChild("Lgd") then
          if not Lgd:FindFirstChild("NameEsp") then
            local bill = Instance.new("BillboardGui", Lgd)
            bill.Name = "NameEsp"
            bill.ExtentsOffset = Vector3.new(0, 1, 0)
            bill.Size = UDim2.new(1, 200, 1, 30)
            bill.Adornee = Lgd
            bill.AlwaysOnTop = true
            local name = Instance.new("TextLabel", bill)
            name.Font = "Code"
            name.FontSize = "Size14"
            name.TextWrapped = true
            name.Size = UDim2.new(1, 0, 1, 0)
            name.TextYAlignment = "Top"
            name.BackgroundTransparency = 1
            name.TextStrokeTransparency = 0.5
            name.TextColor3 = Color3.fromRGB(80, 245, 245)
            name.Text = (v.Name .."   \n" ..round((plr.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude /3) .." M")
          else
            Lgd["NameEsp"].TextLabel.Text = (v.Name .."   \n" ..round((plr.Character.Head.Position - v.HumanoidRootPart.Position).Magnitude /3) .." M")    
          end                              
        end
      end
    end
  else
    if workspace:FindFirstChild("Lgd") then workspace:FindFirstChild("Lgd"):Destroy() end    
  end
end

ChestEsp = function()
  if ChestESP then
    local CollectionService = game:GetService("CollectionService")
    local Chests = CollectionService:GetTagged("_ChestTagged")        
    for _, Chest in ipairs(Chests) do
      pcall(function()
        local chestPos = Chest:GetPivot().Position
        local distanceMagnitude = (chestPos - plr.Character.Head.Position).Magnitude
        local existingEsp = Chest:FindFirstChild("ChestEspAttachment")                    
        if not existingEsp then
          local attachment = Instance.new("Attachment")
          attachment.Name = "ChestEspAttachment"
          attachment.Parent = Chest
          attachment.Position = Vector3.new(0, 3, 0)                     
          local nameEsp = Instance.new("BillboardGui")
          nameEsp.Name = "NameEsp"
          nameEsp.Size = UDim2.new(0, 200, 0, 30)
          nameEsp.Adornee = attachment
          nameEsp.ExtentsOffset = Vector3.new(0, 1, 0)
          nameEsp.AlwaysOnTop = true
          nameEsp.Parent = attachment                        
          local nameLabel = Instance.new("TextLabel")
          nameLabel.Font = Enum.Font.Code
          nameLabel.TextSize = 14
          nameLabel.TextWrapped = true
          nameLabel.Size = UDim2.new(1, 0, 1, 0)
          nameLabel.TextYAlignment = Enum.TextYAlignment.Top
          nameLabel.BackgroundTransparency = 1
          nameLabel.TextStrokeTransparency = 0.5
          nameLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
          nameLabel.Parent = nameEsp
        end
        local nameEsp = existingEsp and existingEsp:FindFirstChild("NameEsp")
        if nameEsp then
          local displayDistance = math.floor(distanceMagnitude / 3)
          local chestName = Chest.Name:gsub("Label", "")
          nameEsp.TextLabel.Text = string.format("[%s] %d M", chestName, displayDistance)
        end
      end)
    end
  else
    for _, Chest in ipairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
      local espAttachment = Chest:FindFirstChild("ChestEspAttachment")
      if espAttachment then espAttachment:Destroy() end
    end
  end
end

berriesEsp = function()
  if BerryEsp then
    local CollectionService = game:GetService("CollectionService")
    local BerryBushes = CollectionService:GetTagged("BerryBush")
    for _, Bush in ipairs(BerryBushes) do
      pcall(function()
        local bushPosition = Bush.Parent:GetPivot().Position
        for _, BerryName in pairs(Bush:GetAttributes()) do
          if BerryName then
            local espPartName = "BerryEspPart_" .. BerryName .. "_" .. tostring(bushPosition)
            local existingEsp = workspace:FindFirstChild(espPartName)                        
            if not existingEsp then
              existingEsp = Instance.new("Part")
              existingEsp.Name = espPartName
              existingEsp.Transparency = 1
              existingEsp.Size = Vector3.new(1, 1, 1)
              existingEsp.Anchored = true
              existingEsp.CanCollide = false
              existingEsp.Parent = workspace
              existingEsp.CFrame = CFrame.new(bushPosition)
            end                        
            if not existingEsp:FindFirstChild("NameEsp") then
              local nameEsp = Instance.new("BillboardGui", existingEsp)
              nameEsp.Name = "NameEsp"
              nameEsp.ExtentsOffset = Vector3.new(0, 1, 0)
              nameEsp.Size = UDim2.new(0, 200, 0, 30)
              nameEsp.Adornee = existingEsp
              nameEsp.AlwaysOnTop = true                            
              local nameLabel = Instance.new("TextLabel", nameEsp)
              nameLabel.Font = Enum.Font.Code
              nameLabel.TextSize = 14
              nameLabel.TextWrapped = true
              nameLabel.Size = UDim2.new(1, 0, 1, 0)
              nameLabel.TextYAlignment = Enum.TextYAlignment.Top
              nameLabel.BackgroundTransparency = 1
              nameLabel.TextStrokeTransparency = 0.5
              nameLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
            end                        
            local nameEsp = existingEsp:FindFirstChild("NameEsp")
            local distance = (plr.Character.Head.Position - bushPosition).Magnitude / 3
            if nameEsp then nameEsp.TextLabel.Text = ('[' .. BerryName .. ']' .. " " .. math.round(distance) .. " M") end
          end
        end
      end)
    end
  else
    for _, v in ipairs(workspace:GetChildren()) do
      if v:IsA("Part") and v.Name:match("BerryEspPart_.*") then v:Destroy() end
    end
  end
end

-- ============ RAYFIELD INIT ============
local ICON = "rbxassetid://109364250143878"
local DISCORD = "https://discord.gg/a4Sd2FBj6V"
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local ActiveFeatures = {}
local function UpdateStatusDisplay()
    if #ActiveFeatures == 0 then return "Chưa bật chức năng nào" end
    local text = "Dang Bat:"
    for _, name in ipairs(ActiveFeatures) do text = text .. "\n  ● " .. name end
    return text
end
local function ToggleFeature(name, isOn)
    if isOn then
        local f = false
        for _, v in ipairs(ActiveFeatures) do if v == name then f = true break end end
        if not f then table.insert(ActiveFeatures, name) end
    else
        for i, v in ipairs(ActiveFeatures) do if v == name then table.remove(ActiveFeatures, i) break end end
    end
    if _G.StatusLabel then pcall(function() _G.StatusLabel:Set(UpdateStatusDisplay()) end) end
end

local Window = Rayfield:CreateWindow({
   Name = "Apple Cat Hub | Blox Fruits",
   Icon = 109364250143878,
   LoadingTitle = "Apple Cat Hub",
   LoadingSubtitle = "By namggfggl30",
   Theme = "Default",
   ConfigurationSaving = { Enabled = true, FolderName = "AppleCatHub", FileName = "Config" },
   Discord = { Enabled = false, Invite = "discord.gg/a4Sd2FBj6V", RememberJoins = true },
   KeySystem = false
})

pcall(function() if Rayfield.SetToggleImage then Rayfield:SetToggleImage(ICON) end end)

_G.AC_Window = Window
_G.AC_ICON = ICON
_G.AC_Rayfield = Rayfield
_G.AC_ToggleFeature = ToggleFeature

-- ============ INFO TAB ============
local InfoTab = Window:CreateTab("Info & Status", ICON)
InfoTab:CreateSection("Discord")
InfoTab:CreateButton({ Name = "Copy Link Discord", Callback = function()
    setclipboard(DISCORD)
    Rayfield:Notify({ Title = "Apple Cat Hub", Content = "Đã sao chép link Discord!", Duration = 3, Image = 109364250143878 })
end })

InfoTab:CreateSection("Status Server")
local TimeZoneLabel = InfoTab:CreateLabel("Time: Loading...")
spawn(function() while task.wait(1) do
    local d = os.date("*t") local h = (d.hour) % 24
    local ampm = h < 12 and "AM" or "PM"
    TimeZoneLabel:Set("Time: " .. string.format("%02d/%02d/%04d - %02i:%02i:%02i %s", d.day, d.month, d.year, ((h-1)%12)+1, d.min, d.sec, ampm))
end end)

local GameTimeLabel = InfoTab:CreateLabel("Game Time: Loading...")
spawn(function() while task.wait(1) do
    local g = math.floor(workspace.DistributedGameTime + 0.5)
    GameTimeLabel:Set(string.format("Game Time: %dh %dm %ds", math.floor(g/3600)%24, math.floor(g/60)%60, g%60))
end end)

local MirageLabel = InfoTab:CreateLabel("Mirage Island: ❌")
spawn(function() while task.wait(1) do MirageLabel:Set("Mirage Island: " .. (game.Workspace._WorldOrigin.Locations:FindFirstChild('Mirage Island') and '✅' or '❌')) end end)
local KitsuneLabel = InfoTab:CreateLabel("Kitsune Island: ❌")
spawn(function() while task.wait(1) do KitsuneLabel:Set("Kitsune Island: " .. (game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") and '✅' or '❌')) end end)
local PrehistoricLabel = InfoTab:CreateLabel("Prehistoric Island: ❌")
spawn(function() while task.wait(1) do PrehistoricLabel:Set("Prehistoric Island: " .. (game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") and '✅' or '❌')) end end)
local FrozenLabel = InfoTab:CreateLabel("Frozen Dimension: ❌")
spawn(function() while task.wait(1) do FrozenLabel:Set("Frozen Dimension: " .. (game.Workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') and '✅' or '❌')) end end)
local CakePrinceLabel = InfoTab:CreateLabel("Cake Prince: Loading...")
spawn(function() while task.wait(1) do
    local cp = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
    if string.len(cp) >= 86 then CakePrinceLabel:Set("Killed: " .. string.sub(cp, 39, 41))
    else CakePrinceLabel:Set("Cake Prince: ✅") end
end end)
local RipLabel = InfoTab:CreateLabel("Rip Indra: ❌")
spawn(function() while task.wait(1) do RipLabel:Set("Rip Indra: " .. ((game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form") or game:GetService("Workspace").Enemies:FindFirstChild("rip_indra")) and '✅' or '❌')) end end)
local DoughLabel = InfoTab:CreateLabel("Dough King: ❌")
spawn(function() while task.wait(1) do DoughLabel:Set("Dough King: " .. ((game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") or game:GetService("Workspace").Enemies:FindFirstChild("Dough King")) and '✅' or '❌')) end end)
local FullMoonLabel = InfoTab:CreateLabel("Moon: 0/5")
spawn(function() while task.wait(1) do
    local mt = game:GetService("Lighting").Sky.MoonTextureId
    local s = "Moon: 0/5"
    if mt == "http://www.roblox.com/asset/?id=9709149431" then s = "Moon: 5/5 (Full Moon) ✅"
    elseif mt == "http://www.roblox.com/asset/?id=9709149052" then s = "Moon: 4/5"
    elseif mt == "http://www.roblox.com/asset/?id=9709143733" then s = "Moon: 3/5"
    elseif mt == "http://www.roblox.com/asset/?id=9709150401" then s = "Moon: 2/5"
    elseif mt == "http://www.roblox.com/asset/?id=9709149680" then s = "Moon: 1/5" end
    FullMoonLabel:Set(s)
end end)
local LegendaryLabel = InfoTab:CreateLabel("Legendary Sword: Not Found")
spawn(function() while task.wait(1) do
    local s = "Not Found"
    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","1") then s = "Shisui ✅"
    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","2") then s = "Wando ✅"
    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","3") then s = "Saddi ✅" end
    LegendaryLabel:Set("Legendary Sword: " .. s)
end end)
local BoneLabel = InfoTab:CreateLabel("Bone: 0")
spawn(function() while task.wait(1) do BoneLabel:Set("Bones: " .. tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Check"))) end end)
InfoTab:CreateSection("Status Farm")
_G.StatusLabel = InfoTab:CreateLabel("Chưa bật chức năng nào")
local MainTab = Window:CreateTab("Farming", ICON)
MainTab:CreateDropdown({ Name = "Select Weapon", Options = {"Melee","Sword","Blox Fruit","Gun"}, CurrentOption = "Melee", Flag = "SelectWeapon", Callback = function(o) _G.ChooseWP = o end })
MainTab:CreateSection("Farming")
MainTab:CreateToggle({ Name = "Auto Farm Level", CurrentValue = false, Flag = "AutoFarmLevel", Callback = function(v) _G.Level = v ToggleFeature("Auto Farm Level", v) end })
MainTab:CreateToggle({ Name = "Auto Farm Nearest", CurrentValue = false, Flag = "AutoFarmNearest", Callback = function(v) _G.AutoFarmNear = v ToggleFeature("Auto Farm Nearest", v) end })
MainTab:CreateToggle({ Name = "Auto Factory Raid", CurrentValue = false, Flag = "AutoFactory", Callback = function(v) _G.AutoFactory = v ToggleFeature("Auto Factory Raid", v) end })
MainTab:CreateToggle({ Name = "Auto Pirate Raid", CurrentValue = false, Flag = "AutoPirateRaid", Callback = function(v) _G.AutoRaidCastle = v ToggleFeature("Auto Pirate Raid", v) end })
MainTab:CreateToggle({ Name = "Auto Farm Ectoplasm", CurrentValue = false, Flag = "AutoEctoplasm", Callback = function(v) _G.AutoEctoplasm = v ToggleFeature("Auto Farm Ectoplasm", v) end })
MainTab:CreateSection("Chest")
MainTab:CreateToggle({ Name = "Auto Farm Chest", CurrentValue = false, Flag = "AutoFarmChest", Callback = function(v) _G.AutoFarmChest = v ToggleFeature("Auto Farm Chest", v) end })
MainTab:CreateToggle({ Name = "Auto Chest Bypass", CurrentValue = false, Flag = "AutoChestBP", Callback = function(v) _G.AutoChestBP = v ToggleFeature("Auto Chest Bypass", v) end })
MainTab:CreateToggle({ Name = "Stop Items", CurrentValue = true, Flag = "StopItems", Callback = function(v) _G.StopWhenChalice = v end })
MainTab:CreateSection("Collect Berry")
MainTab:CreateToggle({ Name = "Auto Farm Berry", CurrentValue = false, Flag = "AutoBerry", Callback = function(v) _G.AutoBerry = v ToggleFeature("Auto Farm Berry", v) end })
MainTab:CreateToggle({ Name = "Auto Farm Berry + Hop", CurrentValue = false, Flag = "AutoBerryHop", Callback = function(v) _G.AutoBerryH = v ToggleFeature("Auto Farm Berry + Hop", v) end })
MainTab:CreateSection("Farm Mob")
local MobList = {}
if World1 then MobList = {"Bandit","Monkey","Gorilla","Pirate","Brute","Desert Bandit","Desert Officer","Snow Bandit","Snowman","Chief Petty Officer","Sky Bandit","Dark Master","Toga Warrior","Gladiator","Military Soldier","Military Spy","Fishman Warrior","Fishman Commando","God's Guard","Shanda","Royal Squad","Royal Soldier","Galley Pirate","Galley Captain"}
elseif World2 then MobList = {"Raider","Mercenary","Swan Pirate","Factory Staff","Marine Lieutenant","Marine Captain","Zombie","Vampire","Snow Trooper","Winter Warrior","Lab Subordinate","Horned Warrior","Magma Ninja","Lava Pirate","Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer","Arctic Warrior","Snow Lurker","Sea Soldier","Water Fighter"}
elseif World3 then MobList = {"Pirate Millionaire","Dragon Crew Warrior","Dragon Crew Archer","Female Islander","Giant Islander","Marine Commodore","Marine Rear Admiral","Fishman Raider","Fishman Captain","Forest Pirate","Mythological Pirate","Jungle Pirate","Musketeer Pirate","Reborn Skeleton","Living Zombie","Demonic Soul","Posessed Mummy","Peanut Scout","Peanut President","Ice Cream Chef","Ice Cream Commander","Cookie Crafter","Cake Guard","Baking Staff","Head Baker","Cocoa Warrior","Chocolate Bar Battler","Sweet Thief","Candy Rebel","Candy Pirate","Snow Demon","Isle Outlaw","Island Boy","Sun-kissed Warrior","Isle Champion"} end
MainTab:CreateDropdown({ Name = "Select Mob", Options = MobList, CurrentOption = MobList[1], Flag = "SelectMob", Callback = function(o) getgenv().SelectMob = o end })
MainTab:CreateToggle({ Name = "Auto Kill Mob", CurrentValue = false, Flag = "AutoKillMob", Callback = function(v) _G.AutoKillMob = v ToggleFeature("Auto Kill Mob", v) end })
MainTab:CreateSection("Farm All Island")
local IslandList = {}
if World1 then IslandList = {"Pirates","Marine","Jungle","Pirate Village","Desert","Frozen Village","Marine Fortress","Skylands Lower","Prison","Colosseum","Magma Village","Underwater City","Skylands Upper"}
elseif World2 then IslandList = {"Kingdom of Rose","Green Zone","Graveyard Island","Snow Mountain","Hot and Cold (Cold)","Hot and Cold (Hot)","Cursed Ship","Ice Castle","Forgotten Island"}
elseif World3 then IslandList = {"Port Town","Hydra Island","Great Tree","Floating Turtle","Haunted Castle","Sea of Treats","Tiki Outpost","Submerged Island"} end
MainTab:CreateDropdown({ Name = "Select Island", Options = IslandList, CurrentOption = IslandList[1], Flag = "SelectIsland", Callback = function(o) _G.SelectIsland = o end })
MainTab:CreateToggle({ Name = "Auto Farm All Island", CurrentValue = false, Flag = "AutoFarmIsland", Callback = function(v) _G.AutoFarmIsland = v ToggleFeature("Auto Farm All Island", v) end })
MainTab:CreateSection("Farm Elite Hunter")
local EliteProgress = MainTab:CreateLabel("Elite Progress: 0")
spawn(function() while task.wait(0.5) do pcall(function() EliteProgress:Set("Elite Progress: " .. tostring(replicated.Remotes.CommF_:InvokeServer("EliteHunter","Progress"))) end) end end)
MainTab:CreateToggle({ Name = "Auto Farm Elite", CurrentValue = false, Flag = "AutoFarmElite", Callback = function(v) _G.FarmEliteHunt = v ToggleFeature("Auto Farm Elite", v) end })
MainTab:CreateToggle({ Name = "Auto Farm Elite + Hop", CurrentValue = false, Flag = "AutoFarmEliteHop", Callback = function(v) _G.FarmEliteH = v ToggleFeature("Auto Farm Elite + Hop", v) end })
MainTab:CreateSection("Farm Rip Indra")
MainTab:CreateToggle({ Name = "Auto Attack Rip Indra", CurrentValue = false, Flag = "AutoRipIndra", Callback = function(v) _G.AutoRipIngay = v ToggleFeature("Auto Attack Rip Indra", v) end })
MainTab:CreateToggle({ Name = "Auto Unlocked Haki", CurrentValue = false, Flag = "AutoUnHaki", Callback = function(v) _G.AutoUnHaki = v ToggleFeature("Auto Unlocked Haki", v) end })
MainTab:CreateSection("Farming Cake")
local CakeKillLabel = MainTab:CreateLabel("Cake Prince Killed: 0")
spawn(function() while task.wait(0.2) do pcall(function()
    local k = string.match(replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner"), "%d+")
    if k then CakeKillLabel:Set("Killed: " .. (500 - tonumber(k) or 0)) end
end) end end)
MainTab:CreateToggle({ Name = "Auto Farm Cake Prince", CurrentValue = false, Flag = "AutoCakePrince", Callback = function(v) _G.Auto_Cake_Prince = v ToggleFeature("Auto Farm Cake Prince", v) end })
MainTab:CreateToggle({ Name = "Accept Quests Cake", CurrentValue = false, Flag = "AcceptQuestCake", Callback = function(v) _G.AcceptQuestC = v end })
MainTab:CreateToggle({ Name = "Auto Summon Cake Prince", CurrentValue = false, Flag = "AutoSummonCake", Callback = function(v) _G.AutoSpawnCP = v ToggleFeature("Auto Summon Cake Prince", v) end })
MainTab:CreateToggle({ Name = "Auto Dough King [Fully]", CurrentValue = false, Flag = "AutoDoughKing", Callback = function(v) _G.AutoDoughKing = v ToggleFeature("Auto Dough King", v) end })
MainTab:CreateToggle({ Name = "Auto Farm Dough King", CurrentValue = false, Flag = "AutoFarmDoughKing", Callback = function(v) _G.AutoAttackDoughKing = v ToggleFeature("Auto Farm Dough King", v) end })
MainTab:CreateToggle({ Name = "Auto Farm Dough King + Hop", CurrentValue = false, Flag = "AutoDoughKingHop", Callback = function(v) _G.AutoHop_Dough = v ToggleFeature("Auto Dough King + Hop", v) end })
MainTab:CreateSection("Farming Bone")
local BoneCountLabel = MainTab:CreateLabel("Bones: 0")
spawn(function() while task.wait(0.2) do pcall(function() BoneCountLabel:Set("Bones: " .. GetM("Bones")) end) end end)
MainTab:CreateToggle({ Name = "Auto Farm Bone", CurrentValue = false, Flag = "AutoFarmBone", Callback = function(v) _G.AutoFarm_Bone = v ToggleFeature("Auto Farm Bone", v) end })
MainTab:CreateToggle({ Name = "Accept Quests Bone", CurrentValue = false, Flag = "AcceptQuestBone", Callback = function(v) _G.AcceptQuestB = v end })
MainTab:CreateToggle({ Name = "Auto Soul Reaper", CurrentValue = false, Flag = "AutoSoulReaper", Callback = function(v) _G.AutoHytHallow = v ToggleFeature("Auto Soul Reaper", v) end })
MainTab:CreateToggle({ Name = "Auto Random Bones", CurrentValue = false, Flag = "AutoRandomBones", Callback = function(v) _G.Auto_Random_Bone = v ToggleFeature("Auto Random Bones", v) end })
MainTab:CreateToggle({ Name = "Auto Try Luck Gravestone", CurrentValue = false, Flag = "AutoTryLuck", Callback = function(v) _G.TryLucky = v ToggleFeature("Auto Try Luck", v) end })
MainTab:CreateToggle({ Name = "Auto Pray Gravestone", CurrentValue = false, Flag = "AutoPray", Callback = function(v) _G.Praying = v ToggleFeature("Auto Pray", v) end })
MainTab:CreateSection("Tyrant of the Skies")
MainTab:CreateToggle({ Name = "Auto Farm Boss TOTS", CurrentValue = false, Flag = "AutoFarmTyrant", Callback = function(v) _G.FarmTyrant = v ToggleFeature("Auto Farm Boss TOTS", v) end })
MainTab:CreateToggle({ Name = "Auto Summon Boss", CurrentValue = false, Flag = "AutoSummonBoss", Callback = function(v) _G.FarmPhaBinh = v ToggleFeature("Auto Summon Boss", v) end })
MainTab:CreateSection("Farm Material")
MainTab:CreateDropdown({ Name = "Choose Material", Options = MaterialList, CurrentOption = MaterialList[1], Flag = "SelectMaterial", Callback = function(o) getgenv().SelectMaterial = o end })
MainTab:CreateToggle({ Name = "Auto Farm Materials", CurrentValue = false, Flag = "AutoFarmMaterials", Callback = function(v) getgenv().AutoMaterial = v ToggleFeature("Auto Farm Materials", v) end })
MainTab:CreateSection("Farm Boss")
MainTab:CreateDropdown({ Name = "Select Boss", Options = BossList, CurrentOption = BossList[1], Flag = "SelectBoss", Callback = function(o) _G.FindBoss = o end })
MainTab:CreateToggle({ Name = "Auto Farm Boss", CurrentValue = false, Flag = "AutoFarmBoss", Callback = function(v) _G.FarmBoss = v ToggleFeature("Auto Farm Boss", v) end })
MainTab:CreateToggle({ Name = "Accept Quests Boss", CurrentValue = true, Flag = "AcceptQuestBoss", Callback = function(v) _G.AcceptQuestBoss = v end })
MainTab:CreateToggle({ Name = "Auto Farm All Boss", CurrentValue = false, Flag = "AutoFarmAllBoss", Callback = function(v) _G.AutoFarmAllBoss = v ToggleFeature("Auto Farm All Boss", v) end })
MainTab:CreateSection("Farming Mastery")
MainTab:CreateDropdown({ Name = "Choose Island", Options = {"Cake","Bone"}, CurrentOption = "Bone", Flag = "MasteryIsland", Callback = function(o) SelectIsland = o end })
MainTab:CreateToggle({ Name = "Auto Mastery Fruits", CurrentValue = false, Flag = "AutoMasteryFruits", Callback = function(v) _G.FarmMastery_Dev = v ToggleFeature("Auto Mastery Fruits", v) end })
MainTab:CreateToggle({ Name = "Auto Mastery Gun", CurrentValue = false, Flag = "AutoMasteryGun", Callback = function(v) _G.FarmMastery_G = v ToggleFeature("Auto Mastery Gun", v) end })
MainTab:CreateToggle({ Name = "Auto Mastery All Sword", CurrentValue = false, Flag = "AutoMasterySword", Callback = function(v) _G.FarmMastery_S = v ToggleFeature("Auto Mastery Sword", v) end })
-- ============ SETTINGS TAB ============
local SettingsTab = Window:CreateTab("Settings", ICON)
SettingsTab:CreateSection("Settings / Configure")
SettingsTab:CreateToggle({ Name = "Fast Attack", CurrentValue = true, Flag = "FastAttack", Callback = function(v) _G.Seriality = v end })
SettingsTab:CreateToggle({ Name = "Bring Mobs", CurrentValue = true, Flag = "BringMobs", Callback = function(v) _B = v end })
SettingsTab:CreateSlider({ Name = "Hop Delay (Minutes)", Range = {5,120}, Increment = 1, Suffix = " min", CurrentValue = 30, Flag = "HopDelay", Callback = function(v) _G.HopDelay = v * 60 end })
SettingsTab:CreateToggle({ Name = "Auto Hop Server with time", CurrentValue = false, Flag = "AutoHopTimer", Callback = function(v) _G.AutoHopServer = v if not v then _G.HopTimer = nil end end })
SettingsTab:CreateToggle({ Name = "Auto Set Spawn Point", CurrentValue = false, Flag = "AutoSetSpawn", Callback = function(v) getgenv().Set = v if v then pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint") end) end end })
SettingsTab:CreateToggle({ Name = "Auto Turn on Buso", CurrentValue = true, Flag = "AutoBuso", Callback = function(v) Boud = v end })
SettingsTab:CreateToggle({ Name = "Auto Haki Observation", CurrentValue = false, Flag = "AutoObservation", Callback = function(v) getgenv().Observation = v end })
SettingsTab:CreateToggle({ Name = "Auto Turn on Race V3", CurrentValue = false, Flag = "AutoRaceV3", Callback = function(v) _G.RaceClickAutov3 = v end })
SettingsTab:CreateToggle({ Name = "Auto Turn on Race V4", CurrentValue = false, Flag = "AutoRaceV4", Callback = function(v) _G.RaceClickAutov4 = v end })
SettingsTab:CreateToggle({ Name = "Auto Turn on Spin xyz", CurrentValue = false, Flag = "AutoSpin", Callback = function(v) RandomCFrame = v end })
SettingsTab:CreateToggle({ Name = "Safe Mode", CurrentValue = false, Flag = "SafeMode", Callback = function(v) _G.Safemode = v end })
SettingsTab:CreateToggle({ Name = "Remove Hit VFX", CurrentValue = false, Flag = "RemoveHitVFX", Callback = function(v) _G.DestroyHit = v end })
SettingsTab:CreateToggle({ Name = "Remove Death & Respawn VFX", CurrentValue = false, Flag = "RemoveDeathVFX", Callback = function(v) RDeath = v end })
SettingsTab:CreateToggle({ Name = "Disable Notify", CurrentValue = false, Flag = "DisableNotify", Callback = function(v) RemoveDamage = v end })
SettingsTab:CreateToggle({ Name = "Anti AFK", CurrentValue = true, Flag = "AntiAFK", Callback = function(v) if v then
    local vu = game:GetService("VirtualUser")
    repeat wait() until game:IsLoaded()
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end end })
SettingsTab:CreateToggle({ Name = "Auto Anti-Admin Join Server", CurrentValue = true, Flag = "AntiAdmin", Callback = function(v) getgenv().HopServerAdmin = v end })
SettingsTab:CreateToggle({ Name = "No Clip", CurrentValue = false, Flag = "NoClip", Callback = function(v) getgenv().NoClip = v end })

spawn(function() while task.wait(Sec) do pcall(function()
    if _G.RaceClickAutov3 then repeat replicated.Remotes.CommE:FireServer("ActivateAbility") wait(30) until not _G.RaceClickAutov3 end
end) end end)

spawn(function() while task.wait(Sec) do pcall(function()
    if _G.RaceClickAutov4 then
        if plr.Character:FindFirstChild("RaceEnergy") and plr.Character.RaceEnergy.Value == 1 then Useskills("nil","Y") end
    end
end) end end)

spawn(function() while task.wait(Sec) do pcall(function()
    if _G.DestroyHit then
        for _, v in pairs(workspace["_WorldOrigin"]:GetChildren()) do
            if v.Name == "SlashHit" or v.Name == "CurvedRing" or v.Name == "SwordSlash" or v.Name == "SlashTail" then v:Destroy() end
        end
    end
end) end end)

spawn(function() while wait(Sec) do pcall(function()
    if RDeath then
        if replicated.Effect.Container:FindFirstChild("Death") then replicated.Effect.Container.Death:Destroy() end
        if replicated.Effect.Container:FindFirstChild("Respawn") then replicated.Effect.Container.Respawn:Destroy() end
    end
end) end end)

spawn(function() while wait(Sec) do pcall(function()
    if RemoveDamage then
        replicated.Assets.GUI.DamageCounter.Enabled = false
        plr.PlayerGui.Notifications.Enabled = false
    else
        replicated.Assets.GUI.DamageCounter.Enabled = true
        plr.PlayerGui.Notifications.Enabled = true
    end
end) end end)

spawn(function() while wait() do pcall(function()
    if getgenv().HopServerAdmin then
        for _, v in pairs(game.Players:GetPlayers()) do
            local blacklist = {"red_game43","rip_indra","Axiore","Polkster","wenlocktoad","Daigrock","toilamvidamme","oofficialnoobie","Uzoth","Azarth","arlthmetic","Death_King","Lunoven","TheGreateAced","rip_fud","drip_mama","layandikit12","Hingoi"}
            if table.find(blacklist, v.Name) then Hop() end
        end
    end
end) end end)

spawn(function() while wait() do pcall(function()
    if getgenv().NoClip then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end) end end)

spawn(function() while wait() do pcall(function()
    if getgenv().Observation then game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true) end
end) end end)

-- ============ FISHING TAB ============
local FishTab = Window:CreateTab("Fishing", ICON)
FishTab:CreateSection("Fishing")
FishTab:CreateDropdown({ Name = "Select Fishing Rod", Options = {"Fishing Rod","Gold Rod","Shark Rod","Shell Rod","Treasure Rod"}, CurrentOption = "Fishing Rod", Flag = "SelectRod", Callback = function(o) _G.SelectedRod = o end })
FishTab:CreateDropdown({ Name = "Select Bait", Options = {"Basic Bait","Kelp Bait","Good Bait","Abyssal Bait","Frozen Bait","Epic Bait","Carnivore Bait"}, CurrentOption = "Basic Bait", Flag = "SelectBait", Callback = function(o) _G.SelectedBait = o if _G.AutoBuyBait then pcall(function() Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {}) end) end end })
FishTab:CreateToggle({ Name = "Auto Buy Bait", CurrentValue = false, Flag = "AutoBuyBait", Callback = function(v) _G.AutoBuyBait = v if v then pcall(function() Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {}) end) end end })
FishTab:CreateToggle({ Name = "Auto Fishing", CurrentValue = false, Flag = "AutoFishing", Callback = function(v) _G.AutoFishing = v ToggleFeature("Auto Fishing", v) end })
FishTab:CreateToggle({ Name = "Auto Quest Fishing", CurrentValue = false, Flag = "AutoQuestFishing", Callback = function(v) _G.AutoFishingQuest = v end })
FishTab:CreateToggle({ Name = "Auto Complete Quest", CurrentValue = false, Flag = "AutoCompleteQuest", Callback = function(v) _G.AutoQuestComplete = v if v then pcall(function() Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC","FinishQuest") end) end end })
FishTab:CreateToggle({ Name = "Auto Sell Fish", CurrentValue = false, Flag = "AutoSellFish", Callback = function(v) _G.AutoSellFish = v if v then pcall(function() Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC","SellFish") end) end end })
FishTab:CreateToggle({ Name = "Auto Spam Skill Z", CurrentValue = false, Flag = "AutoSkillZ", Callback = function(v) _G.AutoSkillZ = v end })

spawn(function() while task.wait(2) do pcall(function()
    if _G.AutoBuyBait and _G.SelectedBait then Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {}) end
end) end end)
spawn(function() while task.wait(5) do pcall(function()
    if _G.AutoQuestComplete then Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC","FinishQuest") end
end) end end)
spawn(function() while task.wait(5) do pcall(function()
    if _G.AutoSellFish then Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC","SellFish") end
end) end end)
spawn(function() while task.wait(0.5) do pcall(function()
    if _G.AutoSkillZ then replicated.Modules.Net["RF/JobToolAbilities"]:InvokeServer("Z", true) end
end) end end)

-- ============ STATS & ESP TAB ============
local EspTab = Window:CreateTab("Stats & Esp", ICON)
EspTab:CreateSection("Stats Upgrade")
EspTab:CreateSlider({ Name = "Stats Value", Range = {0,1000}, Increment = 1, CurrentValue = 10, Flag = "StatsValue", Callback = function(v) pSats = v end })
EspTab:CreateToggle({ Name = "Auto Melee", CurrentValue = false, Flag = "AutoMelee", Callback = function(v) _G.Auto_Melee = v ToggleFeature("Auto Melee", v) end })
EspTab:CreateToggle({ Name = "Auto Swords", CurrentValue = false, Flag = "AutoSwords", Callback = function(v) _G.Auto_Sword = v ToggleFeature("Auto Swords", v) end })
EspTab:CreateToggle({ Name = "Auto Gun", CurrentValue = false, Flag = "AutoGun", Callback = function(v) _G.Auto_Gun = v ToggleFeature("Auto Gun", v) end })
EspTab:CreateToggle({ Name = "Auto Blox Fruit", CurrentValue = false, Flag = "AutoBloxFruit", Callback = function(v) _G.Auto_DevilFruit = v ToggleFeature("Auto Blox Fruit", v) end })
EspTab:CreateToggle({ Name = "Auto Defense", CurrentValue = false, Flag = "AutoDefense", Callback = function(v) _G.Auto_Defense = v ToggleFeature("Auto Defense", v) end })

spawn(function() while wait(Sec) do pcall(function()
    if _G.Auto_Melee then statsSetings("Melee",pSats) end
    if _G.Auto_Sword then statsSetings("Sword",pSats) end
    if _G.Auto_Gun then statsSetings("Gun",pSats) end
    if _G.Auto_DevilFruit then statsSetings("Devil",pSats) end
    if _G.Auto_Defense then statsSetings("Defense",pSats) end
end) end end)

EspTab:CreateSection("ESP")
EspTab:CreateToggle({ Name = "Esp Berry", CurrentValue = false, Flag = "EspBerry", Callback = function(v) BerryEsp = v
    if not v then for _, o in ipairs(workspace:GetChildren()) do if o:IsA("Part") and o.Name:match("BerryEspPart_.*") then o:Destroy() end end
    else task.spawn(function() while BerryEsp do berriesEsp() task.wait() end end) end end })
EspTab:CreateToggle({ Name = "Esp Player", CurrentValue = false, Flag = "EspPlayer", Callback = function(v) PlayerEsp = v
    if not v then for _, p in next, game.Players:GetChildren() do pcall(function()
        if not isnil(p.Character) and not isnil(p.Character.Head) then
            if p.Character.Head:FindFirstChild('NameEsp'..Number) then p.Character.Head:FindFirstChild('NameEsp'..Number):Destroy() end
        end end) end
    else task.spawn(function() while PlayerEsp do EspPly() task.wait() end end) end end })
EspTab:CreateToggle({ Name = "Esp Chest", CurrentValue = false, Flag = "EspChest", Callback = function(v) ChestESP = v
    if not v then for _, c in ipairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        local a = c:FindFirstChild("ChestEspAttachment") if a then a:Destroy() end end
    else task.spawn(function() while ChestESP do ChestEsp() task.wait() end end) end end })
EspTab:CreateToggle({ Name = "Esp Fruit", CurrentValue = false, Flag = "EspFruit", Callback = function(v) DevilFruitESP = v
    if not v then for _, o in next, workspace:GetChildren() do pcall(function()
        if o:FindFirstChild('Handle') and o.Handle:FindFirstChild('NameEsp'..Number) then o.Handle:FindFirstChild('NameEsp'..Number):Destroy() end
    end) end
    else task.spawn(function() while DevilFruitESP do DevEsp() task.wait() end end) end end })
EspTab:CreateToggle({ Name = "Esp Island", CurrentValue = false, Flag = "EspIsland", Callback = function(v) IslandESP = v
    if not v then for _, o in next, workspace["_WorldOrigin"].Locations:GetChildren() do pcall(function()
        if o:FindFirstChild('NameEsp') then o:FindFirstChild('NameEsp'):Destroy() end end) end
    else task.spawn(function() while IslandESP do LocationEsp() task.wait() end end) end end })
EspTab:CreateToggle({ Name = "Esp Flower", CurrentValue = false, Flag = "EspFlower", Callback = function(v) FlowerESP = v
    if not v then for _, o in pairs(workspace:GetChildren()) do pcall(function()
        if (o.Name == "Flower2" or o.Name == "Flower1") and o:FindFirstChild('NameEsp'..Number) then o:FindFirstChild('NameEsp'..Number):Destroy() end end) end
    else task.spawn(function() while FlowerESP do flowerEsp() task.wait() end end) end end })
EspTab:CreateToggle({ Name = "Esp Legendary Sword", CurrentValue = false, Flag = "EspLegendary", Callback = function(v) LegenS = v
    if not v then if workspace:FindFirstChild("Lgd") then workspace:FindFirstChild("Lgd"):Destroy() end
    else task.spawn(function() while LegenS do LegenSword() task.wait() end end) end end })
EspTab:CreateToggle({ Name = "Esp Haki Color", CurrentValue = false, Flag = "EspHakiColor", Callback = function(v) ColorEsp = v
    if not v then if workspace:FindFirstChild("Gay") then workspace:FindFirstChild("Gay"):Destroy() end
    else task.spawn(function() while ColorEsp do HakiClorEsp() task.wait() end end) end end })
EspTab:CreateToggle({ Name = "Esp Gear", CurrentValue = false, Flag = "EspGear", Callback = function(v) ESPGear = v
    if not v then for _, o in pairs(workspace.Map.MysticIsland:GetDescendants()) do pcall(function()
        if o:FindFirstChild("NameEsp") then o:FindFirstChild("NameEsp"):Destroy() end end) end
    else task.spawn(function() while ESPGear do gearEsp() task.wait() end end) end end })
EspTab:CreateToggle({ Name = "Esp SeaEvent Island", CurrentValue = false, Flag = "EspSeaEvent", Callback = function(v) EspEventIsland = v
    if not v then for _, o in pairs(workspace._WorldOrigin.Locations:GetChildren()) do pcall(function()
        if o:FindFirstChild("NameEsp") then o:FindFirstChild("NameEsp"):Destroy() end end) end
    else task.spawn(function() while EspEventIsland do EventIslandEsp() task.wait() end end) end end })
EspTab:CreateToggle({ Name = "Esp Advanced Dealer", CurrentValue = false, Flag = "EspAdvancedDealer", Callback = function(v) advanEsp = v
    if not v then if workspace:FindFirstChild("Adv") then workspace:FindFirstChild("Adv"):Destroy() end
    else task.spawn(function() while advanEsp do AdvanFruitEsp() task.wait() end end) end end })
    -- ============ FRUIT & RAID TAB ============
local RaidsTab = Window:CreateTab("Fruit & Raid", ICON)
RaidsTab:CreateSection("Fruits Options")
RaidsTab:CreateToggle({ Name = "Auto Random Fruit", CurrentValue = false, Flag = "AutoRandomFruit", Callback = function(v) _G.Random_Auto = v ToggleFeature("Auto Random Fruit", v) end })
RaidsTab:CreateToggle({ Name = "Auto Drop Fruit", CurrentValue = false, Flag = "AutoDropFruit", Callback = function(v) _G.DropFruit = v ToggleFeature("Auto Drop Fruit", v) end })
RaidsTab:CreateToggle({ Name = "Auto Store Fruit", CurrentValue = false, Flag = "AutoStoreFruit", Callback = function(v) _G.StoreF = v ToggleFeature("Auto Store Fruit", v) end })
RaidsTab:CreateToggle({ Name = "Auto Tween to Fruit", CurrentValue = false, Flag = "AutoTweenFruit", Callback = function(v) _G.TwFruits = v ToggleFeature("Auto Tween Fruit", v) end })
RaidsTab:CreateToggle({ Name = "Auto Collect Fruit", CurrentValue = false, Flag = "AutoCollectFruit", Callback = function(v) _G.InstanceF = v ToggleFeature("Auto Collect Fruit", v) end })
RaidsTab:CreateDropdown({ Name = "Select Fruit Shop", Options = {"Rocket-Rocket","Spin-Spin","Blade-Blade","Spring-Spring","Bomb-Bomb","Smoke-Smoke","Spike-Spike","Flame-Flame","Ice-Ice","Sand-Sand","Dark-Dark","Eagle-Eagle","Diamond-Diamond","Light-Light","Rubber-Rubber","Ghost-Ghost","Magma-Magma","Quake-Quake","Buddha-Buddha","Love-Love","Creation-Creation","Spider-Spider","Sound-Sound","Phoenix-Phoenix","Portal-Portal","Lightning-Lightning","Pain-Pain","Blizzard-Blizzard","Gravity-Gravity","T-Rex-T-Rex","Mammoth-Mammoth","Dough-Dough","Shadow-Shadow","Venom-Venom","Gas-Gas","Control-Control","Spirit-Spirit","Leopard-Leopard","Yeti-Yeti","Kitsune-Kitsune","Dragon-Dragon"}, CurrentOption = "Rocket-Rocket", Flag = "SelectFruitShop", Callback = function(o) getgenv().SelectFruit = o end })
RaidsTab:CreateToggle({ Name = "Auto Buy Fruit Shop", CurrentValue = false, Flag = "AutoBuyFruitShop", Callback = function(v) getgenv().AutoBuyFruitSniper = v ToggleFeature("Auto Buy Fruit", v) end })
RaidsTab:CreateSection("Dungeon / Raiding")
RaidsTab:CreateDropdown({ Name = "Select Chip", Options = DungeonTables, CurrentOption = DungeonTables[1], Flag = "SelectChip", Callback = function(o) _G.SelectChip = o end })
RaidsTab:CreateToggle({ Name = "Auto Select Dungeon Chip", CurrentValue = false, Flag = "AutoSelectChip", Callback = function(v) _G.AutoSelectDungeon = v ToggleFeature("Auto Select Chip", v) end })
RaidsTab:CreateButton({ Name = "Buy Dungeon Chips [Beli]", Callback = function() if not GetBP("Special Microchip") then replicated.Remotes.CommF_:InvokeServer("RaidsNpc","Select",_G.SelectChip) end end })
RaidsTab:CreateToggle({ Name = "Auto Buy Chip [Beli]", CurrentValue = false, Flag = "AutoChipBeli", Callback = function(v) _G.AutoChipBeli = v ToggleFeature("Auto Chip Beli", v) end })
RaidsTab:CreateToggle({ Name = "Auto Buy Chip [Devil Fruit]", CurrentValue = false, Flag = "AutoChipFruit", Callback = function(v) _G.AutoChipFruit = v ToggleFeature("Auto Chip Fruit", v) end })
RaidsTab:CreateToggle({ Name = "Auto Start Raid", CurrentValue = false, Flag = "AutoStartRaid", Callback = function(v) _G.Auto_StartRaid = v ToggleFeature("Auto Start Raid", v) end })
RaidsTab:CreateToggle({ Name = "Auto Raid + Next Island", CurrentValue = false, Flag = "AutoRaidNext", Callback = function(v) _G.Raiding = v ToggleFeature("Auto Raid Next", v) end })
RaidsTab:CreateToggle({ Name = "Auto Awakening", CurrentValue = false, Flag = "AutoAwakening", Callback = function(v) _G.Auto_Awakener = v ToggleFeature("Auto Awakening", v) end })
RaidsTab:CreateSection("Law / Order")
RaidsTab:CreateButton({ Name = "Buy Microchip Law", Callback = function() replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Microchip","2") end })
RaidsTab:CreateButton({ Name = "Start Law Raids", Callback = function() fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector) end })
RaidsTab:CreateToggle({ Name = "Auto Kill Law", CurrentValue = false, Flag = "AutoKillLaw", Callback = function(v) _G.AutoLawKak = v ToggleFeature("Auto Kill Law", v) end })
RaidsTab:CreateSection("Raids Dungeons")
RaidsTab:CreateToggle({ Name = "Auto Farm Dungeon", CurrentValue = false, Flag = "AutoFarmDungeon", Callback = function(v) _G.AutoFarmDungeon = v ToggleFeature("Auto Farm Dungeon", v) end })
RaidsTab:CreateToggle({ Name = "TP Exit 1", CurrentValue = false, Flag = "TPExit1", Callback = function(v) _G.TPFloor1 = v end })
RaidsTab:CreateToggle({ Name = "TP Exit 2", CurrentValue = false, Flag = "TPExit2", Callback = function(v) _G.TPFloor2 = v end })
RaidsTab:CreateToggle({ Name = "TP Exit 3", CurrentValue = false, Flag = "TPExit3", Callback = function(v) _G.TPFloor3 = v end })
RaidsTab:CreateToggle({ Name = "TP Exit 4", CurrentValue = false, Flag = "TPExit4", Callback = function(v) _G.TPFloor4 = v end })

spawn(function() while wait(Sec) do pcall(function() if _G.Random_Auto then replicated.Remotes.CommF_:InvokeServer("Cousin","Buy") end end) end end)
spawn(function() while wait(Sec) do pcall(function() if _G.DropFruit then DropFruits() end end) end end)
spawn(function() while wait(Sec) do pcall(function() if _G.StoreF then UpdStFruit() end end) end end)
spawn(function() while wait(Sec) do pcall(function()
    if _G.TwFruits then for _,x1 in pairs(workspace:GetChildren()) do if string.find(x1.Name, "Fruit") then _tp(x1.Handle.CFrame) end end end
end) end end)
spawn(function() while wait(Sec) do pcall(function() if _G.InstanceF then collectFruits(_G.InstanceF) end end) end end)
spawn(function() while wait() do pcall(function()
    if getgenv().AutoBuyFruitSniper then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", getgenv().SelectFruit)
    end
end) end end)

spawn(function() while task.wait(1) do pcall(function()
    if _G.AutoChipBeli and not GetBP("Special Microchip") then
        replicated.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
    end
end) end end)

spawn(function() while task.wait(1) do pcall(function()
    if _G.AutoChipFruit and not GetBP("Special Microchip") then
        local fruits = replicated.Remotes.CommF_:InvokeServer("GetFruits")
        for _, data in pairs(fruits) do
            if data.Price <= 490000 then
                replicated.Remotes.CommF_:InvokeServer("LoadFruit", tostring(data.Name))
                replicated.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
                break
            end
        end
    end
end) end end)

spawn(function() while task.wait(Sec) do
    if not _G.Auto_StartRaid then continue end
    pcall(function()
        local top = plr.PlayerGui.Main.TopHUDList
        if not top or top.RaidTimer.Visible then return end
        if not GetBP("Special Microchip") then return end
        if World2 then
            local btn = workspace.Map.CircleIsland.RaidSummon2.Button.Main
            if btn then
                if btn:FindFirstChild("ProximityPrompt") then fireproximityprompt(btn.ProximityPrompt)
                elseif btn:FindFirstChild("ClickDetector") then fireclickdetector(btn.ClickDetector) end
            end
        end
        if World3 then
            local btn = workspace.Map["Boat Castle"].RaidSummon2.Button.Main
            if btn then
                if btn:FindFirstChild("ProximityPrompt") then fireproximityprompt(btn.ProximityPrompt)
                elseif btn:FindFirstChild("ClickDetector") then fireclickdetector(btn.ClickDetector) end
            end
        end
    end)
end end)

spawn(function()
    local locations = workspace["_WorldOrigin"].Locations
    local islands = {"Island 1","Island 2","Island 3","Island 4","Island 5"}
    local currentIsland = nil
    while task.wait(0.3) do
        if not _G.Raiding then continue end
        local gui = plr.PlayerGui.Main.TopHUDList.RaidTimer
        if not gui.Visible then continue end
        local char = plr.Character if not char then continue end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum or hum.Health <= 0 then continue end
        if hum.Sit or hum.PlatformStand or root.Anchored then continue end
        local closestDist = 999999
        for _,name in ipairs(islands) do
            local loc = locations:FindFirstChild(name)
            if loc then
                local dist = (root.Position - loc.Position).Magnitude
                if dist < closestDist then closestDist = dist currentIsland = name end
            end
        end
        if not currentIsland then continue end
        local islandPos = locations:FindFirstChild(currentIsland)
        if not islandPos then continue end
        local foundEnemies = false
        for _,mob in ipairs(workspace.Enemies:GetChildren()) do
            local eh = mob:FindFirstChild("Humanoid")
            local ehrp = mob:FindFirstChild("HumanoidRootPart")
            if eh and ehrp and eh.Health > 0 then
                if (ehrp.Position - islandPos.Position).Magnitude < 450 then
                    foundEnemies = true
                    repeat task.wait() Attack.Kill(mob, _G.Raiding) until not _G.Raiding or not mob.Parent or eh.Health <= 0
                end
            end
        end
        if not foundEnemies then
            local idx = table.find(islands, currentIsland)
            if idx and islands[idx+1] then
                local nxt = locations:FindFirstChild(islands[idx+1])
                if nxt then _tp(nxt.CFrame * CFrame.new(0, 45, 120)) end
                currentIsland = islands[idx+1]
                task.wait(1)
            end
        end
    end
end)

spawn(function() while wait(Sec) do pcall(function()
    if _G.Auto_Awakener then
        replicated.Remotes.CommF_:InvokeServer("Awakener","Check")
        replicated.Remotes.CommF_:InvokeServer("Awakener","Awaken")
    end
end) end end)

spawn(function() while wait(Sec) do pcall(function()
    if _G.AutoLawKak then
        local v = GetConnectionEnemies("Order")
        if v then repeat task.wait() Attack.Kill(v, _G.AutoLawKak) until _G.AutoLawKak == false or not v.Parent or v.Humanoid.Health <= 0
        else _tp(CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)) end
    end
end) end end)

spawn(function() while task.wait(0.15) do
    if not _G.AutoFarmDungeon then continue end
    pcall(function()
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end
        for _, mob in pairs(workspace.Enemies:GetChildren()) do
            if not _G.AutoFarmDungeon then break end
            local mh = mob:FindFirstChild("Humanoid")
            local mhrp = mob:FindFirstChild("HumanoidRootPart")
            if mh and mhrp and mh.Health > 0 then
                if (mhrp.Position - hrp.Position).Magnitude <= 5000 then
                    repeat task.wait() Attack.Kill(mob, true) until not _G.AutoFarmDungeon or not mob.Parent or mh.Health <= 0
                end
            end
        end
    end)
end end)

-- ============ LOCAL PLAYER TAB ============
local CombatTab = Window:CreateTab("Local Player", ICON)
CombatTab:CreateSection("Combat / AimBot")
local __AimBotTurn = CombatTab:CreateLabel("Aimbot: False")
spawn(function() while wait(0.2) do pcall(function()
    if _G.AimMethod then
        if (_G.AimCam or _G.AimbotGun) then __AimBotTurn:Set("Aimbot - " .. Checking_AimStatus() .. " : True")
        else __AimBotTurn:Set("Aimbot - Skills : True") end
    else __AimBotTurn:Set("Aimbot - Skills : False") end
end) end end)

Checking_AimStatus = function()
    if _G.AimCam then return "Aimbot Camera"
    elseif _G.AimbotGun then return "Aimbot Guns"
    else return "" end
end

local PlrList = {}
for _, v in pairs(game:GetService("Players"):GetChildren()) do table.insert(PlrList, v.Name) end
CombatTab:CreateDropdown({ Name = "Select Players", Options = PlrList, CurrentOption = PlrList[1] or "None", Flag = "SelectPlayers", Callback = function(o) _G.PlayersList = o end })
CombatTab:CreateToggle({ Name = "Teleport To Select Players", CurrentValue = false, Flag = "TPToPlayers", Callback = function(v) _G.TpPly = v end })
CombatTab:CreateToggle({ Name = "Spectate Select Players", CurrentValue = false, Flag = "SpectatePlayers", Callback = function(v) SpectatePlys = v
    spawn(function() repeat task.wait(0.1)
        if game:GetService("Players"):FindFirstChild(_G.PlayersList) then
            workspace.Camera.CameraSubject = game:GetService("Players"):FindFirstChild(_G.PlayersList).Character.Humanoid
        end
    until not SpectatePlys
    workspace.Camera.CameraSubject = plr.Character.Humanoid end) end })
CombatTab:CreateDropdown({ Name = "Select Aim Method", Options = {"Aim Player","Nearest Aim"}, CurrentOption = "Aim Player", Flag = "SelectAimMethod", Callback = function(o) ABmethod = o end })
CombatTab:CreateToggle({ Name = "Aimbot Method Skills", CurrentValue = false, Flag = "AimbotSkills", Callback = function(v) _G.AimMethod = v ToggleFeature("Aimbot Skills", v) end })
CombatTab:CreateToggle({ Name = "Aimbot Camera Closest Players", CurrentValue = false, Flag = "AimbotCamera", Callback = function(v) _G.AimCam = v ToggleFeature("Aimbot Camera", v) end })

spawn(function() while wait() do pcall(function()
    if _G.AimMethod and ABmethod == "Aim Player" then
        local target = Players:FindFirstChild(_G.PlayersList)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            if target.Team ~= plr.Team then MousePos = target.Character.HumanoidRootPart.Position end
        end
    end
end) end end)
spawn(function() while wait() do pcall(function()
    if _G.AimMethod and ABmethod == "Nearest Aim" then
        local MaxDistance = math.huge
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= plr and v.Team ~= plr.Team and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local Distance = (v.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                if Distance < MaxDistance then MaxDistance = Distance MousePos = v.Character.HumanoidRootPart.Position end
            end
        end
    end
end) end end)

CombatTab:CreateSection("Quests Players")
CombatTab:CreateButton({ Name = "Get Player Quests", Callback = function() pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter") end) end })
CombatTab:CreateToggle({ Name = "Auto Get PlayerQuest", CurrentValue = false, Flag = "AutoGetPlayerQuest", Callback = function(v) _G.AutoReceivePlayerQuest = v ToggleFeature("Auto Get PlayerQuest", v) end })
CombatTab:CreateToggle({ Name = "Auto Kill Player Quest", CurrentValue = false, Flag = "AutoKillPlayerQuest", Callback = function(v) _G.AutoPlayerHunter = v ToggleFeature("Auto Kill PlayerQuest", v) end })
CombatTab:CreateToggle({ Name = "Auto Enable PvP", CurrentValue = false, Flag = "AutoEnablePvP", Callback = function(v) _G.AutoPvP = v ToggleFeature("Auto Enable PvP", v) end })
CombatTab:CreateToggle({ Name = "Auto Safe Mode", CurrentValue = false, Flag = "AutoSafeMode", Callback = function(v) _G.SafeMode = v ToggleFeature("Auto Safe Mode", v) end })

CombatTab:CreateSection("LocalPlayer Settings")
CombatTab:CreateToggle({ Name = "Enable Fly", CurrentValue = false, Flag = "EnableFly", Callback = function(v) if toggleFly then toggleFly(v) end ToggleFeature("Enable Fly", v) end })
CombatTab:CreateSlider({ Name = "Speed Fly Mode", Range = {10,200}, Increment = 1, CurrentValue = 50, Flag = "SpeedFly", Callback = function(v) if updateFlySpeed then updateFlySpeed(v) end end })
CombatTab:CreateToggle({ Name = "Instance Mink V3 [INF]", CurrentValue = false, Flag = "MinkV3INF", Callback = function(v) InfAblities = v end })
CombatTab:CreateToggle({ Name = "Instance Energy [INF]", CurrentValue = false, Flag = "EnergyINF", Callback = function(v) infEnergy = v if v then getInfinity_Ability("Energy", infEnergy) end end })
CombatTab:CreateToggle({ Name = "Instance Soru [INF]", CurrentValue = false, Flag = "SoruINF", Callback = function(v) _G.InfSoru = v if v then getInfinity_Ability("Soru", _G.InfSoru) end end })
CombatTab:CreateToggle({ Name = "Instance Observation Range [INF]", CurrentValue = false, Flag = "ObservationINF", Callback = function(v) _G.InfiniteObRange = v if v then getInfinity_Ability("Observation", _G.InfiniteObRange) end end })
CombatTab:CreateToggle({ Name = "Ignore Same Teams", CurrentValue = false, Flag = "IgnoreSameTeams", Callback = function(v) _G.NoAimTeam = v end })
CombatTab:CreateToggle({ Name = "Accept Allies", CurrentValue = false, Flag = "AcceptAllies", Callback = function(v) _G.AcceptAlly = v ToggleFeature("Accept Allies", v) end })

spawn(function() while wait() do pcall(function()
    if _G.AutoReceivePlayerQuest then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter") end
end) end end)

spawn(function() while wait() do pcall(function()
    if _G.AutoPvP then
        if plr.PlayerGui.Main:FindFirstChild("PvpDisabled") and plr.PlayerGui.Main.PvpDisabled.Visible then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
        end
    end
end) end end)

spawn(function() while wait(0.1) do pcall(function()
    if _G.SafeMode then
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp then _tp(hrp.CFrame * CFrame.new(0, 1000, 0)) end
    end
end) end end)

spawn(function() while wait(Sec) do pcall(function()
    if _G.AcceptAlly then
        for _, v in pairs(game.Players:GetChildren()) do
            if v.Name ~= plr.Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AcceptAlly", v.Name)
            end
        end
    end
end) end end)

spawn(function() while wait(.2) do pcall(function()
    if InfAblities then
        if not plr.Character.HumanoidRootPart:FindFirstChild("Agility") then
            local agility = replicated.FX["Agility"]:Clone()
            agility.Name = "Agility"
            agility.Parent = plr.Character.HumanoidRootPart
        end
    else
        if plr.Character.HumanoidRootPart:FindFirstChild("Agility") then plr.Character.HumanoidRootPart.Agility:Destroy() end
    end
end) end end)
-- ============ TELEPORT TAB ============
local TravelTab = Window:CreateTab("Teleport", ICON)
TravelTab:CreateSection("Travel - Worlds")
TravelTab:CreateButton({ Name = "Travel East Blue (World 1)", Callback = function() replicated.Remotes.CommF_:InvokeServer("TravelMain") end })
TravelTab:CreateButton({ Name = "Travel Dressrosa (World 2)", Callback = function() replicated.Remotes.CommF_:InvokeServer("TravelDressrosa") end })
TravelTab:CreateButton({ Name = "Travel Zou (World 3)", Callback = function() replicated.Remotes.CommF_:InvokeServer("TravelZou") end })
TravelTab:CreateSection("Travel - Island")
local LocationList = {}
for i,v in pairs(workspace["_WorldOrigin"].Locations:GetChildren()) do table.insert(LocationList, v.Name) end
TravelTab:CreateDropdown({ Name = "Select Travelling", Options = LocationList, CurrentOption = LocationList[1] or "None", Flag = "SelectTravel", Callback = function(o) _G.Island = o end })
TravelTab:CreateToggle({ Name = "Auto Travel", CurrentValue = false, Flag = "AutoTravel", Callback = function(v) _G.Teleport = v
    if v then for i, loc in pairs(workspace["_WorldOrigin"].Locations:GetChildren()) do
        if loc.Name == _G.Island then repeat wait() _tp(loc.CFrame * CFrame.new(0,30,0)) until not _G.Teleport or Root.CFrame == loc.CFrame end
    end end end })
TravelTab:CreateSection("Travel - Portal")
local PortalList = {}
if World1 then PortalList = {"Sky","UnderWater"}
elseif World2 then PortalList = {"SwanRoom","Cursed Ship"}
elseif World3 then PortalList = {"Castle On The Sea","Mansion Cafe","Hydra Teleport","Canvendish Room","Temple of Time"} end
TravelTab:CreateDropdown({ Name = "Select Portal", Options = PortalList, CurrentOption = PortalList[1] or "None", Flag = "SelectPortal", Callback = function(o) _G.Island_PT = o end })
TravelTab:CreateButton({ Name = "requestEntrance", Callback = function()
    if _G.Island_PT == "Sky" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894,5547,-380))
    elseif _G.Island_PT == "UnderWater" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163,11,1819))
    elseif _G.Island_PT == "SwanRoom" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(2285,15,905))
    elseif _G.Island_PT == "Cursed Ship" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923,126,32852))
    elseif _G.Island_PT == "Castle On The Sea" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-5097.93164,316.447021,-3142.66602))
    elseif _G.Island_PT == "Mansion Cafe" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875,374.94024658203,-7551.677734375))
    elseif _G.Island_PT == "Hydra Teleport" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5643.45263671875,1013.0858154296875,-340.51025390625))
    elseif _G.Island_PT == "Canvendish Room" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5314.54638671875,22.562219619750977,-127.06755065917969))
    elseif _G.Island_PT == "Temple of Time" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(28310.0234,14895.1123,109.456741)) end end })
TravelTab:CreateSection("Travel - NPCs")
local NPCList_local = {}
for _, v in pairs(replicated.NPCs:GetChildren()) do table.insert(NPCList_local, v.Name) end
TravelTab:CreateDropdown({ Name = "Select NPCs", Options = NPCList_local, CurrentOption = NPCList_local[1] or "None", Flag = "SelectNPC", Callback = function(o) NPClist = o end })
TravelTab:CreateToggle({ Name = "Auto Tween to NPC", CurrentValue = false, Flag = "AutoTweenNPC", Callback = function(v) _G.TPNpc = v ToggleFeature("Auto Tween NPC", v) end })

spawn(function() while wait(Sec) do pcall(function()
    if _G.TPNpc then
        for __, v in pairs(replicated.NPCs:GetChildren()) do
            if v.Name == NPClist then _tp(v.HumanoidRootPart.CFrame) end
        end
    end
end) end end)

-- ============ SHOPPING TAB ============
local ShopTab = Window:CreateTab("Shopping", ICON)
ShopTab:CreateSection("Shop Options")
ShopTab:CreateButton({ Name = "Buy Buso", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuyHaki","Buso") end })
ShopTab:CreateButton({ Name = "Buy Geppo", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuyHaki","Geppo") end })
ShopTab:CreateButton({ Name = "Buy Soru", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuyHaki","Soru") end })
ShopTab:CreateButton({ Name = "Buy Ken", Callback = function() replicated.Remotes.CommF_:InvokeServer("KenTalk","Buy") end })
ShopTab:CreateSection("Fighting - Style")
ShopTab:CreateButton({ Name = "Buy Black Leg", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuyBlackLeg") end })
ShopTab:CreateButton({ Name = "Buy Electro", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuyElectro") end })
ShopTab:CreateButton({ Name = "Buy Fishman Karate", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuyFishmanKarate") end })
ShopTab:CreateButton({ Name = "Buy DragonClaw", Callback = function() replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2") end })
ShopTab:CreateButton({ Name = "Buy Superhuman", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuySuperhuman") end })
ShopTab:CreateButton({ Name = "Buy Death Step", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuyDeathStep") end })
ShopTab:CreateButton({ Name = "Buy Sharkman Karate", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate") end })
ShopTab:CreateButton({ Name = "Buy ElectricClaw", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuyElectricClaw") end })
ShopTab:CreateButton({ Name = "Buy DragonTalon", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuyDragonTalon") end })
ShopTab:CreateButton({ Name = "Buy Godhuman", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuyGodhuman") end })
ShopTab:CreateButton({ Name = "Buy SanguineArt", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuySanguineArt") end })
ShopTab:CreateSection("Accessory")
ShopTab:CreateButton({ Name = "Buy Tomoe Ring", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Tomoe Ring") end })
ShopTab:CreateButton({ Name = "Buy Black Cape", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Black Cape") end })
ShopTab:CreateButton({ Name = "Buy Swordsman Hat", Callback = function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Swordsman Hat") end })
ShopTab:CreateButton({ Name = "Buy Bizarre Rifle", Callback = function() replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Buy", 1) end })
ShopTab:CreateButton({ Name = "Buy Ghoul Mask", Callback = function() replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Buy", 2) end })
ShopTab:CreateSection("Weapon World1")
for _, w in ipairs({"Cutlass","Katana","Iron Mace","Duel Katana","Triple Katana","Pipe","Dual-Headed Blade","Bisento","Soul Cane","Slingshot","Musket","Dual Flintlock","Flintlock","Refined Flintlock","Cannon"}) do
    ShopTab:CreateButton({ Name = "Buy " .. w, Callback = function() replicated.Remotes.CommF_:InvokeServer("BuyItem", w) end })
end
ShopTab:CreateButton({ Name = "Buy Kabucha", Callback = function() replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","2") end })
ShopTab:CreateSection("Fragments shop")
ShopTab:CreateButton({ Name = "Buy Refund Stats", Callback = function() replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","2") end })
ShopTab:CreateButton({ Name = "Buy Reroll Race", Callback = function() replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","2") end })
ShopTab:CreateButton({ Name = "Buy Ghoul Race", Callback = function() replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Change", 4) end })
ShopTab:CreateButton({ Name = "Buy Cyborg Race (2.5k)", Callback = function() replicated.Remotes.CommF_:InvokeServer("CyborgTrainer","Buy") end })

-- ============ MISCELLANEOUS TAB ============
local MiscTab = Window:CreateTab("Miscellaneous", ICON)
MiscTab:CreateSection("Server - Function")
MiscTab:CreateButton({ Name = "Redeem All Codes", Callback = function()
    local codes = {"LIGHTNINGABUSE","1LOSTADMIN","ADMINFIGHT","GIFTING_HOURS","NOMOREHACK","BANEXPLOIT","WildDares","BossBuild","GetPranked","EARN_FRUITS","SUB2GAMERROBOT_RESET1","KITT_RESET","Bignews","CHANDLER","Fudd10","fudd10_v2","Sub2UncleKizaru","FIGHT4FRUIT","kittgaming","TRIPLEABUSE","Sub2CaptainMaui","Sub2Fer999","Enyu_is_Pro","Magicbus","JCWK","Starcodeheo","Bluxxy","SUB2GAMERROBOT_EXP1","Sub2NoobMaster123","Sub2Daigrock","Axiore","TantaiGaming","StrawHatMaine","Sub2OfficialNoobie","TheGreatAce","JULYUPDATE_RESET","ADMINHACKED","SEATROLLING","24NOADMIN","ADMIN_TROLL","NEWTROLL","SECRET_ADMIN","staffbattle","NOEXPLOIT","NOOB2ADMIN","CODESLIDE","fruitconcepts","krazydares"}
    local RedeemRemote = replicated:WaitForChild("Remotes"):FindFirstChild("Redeem")
    if RedeemRemote then for _, code in ipairs(codes) do task.wait(0) pcall(function()
        if RedeemRemote.InvokeServer then RedeemRemote:InvokeServer(code) else RedeemRemote:FireServer(code) end
    end) end end
end })
MiscTab:CreateButton({ Name = "Rejoin Server", Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer) end })
MiscTab:CreateButton({ Name = "Hop Server", Callback = function() Hop() end })
MiscTab:CreateButton({ Name = "Copy JobID", Callback = function() setclipboard(tostring(game.JobId)) end })
MiscTab:CreateInput({ Name = "Input Job ID", PlaceholderText = "Job ID", CurrentValue = "", Flag = "InputJobID",
    Callback = function(v) getgenv().Job = v end })
MiscTab:CreateButton({ Name = "Teleport [Job ID]", Callback = function()
    if getgenv().Job and getgenv().Job ~= "" then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, getgenv().Job, game.Players.LocalPlayer) end end })
MiscTab:CreateSection("Player Gui / Others")
MiscTab:CreateButton({ Name = "Open Awakenings Expert", Callback = function() plr.PlayerGui.Main.AwakeningToggler.Visible = true end })
MiscTab:CreateButton({ Name = "Open Title Selection", Callback = function() replicated.Remotes.CommF_:InvokeServer("getTitles",true) plr.PlayerGui.Main.Titles.Visible = true end })
MiscTab:CreateToggle({ Name = "Disable Chat GUI", CurrentValue = false, Flag = "DisableChat", Callback = function(v) game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, not v) end })
MiscTab:CreateToggle({ Name = "Disable Leaderboard GUI", CurrentValue = false, Flag = "DisableLeaderboard", Callback = function(v) game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, not v) end })
MiscTab:CreateButton({ Name = "Set Pirate Team", Callback = function() Pirates() end })
MiscTab:CreateButton({ Name = "Set Marine Team", Callback = function() Marines() end })
MiscTab:CreateSection("Graphics / Haki Stats")
MiscTab:CreateDropdown({ Name = "Select Haki States", Options = {"State 0","State 1","State 2","State 3","State 4","State 5"}, CurrentOption = "State 0", Flag = "SelectHakiState", Callback = function(o) _G.SelectStateHaki = o end })
MiscTab:CreateButton({ Name = "ChangeBusoStage", Callback = function()
    local n = tonumber(string.match(_G.SelectStateHaki or "State 0", "%d+"))
    if n then replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", n) end end })
MiscTab:CreateToggle({ Name = "Turn on Fast Mode", CurrentValue = false, Flag = "FastMode", Callback = function(v) if v then
    for _, zx in next, workspace:GetDescendants() do if table.find(Past, zx.ClassName) then zx.Material = "Plastic" end end
end end })
MiscTab:CreateToggle({ Name = "Turn on Low CPU", CurrentValue = false, Flag = "LowCPU", Callback = function(v) if v then LowCpu() end end })
MiscTab:CreateButton({ Name = "Remove Sky Fog", Callback = function()
    if Lighting:FindFirstChild("LightingLayers") then Lighting.LightingLayers:Destroy() end
    if Lighting:FindFirstChild("SeaTerrorCC") then Lighting.SeaTerrorCC:Destroy() end
    if Lighting:FindFirstChild("FantasySky") then Lighting.FantasySky:Destroy() end end })
MiscTab:CreateToggle({ Name = "Turn on Full Bright", CurrentValue = false, Flag = "FullBright", Callback = function(v)
    if v then Lighting.Ambient = Color3.new(1,1,1) Lighting.ColorShift_Bottom = Color3.new(1,1,1) Lighting.ColorShift_Top = Color3.new(1,1,1)
    else Lighting.Ambient = Color3.new(0,0,0) Lighting.ColorShift_Bottom = Color3.new(0,0,0) Lighting.ColorShift_Top = Color3.new(0,0,0) end end })
MiscTab:CreateDropdown({ Name = "Select Time", Options = {"Day","Night"}, CurrentOption = "Day", Flag = "SelectTime", Callback = function(o) _G.SelectDN = o end })
MiscTab:CreateToggle({ Name = "Turn on Time", CurrentValue = false, Flag = "TurnOnTime", Callback = function(v) _G.daylightN = v end })
MiscTab:CreateToggle({ Name = "Turn on Walk on Water", CurrentValue = true, Flag = "WalkWater", Callback = function(v) _G.WalkWater_Part = v
    if v then workspace.Map["WaterBase-Plane"].Size = Vector3.new(1000,112,1000)
    else workspace.Map["WaterBase-Plane"].Size = Vector3.new(1000,80,1000) end end })
MiscTab:CreateToggle({ Name = "Turn on Ice Walk", CurrentValue = false, Flag = "IceWalk", Callback = function(v) _G.WalkWater = v end })
MiscTab:CreateToggle({ Name = "Kill Aura", CurrentValue = false, Flag = "KillAura", Callback = function(v) _G.KillAuraFull = v ToggleFeature("Kill Aura", v) end })

spawn(function() while task.wait() do pcall(function()
    if _G.daylightN then
        if _G.SelectDN == "Day" then Lighting.ClockTime = 12
        elseif _G.SelectDN == "Night" then Lighting.ClockTime = 0 end
    end
end) end end)

-- ============ NOTIFY ============
Rayfield:Notify({
   Title = "Apple Cat Hub",
   Content = "Đã tải thành công! Join Discord: discord.gg/a4Sd2FBj6V",
   Duration = 8,
   Image = 109364250143878,
})