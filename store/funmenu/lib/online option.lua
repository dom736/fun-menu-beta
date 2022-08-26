
generate_features = function(pid)
	menu.action(menu.player_root(pid), "test", {}, "", function()
		util.toast("test"..pid)
	end)
end

for _, pId in ipairs(players.list()) do
	generate_features(pId)
end
players.on_join(generate_features)
