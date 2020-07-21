PrefabFiles = {
	"themaid",
    "themaid_none",
    "themaidknife",
    "themaidpill",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/themaid.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/themaid.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/themaid.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/themaid.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/themaid_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/themaid_silho.xml" ),

    Asset( "IMAGE", "bigportraits/themaid.tex" ),
    Asset( "ATLAS", "bigportraits/themaid.xml" ),
	
	Asset( "IMAGE", "images/map_icons/themaid.tex" ),
	Asset( "ATLAS", "images/map_icons/themaid.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_themaid.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_themaid.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_themaid.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_themaid.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_themaid.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_themaid.xml" ),
	
	Asset( "IMAGE", "images/names_themaid.tex" ),
    Asset( "ATLAS", "images/names_themaid.xml" ),
	
	Asset( "IMAGE", "images/names_gold_themaid.tex" ),
    Asset( "ATLAS", "images/names_gold_themaid.xml" ),

    Asset("ATLAS", "images/inventoryimages/themaidknife.xml"),
    Asset("IMAGE", "images/inventoryimages/themaidknife.tex"),

    Asset("ATLAS", "images/themaidtab/themaidtab.xml"),
    Asset("IMAGE", "images/themaidtab/themaidtab.tex"),

	Asset("ANIM", "anim/themaidpill.zip"),
    Asset("ATLAS", "images/inventoryimages/themaidpill.xml"),
}

AddMinimapAtlas("images/map_icons/themaid.xml")
AddMinimapAtlas("images/map_icons/themaidknife.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH
local TUNING = GLOBAL.TUNING

local startingItems = {
	themaidknife = {atlas = "images/inventoryimages/themaidknife.xml"},
	"blue_cap",
	"green_cap",
}

TUNING.THEMAID = {}
TUNING.THEMAID.REVENGEKEY = GetModConfigData("revengekey") or 122

-- The character select starting items
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.THEMAID = {
    "themaidknife",
	"blue_cap",
	"green_cap",
}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE = type(TUNING.STARTING_ITEM_IMAGE_OVERRIDE) == "table" and GLOBAL.MergeMaps(TUNING.STARTING_ITEM_IMAGE_OVERRIDE, startingItems) or startingItems

-- The character select screen lines
STRINGS.CHARACTER_TITLES.themaid = "The Maid"
STRINGS.CHARACTER_NAMES.themaid = "Joy"
STRINGS.CHARACTER_DESCRIPTIONS.themaid = "*Quick, quick, Master is calling\n*Like to do OT\n*Servant mindset\n*Has a tough life\n*Holding a grudge\n*Joy's Knife is deadly sharp\n*Joy's Pill keeps her sane"
STRINGS.CHARACTER_QUOTES.themaid = "\"How Ploy died?\""
STRINGS.CHARACTER_SURVIVABILITY.themaid = "Somewhat"

-- Custom speech strings
STRINGS.CHARACTERS.THEMAID = require "speech_themaid"

-- The character's name as appears in-game 
STRINGS.NAMES.THEMAID = "Joy"
STRINGS.SKIN_NAMES.themaid_none = "Joy"

-- Your character's stats
TUNING.THEMAID_HEALTH = 250
TUNING.THEMAID_HUNGER = 150
TUNING.THEMAID_SANITY = 100
TUNING.THEMAID_HUNGER_RATE = TUNING.WILSON_HUNGER_RATE * 0.8

local theMaidTab = AddRecipeTab("The Maid Tab", 666, "images/themaidtab/themaidtab.xml", "themaidtab.tex", "themaidbuilder")

local theMaidPill = Ingredient("themaidpill", 1)
theMaidPill.atlas = "images/inventoryimages/themaidpill.xml"
STRINGS.RECIPE_DESC.THEMAIDPILL = "Greatly boost sanity"

local theMaidPillRecipe = AddRecipe("themaidpill", {
    Ingredient("blue_cap", 1), Ingredient("green_cap", 1)
}, theMaidTab, TECH.NONE, nil, nil, nil, nil, "themaidbuilder", "images/inventoryimages/themaidpill.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("themaid", "FEMALE")
