local espmenu = menu.list(menu.my_root(), ESP_SETTINGS, {}, "")
local playeresp = menu.list(espmenu, PLAYER_ESP, {}, "")
colorplayerfar = {r=1, g=0.62745100259781, b=0.0, a=1}
menu.colour(playeresp, FAR_ESP, {"colorplayerfar"}, "", colorplayerfar.r, colorplayerfar.g, colorplayerfar.b, colorplayerfar.a, true, function(c)
	colorplayerfar = c
end)
colorplayernearby = {r=1, g=0.0, b=0.0, a=1}
menu.colour(playeresp, NEARBY_ESP, {"colorplayernearby"}, "", colorplayernearby.r, colorplayernearby.g, colorplayernearby.b, colorplayernearby.a, true, function(c)
	colorplayernearby = c
end)
colorplayerdead = { r=0.0, g=0.0, b=0.0, a=1}
menu.colour(playeresp, DEAD_ESP, {"colorplayerdead"}, "", colorplayerdead.r, colorplayerdead.g, colorplayerdead.b, colorplayerdead.a, true, function(c)
	colorplayerdead = c
end)
local friendesp = menu.list(espmenu, FRIEND_ESP, {}, "")
colorfriendfar = {r=0.3647058904171, g=0.71372550725937, b=0.89803922176361, a=1}
menu.colour(friendesp, FAR_ESP, {"colorfriendfar"}, "", colorfriendfar.r, colorfriendfar.g, colorfriendfar.b, colorfriendfar.a, true, function(c)
	colorfriendfar = c
end)
colorfriendnearby = {r=0.3647058904171, g=0.71372550725937, b=0.89803922176361, a=1}
menu.colour(friendesp, NEARBY_ESP, {"colorfriendnearby"}, "", colorfriendnearby.r, colorfriendnearby.g, colorfriendnearby.b, colorfriendnearby.a, true, function(c)
	colorfriendnearby = c
end)
colorfrienddead = { r=0.0, g=0.0, b=0.0, a=1}
menu.colour(friendesp, DEAD_ESP, {"colorfrienddead"}, "", colorfrienddead.r, colorfrienddead.g, colorfrienddead.b, colorfrienddead.a, true, function(c)
	colorfrienddead = c
end)