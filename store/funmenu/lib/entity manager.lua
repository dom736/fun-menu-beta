entitymanagerlist = menu.list(menu.my_root(), ENTITY_MANAGE, {}, "")
vehmanager = off
menu.toggle(entitymanagerlist, ACTIVATE_VEH_MANAGER, {"vehmanager"}, "", function(on)
	vehmanager = on
end)
pedmanager = off
menu.toggle(entitymanagerlist, ACTIVATE_PED_MANAGER, {"pedmanager"}, "", function(on)
	pedmanager = on
end)
objectmanager = off
toggleobjmanager = menu.toggle(entitymanagerlist, ACTIVATE_OBJECT_MANAGER, {"objmanager"}, "", function(on)
	if not objectmanager then
		menu.trigger_commands("objmanager off")
		menu.show_warning(toggleobjmanager, CLICK_MENU, OBJECT_WARN, function() 
			objectmanager = true
			menu.trigger_commands("objmanager on")
		end)
	else
		objectmanager = on
	end
end)
vehmanagerlist = menu.list(entitymanagerlist, VEH_MANAGER, {}, "")
vehiclelist = {}
vehhandle = {}
pedmanagerlist = menu.list(entitymanagerlist, PED_MANAGER, {}, "")
pedlist = {}
pedhandle = {}
objectmanagerlist = menu.list(entitymanagerlist, OBJECT_MANAGER, {}, "")
objectlist = {}
objecthandle = {}
util.create_tick_handler(function()
	vehmanagerhandle = {}
	if (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) and vehmanager then
		vehmanagerhandle = entities.get_all_vehicles_as_handles()
	end
	pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	for _, vehicule in ipairs(vehmanagerhandle) do
		if ENTITY.DOES_ENTITY_EXIST(vehicule) and (vehiclelist[vehicule] == nil) and vehmanager and (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) then
			vehhandle[vehicule] = vehicule
			manufacturer = HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(VEHICLE.GET_MAKE_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(vehicule)))
			if (manufacturer == "NULL") then
				manufacturer = ""
			end
			carname = HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(vehicule)))
			if (carname == "NULL") then
				carname = ""
			end
			espace = " "
			if (manufacturer == "") then
				espace = ""
			end
			posnameveh = ENTITY.GET_ENTITY_COORDS(vehicule)
			posnameveh = v3.distance(pos, posnameveh)
			finalvehname = manufacturer..espace..carname.." ["..math.floor(posnameveh).."m]"
			if (finalvehname == "") then 
				finalvehname = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(vehicule))
			end
			vehlist = menu.list(vehmanagerlist, finalvehname, {}, "")
			vehiclelist[vehicule] = vehlist
			menu.action(vehiclelist[vehicule], EXPLO_VEH_MANAG, {""}, "", function()
				requestControlLoop(vehhandle[vehicule])
				NETWORK.NETWORK_EXPLODE_VEHICLE(vehhandle[vehicule], true, true, false)
			end)
			menu.action(vehiclelist[vehicule], TELEPORT_VEH_MANAG, {""}, "", function()
				requestControlLoop(vehhandle[vehicule])
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehhandle[vehicule], pos.x, pos.y, pos.z, false, false, false)
			end)
			menu.action(vehiclelist[vehicule], TELEPORT_TO_VEH_MANAG, {""}, "", function()
				requestControlLoop(vehhandle[vehicule])
				posnameobjectfunc = ENTITY.GET_ENTITY_COORDS(vehhandle[vehicule])
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(plyped(), posnameobjectfunc.x, posnameobjectfunc.y, posnameobjectfunc.z+2, false, false, false)
			end)
			menu.click_slider(vehiclelist[vehicule], SET_SPEED_VEH_MANAG, {""}, "", -1000, 1000, 100, 100, function(s)
				requestControlLoop(vehhandle[vehicule])
				VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehhandle[vehicule], s)
			end)
			menu.action(vehiclelist[vehicule], FIX_VEH_MANAG, {""}, "", function()
				requestControlLoop(vehhandle[vehicule])
				fixveh(vehhandle[vehicule])
			end)
			menu.action(vehiclelist[vehicule], DRIVE_VEH_MANAG, {""}, "", function()
				requestControlLoop(vehhandle[vehicule])
				if not (VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehhandle[vehicule], -1) == 0) then
					pedinseat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehhandle[vehicule], -1)
					TASK.CLEAR_PED_TASKS_IMMEDIATELY(pedinseat)
				end
				PED.SET_PED_INTO_VEHICLE(plyped(), vehhandle[vehicule], -1)
			end)
			menu.action(vehiclelist[vehicule], DELETE_VEH_MANAG, {""}, "", function()
				requestControlLoop(vehhandle[vehicule])
				entities.delete_by_handle(vehhandle[vehicule])
			end)
		end
	end
	for key, value in pairs(vehiclelist) do
		if ENTITY.DOES_ENTITY_EXIST(key) and vehmanager and (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) then
			manufacturer = HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(VEHICLE.GET_MAKE_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(key)))
			if (manufacturer == "NULL") then
				manufacturer = ""
			end
			carname = HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(key)))
			if (carname == "NULL") then
				carname = ""
			end
			espace = " "
			if (manufacturer == "") then
				espace = ""
			end
			posnameveh = ENTITY.GET_ENTITY_COORDS(key)
			posnameveh = v3.distance(pos, posnameveh)
			finalvehname = manufacturer..espace..carname.." ["..math.floor(posnameveh).."m]"
			if (manufacturer..espace..carname == "") then 
				finalvehname = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(key)).." ["..math.floor(posnameveh).."m]"
			end
			menu.set_menu_name(value, finalvehname)
		end
	end
	for key, value in pairs(vehiclelist) do
		if not ENTITY.DOES_ENTITY_EXIST(key) and not (vehiclelist[key] == nil) then
			pcall(menu.delete, value)
			vehiclelist[key] = nil
		end
	end
	util.yield()
end)
util.create_tick_handler(function()
	pedmanagerhandle = {}
	if (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) and pedmanager then
		pedmanagerhandle = entities.get_all_peds_as_handles()
	end
	pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	for _, ped in ipairs(pedmanagerhandle) do
		if ENTITY.DOES_ENTITY_EXIST(ped) and (pedlist[ped] == nil) and pedmanager and (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) then
			pedhandle[ped] = ped
			pedname = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(ped))
			posnameped = ENTITY.GET_ENTITY_COORDS(ped)
			posnameped = v3.distance(pos, posnameped)
			finalpedname = pedname.." ["..math.floor(posnameped).."m]"
			pedlistnumber = menu.list(pedmanagerlist, finalpedname, {}, "")
			pedlist[ped] = pedlistnumber
			menu.action(pedlist[ped], EXPLO_VEH_MANAG, {""}, "", function()
				requestControlLoop(pedhandle[ped])
				posped = ENTITY.GET_ENTITY_COORDS(ped)
				FIRE.ADD_EXPLOSION(posped.x, posped.y, posped.z, 0, 1, true, false, 1, false)
			end)
			menu.action(pedlist[ped], TELEPORT_VEH_MANAG, {""}, "", function()
				requestControlLoop(pedhandle[ped])
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(pedhandle[ped], pos.x, pos.y, pos.z, false, false, false)
			end)
			menu.action(pedlist[ped], TELEPORT_TO_VEH_MANAG, {""}, "", function()
				requestControlLoop(pedhandle[ped])
				posnameobjectfunc = ENTITY.GET_ENTITY_COORDS(pedhandle[ped])
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(plyped(), posnameobjectfunc.x, posnameobjectfunc.y, posnameobjectfunc.z+2, false, false, false)
			end)
			menu.action(pedlist[ped], CLEAR_TASK_PED_MANAG, {""}, "", function()
				requestControlLoop(pedhandle[ped])
				TASK.CLEAR_PED_TASKS_IMMEDIATELY(pedhandle[ped])
			end)
			menu.action(pedlist[ped], DELETE_VEH_MANAG, {""}, "", function()
				requestControlLoop(pedhandle[ped])
				entities.delete_by_handle(pedhandle[ped])
			end)
		end
	end
	for key, value in pairs(pedlist) do
		if ENTITY.DOES_ENTITY_EXIST(key) and pedmanager and (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) then
			pedname = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(key))
			posnameped = ENTITY.GET_ENTITY_COORDS(key)
			posnameped = v3.distance(pos, posnameped)
			finalpedname = pedname.." ["..math.floor(posnameped).."m]"
			menu.set_menu_name(value, finalpedname)
		end
	end
	for key, value in pairs(pedlist) do
		if not ENTITY.DOES_ENTITY_EXIST(key) and not (pedlist[key] == nil) then
			pcall(menu.delete, value)
			pedlist[key] = nil
		end
	end
	util.yield()
end)
util.create_tick_handler(function()
	objectmanagerhandle = {}
	if (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) and objectmanager then
		objectmanagerhandle = entities.get_all_objects_as_handles()
	end
	pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	for _, object in ipairs(objectmanagerhandle) do
		if ENTITY.DOES_ENTITY_EXIST(object) and (objectlist[object] == nil) and not (util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(object)) == "") and objectmanager and (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) then
			objecthandle[object] = object
			objectname = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(object))
			posnameobject1 = ENTITY.GET_ENTITY_COORDS(object)
			posnameobject1 = v3.distance(pos, posnameobject1)
			finalobjectname = objectname
			objectlistnumber = menu.list(objectmanagerlist, finalobjectname, {}, "")
			objectlist[object] = objectlistnumber
			menu.action(objectlist[object], EXPLO_VEH_MANAG, {""}, "", function()
				requestControlLoop(objecthandle[object])
				posobject = ENTITY.GET_ENTITY_COORDS(object)
				FIRE.ADD_EXPLOSION(posobject.x, posobject.y, posobject.z, 0, 1, true, false, 1, false)
			end)
			menu.action(objectlist[object], TELEPORT_VEH_MANAG, {""}, "", function()
				requestControlLoop(objecthandle[object])
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(objecthandle[object], pos.x, pos.y, pos.z, false, false, false)
			end)
			menu.action(objectlist[object], TELEPORT_TO_VEH_MANAG, {""}, "", function()
				requestControlLoop(objecthandle[object])
				posnameobjectfunc = ENTITY.GET_ENTITY_COORDS(objecthandle[object])
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(plyped(), posnameobjectfunc.x, posnameobjectfunc.y, posnameobjectfunc.z+2, false, false, false)
			end)
			menu.action(objectlist[object], DELETE_VEH_MANAG, {""}, "", function()
				requestControlLoop(objecthandle[object])
				entities.delete_by_handle(objecthandle[object])
			end)
		end
		util.yield(10)
	end
end)
util.create_tick_handler(function()
for key, value in pairs(objectlist) do
		if not ENTITY.DOES_ENTITY_EXIST(key) and not (objectlist[key] == nil) then
			pcall(menu.delete, value)
			objectlist[key] = nil
		end
	end
end)