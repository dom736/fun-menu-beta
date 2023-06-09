local function does_entity_exist(entity)
	for _, checkveh in ipairs(vehmanagerpointer) do
		if entity == checkveh then
			return true
		end
	end
	for _, checkped in ipairs(pedmanagerpointer) do
		if entity == checkped then
			return true
		end
	end
	for _, checkobject in ipairs(objectmanagerpointer) do
		if entity == checkobject then
			return true
		end
	end
	return false
end
local function get_handle(pointer)
	if not enthandle[pointer] then
		enthandle[pointer] = entities.pointer_to_handle(pointer)
	end
	return enthandle[pointer]
end

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

enthandle = {}
vehmanagerlist = menu.list(entitymanagerlist, VEH_MANAGER, {}, "")
vehiclelist = {}
vehpointer = {}
vehmodel = {}
pedmanagerlist = menu.list(entitymanagerlist, PED_MANAGER, {}, "")
pedlist = {}
pedpointer = {}
pedmodel = {}
objectmanagerlist = menu.list(entitymanagerlist, OBJECT_MANAGER, {}, "")
objectlist = {}
objectpointer = {}
objectmodel = {}

util.create_tick_handler(function()
	vehmanagerpointer = {}
	if vehmanager then
		vehmanagerpointer = entities.get_all_vehicles_as_pointers()	
	end
	for _, vehicule in ipairs(vehmanagerpointer) do	
		if does_entity_exist(vehicule) and (vehiclelist[vehicule] == nil) and vehmanager then
			vehpointer[vehicule] = vehicule
			vehmodel[vehicule] = entities.get_model_hash(vehicule)
			local posnameveh =  entities.get_position(vehicule)
			local posnameveh = v3.distance(pos, posnameveh)
			local manufacturer = HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(VEHICLE.GET_MAKE_NAME_FROM_VEHICLE_MODEL(vehmodel[vehicule]))
			if (manufacturer == "NULL") then
				manufacturer = ""
			end
			local carname = HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(util.reverse_joaat(vehmodel[vehicule]))
			if (carname == "NULL") then
				carname = ""
			end
			espace = " "
			if (manufacturer == "") then
				espace = ""
			end
			local finalvehname = manufacturer..espace..carname.." ["..math.floor(posnameveh).."m]"
			if (finalvehname == "") then 
				finalvehname = util.reverse_joaat(vehmodel[vehicule])
			end
			vehlist = menu.list(vehmanagerlist, "1", {}, "")
			vehiclelist[vehicule] = vehlist
			menu.action(vehiclelist[vehicule], EXPLO_VEH_MANAG, {""}, "", function()
				get_handle(vehpointer[vehicule])
				requestControlLoop(get_handle(vehpointer[vehicule]))
				NETWORK.NETWORK_EXPLODE_VEHICLE(get_handle(vehpointer[vehicule]), true, true, false)
			end)
			menu.action(vehiclelist[vehicule], TELEPORT_VEH_MANAG, {""}, "", function()
				requestControlLoop(get_handle(vehpointer[vehicule]))
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(get_handle(vehpointer[vehicule]), pos.x, pos.y, pos.z, false, false, false)
			end)
			menu.action(vehiclelist[vehicule], TELEPORT_TO_VEH_MANAG, {""}, "", function()
				requestControlLoop(get_handle(vehpointer[vehicule]))
				posnameobjectfunc = ENTITY.GET_ENTITY_COORDS(get_handle(vehpointer[vehicule]))
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(plyped(), posnameobjectfunc.x, posnameobjectfunc.y, posnameobjectfunc.z+2, false, false, false)
			end)
			menu.click_slider(vehiclelist[vehicule], SET_SPEED_VEH_MANAG, {""}, "", -1000, 1000, 100, 100, function(s)
				requestControlLoop(get_handle(vehpointer[vehicule]))
				VEHICLE.SET_VEHICLE_FORWARD_SPEED(get_handle(vehpointer[vehicule]), s)
			end)
			menu.action(vehiclelist[vehicule], FIX_VEH_MANAG, {""}, "", function()
				requestControlLoop(get_handle(vehpointer[vehicule]))
				fixveh(get_handle(vehpointer[vehicule]))
			end)
			menu.action(vehiclelist[vehicule], DRIVE_VEH_MANAG, {""}, "", function()
				requestControlLoop(get_handle(vehpointer[vehicule]))
				if not (VEHICLE.GET_PED_IN_VEHICLE_SEAT(get_handle(vehpointer[vehicule]), -1) == 0) then
					pedinseat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(get_handle(vehpointer[vehicule]), -1)
					TASK.CLEAR_PED_TASKS_IMMEDIATELY(pedinseat)
				end
				PED.SET_PED_INTO_VEHICLE(plyped(), get_handle(vehpointer[vehicule]), -1)
			end)
			menu.action(vehiclelist[vehicule], DELETE_VEH_MANAG, {""}, "", function()
				entities.delete(vehpointer[vehicule])
				vehiclelist[key] = nil
				enthandle[vehpointer[key]] = nil
			end)
		end
	end
	for key, value in pairs(vehiclelist) do
		if not does_entity_exist(key) and not (vehiclelist[key] == nil) then
			pcall(menu.delete, value)
			vehiclelist[key] = nil
			enthandle[vehpointer[key]] = nil
		end
	end
	for key, value in pairs(vehiclelist) do
		if does_entity_exist(key) and vehmanager then
			local manufacturer = HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(VEHICLE.GET_MAKE_NAME_FROM_VEHICLE_MODEL(vehmodel[key]))
			if (manufacturer == "NULL") then
				manufacturer = ""
			end
			local carname = HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(util.reverse_joaat(vehmodel[key]))
			if (carname == "NULL") then
				carname = ""
			end
			espace = " "
			if (manufacturer == "") then
				espace = ""
			end
			local posnameveh =  entities.get_position(key)
			local posnameveh = v3.distance(pos, posnameveh)
			finalvehname = manufacturer..espace..carname.." ["..math.floor(posnameveh).."m]"
			if (manufacturer..espace..carname == "") then 
				finalvehname = util.reverse_joaat(vehmodel[key]).." ["..math.floor(posnameveh).."m]"
			end
			menu.set_menu_name(value, finalvehname)
		end
	end
	util.yield(500)
end)

util.create_tick_handler(function()
	pedmanagerpointer = {}
	if pedmanager then
		pedmanagerpointer = entities.get_all_peds_as_pointers()
	end
	for _, ped in ipairs(pedmanagerpointer) do
		if does_entity_exist(ped) and (pedlist[ped] == nil) and pedmanager then
			pedpointer[ped] = ped
			pedmodel[ped] = entities.get_model_hash(ped)
			local posnameped = entities.get_position(ped)
			local posnameped = v3.distance(pos, posnameped)
			local finalpedname = util.reverse_joaat(pedmodel[ped]).." ["..math.floor(posnameped).."m]"
			pedlistnumber = menu.list(pedmanagerlist, finalpedname, {}, "")
			pedlist[ped] = pedlistnumber
			menu.action(pedlist[ped], EXPLO_VEH_MANAG, {""}, "", function()
				requestControlLoop(get_handle(pedpointer[ped]))
				posped = ENTITY.GET_ENTITY_COORDS(get_handle(pedpointer[ped]))
				FIRE.ADD_EXPLOSION(posped.x, posped.y, posped.z, 0, 1, true, false, 1, false)
			end)
			menu.action(pedlist[ped], TELEPORT_VEH_MANAG, {""}, "", function()
				requestControlLoop(get_handle(pedpointer[ped]))
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(get_handle(pedpointer[ped]), pos.x, pos.y, pos.z, false, false, false)
			end)
			menu.action(pedlist[ped], TELEPORT_TO_VEH_MANAG, {""}, "", function()
				requestControlLoop(get_handle(pedpointer[ped]))
				posnameobjectfunc = ENTITY.GET_ENTITY_COORDS(get_handle(pedpointer[ped]))
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(plyped(), posnameobjectfunc.x, posnameobjectfunc.y, posnameobjectfunc.z+2, false, false, false)
			end)
			menu.action(pedlist[ped], CLEAR_TASK_PED_MANAG, {""}, "", function()
				requestControlLoop(get_handle(pedpointer[ped]))
				TASK.CLEAR_PED_TASKS_IMMEDIATELY(get_handle(pedpointer[ped]))
			end)
			menu.action(pedlist[ped], DELETE_VEH_MANAG, {""}, "", function()
				entities.delete(pedpointer[ped])
				pcall(menu.delete, value)
				pedlist[key] = nil
				enthandle[pedpointer[key]] = nil
			end)
		end
	end
	for key, value in pairs(pedlist) do
		if not does_entity_exist(key) and not (pedlist[key] == nil) then
			pcall(menu.delete, value)
			pedlist[key] = nil
			enthandle[pedpointer[key]] = nil
		end
	end
	for key, value in pairs(pedlist) do
		if does_entity_exist(key) and pedmanager then
			local posnameped = entities.get_position(key)
			local posnameped = v3.distance(pos, posnameped)
			local finalpedname = util.reverse_joaat(pedmodel[key]).." ["..math.floor(posnameped).."m]"
			menu.set_menu_name(value, finalpedname)
		end
	end
	util.yield(500)
end)
util.create_tick_handler(function()
	objectmanagerpointer = {}
	if objectmanager then
		objectmanagerpointer = entities.get_all_objects_as_pointers()
	end
	for _, object in ipairs(objectmanagerpointer) do
		if does_entity_exist(object) and (objectlist[object] == nil) and not (util.reverse_joaat(entities.get_model_hash(object)) == "") and objectmanager then
			objectpointer[object] = object
			objectmodel[object] = entities.get_model_hash(object)
			local finalobjectname = util.reverse_joaat(objectmodel[object])
			objectlistnumber = menu.list(objectmanagerlist, finalobjectname, {}, "")
			objectlist[object] = objectlistnumber
			menu.action(objectlist[object], EXPLO_VEH_MANAG, {""}, "", function()
				requestControlLoop(get_handle(objectpointer[object]))
				posobject = ENTITY.GET_ENTITY_COORDS(get_handle(objectpointer[object]))
				FIRE.ADD_EXPLOSION(posobject.x, posobject.y, posobject.z, 0, 1, true, false, 1, false)
			end)
			menu.action(objectlist[object], TELEPORT_VEH_MANAG, {""}, "", function()
				requestControlLoop(get_handle(objectpointer[object]))
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(get_handle(objectpointer[object]), pos.x, pos.y, pos.z, false, false, false)
			end)
			menu.action(objectlist[object], TELEPORT_TO_VEH_MANAG, {""}, "", function()
				requestControlLoop(get_handle(objectpointer[object]))
				posnameobjectfunc = ENTITY.GET_ENTITY_COORDS(get_handle(objectpointer[object]))
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(plyped(), posnameobjectfunc.x, posnameobjectfunc.y, posnameobjectfunc.z+2, false, false, false)
			end)
			menu.action(objectlist[object], DELETE_VEH_MANAG, {""}, "", function()
				entities.delete(objectpointer[object])
				pcall(menu.delete, objectlist[object])
				objectlist[object] = nil
				enthandle[objectpointer[object]] = nil
			end)
		end
		util.yield(10)
	end
	util.yield(1000)
end)
util.create_tick_handler(function()
	for key, value in pairs(objectlist) do
		if not does_entity_exist(key) and not (objectlist[key] == nil) then
			pcall(menu.delete, value)
			objectlist[key] = nil
		end
	end
	util.yield()
end)