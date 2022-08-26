vehmenu = menu.list(menu.my_root(), VEHICULE_MENU, {}, "")
vehflymenu = menu.list(vehmenu, VEH_FLY_SUBMENU, {}, "")
vehspeedmettermenu = menu.list(vehmenu, SPEED_METTER, {}, "")
vehspeedmettersettingmenu = menu.list(vehspeedmettermenu, SPEED_METTER_SETTING, {}, "")
vehspeedmettertexturemenu = menu.list(vehspeedmettermenu, SPEED_METTER_TEXTURE, {}, "")

successiadrive = pcall(require, iadrive)
if not successiadrive then
	util.toast(FAIL_LOAD1.."ia drive"..FAIL_LOAD2)
end

vehflystop = off
menu.toggle(vehflymenu, VEH_FLY_STOP, {}, "", function(on)
    vehflystop = on
end)

menu.toggle_loop(vehmenu, VEH_FLY, {"vehfly"}, "", function(toggle)
if not (veh == 0) then
    rotation = CAM.GET_GAMEPLAY_CAM_ROT(2)
    ENTITY.SET_ENTITY_ROTATION(veh, rotation.x, rotation.y, rotation.z, 2, true)
	if not (PAD.IS_CONTROL_PRESSED(2, 34) or PAD.IS_CONTROL_PRESSED(2, 35) or PAD.IS_CONTROL_PRESSED(2, 21) or PAD.IS_CONTROL_PRESSED(2, 36) or PAD.IS_CONTROL_PRESSED(2, 32) or PAD.IS_CONTROL_PRESSED(2, 33)) and vehflystop then
		ENTITY.FREEZE_ENTITY_POSITION(veh, true)
	end

    if PAD.IS_CONTROL_PRESSED(2, 34) then   --left
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, -2, 0, 0, false, true, true, true)
		ENTITY.FREEZE_ENTITY_POSITION(veh, false)
    end

    if PAD.IS_CONTROL_PRESSED(2, 35) then   --right
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 2, 0, 0, false, true, true, true)
		ENTITY.FREEZE_ENTITY_POSITION(veh, false)
    end

    if PAD.IS_CONTROL_PRESSED(2, 21) then   --up
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0, 0, 2, false, true, true, true)
		ENTITY.FREEZE_ENTITY_POSITION(veh, false)
    end

    if PAD.IS_CONTROL_PRESSED(2, 36) then   --down
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0, 0, -2, false, true, true, true)
		ENTITY.FREEZE_ENTITY_POSITION(veh, false)
    end

    if PAD.IS_CONTROL_PRESSED(2, 32) then   --forward
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0, 2, 0, false, true, true, true)
		ENTITY.FREEZE_ENTITY_POSITION(veh, false)
    end

    if PAD.IS_CONTROL_PRESSED(2, 33) then   --backward
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0, -2, 0, false, true, true, true)
		ENTITY.FREEZE_ENTITY_POSITION(veh, false)
    end
	ENTITY.FREEZE_ENTITY_POSITION(veh, false)
end
end)

coordscreenspeedmetterx = 800
menu.slider(vehspeedmettersettingmenu, X_SPEED_METTER, {"xcoordspeedmetter"}, "", 0, xscreensize, 800, 1, function(s)
    coordscreenspeedmetterx = s
 end)

coordscreenspeedmettery = 800
menu.slider(vehspeedmettersettingmenu, Y_SPEED_METTER, {"ycoordspeedmetter"}, "", 0, yscreensize, 800, 1, function(s)
    coordscreenspeedmettery = s
 end)
alphaspeedmetter = 1
menu.slider(vehspeedmettersettingmenu, A_SPEED_METTER, {"alphaspeedometter"}, "", 1, 100, 100, 1, function(s)
	sf = s/100
    alphaspeedmetter = sf
 end)

sizespeedmetter = 0.05
menu.slider(vehspeedmettersettingmenu, S_SPEED_METTER, {"sizespeedometter"}, "", 1, 100, 5, 1, function(s)
	sf = s/100
    sizespeedmetter = sf
 end)

speedmettertexture = 0
menu.toggle(vehspeedmettertexturemenu, DEFAULT_SPEED_METTER_TEXTURE, {"speedmeterdefault"}, "", function()
	if (getmenuvalue(VEHICULE_MENU..">"..SPEED_METTER..">"..SPEED_METTER_TEXTURE..">"..CHERAX_SPEED_METTER_TEXTURE) == 1) and (getmenuvalue(VEHICULE_MENU..">"..SPEED_METTER..">"..SPEED_METTER_TEXTURE..">"..DEFAULT_SPEED_METTER_TEXTURE) == 1) then
		menu.trigger_commands("speedmetercherax off")
	end
	if (getmenuvalue(VEHICULE_MENU..">"..SPEED_METTER..">"..SPEED_METTER_TEXTURE..">"..DEFAULT_SPEED_METTER_TEXTURE) == 1) then
		speedmettertexture = 0  
	end
	if (getmenuvalue(VEHICULE_MENU..">"..SPEED_METTER..">"..SPEED_METTER_TEXTURE..">"..DEFAULT_SPEED_METTER_TEXTURE) == 0) and (getmenuvalue(VEHICULE_MENU..">"..SPEED_METTER..">"..SPEED_METTER_TEXTURE..">"..CHERAX_SPEED_METTER_TEXTURE) == 0) then
		menu.trigger_commands("speedmeterdefault on")
	end
end, true)
menu.toggle(vehspeedmettertexturemenu, CHERAX_SPEED_METTER_TEXTURE, {"speedmetercherax"}, "", function()
	if (getmenuvalue(VEHICULE_MENU..">"..SPEED_METTER..">"..SPEED_METTER_TEXTURE..">"..DEFAULT_SPEED_METTER_TEXTURE) == 1) and (getmenuvalue(VEHICULE_MENU..">"..SPEED_METTER..">"..SPEED_METTER_TEXTURE..">"..CHERAX_SPEED_METTER_TEXTURE) == 1) then
		menu.trigger_commands("speedmeterdefault off")
	end
	if (getmenuvalue(VEHICULE_MENU..">"..SPEED_METTER..">"..SPEED_METTER_TEXTURE..">"..CHERAX_SPEED_METTER_TEXTURE) == 1) then
		speedmettertexture = 1
	end
	if (getmenuvalue(VEHICULE_MENU..">"..SPEED_METTER..">"..SPEED_METTER_TEXTURE..">"..DEFAULT_SPEED_METTER_TEXTURE) == 0) and (getmenuvalue(VEHICULE_MENU..">"..SPEED_METTER..">"..SPEED_METTER_TEXTURE..">"..CHERAX_SPEED_METTER_TEXTURE) == 0) then
		menu.trigger_commands("speedmetercherax on")
	end
end)

speedmetter = off
menu.toggle(vehspeedmettermenu, "Activate speedmetter", {}, "", function(on)
	speedmetter = on
	if speedmetter then
		alphaspeedmetterf = 0
	else
		alphaspeedmetterf = alphaspeedmetter
	end
	while speedmetter do
		if (speedmettertexture == 0) then
			needleid = speedmetterneedleid
			radiantid = speedmeterradiantid
			rpmradiantid = speedmeterrpmraddiantid
			rpmneedleid = speedmetterneedleid
			ratiorotspeed = 0.5625
			ratiorpm = 0.00625
			stoprotrpm = 1
			ratioscreen = 10
		else
			needleid = speedmetterneedleidcherax
			radiantid = speedmeterradiantidcherax
			rpmradiantid = speedmeterrrpmidcherax
			rpmneedleid = speedmetterneedleidcherax
			ratiorotspeed = 1.125
			ratiorpm = 0.0062
			stoprotrpm = 0.55555555555
			ratioscreen = 7.39583333333
		end
		if PED.IS_PED_IN_VEHICLE(plyped(), veh, true) then
			entityspeedmetter = ENTITY.GET_ENTITY_SPEED(veh)
			rpmspeedmetter = entities.get_rpm(entities.get_user_vehicle_as_pointer())*10000
			needlerot = ((ratiorotspeed*entityspeedmetter)/100)
			if needlerot > 0.755 then
				needlerot = 0.755
			end
			needlerotrpm = ((ratiorpm*rpmspeedmetter)/100)
			if needlerotrpm > stoprotrpm then
				needlerotrpm = stoprotrpm
			end
			coordscreenspeedmetterxfinal = (1/xscreensize)*coordscreenspeedmetterx
			coordscreenspeedmetteryfinal = (1/yscreensize)*coordscreenspeedmettery
			coordscreenspeedmetterxrpmfinal = (1/xscreensize)*(coordscreenspeedmetterx-(xscreensize*ratioscreen/100))
			coordscreenspeedmetteryrpmfinal = (1/yscreensize)*(coordscreenspeedmettery)
			if alphaspeedmetterf < 0 then 
				alphaspeedmetterf = 0
			end
			if alphaspeedmetterf < alphaspeedmetter then
				alphaspeedmetterf = alphaspeedmetterf+0.01
			end
			if alphaspeedmetterf >alphaspeedmetter then
				alphaspeedmetterf = alphaspeedmetterf-0.01
			end
			directx.draw_texture(radiantid, sizespeedmetter, 0.1, 0.5, 0.5, coordscreenspeedmetterxfinal, coordscreenspeedmetteryfinal, 0, 1, 1, 1, alphaspeedmetterf)
			directx.draw_texture(needleid, sizespeedmetter, 0.1, 0.5, 0.5, coordscreenspeedmetterxfinal, coordscreenspeedmetteryfinal, needlerot, 1, 1, 1, alphaspeedmetterf)
			directx.draw_texture(rpmradiantid, sizespeedmetter, 0.1, 0.5, 0.5, coordscreenspeedmetterxrpmfinal, coordscreenspeedmetteryfinal, 0, 1, 1, 1, alphaspeedmetterf)
			directx.draw_texture(rpmneedleid, sizespeedmetter, 0.1, 0.5, 0.5, coordscreenspeedmetterxrpmfinal, coordscreenspeedmetteryfinal, needlerotrpm, 1, 1, 1, alphaspeedmetterf)
		end
		if not (alphaspeedmetterf == 0 ) and not PED.IS_PED_IN_VEHICLE(plyped(), veh, true)then
			alphaspeedmetterf = alphaspeedmetterf-0.01
			directx.draw_texture(radiantid, sizespeedmetter, 0.1, 0.5, 0.5, coordscreenspeedmetterxfinal, coordscreenspeedmetteryfinal, 0, 1, 1, 1, alphaspeedmetterf)
			directx.draw_texture(needleid, sizespeedmetter, 0.1, 0.5, 0.5, coordscreenspeedmetterxfinal, coordscreenspeedmetteryfinal, needlerot, 1, 1, 1, alphaspeedmetterf)
			directx.draw_texture(rpmradiantid, sizespeedmetter, 0.1, 0.5, 0.5, coordscreenspeedmetterxrpmfinal, coordscreenspeedmetteryfinal, 0, 1, 1, 1, alphaspeedmetterf)
			directx.draw_texture(rpmneedleid, sizespeedmetter, 0.1, 0.5, 0.5, coordscreenspeedmetterxrpmfinal, coordscreenspeedmetteryfinal, needlerotrpm, 1, 1, 1, alphaspeedmetterf)
		end
		util.yield()
	end
	while not (alphaspeedmetterf < 0 ) and not speedmetter do
		if (speedmettertexture == 0) then
			needleid = speedmetterneedleid
			radiantid = speedmeterradiantid
		else
			needleid = speedmetterneedleidcherax
			radiantid = speedmeterradiantidcherax
		end
		alphaspeedmetterf = alphaspeedmetterf-0.01
		directx.draw_texture(radiantid, sizespeedmetter, 0.1, 0.5, 0.5, coordscreenspeedmetterxfinal, coordscreenspeedmetteryfinal, 0, 1, 1, 1, alphaspeedmetterf)
		directx.draw_texture(needleid, sizespeedmetter, 0.1, 0.5, 0.5, coordscreenspeedmetterxfinal, coordscreenspeedmetteryfinal, needlerot, 1, 1, 1, alphaspeedmetterf)
		directx.draw_texture(rpmradiantid, sizespeedmetter, 0.1, 0.5, 0.5, coordscreenspeedmetterxrpmfinal, coordscreenspeedmetteryfinal, 0, 1, 1, 1, alphaspeedmetterf)
		directx.draw_texture(rpmneedleid, sizespeedmetter, 0.1, 0.5, 0.5, coordscreenspeedmetterxrpmfinal, coordscreenspeedmetteryfinal, needlerotrpm, 1, 1, 1, alphaspeedmetterf)
		util.yield()
	end
end)

menu.toggle_loop(vehmenu, AUTO_REPAIR, {}, "", function()
	if VEHICLE.GET_DOES_VEHICLE_HAVE_DAMAGE_DECALS(veh) or not VEHICLE.ARE_ALL_VEHICLE_WINDOWS_INTACT(veh) then
		fixveh(veh)
		util.yield(100)
	end
end)

hornboost = off
menu.toggle(vehmenu, HORN_BOOST, {}, "", function(on)
    hornboost = on
	while hornboost do
		if PAD.IS_CONTROL_PRESSED(86, 86) then
            pos = ENTITY.GET_ENTITY_SPEED(veh)
            hfclc = hornforce/100
            hornforcef = hfclc+1
			VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, pos*hornforcef)
		end
		util.yield()
	end
end)

hornforce = 1
menu.slider(vehmenu, HORN_BOOST_FORCE, {""}, "", 1, 9, 1, 1, function(s)
    hornforce = s
end)

menu.toggle_loop(vehmenu, SUPER_DRIVE, {""}, "", function()
	if PAD.IS_CONTROL_PRESSED(2, 32) then   --forward
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0, 1, 0, false, true, true, true)
		ENTITY.FREEZE_ENTITY_POSITION(veh, false)
    end

    if PAD.IS_CONTROL_PRESSED(2, 33) then   --backward
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0, -1, 0, false, true, true, true)
		ENTITY.FREEZE_ENTITY_POSITION(veh, false)
    end
end)

inviciblecarlight = off
menu.toggle(vehmenu, INVINC_CAR_LIGHT, {}, INVINC_CAR_LIGHT_DESC, function(on)
    inviciblecarlight = on
	while inviciblecarlight do
		VEHICLE.SET_VEHICLE_HAS_UNBREAKABLE_LIGHTS(veh, true)
		util.yield()
	end
	VEHICLE.SET_VEHICLE_HAS_UNBREAKABLE_LIGHTS(veh, false)
end)

nopop = off
menu.toggle(vehmenu, NO_CAR_POP, {}, "", function(on)
    nopop = on
	while nopop do
		AUDIO.ENABLE_VEHICLE_EXHAUST_POPS(veh, false)
		util.yield()
	end
	AUDIO.ENABLE_VEHICLE_EXHAUST_POPS(veh, true)
end)

menu.action(vehmenu, RAISE_ROOF, {}, "", function()
	VEHICLE.RAISE_CONVERTIBLE_ROOF(veh, true)
	util.yield(100)
	VEHICLE.RAISE_CONVERTIBLE_ROOF(veh, true)
end)

menu.action(vehmenu, LOWER_ROOF, {}, "", function()
	VEHICLE.LOWER_CONVERTIBLE_ROOF(veh, true)
end)


menu.toggle_loop(vehmenu, KEEP_ON, {}, KEEP_ON_DESC, function()
	if VEHICLE.IS_THIS_MODEL_A_HELI(ENTITY.GET_ENTITY_MODEL(veh)) or VEHICLE.IS_THIS_MODEL_A_PLANE(ENTITY.GET_ENTITY_MODEL(veh)) then
		VEHICLE.SET_HELI_BLADES_FULL_SPEED(veh)
	else
		VEHICLE.SET_VEHICLE_ENGINE_ON(veh, true, true, true)
	end
end)

menu.toggle_loop(vehmenu, NO_DEPTH_LIMIT, {}, NO_DEPTH_LIMIT_DESC, function()
	if ENTITY.GET_ENTITY_MODEL(veh) == util.joaat("submersible") or ENTITY.GET_ENTITY_MODEL(veh) == util.joaat("submersible2") or ENTITY.GET_ENTITY_MODEL(veh) == util.joaat("avisa") or ENTITY.GET_ENTITY_MODEL(veh) == util.joaat("kosatka") then
		VEHICLE.SET_SUBMARINE_CRUSH_DEPTHS(veh, false , 1000, 1000, 1000)
	end
end)

anchor = off
menu.toggle(vehmenu, ANCHOR_BOAT, {}, "", function(on)
    anchor = on
	while anchor do 
		VEHICLE.SET_BOAT_ANCHOR(veh, true)
		VEHICLE._SET_BOAT_FROZEN_WHEN_ANCHORED(veh, true)
		util.yield()
	end
	VEHICLE.SET_BOAT_ANCHOR(veh, false)
	VEHICLE._SET_BOAT_FROZEN_WHEN_ANCHORED(veh, false)
end)

menu.toggle_loop(vehmenu, ANCHOR_BOAT_LEAVE, {}, ANCHOR_BOAT_LEAVE_DESC, function(on)
	veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
	if veh == 0 then
		if VEHICLE.IS_THIS_MODEL_A_BOAT(ENTITY.GET_ENTITY_MODEL(vehlast)) then
			VEHICLE.SET_BOAT_ANCHOR(vehlast, true)
			VEHICLE._SET_BOAT_FROZEN_WHEN_ANCHORED(vehlast, true)
		end
	else
		if VEHICLE.IS_THIS_MODEL_A_BOAT(ENTITY.GET_ENTITY_MODEL(vehlast)) then
			VEHICLE.SET_BOAT_ANCHOR(veh, false)
			VEHICLE._SET_BOAT_FROZEN_WHEN_ANCHORED(veh, false)
		end
	end
		
end)

menu.slider(vehmenu, FORKLIFT_HEIGTH, {""}, FORKLIFT_HEIGTH_DESC, 0, 10, 0, 1, function(s)
	sf = s/10
	VEHICLE.SET_FORKLIFT_FORK_HEIGHT(veh, sf)
 end)

menu.action(vehmenu, EJECT_WINDSHIELD, {}, "", function()
	VEHICLE.POP_OUT_VEHICLE_WINDSCREEN(veh)
end)

invincpart = off
menu.toggle(vehmenu, UNBREAKABLE_PART, {}, "", function(on)
    invincpart = on
	while invincpart do
		VEHICLE.SET_VEHICLE_STRONG(veh, true)
		util.yield()
	end
	VEHICLE.SET_VEHICLE_STRONG(veh, false)
end)

menu.toggle(vehmenu, STICK_TO_GROUND, {}, "", function(on)
	sticktoground = on
	while sticktoground do
		if not VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(veh) then
			VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(veh, 50)
			util.yield(100)
		end
		util.yield()
	end
end)

easyenter = off
menu.toggle(vehmenu, EASY_ENTER, {}, "", function(on)
	easyenter = on
	while easyenter do
		if not (PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(plyped()) == 0) then
			requestControlLoop(PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(plyped()))
			VEHICLE.BRING_VEHICLE_TO_HALT(PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(plyped()), 0, 1)
		end
		util.yield()
	end
end)
menu.toggle_loop(vehmenu, DRIVE_ON_WALL, {}, "", function()
	ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0, 0, -0.2, false, true, true, true)
end)
menu.toggle_loop(vehmenu, ANTI_CARJACKING, {}, "", function()
	if not (veh == 0) then
		plyseat = 0
		for i = -1, 30 do
			if (VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, i) == plyped()) then
				plyseat = i
			end
		end
		if PED.IS_PED_BEING_JACKED(plyped()) then
			PED.SET_PED_INTO_VEHICLE(plyped(), veh, plyseat)
		end
	end
end)