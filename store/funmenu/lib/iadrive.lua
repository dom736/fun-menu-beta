drivestyleflag = {
	{flagname = FLAG1, flagdesc = "", flagvalue = 1},
	{flagname = FLAG2, flagdesc = "", flagvalue = 2},
	{flagname = FLAG3, flagdesc = "", flagvalue = 4},
	{flagname = FLAG4, flagdesc = "", flagvalue = 8},
	{flagname = FLAG5, flagdesc = "", flagvalue = 16},
	{flagname = FLAG6, flagdesc = "", flagvalue = 32},
	{flagname = UNKNOWN, flagdesc = "", flagvalue = 64},
	{flagname = FLAG8, flagdesc = "", flagvalue = 128},
	{flagname = FLAG9, flagdesc = "", flagvalue = 256},
	{flagname = FLAG10, flagdesc = FLAG10DESC, flagvalue = 512},
	{flagname = FLAG11, flagdesc = "", flagvalue = 1024},
	{flagname = UNKNOWN, flagdesc = "", flagvalue = 2048},
	{flagname = UNKNOWN, flagdesc = "", flagvalue = 4096},
	{flagname = UNKNOWN, flagdesc = "", flagvalue = 8192},
	{flagname = UNKNOWN, flagdesc = NO_USED_FLAG, flagvalue = 16384},
	{flagname = UNKNOWN, flagdesc = NO_USED_FLAG, flagvalue = 32768},
	{flagname = UNKNOWN, flagdesc = NO_USED_FLAG, flagvalue = 65536},
	{flagname = UNKNOWN, flagdesc = NO_USED_FLAG, flagvalue = 131072},
	{flagname = FLAG19, flagdesc = FLAG19DESC, flagvalue = 262144},
	{flagname = FLAG20, flagdesc = FLAG20DESC, flagvalue = 524288},
	{flagname = UNKNOWN, flagdesc = NO_USED_FLAG, flagvalue = 1048576},
	{flagname = UNKNOWN, flagdesc = "", flagvalue = 2097152},
	{flagname = FLAG23, flagdesc = FLAG23DESC, flagvalue = 4194304},
	{flagname = UNKNOWN, flagdesc = "", flagvalue = 8388608},
	{flagname = FLAG25, flagdesc = FLAG25DESC, flagvalue = 16777216},
	{flagname = UNKNOWN, flagdesc = "", flagvalue = 33554432},
	{flagname = UNKNOWN, flagdesc = NO_USED_FLAG, flagvalue = 67108864},
	{flagname = UNKNOWN, flagdesc = NO_USED_FLAG, flagvalue = 134217728},
	{flagname = UNKNOWN, flagdesc = NO_USED_FLAG, flagvalue = 268435456},
	{flagname = FLAG30, flagdesc = FLAG30DESC, flagvalue = 536870912},
	{flagname = UNKNOWN, flagdesc = "", flagvalue = 1073741824}
}

driveflag = 0
flagoptionstate = {}
iadrivemenu = menu.list(vehmenu, AI_DRIVE_MENU, {}, "")
iadriveflagmenu = menu.list(iadrivemenu, AI_DRIVE_FLAG, {}, "")

for i, v in ipairs(drivestyleflag) do
	flagoptionstate[i] = false
	menu.toggle(iadriveflagmenu, v.flagname, {}, v.flagdesc, function(on)
		flagoptionstate[i] = on
		if flagoptionstate[i] then
			driveflag = driveflag+v.flagvalue
			if drivetowaypoint then
				local poswaypoint = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
				TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(plyped(), veh, poswaypoint.x, poswaypoint.y, poswaypoint.z, aispeed, driveflag, 0)
				PED.SET_PED_KEEP_TASK(plyped(), true)
			end
		else
			driveflag = driveflag-v.flagvalue
			if drivetowaypoint then
				local poswaypoint = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
				TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(plyped(), veh, poswaypoint.x, poswaypoint.y, poswaypoint.z, aispeed, driveflag, 0)
				PED.SET_PED_KEEP_TASK(plyped(), true)
			end
		end
	end)
end

aispeed = 50

menu.slider(iadrivemenu, IA_SPEED, {}, "", 0, 500, 50, 5, function(s)
	if drivetowaypoint then
	    local poswaypoint = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
		TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(plyped(), veh, poswaypoint.x, poswaypoint.y, poswaypoint.z, s, driveflag, 0)
		PED.SET_PED_KEEP_TASK(plyped(), true)
	end
	aispeed = s
end)

drivetowaypoint = off
menu.toggle(iadrivemenu, DRIVE_TO_WAYPOINT, {"drivetowaypoint"}, "", function(on)
	drivetowaypoint = on
	if drivetowaypoint and not (veh == 0) then
		cleartaskinveh()
		if HUD.IS_WAYPOINT_ACTIVE() then
	    		local poswaypoint = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
				TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(plyped(), veh, poswaypoint.x, poswaypoint.y, poswaypoint.z, aispeed, driveflag, 0)
				PED.SET_PED_KEEP_TASK(plyped(), true)
		end
		while drivetowaypoint do
			if not HUD.IS_WAYPOINT_ACTIVE() then
				menu.trigger_commands("drivetowaypoint off")
				util.toast(NO_WAYPOINT)
			end
			util.yield()
		end
	end
	if (veh == 0) and drivetowaypoint then
		menu.trigger_commands("drivetowaypoint off")
		util.toast(NOT_IN_CAR)
	end
	if not drivetowaypoint and not (veh == 0) then
		cleartaskinveh()
	end
end)