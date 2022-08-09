loadtimestart = util.current_time_millis()
util.keep_running()
util.require_natives(1651208000)

veh = 0

menu.divider(menu.my_root(), 'Fun menu' )

--------------directory--------------
	funmenudir = filesystem.store_dir().."funmenu\\"
	funmenulangdir = funmenudir.."lang\\"
	phonebgdir = funmenudir.."Phone BG Image//"
	settingdir = funmenudir.."funmenuconfig.ini"
	speedmeterneedle = funmenudir.."Needledefault.dds"
	speedmeterradiant = funmenudir.."Speedometerdefault.dds"
	speedmeterrpmraddiant = funmenudir.."RPM.dds"
	speedmeterneedlecherax = funmenudir.."Needlecherax.dds"
	speedmeterradiantcherax = funmenudir.."Speedometercherax.dds"
	speedmeterrrpmcherax = funmenudir.."RPMcherax.dds"
	onlineplayerlib = "store.funmenu.lib.onlineplayer"
	selflib = "store.funmenu.lib.self"
	vehiclelib = "store.funmenu.lib.vehicle"
	iadrive = "store.funmenu.lib.iadrive"
	weaponlib = "store.funmenu.lib.weapon"
	audiolib = "store.funmenu.lib.audio"
	misclib = "store.funmenu.lib.misc"
	entmanalib = "store.funmenu.lib.entity manager"
	esplib = "store.funmenu.lib.espsettings"
	gtascriptmonitorlib = "store.funmenu.lib.gtascriptmonitor"

	local enlang = funmenulangdir.."Englishtrad.lua"
	local frlang = funmenulangdir.."Frenchtrad.lua"

	if not filesystem.exists(funmenudir) then
            filesystem.mkdir(funmenudir)
    end
	if not filesystem.exists(funmenulangdir) then
            filesystem.mkdir(funmenulangdir)
    end
	if not filesystem.exists(settingdir) then
                local open = io.open(settingdir, "w+")
                open:write("Unknown")
                open:close()
    end
--------------directory end--------------
xscreensize, yscreensize = directx.get_client_size()
function requestControlLoop(entity)
	local tick = 0
	while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and tick < 25 do
		util.yield()
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
		tick = tick + 1
	end
	if NETWORK.NETWORK_IS_SESSION_STARTED() then
		local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
		NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
	end
end
function rotateentity(entity, rotation)
	while not ENTITY.GET_ENTITY_HEADING(veh) == rotation do
		requestControlLoop(entity)
		ENTITY.SET_ENTITY_HEADING(entity, rotation)
		util.yield(1000)
	end
end
function requestModels(...)
	local arg = {...}
	for _, model in ipairs(arg) do
		if not STREAMING.IS_MODEL_VALID(model) then
			error("tried to request an invalid model")
		end
		STREAMING.REQUEST_MODEL(model)
		while not STREAMING.HAS_MODEL_LOADED(model) do
			util.yield()
		end
	end
end
function requestweapon(...)
	local arg = {...}
	for _, model in ipairs(arg) do
		WEAPON.REQUEST_WEAPON_ASSET(model, 31, 26)
		while not WEAPON.HAS_WEAPON_ASSET_LOADED(model) do
			util.yield()
		end
	end
end
function attachweapon(spawnweapon)
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 416676503) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 690389602) then
		ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.15, 0, 0.13, 270, 0, 0, false, true, false, false, 1, true)
	end
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -728555052) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -1609580060) then
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_bat")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.3, -0.18, -0.15, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_crowbar")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 90, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_battleaxe")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_golfclub")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hatchet")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_poolcue")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), -0.2, -0.18, 0.1, 0, 120, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stone_hatchet")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_knuckle")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 90, false, true, false, false, 1, true)
		end
		if not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_bat"))  and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_crowbar")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_battleaxe"))and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_golfclub")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hatchet")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_poolcue")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stone_hatchet")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_knuckle")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0, 0, 0.13, 0, 90, 270, false, true, false, false, 1, true)
		end
	end
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1548507267) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -37788308) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1595662460) then	
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_petrolcan")) or (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hazardcan")) or (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fertilizercan")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0, -0.18, -0, 0, 90, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_proxmine")) or (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stickybomb")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 0, 270, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fireextinguisher")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0, -0.05, 0.13, 0, 270, 90, false, true, false, false, 1, true)
		end
		if not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_petrolcan")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hazardcan")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fertilizercan")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_proxmine")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stickybomb")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fireextinguisher")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 270, false, true, false, false, 1, true)
		end
	end

	if not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 416676503) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 690389602) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -728555052) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -1609580060) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1548507267) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -37788308) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1595662460) then
		ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0, -0.18, 0, 180, 220, 0, false, true, false, false, 1, true)
	end
end
function fixveh( vehicle )
	vel = ENTITY.GET_ENTITY_VELOCITY(vehicle)
	VEHICLE.SET_VEHICLE_FIXED(vehicle)
	VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, 1000)
	ENTITY.SET_ENTITY_VELOCITY(vehicle, vel.x, vel.y, vel.z)
end
function getveh( plid )
	vehonline = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(plid), true)
	return vehonline
end
function plyped()
	return PLAYER.PLAYER_PED_ID()
end
function disableocclusion(status)
	local peds = entities.get_all_peds_as_handles()
	for _, ped in ipairs(peds) do
		if ENTITY.DOES_ENTITY_EXIST(ped) then
			PED.SET_PED_AO_BLOB_RENDERING(ped, status)
		end
	end
end
function driveitgun ()
	entitodrive = memory.alloc_int()
	if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(PLAYER.PLAYER_ID(), entitodrive) then
		if PAD.IS_CONTROL_PRESSED(1, 23) then
			PED.SET_PED_INTO_VEHICLE(plyped(), memory.read_int(entitodrive), -1)
		end
	end
	memory.free(entitodrive)
end
function deletegun ()
	entitodelete = memory.alloc_int()
	if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(PLAYER.PLAYER_ID(), entitodelete) then
		if PAD.IS_CONTROL_PRESSED(1, 178) then
			entities.delete_by_handle(memory.read_int(entitodelete))
		end
	end
	memory.free(entitodrive)
end
function spawnplaneforattack(posforplane, playerplane, zspawnplus, headingspawn)
	planehash = util.joaat("Lazer")
	requestModels(planehash)
	spawnplanef = VEHICLE.CREATE_VEHICLE(planehash, posforplane.x, posforplane.y, posforplane.z+zspawnplus, headingspawn, true, false)
	VEHICLE.SET_VEHICLE_ENGINE_ON(spawnplanef, true, true, true)
	spawnpedforplane = PED.CREATE_RANDOM_PED(posplane.x, posplane.y, posplane.z)
	PED.SET_PED_INTO_VEHICLE(spawnpedforplane, spawnplanef, -1)
	TASK.TASK_PLANE_MISSION(spawnpedforplane, spawnplanef, 0, playerplane, posforplane.x, posforplane.y, posforplane.z, 6, 0, 0, 0, 30, 500)
	return spawnplanef
end
function delattackplane(model)
	local hash = util.joaat(model)
	local vehicles = entities.get_all_vehicles_as_handles()
	for _, vehicle in ipairs(vehicles) do
		if ENTITY.DOES_ENTITY_EXIST(vehicle) and ENTITY.GET_ENTITY_MODEL(vehicle) == hash then
			local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
			if not PED.IS_PED_A_PLAYER(ped) then
				requestControlLoop(vehicle)
				requestControlLoop(ped)
				entities.delete_by_handle(vehicle)
				entities.delete_by_handle(ped)
			end
		end
	end
end
function spawnpedattack(playerattack, modelpedattack, numberped, invincbleped, invisibleped, onplayer)
	numberloop = numberped
	if (modelpedattack == 0) or not STREAMING.IS_MODEL_VALID(util.joaat(modelpedattack)) then
		hashpedattack = util.joaat("ig_chrisformage")
	else
		hashpedattack = util.joaat(modelpedattack)
	end
	requestModels(hashpedattack)
	while not (numberloop == 0)do
		posformage = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerattack))
		if onplayer then
			spawnpedattacks = PED.CREATE_PED(0, hashpedattack, posformage.x, posformage.y, posformage.z, 0, true, false)
		else
			spawnpedattacks = PED.CREATE_PED(0, hashpedattack, posformage.x+math.random(-10, 10), posformage.y+math.random(-10, 10), posformage.z, 0, true, false)
		end
		if invincbleped then
			ENTITY.SET_ENTITY_INVINCIBLE(spawnpedattacks, true)
		end
		if invisibleped then
			ENTITY.SET_ENTITY_VISIBLE(spawnpedattacks, false, false)
		end
		PED.SET_PED_DEFAULT_COMPONENT_VARIATION(spawnpedattacks)
		WEAPON.GIVE_DELAYED_WEAPON_TO_PED(spawnpedattacks, util.joaat("WEAPON_PISTOL"), 9999, true)
		PED.SET_PED_AS_COP(spawnpedattacks, true)
		TASK.TASK_COMBAT_PED(spawnpedattacks, PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerattack), 0, 16)
		numberloop = numberloop-1
		util.yield(100)
	end
end
function worldToScreen(coords)
    local sx = memory.alloc()
    local sy = memory.alloc()
    local success = GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(coords.x, coords.y, coords.z, sx, sy)
    local screenx = memory.read_float(sx) local screeny = memory.read_float(sy) memory.free(sx) memory.free(sy)
    return {x = screenx, y = screeny, success = success}
end
function drawline(bone1, bone2, color)
	bone1stand = worldToScreen(bone1)
	bone2stand = worldToScreen(bone2)
	if bone1stand.success and bone2stand.success then
		directx.draw_line(bone1stand.x, bone1stand.y, bone2stand.x, bone2stand.y, color)
	end
end
function drawlinenat(modelbox1, modelbox2, color)
	GRAPHICS.DRAW_LINE(modelbox1.x, modelbox1.y, modelbox1.z, modelbox2.x, modelbox2.y, modelbox2.z, math.floor(color.r*255), math.floor(color.g*255), math.floor(color.b*255), math.floor(color.a*255))
end
function getbonecoord(playerid, bone)
	antilag = ENTITY.GET_ENTITY_VELOCITY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerid))
	antilagreduce = 80
	boner = PED.GET_PED_BONE_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerid), bone, 0, 0, 0)
	boner.x = boner.x-(antilag.x/antilagreduce)
	boner.y = boner.y-(antilag.y/antilagreduce)
	boner.z = boner.z-(antilag.z/antilagreduce)
	return boner
end
function getmenuvalueplayer(playerid, path)
	return menu.get_value(menu.ref_by_path("Players>"..players.get_name_with_tags(playerid)..">"..path))
end
function getmenuvalue(path)
	return menu.get_value(menu.ref_by_path("Stand>Lua Scripts>"..SCRIPT_NAME..">"..path))
end
function getgamerhandle(pid)
	ptr = memory.alloc_int()
	NETWORK.NETWORK_HANDLE_FROM_PLAYER(PLAYER.PLAYER_ID(), ptr, 13)
	return ptr
end
function cleartaskinveh()
	TASK.CLEAR_PED_TASKS_IMMEDIATELY(plyped())
	PED.SET_PED_INTO_VEHICLE(plyped(), vehlast, -1)
end

function readlangfile()					--credit for lang changing code goes to IceDoomfist hope he don't mind
	local open = io.open(settingdir)
	return open:read("*a"), open:close()
end
function writelangfile(Language)
	local open = io.open(settingdir, "w+")
	open:write(Language)
	open:close()
end
function loadlangfile(Dir, Lang)
	if filesystem.exists(Dir) then
		dofile(Dir)
	else
		util.toast(Lang.." language file doesn't exist.")
		util.toast("Fatal script error stopping script")
		util.stop_script()
	end
end
function warning(Command_ID, langwrite)
	menu.show_warning(Command_ID, CLICK_MENU, RESTART_MESS, function()
	writelangfile(langwrite)
	util.stop_script()
	end)
end

if readlangfile() == "Unknown" then
	if lang.get_current() == "fr" then
		writelangfile("French - fran�ais")
	else
		writelangfile("English")
	end
end

if readlangfile() == "French - fran�ais" then
	loadlangfile(frlang, "French")
	actuallang = "French"
else
	loadlangfile(enlang, "English")
	actuallang = "English"
end

speedmeterradiantid = directx.create_texture(speedmeterradiant)
speedmetterneedleid = directx.create_texture(speedmeterneedle)
speedmeterrpmraddiantid = directx.create_texture(speedmeterrpmraddiant)
speedmeterradiantidcherax = directx.create_texture(speedmeterradiantcherax)
speedmetterneedleidcherax = directx.create_texture(speedmeterneedlecherax)
speedmeterrrpmidcherax = directx.create_texture(speedmeterrrpmcherax)


successself = pcall(require, selflib)
if not successself then
	util.toast(FAIL_LOAD1..SELF_MENU..FAIL_LOAD2)
end
successvehicle = pcall(require, vehiclelib)
if not successvehicle then
	util.toast(FAIL_LOAD1..VEHICULE_MENU..FAIL_LOAD2)
end
successweapon = pcall(require, weaponlib)
if not successweapon then
	util.toast(FAIL_LOAD1..WEAP_MENU..FAIL_LOAD2)
end
successaudio = pcall(require, audiolib)
if not successaudio then
	util.toast(FAIL_LOAD1..AUDIO_MENU..FAIL_LOAD2)
end
successmisc = pcall(require, misclib)
if not successmisc then
	util.toast(FAIL_LOAD1..MISC_MENU..FAIL_LOAD2)
end
successentmana = pcall(require, entmanalib)
if not successentmana then
	util.toast(FAIL_LOAD1..ENTITY_MANAGE..FAIL_LOAD2)
end
successesp = pcall(require, esplib)
if not successesp then
	util.toast(FAIL_LOAD1..ESP_FAIL..FAIL_LOAD2)
end
successgtascript = pcall(require, gtascriptmonitorlib)
if not successgtascript then
	util.toast(FAIL_LOAD1..GTA_MONITOR_FAIL..FAIL_LOAD2)
end

--------------settings menu--------------
local settingmenu = menu.list(menu.my_root(), SETTING_MENU, {}, "")
local langmenu = menu.list(settingmenu, LANG_MENU..actuallang, {}, "")

chooselang_fr = menu.action(langmenu, "French - Francais", {}, "", function()
	warning(chooselang_fr, "French - fran�ais")
end)
chooselang_en = menu.action(langmenu, "English", {}, "", function()
	warning(chooselang_en, "English")
end)


--------------settings menu end--------------
hasbeenexecuted = false
controlveh = off
vehcontrol = 0
distancehalt = 0 
timehalt = 1


require(onlineplayerlib)
loadingtimeend = util.current_time_millis()
util.show_corner_help(WELCOM_MESS.. loadingtimeend-loadtimestart ..WELCOM_MESS_2)


while true do
	pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	vehlast = entities.get_user_vehicle_as_handle()
	veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()), false)
	if not NETWORK.NETWORK_IS_SESSION_STARTED() and successself then 
		menu.set_visible(specialability, true)
	end
	if NETWORK.NETWORK_IS_SESSION_STARTED() and successself then 
		menu.set_visible(specialability, false)
	end
	if successmisc then
		MOBILE.SET_MOBILE_PHONE_ROTATION(phrotx, phroty, phrotz)
	end
	
	
	util.yield()
end