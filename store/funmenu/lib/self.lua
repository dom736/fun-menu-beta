local selfmenu = menu.list(menu.my_root(), SELF_MENU, {}, "")
local selfdecalmenu = menu.list(selfmenu, "Decal", {}, "")
nofalldama = off
menu.toggle(selfmenu, NO_FALL_DAMAGE, {}, "", function(on)
    nofalldama = on
	while nofalldama do
		PLAYER.SET_PLAYER_FALL_DISTANCE_TO_TRIGGER_RAGDOLL_OVERRIDE(PLAYER.PLAYER_ID(), 10000)
		util.yield()
	end
	PLAYER.SET_PLAYER_FALL_DISTANCE_TO_TRIGGER_RAGDOLL_OVERRIDE(PLAYER.PLAYER_ID(), 10)
end, false)
nocritical = off
menu.toggle(selfmenu, NO_CRITICAL, {}, "", function(on)
    nocritical = on
	while nocritical do
		PED.SET_PED_SUFFERS_CRITICAL_HITS(PLAYER.PLAYER_PED_ID(), false)
		util.yield()
	end
	PED.SET_PED_SUFFERS_CRITICAL_HITS(PLAYER.PLAYER_PED_ID(), true)
end, false)
unlimair = off
menu.toggle(selfmenu, UNLIM_AIR, {}, "", function(on)
    unlimair = on
	while unlimair do 
		PED.SET_PED_DIES_IN_WATER(PLAYER.PLAYER_PED_ID(), false)
		PED.SET_PED_DIES_IN_SINKING_VEHICLE(PLAYER.PLAYER_PED_ID(), false)
		util.yield()
	end
	PED.SET_PED_DIES_IN_WATER(PLAYER.PLAYER_PED_ID(), true)
	PED.SET_PED_DIES_IN_SINKING_VEHICLE(PLAYER.PLAYER_PED_ID(), true)
end, false)
menu.action(selfdecalmenu, "clear all decal", {}, "Warning somme cannot be cleared", function()
	PED.CLEAR_PED_DAMAGE_DECAL_BY_ZONE(plyped(), 1--[[damagezone]], "all"--[[decalName]])
end)
damagedecal = 1
menu.slider(selfdecalmenu, "Damage zone", {""}, "0 = Torso, 1 = Head, 2 = Left arm, 3 = Right arm, 4 = Left leg, 5 = Right leg", 0, 5, 1, 1, function(s)
	damagedecal = s
end)
xposdecal = 0.5
menu.slider(selfdecalmenu, "X coord", {""}, "Horizon", 0, 100, 50, 1, function(s)
	sf = s/100
	xposdecal = sf
end)
yposdecal = 0.5
menu.slider(selfdecalmenu, "Y coord", {""}, "Vertical", 0, 100, 50, 1, function(s)
	sf = s/100
	yposdecal = sf
end)
headingdecal = 0
menu.slider(selfdecalmenu, "Rotation", {""}, "", 0, 359, 0, 1, function(s)
	headingdecal = s
end)
scaledecal = 1
menu.slider(selfdecalmenu, "Scale", {""}, "", 0, 300, 10, 1, function(s)
	sf = s/10
	scaledecal = sf
end)
variationdecal = 0
menu.slider(selfdecalmenu, "Variation", {""}, " scar: 13 variation, blushing: no limit ?, cs_flush_anger: 0 variation, cs_flush_anger_face: no limit ?, bruise: no limit ?, bruise_large: no limit ?, herpes: 0 variation, ArmorBullet: no limit ?, basic_dirt_cloth: no limit ?, basic_dirt_skin: no limit ?, cs_trev1_dirt: 13 variation", 0, 300, 0, 1, function(s)
	
	variationdecal = s
end)
decaltype = ""
menu.slider(selfdecalmenu, "Decal type", {""}, "1 = scar, 2 = blushing, 3 = cs_flush_anger, 4 = cs_flush_anger_face, 5 = bruise, 6 = bruise_large, 7 = herpes, 8 = ArmorBullet, 9 = basic_dirt_cloth, 10 = basic_dirt_skin, 11 = cs_trev1_dirt", 1, 11, 1, 1, function(s)
	if s == 1 then
		decaltype = "scar"
	end
	if s == 2 then
		decaltype = "blushing"
	end
	if s == 3 then
		decaltype = "cs_flush_anger"
	end
	if s == 4 then
		decaltype = "cs_flush_anger_face"
	end
	if s == 5 then
		decaltype = "bruise"
	end
	if s == 6 then
		decaltype = "bruise_large"
	end
	if s == 7 then
		decaltype = "herpes"
	end
	if s == 8 then
		decaltype = "ArmorBullet"
	end
	if s == 9 then
		decaltype = "basic_dirt_cloth"
	end
	if s == 10 then
		decaltype = "basic_dirt_skin"
	end
	if s == 11 then
		decaltype = "cs_trev1_dirt"
	end
end)
menu.action(selfdecalmenu, "add decal", {}, "", function()
	PED.APPLY_PED_DAMAGE_DECAL(plyped()--[[ped]], damagedecal--[[damagezone]], xposdecal--[[xOffset]], yposdecal--[[yOffset]], headingdecal--[[heading]], scaledecal--[[scale]], 1--[[alpha]], variationdecal--[[variation]], 0--[[fadeIn]], decaltype--[[decalName]])
end)
pednerf = off
menu.toggle(selfmenu, PED_NERF, {}, PED_NERF_DESC, function(on)
	pednerf = on
	while pednerf do
		PED.SET_AI_WEAPON_DAMAGE_MODIFIER(0)
		PED.SET_AI_MELEE_WEAPON_DAMAGE_MODIFIER(0)
		util.yield()
	end
		PED.SET_AI_WEAPON_DAMAGE_MODIFIER(1)
		PED.SET_AI_MELEE_WEAPON_DAMAGE_MODIFIER(1)
end)
specialability = menu.toggle_loop(selfmenu, INF_SPECIAL, {}, "", function()
	PLAYER.SPECIAL_ABILITY_FILL_METER(PLAYER.PLAYER_ID(), true)
end)