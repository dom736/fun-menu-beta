miscmenu = menu.list(menu.my_root(), MISC_MENU, {"miscmenu"}, "")
miscwindmenu = menu.list(miscmenu, WIND_SUBMENU, {"windmenu"}, "")
miscrainmenu = menu.list(miscmenu, RAINSNOW_SUBMENU, {"rainsnowmenu"}, "")
mischudmenu = menu.list(miscmenu, HUD_SUBMENU, {"hudmenu"}, "")
hudminimapmenu = menu.list(miscmenu,MINIMAP_SUBMENU, {"minimapmenu"}, "")
miscwatermenu = menu.list(miscmenu, WATER_SUBMENU, {"watermenu"}, "")
miscphonemenu = menu.list(miscmenu, PHONE_SUBMENU, {"phonemenu"}, "")
miscphonebgmenu = menu.list(miscphonemenu, PHONE_BG_MENU, {"phonebgmenu"}, "")
miscpostfxmenu = menu.list(miscmenu, "POSTFX", {"postfxmenu"}, "")
misclightmenu = menu.list(miscmenu, LIGHT_MENU, {"lightmenu"}, "")
hidehudmenu = menu.list(mischudmenu, HIDE_HUD_SUBMENU, {"hudhide"}, "")
showhudmenu = menu.list(mischudmenu, SHOW_HUD_SUBMENU, {"hudshow"}, "")

forcejump = off
menu.toggle(miscmenu, FORCE_JUMP, {"jumpinterior"}, FORCE_JUMP_DESC, function(on)
	forcejump = on
	while forcejump do
		if PAD.IS_CONTROL_PRESSED(298, 298) then
			MISC._SET_FORCE_PLAYER_TO_JUMP(PLAYER.PLAYER_ID())
		end
		util.yield()
	end
end)

menu.action(miscmenu, SPAWN_RANDOM, {"spawnrandomped"}, "", function()
	pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	PED.CREATE_RANDOM_PED(pos.x, pos.y, pos.z)
end)

menu.toggle_loop(hidehudmenu, "WANTED_STARS", {"wantedstar"}, "", function()
	HUD.HIDE_HUD_COMPONENT_THIS_FRAME(1)
end)

menu.toggle_loop(hidehudmenu, "WEAPON_ICON", {"hideweaponicon"}, "", function()
	HUD.HIDE_HUD_COMPONENT_THIS_FRAME(2)
end)

menu.toggle_loop(hidehudmenu, "CASH", {"hidecash"}, "", function()
	HUD.HIDE_HUD_COMPONENT_THIS_FRAME(3)
	HUD.HIDE_HUD_COMPONENT_THIS_FRAME(4)
end)

menu.toggle_loop(hidehudmenu, "VEHICLE_NAME", {"hidevehname"}, "", function()
	HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
end)

menu.toggle_loop(hidehudmenu, "AREA_NAME", {"hideareaname"}, "", function()
	HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
end)

menu.toggle_loop(hidehudmenu, "STREET_NAME", {"hidestreetname"}, "", function()
	HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
end)

menu.toggle_loop(hidehudmenu, "RETICLE", {"hidereticle"}, "", function()
	HUD.HIDE_HUD_COMPONENT_THIS_FRAME(14)
end)

menu.toggle_loop(hidehudmenu, "RADIO_STATIONS", {"hideradio"}, "", function()
	HUD.HIDE_HUD_COMPONENT_THIS_FRAME(16)
end)

menu.toggle_loop(hidehudmenu, "WEAPON_WHEEL", {"hideweaponwheel"}, "", function()
	HUD.HIDE_HUD_COMPONENT_THIS_FRAME(19)
end)

menu.toggle_loop(hidehudmenu, "WEAPON_WHEEL_STATS", {"hideweaponstat"}, "", function()
	HUD.HIDE_HUD_COMPONENT_THIS_FRAME(20)
end)

menu.toggle_loop(showhudmenu, "WEAPON_ICON", {"showweaponicon"}, "", function()
	HUD.SHOW_HUD_COMPONENT_THIS_FRAME(2)
	util.yield()
end)

menu.toggle_loop(showhudmenu, "CASH", {"showcash"}, "", function()
	HUD.SHOW_HUD_COMPONENT_THIS_FRAME(3)
	HUD.SHOW_HUD_COMPONENT_THIS_FRAME(4)
	util.yield()
end)

menu.toggle_loop(showhudmenu, "VEHICLE_NAME", {"showvehiclename"}, "", function()
	HUD.SHOW_HUD_COMPONENT_THIS_FRAME(6)
	util.yield()
end)

menu.toggle_loop(showhudmenu, "AREA_NAME", {"showareaname"}, "", function()
	HUD.SHOW_HUD_COMPONENT_THIS_FRAME(7)
	util.yield()
end)

menu.toggle_loop(showhudmenu, "STREET_NAME", {"showstreetname"}, "", function()
	HUD.SHOW_HUD_COMPONENT_THIS_FRAME(9)
	util.yield()
end)

menu.toggle_loop(showhudmenu, "RETICLE", {"showreticle"}, "", function()
	HUD.SHOW_HUD_COMPONENT_THIS_FRAME(14)
end)

mapzoom = 1
menu.slider(hudminimapmenu, MINIMAP_ZOOM, {"minimapzoom"}, "", 0, 100, 0, 1, function(s)
    HUD.SET_RADAR_ZOOM_PRECISE(s)
end)

mapangle = 0
menu.slider(hudminimapmenu, MINIMAP_ANGLE, {"minimapanglme"}, "", 0, 360, 0, 1, function(s)
    mapangle = s
end)

mapanglet = off
menu.toggle(hudminimapmenu, MINIMAP_ANGLE_LOCK, {"lockminimapangle"}, "", function(on)
	mapanglet = on
	while mapanglet do
		HUD.LOCK_MINIMAP_ANGLE(mapangle)
		util.yield()
	end
	HUD.UNLOCK_MINIMAP_ANGLE()
end)


menu.toggle(hudminimapmenu, SONAR_ON_MINIMAP, {"sonaronmap"}, "", function(on)
	HUD._SET_MINIMAP_SONAR_ENABLED(on)
end)

 centermap = off
menu.toggle(hudminimapmenu, CENTER_MAP, {"centermap"}, "", function(on)
	centermap = on
	while centermap do 
		HUD.DONT_TILT_MINIMAP_THIS_FRAME()
		util.yield()
	end
end)

menu.slider(miscwindmenu, WIND_SPEED, {"windspeed"}, WIND_SPEED_DESC, -1, 12, -1, 1, function(s)
	MISC.SET_WIND_SPEED(s)
end)

menu.slider(miscwindmenu, WIND_DIRECTION, {"winddir"}, WIND_DIRECTION_DESC, -1, 360, -1, 1, function(s)
	MISC.SET_WIND_DIRECTION(s)
end)

menu.action(miscrainmenu, FORCE_FLASH, {"forcelightningflash"}, "", function()
	MISC.FORCE_LIGHTNING_FLASH()
end)

menu.slider(miscrainmenu, RAIN_LEVEL, {"rainlevel"}, RAIN_LEVEL_DESC, -1, 10, -1, 1, function(s)
	sf = s/10
	MISC._SET_RAIN_LEVEL(sf)
end)

menu.slider(miscrainmenu, SNOW_LEVEL, {"snowlevel"}, SNOW_LEVEL_DESC, -1, 10, -1, 1, function(s)
	sf = s/10
	MISC._SET_SNOW_LEVEL(sf)
end)

menu.slider(miscwatermenu, WATER_TYPE, {"watertype"}, "", 0, 1, 0, 1, function(s)
	STREAMING._LOAD_GLOBAL_WATER_TYPE(s)
end)

pht = 0
menu.slider(miscphonemenu, PHONE_TYPE, {"phonetype"}, PHONE_TYPE_DESC, 0, 6, 0, 1, function(s)
	pht = s
end)

menu.toggle_loop(miscphonemenu, OVRD_PHONE_TYPE, {"overridephonetype"}, "", function()
	if PAD.IS_CONTROL_JUST_PRESSED(1, 27) then
		util.yield(100)
		MOBILE.CREATE_MOBILE_PHONE(pht)	
	end
end)

menu.toggle_loop(miscphonemenu, OVRD_PHONE_SCALE, {"overridephonescale"}, "", function()
	phsf = phs*100
	MOBILE.SET_MOBILE_PHONE_SCALE(phsf)
end)

 phs = 5
menu.slider(miscphonemenu, PHONE_SCALE, {"phonescale"}, "", 0, 100, 5, 1, function(s)
	phs = s
end)

phrotx = 270
menu.slider(miscphonemenu, PHONE_ROT_X, {""}, "", 0, 360, 270, 1, function(s)
	phrotx = s
end)

phroty = 0
menu.slider(miscphonemenu, PHONE_ROT_Y, {""}, "", 0, 360, 0, 1, function(s)
	phroty = s
end)

phrotz = 0
menu.slider(miscphonemenu, PHONE_ROT_Z, {""}, "", 0, 360, 0, 1, function(s)
	phrotz = s
end)

tableimagename = {}
tableimagepath = {}
for i, v in ipairs(filesystem.list_files(phonebgdir)) do
    if not (string.find(v, ".ytd") == nil) then
        tableimagename[i] = string.gsub(string.gsub(v, ".ytd", ""), filesystem.store_dir().."funmenu"..string.char(92).."Phone BG Image//", "")
        util.register_file(v)
    end
end

menu.toggle_loop(miscphonebgmenu, TUTO_PHONE_BG, {"alwayshost"}, "", function()
    directx.draw_text(0.5, 0.5, TUTO_BG_TEXT, 5, 0.75, {r = 255, g = 255, b = 255, a = 255}, true)
end)
selectedimagebg = ""
imagebgphone = menu.list_action(miscphonebgmenu, SELECTED_IMG, {"bgphone"}, "", tableimagename, function(s)
    menu.set_menu_name(imagebgphone, SELECTED_IMG..tableimagename[s])
    selectedimagebg = tableimagename[s]

end)

menu.toggle_loop(miscphonebgmenu, REPLACE_BG, {}, "", function()
    if not (selectedimagebg == "") then
	    txd = memory.alloc()
	    memory.write_string(txd, selectedimagebg)
	    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(memory.read_int(memory.script_global(20247)), "SET_BACKGROUND_CREW_IMAGE")
	    GRAPHICS.BEGIN_TEXT_COMMAND_SCALEFORM_STRING("CELL_2000")
	    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(selectedimagebg)
	    GRAPHICS.END_TEXT_COMMAND_SCALEFORM_STRING()
	    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    end
end)


creditgta = off
menu.toggle(miscmenu, CREDIT_GTA, {"gtacredit"}, "", function(on)
	creditgta = on
	MISC.SET_CREDITS_ACTIVE(on)
end)

menu.toggle_loop(miscmenu, GET_HOST, {"alwayshost"}, "", function()
	if not (players.get_host() == PLAYER.PLAYER_ID()) and not util.is_session_transition_active() then
		if not (PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**") then
			menu.trigger_commands("kick"..PLAYER.GET_PLAYER_NAME(players.get_host()))
			util.yield(200)
		end
	end
end)

menu.toggle_loop(miscmenu, FORCE_VISIBLE, {}, "", function()
	for _, player in ipairs(players.list(false, true, true)) do
		ENTITY.SET_ENTITY_VISIBLE(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player), true, false)
	end
end)

menu.toggle(miscpostfxmenu, "ArenaEMP", {"postfxArenaEMP"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("ArenaEMP", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("ArenaEMP")
		GRAPHICS.ANIMPOSTFX_PLAY("ArenaEMPOut")
    end
end)

menu.toggle(miscpostfxmenu, "ArenaWheelPurple", {"postfxArenaWheelPurple"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("ArenaWheelPurple", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("ArenaWheelPurple")
    end
end)

menu.action(miscpostfxmenu, "BeastIntroScene", {"postfxBeastIntroScene"}, "", function()
        GRAPHICS.ANIMPOSTFX_PLAY("BeastIntroScene", 0, true)
end)

menu.toggle(miscpostfxmenu, "BeastLaunch", {"postfxBeastLaunch"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("BeastLaunch", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("BeastLaunch")
    end
end)

menu.action(miscpostfxmenu, "BeastTransition", {"postfxBeastTransition"}, "", function()
        GRAPHICS.ANIMPOSTFX_PLAY("BeastTransition", 0, true)
end)

menu.toggle(miscpostfxmenu, "BikerFormation", {"postfxBikerFormation"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("BikerFormation", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("BikerFormation")
		GRAPHICS.ANIMPOSTFX_PLAY("BikerFormationOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "BulletTime", {"postfxBulletTime"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("BulletTime", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("BulletTime")
		GRAPHICS.ANIMPOSTFX_PLAY("BulletTimeOut", 0, true)
    end
end)

menu.action(miscpostfxmenu, "CamPushInFranklin", {"postfxCamPushInFranklin"}, "", function()
        GRAPHICS.ANIMPOSTFX_PLAY("CamPushInFranklin", 0, true)
end)

menu.action(miscpostfxmenu, "CamPushInMichael", {"postfxCamPushInMichael"}, "", function()
        GRAPHICS.ANIMPOSTFX_PLAY("CamPushInMichael", 0, true)
end)

menu.action(miscpostfxmenu, "CamPushInNeutral", {"postfxCamPushInNeutral"}, "", function()
        GRAPHICS.ANIMPOSTFX_PLAY("CamPushInNeutral", 0, true)
end)

menu.action(miscpostfxmenu, "CamPushInTrevor", {"postfxCamPushInTrevor"}, "", function()
        GRAPHICS.ANIMPOSTFX_PLAY("CamPushInTrevor", 0, true)
end)

menu.action(miscpostfxmenu, "CarDamageHit", {"postfxCarDamageHit"}, "", function()
        GRAPHICS.ANIMPOSTFX_PLAY("CarDamageHit", 0, true)
end)

menu.action(miscpostfxmenu, "CarPitstopHealth", {"postfxCarPitstopHealth"}, "", function()
        GRAPHICS.ANIMPOSTFX_PLAY("CarPitstopHealth", 0, true)
end)

menu.toggle(miscpostfxmenu, "ChopVision", {"postfxChopVision"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("ChopVision", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("ChopVision")
    end
end)

menu.toggle(miscpostfxmenu, "CrossLine", {"postfxCrossLine"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("CrossLine", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("CrossLine")
		GRAPHICS.ANIMPOSTFX_PLAY("CrossLineOut", 0, true)
    end
end)

menu.action(miscpostfxmenu, "DanceIntensity01", {"postfxDanceIntensity01"}, "", function()
        GRAPHICS.ANIMPOSTFX_PLAY("DanceIntensity01", 0, true)
end)

menu.action(miscpostfxmenu, "DanceIntensity02", {"postfxDanceIntensity02"}, "", function()
        GRAPHICS.ANIMPOSTFX_PLAY("DanceIntensity02", 0, true)
end)

menu.action(miscpostfxmenu, "DanceIntensity03", {"postfxDanceIntensity03"}, "", function()
        GRAPHICS.ANIMPOSTFX_PLAY("DanceIntensity03", 0, true)
end)

menu.toggle(miscpostfxmenu, "DeadlineNeon", {"postfxDeadlineNeon"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("DeadlineNeon", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("DeadlineNeon")
    end
end)
	
menu.toggle(miscpostfxmenu, "DeathFailMPDark", {"postfxDeathFailMPDark"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("DeathFailMPDark", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("DeathFailMPDark")
    end
end)

menu.toggle(miscpostfxmenu, "DeathFailMPIn", {"postfxDeathFailMPIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("DeathFailMPIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("DeathFailMPIn")
    end
end)

menu.toggle(miscpostfxmenu, "DeathFailNeutralIn", {"postfxDeathFailNeutralIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("DeathFailNeutralIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("DeathFailNeutralIn")
    end
end)

menu.toggle(miscpostfxmenu, "DeathFailOut", {"postfxDeathFailOut"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("DeathFailOut", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("DeathFailOut")
    end
end)

menu.action(miscpostfxmenu, "DefaultBlinkOutro", {"postfxDefaultBlinkOutro"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("DefaultBlinkOutro", 0, true)
end)

menu.toggle(miscpostfxmenu, "DMT_flight", {"postfxDMT_flight"}, "", function(on)
	if on then
		GRAPHICS.ANIMPOSTFX_PLAY("DMT_flight_intro", 0, true)
		util.yield(3000)
		GRAPHICS.ANIMPOSTFX_STOP("DMT_flightintro")
        GRAPHICS.ANIMPOSTFX_PLAY("DMT_flight", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("DMT_flight")
		GRAPHICS.ANIMPOSTFX_STOP("DMT_flight_intro")
    end
end)

menu.toggle(miscpostfxmenu, "Dont_tazeme_bro", {"postfxDont_tazeme_bro"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("Dont_tazeme_bro", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("Dont_tazeme_bro")
    end
end)

menu.toggle(miscpostfxmenu, "DrugsDrivingOut", {"postfxDrugsDrivingOut"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("DrugsDrivingOut", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("DrugsDrivingOut")
    end
end)

menu.action(miscpostfxmenu, "ExplosionJosh3", {"postfxExplosionJosh3"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("ExplosionJosh3", 0, true)
end)

menu.toggle(miscpostfxmenu, "FocusIn", {"postfxFocusIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("FocusIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("FocusIn")
		GRAPHICS.ANIMPOSTFX_PLAY("FocusOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "Heist4CameraFlash", {"postfxHeist4CameraFlash"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("Heist4CameraFlash", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("Heist4CameraFlash")
    end
end)

menu.toggle(miscpostfxmenu, "Heist4CameraFlash2", {"postfxHeist4CameraFlash2"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("Heist4CameraFlash2", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("Heist4CameraFlash2")
    end
end)

menu.toggle(miscpostfxmenu, "HeistCelebEnd", {"postfxHeistCelebEnd"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("HeistCelebEnd", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("HeistCelebEnd")
    end
end)

menu.toggle(miscpostfxmenu, "HeistCelebFail", {"postfxHeistCelebFail"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("HeistCelebFail", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("HeistCelebFail")
    end
end)

menu.toggle(miscpostfxmenu, "HeistCelebFailBW", {"postfxHeistCelebFailBW"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("HeistCelebFailBW", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("HeistCelebFailBW")
    end
end)
	
menu.toggle(miscpostfxmenu, "HeistCelebPass", {"postfxHeistCelebPass"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("HeistCelebPass", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("HeistCelebPass")
    end
end)

menu.toggle(miscpostfxmenu, "HeistCelebPassBW", {"postfxHeistCelebPassBW"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("HeistCelebPassBW", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("HeistCelebPassBW")
    end
end)

menu.action(miscpostfxmenu, "HeistLocate", {"postfxHeistLocate"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("HeistLocate", 0, true)
end)

menu.action(miscpostfxmenu, "HeistTripSkipFade", {"postfxHeistTripSkipFade"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("HeistTripSkipFade", 0, true)
end)

menu.toggle(miscpostfxmenu, "InchOrange", {"postfxInchOrange"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("InchOrange", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("InchOrange")
		GRAPHICS.ANIMPOSTFX_PLAY("InchOrangeOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "InchPickup", {"postfxInchPickup"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("InchPickup", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("InchPickup")
		GRAPHICS.ANIMPOSTFX_PLAY("InchPickupOut", 0, true)
    end
end)
	
menu.toggle(miscpostfxmenu, "InchPurple", {"postfxInchPurple"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("InchPurple", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("InchPurple")
		GRAPHICS.ANIMPOSTFX_PLAY("InchPurpleOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "LostTimeDay", {"postfxLostTimeDay"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("LostTimeDay", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("LostTimeDay")
    end
end)

menu.toggle(miscpostfxmenu, "LostTimeNight", {"postfxLostTimeNight"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("LostTimeNight", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("LostTimeNight")
    end
end)

menu.toggle(miscpostfxmenu, "MenuMGFranklinIn", {"postfxMenuMGFranklinIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MenuMGFranklinIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MenuMGFranklinIn")
		GRAPHICS.ANIMPOSTFX_PLAY("MenuMGFranklinOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "MenuMGHeistIn", {"postfxMenuMGHeistIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MenuMGHeistIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MenuMGHeistIn")
		GRAPHICS.ANIMPOSTFX_PLAY("MenuMGHeistOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "MenuMGHeistIntro", {"postfxMenuMGHeistIntro"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MenuMGHeistIntro", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MenuMGHeistIntro")
    end
end)

menu.toggle(miscpostfxmenu, "MenuMGHeistTint", {"postfxMenuMGHeistTint"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MenuMGHeistTint", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MenuMGHeistTint")
    end
end)

menu.toggle(miscpostfxmenu, "MenuMGIn", {"postfxMenuMGIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MenuMGIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MenuMGIn")
    end
end)


menu.toggle(miscpostfxmenu, "MenuMGIslandHeistIn", {"postfxMenuMGIslandHeistIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MenuMGIslandHeistIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MenuMGIslandHeistIn")
    end
end)

menu.toggle(miscpostfxmenu, "MenuMGMichaelIn", {"postfxMenuMGMichaelIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MenuMGMichaelIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MenuMGMichaelIn")
		GRAPHICS.ANIMPOSTFX_PLAY("MenuMGMichaelOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "MenuMGRemixIn", {"postfxMenuMGRemixIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MenuMGRemixIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MenuMGRemixIn")
    end
end)

menu.toggle(miscpostfxmenu, "MenuMGSelectionIn", {"postfxMenuMGSelectionIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MenuMGSelectionIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MenuMGSelectionIn")
    end
end)

menu.toggle(miscpostfxmenu, "MenuMGSelectionTint", {"postfxMenuMGSelectionTint"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MenuMGSelectionTint", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MenuMGSelectionTint")
    end
end)


menu.toggle(miscpostfxmenu, "MenuMGTournamentIn", {"postfxMenuMGTournamentIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MenuMGTournamentIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MenuMGTournamentIn")
    end
end)

menu.toggle(miscpostfxmenu, "MenuMGTournamentTint", {"postfxMenuMGTournamentTint"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MenuMGTournamentTint", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MenuMGTournamentTint")
    end
end)

menu.toggle(miscpostfxmenu, "MenuMGTrevorIn", {"postfxMenuMGTrevorIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MenuMGTrevorIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MenuMGTrevorIn")
		GRAPHICS.ANIMPOSTFX_PLAY("MenuMGTrevorOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "MenuSurvivalAlienIn", {"postfxMenuSurvivalAlienIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MenuSurvivalAlienIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MenuSurvivalAlienIn")
    end
end)

menu.action(miscpostfxmenu, "MinigameEndFranklin", {"postfxMinigameEndFranklin"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("MinigameEndFranklin", 0, true)
end)


menu.action(miscpostfxmenu, "MinigameEndMichael", {"postfxMinigameEndMichael"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("MinigameEndMichael", 0, true)
end)

menu.action(miscpostfxmenu, "MinigameEndNeutral", {"postfxMinigameEndNeutral"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("MinigameEndNeutral", 0, true)
end)

menu.action(miscpostfxmenu, "MinigameEndTrevor", {"postfxMinigameEndTrevor"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("MinigameEndTrevor", 0, true)
end)

menu.toggle(miscpostfxmenu, "MinigameTransitionIn", {"postfxMinigameTransitionIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MinigameTransitionIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MinigameTransitionIn")
		GRAPHICS.ANIMPOSTFX_PLAY("MinigameTransitionOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "MP_Bull_tost", {"postfxMP_Bull_tost"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MP_Bull_tost", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MP_Bull_tost")
    end
end)


menu.toggle(miscpostfxmenu, "MP_Celeb_Lose", {"postfxMP_Celeb_Lose"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MP_Celeb_Lose", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MP_Celeb_Lose")
		GRAPHICS.ANIMPOSTFX_PLAY("MP_Celeb_Lose_Out", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "MP_Celeb_Preload", {"postfxMP_Celeb_Preload"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MP_Celeb_Preload", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MP_Celeb_Preload")
		GRAPHICS.ANIMPOSTFX_PLAY("MP_Celeb_Preload_Fade", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "MP_Celeb_Win", {"postfxMP_Celeb_Win"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MP_Celeb_Win", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MP_Celeb_Win")
		GRAPHICS.ANIMPOSTFX_PLAY("MP_Celeb_Win_Out", 0, true)
    end
end)


menu.action(miscpostfxmenu, "MP_corona_switch", {"postfxMP_corona_switch"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("MP_corona_switch", 0, true)
end)

menu.action(miscpostfxmenu, "MP_corona_switch_supermod", {"postfxMP_corona_switch_supermod"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("MP_corona_switch_supermod", 0, true)
end)

menu.action(miscpostfxmenu, "MP_intro_logo", {"postfxMP_intro_logo"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("MP_intro_logo", 0, true)
end)


menu.toggle(miscpostfxmenu, "MP_job_load", {"postfxMP_job_load"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MP_job_load", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MP_job_load")
    end
end)

menu.toggle(miscpostfxmenu, "MP_OrbitalCannon", {"postfxMP_OrbitalCannon"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MP_OrbitalCannon", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MP_OrbitalCannon")
    end
end)

menu.toggle(miscpostfxmenu, "MP_race_crash", {"postfxMP_race_crash"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("MP_race_crash", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("MP_race_crash")
    end
end)


menu.action(miscpostfxmenu, "MP_SmugglerCheckpoint", {"postfxMP_SmugglerCheckpoint"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("MP_SmugglerCheckpoint", 0, true)
end)

menu.action(miscpostfxmenu, "MP_TransformRaceFlash", {"postfxMP_TransformRaceFlash"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("MP_TransformRaceFlash", 0, true)
end)

menu.toggle(miscpostfxmenu, "MP_WarpCheckpoint", {"postfxMP_WarpCheckpoint"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("MP_WarpCheckpoint", 0, true)
end)


menu.toggle(miscpostfxmenu, "pennedIn", {"postfxpennedIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("pennedIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("pennedIn")
		GRAPHICS.ANIMPOSTFX_PLAY("PennedInOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "PeyoteEndIn", {"postfxPeyoteEndIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("PeyoteEndIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("PeyoteEndIn")
		GRAPHICS.ANIMPOSTFX_PLAY("PeyoteEndOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "PeyoteIn", {"postfxPeyoteIns"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("PeyoteIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("PeyoteIn")
		GRAPHICS.ANIMPOSTFX_PLAY("PeyoteOut", 0, true)
    end
end)


menu.action(miscpostfxmenu, "PokerCamTransition", {"postfxPokerCamTransition"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("PokerCamTransition", 0, true)
end)

menu.toggle(miscpostfxmenu, "PPFilter", {"postfxPPFilter"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("PPFilter", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("PPFilter")
		GRAPHICS.ANIMPOSTFX_PLAY("PPFilterOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "PPGreen", {"postfxPPGreen"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("PPGreen", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("PPGreen")
		GRAPHICS.ANIMPOSTFX_PLAY("PPGreenOut", 0, true)
    end
end)


menu.toggle(miscpostfxmenu, "PPOrange", {"postfxPPOrange"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("PPOrange", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("PPOrange")
		GRAPHICS.ANIMPOSTFX_PLAY("PPOrangeOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "PPPink", {"postfxPPPink"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("PPPink", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("PPPink")
		GRAPHICS.ANIMPOSTFX_PLAY("PPPinkOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "PPPurple", {"postfxPPPurple"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("PPPurple", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("PPPurple")
		GRAPHICS.ANIMPOSTFX_PLAY("PPPurpleOut", 0, true)
    end
end)


menu.toggle(miscpostfxmenu, "RaceTurbo", {"postfxRaceTurbo"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("RaceTurbo", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("RaceTurbo")
    end
end)

menu.toggle(miscpostfxmenu, "Rampage", {"postfxRampage"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("Rampage", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("Rampage")
		GRAPHICS.ANIMPOSTFX_PLAY("RampageOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "REDMIST", {"postfxREDMIST"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("REDMIST", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("REDMIST")
		GRAPHICS.ANIMPOSTFX_PLAY("REDMISTOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "RemixDrone", {"postfxRemixDrone"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("RemixDrone", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("RemixDrone")
    end
end)

menu.toggle(miscpostfxmenu, "SniperOverlay", {"postfxSniperOverlay"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("SniperOverlay", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("SniperOverlay")
    end
end)

menu.action(miscpostfxmenu, "SuccessFranklin", {"postfxSuccessFranklin"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SuccessFranklin", 0, true)
end)

menu.action(miscpostfxmenu, "SuccessMichael", {"postfxSuccessMichael"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SuccessMichael", 0, true)
end)

menu.action(miscpostfxmenu, "SuccessNeutral", {"postfxSuccessNeutral"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SuccessNeutral", 0, true)
end)

menu.action(miscpostfxmenu, "SuccessTrevor", {"postfxSuccessTrevor"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SuccessTrevor", 0, true)
end)

menu.toggle(miscpostfxmenu, "SurvivalAlien", {"postfxSurvivalAlien"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("SurvivalAlien", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("SurvivalAlien")
    end
end)

menu.toggle(miscpostfxmenu, "SwitchHUDFranklinIn", {"postfxSwitchHUDFranklinIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchHUDFranklinIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("SwitchHUDFranklinIn")
		GRAPHICS.ANIMPOSTFX_PLAY("SwitchHUDFranklinOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "SwitchHUDIn", {"postfxSwitchHUDIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchHUDIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("SwitchHUDIn")
		GRAPHICS.ANIMPOSTFX_PLAY("SwitchHUDOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "SwitchHUDMichaelIn", {"postfxSwitchHUDMichaelIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchHUDMichaelIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("SwitchHUDMichaelIn")
		GRAPHICS.ANIMPOSTFX_PLAY("SwitchHUDMichaelOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "SwitchHUDTrevorIn", {"postfxSwitchHUDTrevorIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchHUDTrevorIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("SwitchHUDTrevorIn")
		GRAPHICS.ANIMPOSTFX_PLAY("SwitchHUDTrevorOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "SwitchOpenFranklin", {"postfxSwitchOpenFranklin"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchOpenFranklin", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("SwitchOpenFranklin")
    end
end)

menu.toggle(miscpostfxmenu, "SwitchOpenMichaelIn", {"postfxSwitchOpenMichaelIn"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchOpenMichaelIn", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("SwitchOpenMichaelIn")
    end
end)

menu.toggle(miscpostfxmenu, "SwitchOpenMichaelMid", {"postfxSwitchOpenMichaelMid"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchOpenMichaelMid", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("SwitchOpenMichaelMid")
    end
end)

menu.toggle(miscpostfxmenu, "SwitchOpenNeutralFIB5", {"postfxSwitchOpenNeutralFIB5"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchOpenNeutralFIB5", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("SwitchOpenNeutralFIB5")
    end
end)

menu.toggle(miscpostfxmenu, "SwitchOpenNeutralOutHeist", {"postfxSwitchOpenNeutralOutHeist"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchOpenNeutralOutHeist", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("SwitchOpenNeutralOutHeist")
    end
end)

menu.action(miscpostfxmenu, "SwitchSceneFranklin", {"postfxSwitchSceneFranklin"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchSceneFranklin", 0, true)
end)

menu.action(miscpostfxmenu, "SwitchSceneMichael", {"postfxSwitchSceneMichael"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchSceneMichael", 0, true)
end)

menu.action(miscpostfxmenu, "SwitchSceneNetural", {"postfxSwitchSceneNetural"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchSceneNetural", 0, true)
end)

menu.action(miscpostfxmenu, "SwitchSceneTrevor", {"postfxSwitchSceneTrevor"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchSceneTrevor", 0, true)
end)

menu.action(miscpostfxmenu, "SwitchShortFranklinIn", {"postfxSwitchShortFranklinIn"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchShortFranklinIn", 0, true)
end)

menu.action(miscpostfxmenu, "SwitchShortFranklinMid", {"postfxSwitchShortFranklinMid"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchShortFranklinMid", 0, true)
end)

menu.action(miscpostfxmenu, "SwitchShortMichaelIn", {"postfxSwitchShortMichaelIn"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchShortMichaelIn", 0, true)
end)

menu.action(miscpostfxmenu, "SwitchShortMichaelMid", {"postfxSwitchShortMichaelMid"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchShortMichaelMid", 0, true)
end)
menu.action(miscpostfxmenu, "SwitchShortNeutralIn", {"postfxSwitchShortNeutralIn"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchShortNeutralIn", 0, true)
end)

menu.action(miscpostfxmenu, "SwitchShortTrevorIn", {"postfxSwitchShortTrevorIn"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchShortTrevorIn", 0, true)
end)

menu.action(miscpostfxmenu, "SwitchShortTrevorMid", {"postfxSwitchShortTrevorMid"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("SwitchShortTrevorMid", 0, true)
end)

menu.toggle(miscpostfxmenu, "TinyRacerGreen", {"postfxTinyRacerGreen"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("TinyRacerGreen", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("TinyRacerGreen")
		GRAPHICS.ANIMPOSTFX_PLAY("TinyRacerGreenOut", 0, true)
    end
end)

menu.toggle(miscpostfxmenu, "TinyRacerIntroCam", {"postfxTinyRacerIntroCam"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("TinyRacerIntroCam", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("TinyRacerIntroCam")
    end
end)

menu.toggle(miscpostfxmenu, "TinyRacerPink", {"postfxTinyRacerPink"}, "", function(on)
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("TinyRacerPink", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("TinyRacerPink")
		GRAPHICS.ANIMPOSTFX_PLAY("TinyRacerPinkOut", 0, true)
    end
end)

menu.action(miscpostfxmenu, "WeaponUpgrade", {"postfxWeaponUpgrade"}, "", function(on)
        GRAPHICS.ANIMPOSTFX_PLAY("WeaponUpgrade", 0, true)
end)

rlight = 255
menu.slider(misclightmenu, "R", {"lightred"}, "", 0, 255, 255, 1, function(s)
	rlight = s 
end)

glight = 255
menu.slider(misclightmenu, "G", {"lightgreen"}, "", 0, 255, 255, 1, function(s)
	glight = s
end)

blight = 255
menu.slider(misclightmenu, "B", {"lightblue"}, "", 0, 255, 255, 1, function(s)
	blight = s
end)

Radiuslight = 1
menu.slider(misclightmenu, LIGHT_RADIUS, {"lightradius"}, "", 0, 9000, 1, 1, function(s)
	Radiuslight = s
end)

intenslight = 1
menu.slider(misclightmenu, LIGHT_INTENS, {"lightintensity"}, "", 0, 1000, 1, 1, function(s)
	intenslight = s
end)

menu.toggle_loop(misclightmenu, LIGHT_ON, {"lighton"}, "", function()
	GRAPHICS.DRAW_LIGHT_WITH_RANGE(pos.x, pos.y, pos.z, rlight, glight, blight, Radiuslight, intenslight)
end)

menu.toggle(miscmenu, SKY_IS_THE_LIMIT, {"noboundary"}, "", function(on)
	skyisthelimit = on
	while skyisthelimit do
		PLAYER.EXTEND_WORLD_BOUNDARY_FOR_PLAYER(pos.x, pos.y, pos.z)
		util.yield()
	end
	PLAYER.RESET_WORLD_BOUNDARY_FOR_PLAYER()
end)

menu.toggle(miscmenu, NO_PLAYER_PED_OCCLUSION, {"noocclusion"}, "", function(on)
	nopedocclusion = on
	while nopedocclusion do
		disableocclusion(false)
		util.yield()
	end
	disableocclusion(true)
end)

menu.toggle(miscmenu, DISABLE_STORE, {}, "", function(on)
	nostore = on
	while nostore do
		NETWORK.SET_STORE_ENABLED(false)
		util.yield()
	end
	NETWORK.SET_STORE_ENABLED(true)
end, true)