local audiomenu = menu.list(menu.my_root(), AUDIO_MENU, {}, "")
local audioplanemenu = menu.list(audiomenu, PLANE_SUBMENU, {}, "")
local audioalarmmenu = menu.list(audiomenu, ALARM_SUBMENU, {}, "")
local audiopolicereportmenu = menu.list(audiomenu, POLICE_SUBMENU, {}, "")
local audioengine = menu.list(audiomenu, ENGINE_SUBMENU, {}, "")
local audioradio = menu.list(audiomenu, RADIO_SUBMENU, {}, "")
audiocop = off
menu.toggle(audiomenu, NO_DISTANT_COP_SIREN, {}, "", function(on)
    audiocop = on
	while audiocop do
		AUDIO.DISTANT_COP_CAR_SIRENS(false)
		util.yield()
	end
	AUDIO.DISTANT_COP_CAR_SIRENS(true)
end, false)
nosiren = off
menu.toggle(audiomenu, NO_SIREN, {}, "", function(on)
    nosiren = on
	while nosiren do 
		VEHICLE.SET_VEHICLE_HAS_MUTED_SIRENS(veh, true)
		util.yield()
	end
	VEHICLE.SET_VEHICLE_HAS_MUTED_SIRENS(veh, false)
end, false)
nostallsound = off
menu.toggle(audioplanemenu, NO_STALL_SOUND, {'nostallsound'}, "", function(on)
    nostallsound = on
	while nostallsound do
		AUDIO.ENABLE_STALL_WARNING_SOUNDS(veh, false)
		util.yield()
	end
	AUDIO.ENABLE_STALL_WARNING_SOUNDS(veh, true)
end, false)
menu.action(audioalarmmenu, STP_ALRAM, {'stopalarm'}, "", function()
    AUDIO.STOP_ALARM('AGENCY_HEIST_FIB_TOWER_ALARMS', true)
	AUDIO.STOP_ALARM('AGENCY_HEIST_FIB_TOWER_ALARMS_UPPER', true)
	AUDIO.STOP_ALARM('AGENCY_HEIST_FIB_TOWER_ALARMS_UPPER_B', true)
end)
tpalarm = off
menu.toggle(audioalarmmenu, TP_TO_ALARM, {'tpalarm'}, "", function(on)
    tpalarm = on
end, false)
menu.action(audioalarmmenu, "fib alarm", {'fib1'}, "", function()
	if tpalarm then
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), 99, -743, 45)
	end
    AUDIO.START_ALARM('AGENCY_HEIST_FIB_TOWER_ALARMS', true)
end)
menu.action(audioalarmmenu, "fib alarm upper", {'fib2'}, "", function()
	if tpalarm then
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), 126, -747, 262)
	end
    AUDIO.START_ALARM('AGENCY_HEIST_FIB_TOWER_ALARMS_UPPER', true)
end)
menu.action(audioalarmmenu, "fib alarm upper b", {'fib3'}, "", function()
	if tpalarm then
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), 114, -740, 258)
	end
    AUDIO.START_ALARM('AGENCY_HEIST_FIB_TOWER_ALARMS_UPPER_B', true)
end)
menu.action(audiopolicereportmenu, CANCEL_REPORT, {''}, "", function()
	AUDIO.CANCEL_ALL_POLICE_REPORTS()
end)
menu.action(audiopolicereportmenu, "LAMAR_1_POLICE_LOST", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("LAMAR_1_POLICE_LOST", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_AH_3B_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_AH_3B_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_AH_MUGGING_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_AH_MUGGING_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_AH_PREP_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_AH_PREP_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_AH_PREP_02", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_AH_PREP_02", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_ARMENIAN_1_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_ARMENIAN_1_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_ARMENIAN_1_02", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_ARMENIAN_1_02", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_ASS_BUS_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_ASS_BUS_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_ASS_MULTI_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_ASS_MULTI_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_BARRY_3A_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_BARRY_3A_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_BS_2A_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_BS_2A_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_BS_2B_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_BS_2B_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_BS_2B_02", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_BS_2B_02", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_BS_2B_03", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_BS_2B_03", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_BS_2B_04", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_BS_2B_04", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_BS_PREP_A_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_BS_PREP_A_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_BS_PREP_B_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_BS_PREP_B_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_CAR_STEAL_2_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_CAR_STEAL_2_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_CAR_STEAL_4_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_CAR_STEAL_4_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_DH_PREP_1_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_DH_PREP_1_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_FIB_1_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_FIB_1_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_FIN_C2_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_FIN_C2_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_Franklin_2_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_Franklin_2_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_FRANLIN_0_KIDNAP", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_FRANLIN_0_KIDNAP", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_GETAWAY_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_GETAWAY_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_JOSH_3_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_JOSH_3_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_JOSH_4_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_JOSH_4_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_JSH_2A_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_JSH_2A_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_JSH_2A_02", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_JSH_2A_02", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_JSH_2A_03", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_JSH_2A_03", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_JSH_2A_04", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_JSH_2A_04", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_JSH_2A_05", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_JSH_2A_05", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_JSH_PREP_1A_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_JSH_PREP_1A_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_JSH_PREP_1B_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_JSH_PREP_1B_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_JSH_PREP_2A_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_JSH_PREP_2A_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_JSH_PREP_2A_02", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_JSH_PREP_2A_02", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_LAMAR_1_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_LAMAR_1_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_MIC_AMANDA_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_MIC_AMANDA_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_NIGEL_1A_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_NIGEL_1A_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_NIGEL_1D_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_NIGEL_1D_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_PS_2A_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_PS_2A_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_PS_2A_02", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_PS_2A_02", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_PS_2A_03", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_PS_2A_03", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_SEC_TRUCK_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_SEC_TRUCK_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_SEC_TRUCK_02", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_SEC_TRUCK_02", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_SEC_TRUCK_02", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_SEC_TRUCK_02", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_SEC_TRUCK_03", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_SEC_TRUCK_03", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_SIMEON_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_SIMEON_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_Sol_3_01", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_Sol_3_01", 0.0)
end)
menu.action(audiopolicereportmenu, "SCRIPTED_SCANNER_REPORT_Sol_3_02", {''}, "", function()
	AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_Sol_3_02", 0.0)
end)
vehaudiooverride = ""
menu.text_input(audioengine, OVRD_ENG_AUDIO, {"ovengaudio"}, OVRD_ENG_AUDIO_DESC, function(s)
	vehaudiooverride = s
	AUDIO.FORCE_USE_AUDIO_GAME_OBJECT(veh, s)
end)
lastveh = 0
menu.toggle_loop(audioengine, AUTO_OVRD_ENG_AUDIO, {}, AUTO_OVRD_ENG_AUDIO_DESC, function()
	if veh ~= lastveh then 
		lastveh = veh
		AUDIO.FORCE_USE_AUDIO_GAME_OBJECT(veh, vehaudiooverride)
	end
end)
onlymusic = off
menu.toggle(audioradio, ONLY_MUSIC, {}, "", function(on)
	onlymusic = on
	while onlymusic do 
		if not AUDIO.GET_PLAYER_RADIO_STATION_INDEX() == 255 then 
			AUDIO.SET_RADIO_STATION_MUSIC_ONLY(AUDIO.GET_PLAYER_RADIO_STATION_NAME(), true)
		end
		util.yield()
	end
	if not AUDIO.GET_PLAYER_RADIO_STATION_INDEX() == 255 then 
			AUDIO.SET_RADIO_STATION_MUSIC_ONLY(AUDIO.GET_PLAYER_RADIO_STATION_NAME(), false)
	end
end)
menu.action(audioradio, SKIP_FOWARD, {}, "", function()
	AUDIO.SET_RADIO_RETUNE_UP()
end)
menu.action(audioradio, SKIP_BACKWARD, {}, "", function()
	AUDIO.SET_RADIO_RETUNE_DOWN()
end)