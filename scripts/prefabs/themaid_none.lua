local assets =
{
	Asset( "ANIM", "anim/themaid.zip" ),
	Asset( "ANIM", "anim/ghost_themaid_build.zip" ),
}

local skins =
{
	normal_skin = "themaid",
	ghost_skin = "ghost_themaid_build",
}

return CreatePrefabSkin("themaid_none",
{
	base_prefab = "themaid",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"THEMAID", "CHARACTER", "BASE"},
	build_name_override = "themaid",
	rarity = "Character",
})