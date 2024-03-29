local weapmenu = menu.list(menu.my_root(), WEAP_MENU, {}, "")

menu.slider(weapmenu, IMPACT_SCALE, {""}, "", 0, 2147483646, 1, 1, function(s)
	GRAPHICS.SET_PARTICLE_FX_BULLET_IMPACT_SCALE(s)
end)
menu.toggle_loop(weapmenu, SHOOT_PED, {""}, "", function()
	pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
	if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then 
		pedspawn = PED.CREATE_RANDOM_PED(pos.x, pos.y, pos.z)
		ENTITY.SET_ENTITY_ROTATION(pedspawn, rot.x, rot.y, rot.z, 1, false)
		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(pedspawn, 1, 0, 1000, 0, false, true, true, true)
	end
end)
driveit = off
menu.toggle(weapmenu, DRIVE_IT, {}, DRIVE_IT_DESC, function(on)
	driveit = on
	while driveit do
		driveitgun()
		util.yield()
	end
end)
delgun = off
menu.toggle(weapmenu, DEL_GUN, {}, DEL_GUN_DESC, function(on)
	delgun = on
	while delgun do
		deletegun()
		util.yield()
	end
end)
invweap = off
menu.toggle(weapmenu, INV_WEAP, {}, "", function(on)
	invweap = on
	while invweap do
		curweap = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(plyped())
		ENTITY.SET_ENTITY_VISIBLE(curweap, false, false)
		util.yield()
	end
	curweap = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(plyped())
	ENTITY.SET_ENTITY_VISIBLE(curweap, true, false)
end)
weaponback = off
menu.toggle(weapmenu, WEAPON_ON_BACK, {}, "", function(on)
	weaponback = on
	if weaponback then
		spawnweapon = 0
	end
	curweap = HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())
	if not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == -1569615261) and weaponback then
		spawnweapon = WEAPON.CREATE_WEAPON_OBJECT(curweap, 1, pos.x, pos.y, pos.z, true, 1, 0)
		attachweapon(spawnweapon)
	end
	while weaponback do
		if (WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(plyped()) == 0) then
			if not (spawnweapon == 0) then
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, true, false)
			end
		else
			ENTITY.SET_ENTITY_VISIBLE(spawnweapon, false, false)
		end
		if not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == curweap) and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == -1569615261) then
			if not (spawnweapon == 0) then
				entities.delete_by_handle(spawnweapon)
			end
			curweap = HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())
			requestweapon(curweap)
			spawnweapon = WEAPON.CREATE_WEAPON_OBJECT(curweap, 1, pos.x, pos.y, pos.z, true, 1, 0)
			if (WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(plyped()) == 0) then
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, true, false)
			else
				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, false, false)
			end
			attachweapon(spawnweapon)
		end
		util.yield()
	end
	entities.delete_by_handle(spawnweapon)
end)