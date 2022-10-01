pedmodelattack = {}
colorline = {}
generate_features = function(pid)
	menu.divider(menu.player_root(pid),'Fun menu')
	pedmodelattack[pid] = 0
	-------------------------------------vehicle menu--------------------------------------------
	local vehonlinemenu = menu.list(menu.player_root(pid), VEH_ONLINE_MENU, {}, "")
	local lunchvehmenu = menu.list(vehonlinemenu, VEH_LUNCH_MENU, {}, "")
	local haltvehmenu = menu.list(vehonlinemenu, HALT_VEH_SUBMENU, {}, "")
	menu.action(lunchvehmenu, LUNCH_UP, {"lunchup"}, "", function()
		requestControlLoop(getveh(pid))
		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(getveh(pid), 1, 0, 0, 100000, false, true, true, true)
	end)
	menu.action(lunchvehmenu, LUNCH_DOWN, {"lunchdown"}, "", function()
		requestControlLoop(getveh(pid))
		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(getveh(pid), 1, 0, 0, -100000, false, true, true, true)
	end)
	menu.action(lunchvehmenu, LUNCH_RIGHT, {"lunchright"}, "", function()
		requestControlLoop(getveh(pid))
		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(getveh(pid), 1, 100000, 0, 0, false, true, true, true)
	end)
	menu.action(lunchvehmenu, LUNCH_LEFT, {"lunchleft"}, "", function()
		requestControlLoop(getveh(pid))
		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(getveh(pid), 1, -100000, 0, 0, false, true, true, true)
	end)
	menu.action(lunchvehmenu, LUNCH_FOWARD, {"lunchfoward"}, "", function()
		requestControlLoop(getveh(pid))
		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(getveh(pid), 1, 0, 100000, 0, false, true, true, true)
	end)
	menu.action(lunchvehmenu, LUNCH_BACKWARD, {"lunchbackward"}, "", function()
		requestControlLoop(getveh(pid))
		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(getveh(pid), 1, 0, -100000, 0, false, true, true, true)
	end)
	menu.action(vehonlinemenu, EXPL_PLY_VEH, {"explodeveh"}, "", function()
		requestControlLoop(getveh(pid))
		NETWORK.NETWORK_EXPLODE_VEHICLE(getveh(pid), true, true, false)
	end)
	menu.action(vehonlinemenu, ROT_180, {"rotveh"}, "", function()
		tick = 0
		head = ENTITY.GET_ENTITY_HEADING(getveh(pid))
		pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
		headc = head+180
		if headc>360 then 
			headf = headc-360
		else
			headf = headc
		end
		while (tick < 25)do
			requestControlLoop(getveh(pid))
			head = ENTITY.GET_ENTITY_HEADING(getveh(pid))
			requestControlLoop(getveh(pid))
			ENTITY.SET_ENTITY_HEADING(getveh(pid), headf)
			tick = tick +1
			util.yield(10)
		end
	end)
	menu.action(vehonlinemenu, TRP_OCEAN, {"tptoocean"}, "", function()
		requestControlLoop(getveh(pid))
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(getveh(pid), '-7000', '-743', '45')
	end)
	menu.action(haltvehmenu, HALT_VEH, {"haltveh"}, "", function()
		requestControlLoop(getveh(pid))
		VEHICLE.BRING_VEHICLE_TO_HALT(getveh(pid), getmenuvalueplayer(pid, VEH_ONLINE_MENU..">"..HALT_VEH_SUBMENU..">"..HALT_DISTANCE_VEH), getmenuvalueplayer(pid, VEH_ONLINE_MENU..">"..HALT_VEH_SUBMENU..">"..HALT_TIME_VEH))
	end)
	
	menu.slider(haltvehmenu, HALT_DISTANCE_VEH, {"haltdist"}, HALT_DISTANCE_VEH_DESC, 0, 2147483646, 0, 1, function(s)
		
	end)
	menu.slider(haltvehmenu, HALT_TIME_VEH, {"halttime"}, HALT_TIME_VEH_DESC, 1, 2147483646, 1, 1, function(s)
		
	end)
	menu.action(vehonlinemenu, FIX_VEH_ONLINE, {"repair", "repairveh", "fixveh"}, "", function()
		requestControlLoop(getveh(pid))
		fixveh(getveh(pid))
	end)
	menu.toggle(vehonlinemenu, NO_LOCK_ON, {"nolockon"}, "", function(on)
		while (menu.get_value(menu.ref_by_path("Players>"..players.get_name_with_tags(pid)..">"..VEH_ONLINE_MENU..">"..NO_LOCK_ON)) == 1) do
			util.yield(10000)
			VEHICLE._SET_VEHICLE_CAN_BE_LOCKED_ON(getveh(pid), false)
			requestControlLoop(getveh(pid))
			util.yield()
		end
		requestControlLoop(getveh(pid))
		VEHICLE._SET_VEHICLE_CAN_BE_LOCKED_ON(getveh(pid), true)
	end)
	menu.action(vehonlinemenu, CHILD_LOCK, {}, "", function()
		VEHICLE.SET_VEHICLE_DOORS_LOCKED(getveh(pid), 4)
	end)
	-------------------------------------Vehicle menu end--------------------------------------------
	-------------------------------------Trolling menu--------------------------------------------
	local trollonlinemenu = menu.list(menu.player_root(pid), TROLL_MENU, {}, "")
	local pedattackmenu = menu.list(trollonlinemenu, PED_ATTACK_MENU, {}, "")
	local settingpedattackmenu = menu.list(pedattackmenu, SETTING_PED_ATTACK_MENU, {}, "")
	menu.toggle(settingpedattackmenu, INVIC_PED_ATTACKER, {"invicibleped"}, "", function()
		
	end)
	menu.toggle(settingpedattackmenu, INV_PED_ATTACKER, {"invisibleped"}, "", function()
		
	end)
	menu.toggle(settingpedattackmenu, SPAWN_ON_PLAYER, {"spawnonplayer"}, SPAWN_ON_PLAYER_DESC, function()
		
	end)
	menu.text_input(pedattackmenu, PED_ATTACK_MODEL, {"attackmodel"}, "", function(s)
		pedmodelattack[pid] = s
	end)
	
	menu.slider(pedattackmenu, NUMBER_PED_ATTACK, {"numberped"}, "", 1, 20, 1, 1, function()
	
	end)
	menu.action(pedattackmenu, SPAWN_ATTACKER, {"spawnattackped"}, "", function()
		pedmodelforattack = pedmodelattack[pid]
		doesspawnonplayer = getmenuvalueplayer(pid, TROLL_MENU..">"..PED_ATTACK_MENU..">"..SETTING_PED_ATTACK_MENU..">"..SPAWN_ON_PLAYER)
		isinvicible = getmenuvalueplayer(pid, TROLL_MENU..">"..PED_ATTACK_MENU..">"..SETTING_PED_ATTACK_MENU..">"..INVIC_PED_ATTACKER)
		isinvisible = getmenuvalueplayer(pid, TROLL_MENU..">"..PED_ATTACK_MENU..">"..SETTING_PED_ATTACK_MENU..">"..INV_PED_ATTACKER)
		whatmodel = getmenuvalueplayer(pid, TROLL_MENU..">"..PED_ATTACK_MENU..">"..PED_ATTACK_MODEL)
		numbertospawn = getmenuvalueplayer(pid, TROLL_MENU..">"..PED_ATTACK_MENU..">"..NUMBER_PED_ATTACK)
		util.toast(isinvisible)
		spawnpedattack(pid, pedmodelforattack, numbertospawn, isinvicible, isinvisible, doesspawnonplayer)
	end)
	menu.toggle(trollonlinemenu, PLANE_ATTACK, {"planeattack"}, "", function(on)
	posplane = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
		if getmenuvalueplayer(pid, TROLL_MENU..">"..PLANE_ATTACK) then
			planespawnz = 100
			headplane = 0
			spawnplaneforattack(posplane, PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), planespawnz, headplane)
			planespawnz = planespawnz+10
			headplane = headplane+36
			spawnplaneforattack(posplane, PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), planespawnz, headplane)
			planespawnz = planespawnz+10
			headplane = headplane+36
			spawnplaneforattack(posplane, PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), planespawnz, headplane)
			planespawnz = planespawnz+10
			headplane = headplane+36
			spawnplaneforattack(posplane, PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), planespawnz, headplane)
			planespawnz = planespawnz+10
			headplane = headplane+36
			spawnplaneforattack(posplane, PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), planespawnz, headplane)
			planespawnz = planespawnz+10
			headplane = headplane+36
			spawnplaneforattack(posplane, PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), planespawnz, headplane)
			planespawnz = planespawnz+10
			headplane = headplane+36
			spawnplaneforattack(posplane, PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), planespawnz, headplane)
			planespawnz = planespawnz+10
			headplane = headplane+36
			spawnplaneforattack(posplane, PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), planespawnz, headplane)
			planespawnz = planespawnz+10
			headplane = headplane+36
			spawnplaneforattack(posplane, PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), planespawnz, headplane)
			planespawnz = planespawnz+10
			headplane = headplane+36
			spawnplaneforattack(posplane, PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), planespawnz, headplane)
			planespawnz = planespawnz+10
			headplane = headplane+36
		end
		while getmenuvalueplayer(pid, TROLL_MENU..">"..PLANE_ATTACK) do
		
			util.yield()
		end
		if not getmenuvalueplayer(pid, "Spectate>Ninja Method") then
			menu.trigger_commands("spectate"..PLAYER.GET_PLAYER_NAME(pid).." on")
		end
		util.yield(1000)
		delattackplane("Lazer")
		if getmenuvalueplayer(pid, "Spectate>Ninja Method") then
			menu.trigger_commands("spectate"..PLAYER.GET_PLAYER_NAME(pid).." off")
		end
	end)
	-------------------------------------Trolling menu end--------------------------------------------
	menu.toggle(menu.player_root(pid), GHOST_PLAYER, {}, "", function(toggle)
		 NETWORK._SET_RELATIONSHIP_TO_PLAYER(pid, toggle)
		 
	end)
	menu.action(menu.player_root(pid), COPY_INFO, {}, "", function()
		util.copy_to_clipboard("Name : "..players.get_name(pid)..string.char(10).."RID : "..players.get_rockstar_id(pid))
	end)
	
	--[[menu.toggle_loop(menu.player_root(pid), "esp", {}, "", function()
		if (NETWORK.NETWORK_IS_FRIEND(getgamerhandle(pid))) then
			colorline[pid] = colorfriendnearby
			if (v3.distance(pos, players.get_position(pid)) > 500) then
				colorline[pid] = colorfriendfar
			end
			if ENTITY.IS_ENTITY_DEAD(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)) then
				colorline[pid] = colorfrienddead
			end
		else
			colorline[pid] = colorplayernearby
			if (v3.distance(pos, players.get_position(pid)) > 500) then
				colorline[pid] = colorplayerfar
			end
			if ENTITY.IS_ENTITY_DEAD(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)) then
				colorline[pid] = colorplayerdead
			end
		end
	
		--lowerbody--
		boneposlthight = getbonecoord(pid, 0xE39F)
		boneposrthight = getbonecoord(pid, 0xCA72)
		boneposlcalf = getbonecoord(pid, 0xF9BB)
		boneposrcalf = getbonecoord(pid, 0x9000)
		boneposlfoot = getbonecoord(pid, 0x3779)
		boneposrfoot = getbonecoord(pid, 0xCC4D)
		boneposltoe = getbonecoord(pid, 0x83C)
		boneposrtoe = getbonecoord(pid, 0x512D)
		--lowerbody--
		--middlebody--
		boneposroot = getbonecoord(pid, 0x0)
		boneposspine0 = getbonecoord(pid, 0x5C01)
		boneposspine1 = getbonecoord(pid, 0x60F0)
		boneposspine2 = getbonecoord(pid, 0x60F1)
		boneposspine3 = getbonecoord(pid, 0x60F2)
		--middlebody--
		--arm--
		boneposlclavicle = getbonecoord(pid, 0xFCD9)
		boneposluperarm = getbonecoord(pid, 0xB1C5)
		boneposlforearm = getbonecoord(pid, 0xEEEB)
		boneposlhand = getbonecoord(pid, 0x49D9)
		boneposrclavicle = getbonecoord(pid, 0x29D2)
		boneposruperarm = getbonecoord(pid, 0x9D4D)
		boneposrforearm = getbonecoord(pid, 0x6E5C)
		boneposrhand = getbonecoord(pid, 0xDEAD)
		--arm--
		--hand--
		boneposlfinger00 = getbonecoord(pid, 0x67F2)
		boneposlfinger01 = getbonecoord(pid, 0xFF9)
		boneposlfinger02 = getbonecoord(pid, 0xFFA)
		boneposlfinger10 = getbonecoord(pid, 0x67F3)
		boneposlfinger11 = getbonecoord(pid, 0x1049)
		boneposlfinger12 = getbonecoord(pid, 0x104A)
		boneposlfinger20 = getbonecoord(pid, 0x67F4)
		boneposlfinger21 = getbonecoord(pid, 0x1059)
		boneposlfinger22 = getbonecoord(pid, 0x105A)
		boneposlfinger30 = getbonecoord(pid, 0x67F5)
		boneposlfinger31 = getbonecoord(pid, 0x1029)
		boneposlfinger32 = getbonecoord(pid, 0x102A)
		boneposlfinger40 = getbonecoord(pid, 0x67F6)
		boneposlfinger41 = getbonecoord(pid, 0x1039)
		boneposlfinger42 = getbonecoord(pid, 0x103A)
		boneposrfinger00 = getbonecoord(pid, 0xE5F2)
		boneposrfinger01 = getbonecoord(pid, 0xFA10)
		boneposrfinger02 = getbonecoord(pid, 0xFA11)
		boneposrfinger10 = getbonecoord(pid, 0xE5F3)
		boneposrfinger11 = getbonecoord(pid, 0xFA60)
		boneposrfinger12 = getbonecoord(pid, 0xFA61)
		boneposrfinger20 = getbonecoord(pid, 0xE5F4)
		boneposrfinger21 = getbonecoord(pid, 0xFA70)
		boneposrfinger22 = getbonecoord(pid, 0xFA71)
		boneposrfinger30 = getbonecoord(pid, 0xE5F5)
		boneposrfinger31 = getbonecoord(pid, 0xFA40)
		boneposrfinger32 = getbonecoord(pid, 0xFA41)
		boneposrfinger40 = getbonecoord(pid, 0xE5F6)
		boneposrfinger41 = getbonecoord(pid, 0xFA50)
		boneposrfinger42 = getbonecoord(pid, 0xFA51)
		--hand--
		boneneck1 = getbonecoord(pid, 0x9995)
		bonehead = getbonecoord(pid, 0x796E)
		drawline(boneneck1, bonehead, colorline[pid])
		drawline(boneneck1, boneposspine3, colorline[pid])
		drawline(boneposrfinger02, boneposrfinger01, colorline[pid])
		drawline(boneposrfinger00, boneposrfinger01, colorline[pid])
		drawline(boneposrhand, boneposrfinger00, colorline[pid])
		drawline(boneposrfinger12, boneposrfinger11, colorline[pid])
		drawline(boneposrfinger10, boneposrfinger11, colorline[pid])
		drawline(boneposrhand, boneposrfinger10, colorline[pid])
		drawline(boneposrfinger22, boneposrfinger21, colorline[pid])
		drawline(boneposrfinger20, boneposrfinger21, colorline[pid])
		drawline(boneposrhand, boneposrfinger20, colorline[pid])
		drawline(boneposrfinger32, boneposrfinger31, colorline[pid])
		drawline(boneposrfinger30, boneposrfinger31, colorline[pid])
		drawline(boneposrhand, boneposrfinger30, colorline[pid])
		drawline(boneposrfinger42, boneposrfinger41, colorline[pid])
		drawline(boneposrfinger40, boneposrfinger41, colorline[pid])
		drawline(boneposrhand, boneposrfinger40, colorline[pid])
		drawline(boneposlfinger02, boneposlfinger01, colorline[pid])
		drawline(boneposlfinger00, boneposlfinger01, colorline[pid])
		drawline(boneposlhand, boneposlfinger00, colorline[pid])
		drawline(boneposlfinger12, boneposlfinger11, colorline[pid])
		drawline(boneposlfinger10, boneposlfinger11, colorline[pid])
		drawline(boneposlhand, boneposlfinger10, colorline[pid])
		drawline(boneposlfinger22, boneposlfinger21, colorline[pid])
		drawline(boneposlfinger20, boneposlfinger21, colorline[pid])
		drawline(boneposlhand, boneposlfinger20, colorline[pid])
		drawline(boneposlfinger32, boneposlfinger31, colorline[pid])
		drawline(boneposlfinger30, boneposlfinger31, colorline[pid])
		drawline(boneposlhand, boneposlfinger30, colorline[pid])
		drawline(boneposlfinger42, boneposlfinger41, colorline[pid])
		drawline(boneposlfinger40, boneposlfinger41, colorline[pid])
		drawline(boneposlhand, boneposlfinger40, colorline[pid])
		drawline(boneposrforearm, boneposrhand, colorline[pid])
		drawline(boneposruperarm, boneposrforearm, colorline[pid])
		drawline(boneposrclavicle, boneposruperarm, colorline[pid])
		drawline(boneposrclavicle, boneneck1, colorline[pid])
		drawline(boneposlforearm, boneposlhand, colorline[pid])
		drawline(boneposluperarm, boneposlforearm, colorline[pid])
		drawline(boneposlclavicle, boneposluperarm, colorline[pid])
		drawline(boneposlclavicle, boneneck1, colorline[pid])
		drawline(boneposspine2, boneposspine3, colorline[pid])
		drawline(boneposspine1, boneposspine2, colorline[pid])
		drawline(boneposspine1, boneposspine0, colorline[pid])
		drawline(boneposroot, boneposspine0, colorline[pid])
		drawline(boneposroot, boneposlthight, colorline[pid])
		drawline(boneposroot, boneposrthight, colorline[pid])
		drawline(boneposlcalf, boneposlthight, colorline[pid])
		drawline(boneposrcalf, boneposrthight, colorline[pid])
		drawline(boneposlcalf, boneposlfoot, colorline[pid])
		drawline(boneposrcalf, boneposrfoot, colorline[pid])
		drawline(boneposltoe, boneposlfoot, colorline[pid])
		drawline(boneposrtoe, boneposrfoot, colorline[pid])
		modelmax = memory.alloc()
		modelmin = memory.alloc()
		MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(plyped()), modelmin, modelmax)
	
		ftopright = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), v3.getX(modelmax), v3.getY(modelmax), v3.getZ(modelmax))
		ftopleft = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), v3.getX(modelmin), v3.getY(modelmax), v3.getZ(modelmax))
		btopright = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), v3.getX(modelmax), v3.getY(modelmin), v3.getZ(modelmax))
		btopleft = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), v3.getX(modelmin), v3.getY(modelmin), v3.getZ(modelmax))
		fbottomleft = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), v3.getX(modelmin), v3.getY(modelmax), -0.98)
		fbottomright = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), v3.getX(modelmax), v3.getY(modelmax), -0.98)
		bbottomleft = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), v3.getX(modelmin), v3.getY(modelmin), -0.98)
		bbottomright = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), v3.getX(modelmax), v3.getY(modelmin), -0.98)
		drawlinenat(ftopright, ftopleft, colorline[pid])
		drawlinenat(fbottomleft, ftopleft, colorline[pid])
		drawlinenat(fbottomleft, fbottomright, colorline[pid])
		drawlinenat(ftopright, fbottomright, colorline[pid])
		drawlinenat(btopright, btopleft, colorline[pid])
		drawlinenat(bbottomleft, btopleft, colorline[pid])
		drawlinenat(bbottomleft, bbottomright, colorline[pid])
		drawlinenat(btopright, bbottomright, colorline[pid])
		drawlinenat(btopleft, ftopleft, colorline[pid])
		drawlinenat(bbottomleft, fbottomleft, colorline[pid])
		drawlinenat(bbottomright, fbottomright, colorline[pid])
		drawlinenat(btopright, ftopright, colorline[pid])
		memory.free(modelmin)
		memory.free(modelmax)
end)]]
	--[[menu.action(menu.player_root(pid), "test", {}, "", function()
		menu.focus(menu.ref_by_path("Players>"..players.get_name_with_tags(0)..">Information>Connection>Connect Address>IP Address"))
		util.yield(100)
		menu.trigger_command(menu.ref_by_path("Players>"..players.get_name_with_tags(0)..">Information>Connection>Connect Address>IP Address"),"")
		local ip = util.get_clipboard_text()
		menu.trigger_command(menu.ref_by_path("Players>"..players.get_name_with_tags(0)..">Information>Connection>Connect Address>City"),"")
		city = util.get_clipboard_text()
		menu.trigger_command(menu.ref_by_path("Players>"..players.get_name_with_tags(0)..">Information>Connection>Connect Address>Region"),"")
		region = util.get_clipboard_text()
		menu.trigger_command(menu.ref_by_path("Players>"..players.get_name_with_tags(0)..">Information>Connection>Connect Address>Country"),"")
		country = util.get_clipboard_text()
		menu.focus(menu.ref_by_path("Players>"..players.get_name_with_tags(pid)..">test"))
		menu.trigger_commands("smstext"..PLAYER.GET_PLAYER_NAME(pid).." IP : "..ip.."Location : "..country..", "..region..", "..city)
		menu.trigger_commands("smssend"..PLAYER.GET_PLAYER_NAME(pid))
	end)
	menu.action(menu.player_root(pid), "test", {}, "", function()
		util.toast(pedmodelattack[pid])
	end)]]
end

players.on_join(generate_features)
players.dispatch_on_join()