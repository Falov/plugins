local PLUGIN = PLUGIN

PLUGIN.name = "Fallov hud"
PLUGIN.description = "My private hud"
PLUGIN.author = "Fallov"

if (CLIENT) then

  function PLUGIN:ShouldHideBars() -- Removing bars for all players because why would you want two HUDs
    return true
  end

  function PLUGIN:HUDPaint()
    if LocalPlayer():GetCharacter() != nil then
      local ply = LocalPlayer()

	surface.CreateFont("MyFont",{
	  font = "Baloo Tamma",
	  extended = false,
	  size = 32,
	  weight = 500,
	  blursize = 0,
	  scanlines = 0,
	  antialias = true,
	  underline = false,
	  italic = false,
	  strikeout = false,
	  symbol = false,
	  rotary = false,
	  shadow = true,
	  additive = false,
	  outline = false,
	 })
	
	surface.CreateFont("MyFont2",{
	  font = "Baloo Tamma",
	  extended = false,
	  size = 25,
	  weight = 500,
	  blursize = 0,
	  scanlines = 0,
	  antialias = true,
	  underline = false,
	  italic = false,
	  strikeout = false,
	  symbol = false,
	  rotary = false,
	  shadow = true,
	  additive = false,
	  outline = false,
	})
	
	  -- icon hud health
	  local healthIcon = ix.util.GetMaterial("materials/icehp32.png")
	  surface.SetDrawColor(240, 248, 255)
	  surface.SetMaterial(healthIcon)
	  surface.DrawTexturedRect(5, 865, 30, 30)
          surface.DrawTexturedRect(40, ScrH() - 30, 290 * (math.Clamp(ply:Health() / ply:GetMaxHealth(), 0, 0)), 20)
          draw.SimpleText(" " .. LocalPlayer():Health() .. "%","MyFont", 40, ScrH() - 33,Color( 240, 248, 255 ),TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
      
	 --icon hud Armor
	  local armorIcon = ix.util.GetMaterial("materials/icearmour32.png")
	  surface.SetDrawColor(240, 248, 255)
	  surface.SetMaterial(armorIcon)
	  surface.DrawTexturedRect(100, 865, 30, 30)
          surface.DrawTexturedRect(1, ScrH() - 55, 290 * (math.Clamp(ply:Armor() / ply:GetMaxArmor(), 0, 0)), 20)
          draw.SimpleText(" " .. LocalPlayer():Armor() .. "%","MyFont", 135, ScrH() - 33,Color( 255, 255, 255, 255 ),TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

      --icon hud Stamina
	  local staminaIcon = ix.util.GetMaterial("materials/iceplayer32.png")
	  surface.SetDrawColor(240, 248, 255)
	  surface.SetMaterial(staminaIcon)
	  surface.DrawTexturedRect(195, 865, 30, 30)
          surface.DrawTexturedRect(1, ScrH() - 80, 290 * (math.Clamp(ply:GetLocalVar("stm", 100) / 100, 0, 0)), 20)
          draw.SimpleText(" " .. (math.Round(LocalPlayer():GetLocalVar("stm", 100),0)) .. "%","MyFont", 230, ScrH() - 33,Color( 255, 255, 255, 255 ),TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	  
	 --icon hud Money
	  local moneyIcon = ix.util.GetMaterial("materials/icesalary32.png")
	  surface.SetDrawColor(240, 248, 255)
	  surface.SetMaterial(moneyIcon)
	  surface.DrawTexturedRect(380, 865, 30, 30)	
          draw.SimpleText(" " .. ply:GetCharacter():GetMoney(),"MyFont", 415, ScrH() - 33, Color( 255, 255, 255, 255 ),TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
      
	  --icon hud hunger
	  local hungerIcon = ix.util.GetMaterial("materials/icehunger32.png")
	  surface.SetDrawColor(240, 248, 255)
	  surface.SetMaterial(hungerIcon)
	  surface.DrawTexturedRect(290, 865, 30, 30)
	  draw.SimpleText(" " .. ply:GetCharacter():GetHunger().. "%","MyFont", 325, ScrH() - 33, Color( 255, 255, 255, 255 ),TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
	  
	  --icon hud Fraction
	  local fractionIcon = ix.util.GetMaterial("materials/icecoins32.png")
	  surface.SetDrawColor(240, 248, 255)
	  surface.SetMaterial(fractionIcon)
	  surface.DrawTexturedRect(5, 810, 30, 30)
	  draw.SimpleText(" " .. (ix.faction.Get(ply:GetCharacter():GetFaction()).name),"MyFont2", 40, ScrH() - 88, Color( 255, 255, 255, 255 ),TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
      
	  --icon hud Name
	  local nameIcon = ix.util.GetMaterial("materials/iceuser32.png")
	  surface.SetDrawColor(240, 248, 255)
	  surface.SetMaterial(nameIcon)
	  surface.DrawTexturedRect(5, 770, 30, 30)
	  draw.SimpleText(" " .. ply:GetCharacter():GetName(),"MyFont", 40, ScrH() - 128, Color( 255, 255, 255, 255 ),TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)
    end
  end
end

function PLUGIN:PlayerDraw()
  if (CLIENT) then
    PlayerView = vgui.Create( "DModelPanel" )
    PlayerView:SetPos(240, ScrH() - 215)
    PlayerView:SetSize( 290, 210 )
    gameevent.Listen("player_spawn")
    hook.Add("player_spawn", "SpawnModel",function()
    -- TODO
      PlayerView:SetModel(LocalPlayer():GetModel())
      local eyepos = PlayerView.Entity:GetBonePosition(PlayerView.Entity:LookupBone("ValveBiped.Bip01_Head1"))
      PlayerView:SetFOV(70)
      PlayerView:SetCamPos(Vector(30, 0, 68))
      PlayerView:SetLookAt(eyepos)
      PlayerView:SetAnimated(true)
      function PlayerView:LayoutEntity( ply ) return end
    end)
    if PlayerView:GetModel() == nil then -- lifesaver
      PlayerView:SetModel(LocalPlayer():GetModel())
      local eyepos = PlayerView.Entity:GetBonePosition(PlayerView.Entity:LookupBone("ValveBiped.Bip01_Head1"))
      PlayerView:SetFOV(70)
      PlayerView:SetCamPos(Vector(30, 0, 68))
      PlayerView:SetLookAt(eyepos)
      PlayerView:SetAnimated(true)
      function PlayerView:LayoutEntity( ply ) return end
    end
  end
end

if (SERVER) then

  function PLUGIN:PlayerInitialSpawn(ply)
    netstream.Start(ply, "CreateHUD")
  end
end

if (CLIENT) then
  netstream.Hook("CreateHUD", function(data)
    timer.Create("HUDCreate", 1, 0 ,function() -- This is important DO NOT TOUCH!
      local ply = LocalPlayer()
        timer.Remove("HUDCreate")
      end)
  end)
  concommand.Add("HUDFail", function() -- More of a debug command, or one to be used if a player's hud doesn't spawn.
    PLUGIN:PlayerDraw()
  end)
end
