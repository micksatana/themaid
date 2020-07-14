PrefabFiles = {
	"themaid",
	"themaid_none",
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
}

AddMinimapAtlas("images/map_icons/themaid.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.themaid = "The Maid"
STRINGS.CHARACTER_NAMES.themaid = "Joy"
STRINGS.CHARACTER_DESCRIPTIONS.themaid = "*Faster in killer mode\n*Sanity drained in killer mode\n*Do not afraid of darkness"
STRINGS.CHARACTER_QUOTES.themaid = "\"How Ploy died?\""
STRINGS.CHARACTER_SURVIVABILITY.themaid = "Slim"

-- Custom speech strings
STRINGS.CHARACTERS.THEMAID = require "speech_themaid"

-- The character's name as appears in-game 
STRINGS.NAMES.THEMAID = "Joy"
STRINGS.SKIN_NAMES.themaid_none = "Joy"

-- The skins shown in the cycle view window on the character select screen.
-- A good place to see what you can put in here is in skinutils.lua, in the function GetSkinModes
local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 } 
    },
}

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("themaid", "FEMALE", skin_modes)
