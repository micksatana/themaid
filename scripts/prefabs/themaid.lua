local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
	Asset( "ANIM", "anim/themaid_revenge.zip" ),
}

-- Your character's stats
TUNING.THEMAID_HEALTH = 250
TUNING.THEMAID_HUNGER = 150
TUNING.THEMAID_SANITY = 100

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.THEMAID = {
	"themaidknife",
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.THEMAID
end
local prefabs = FlattenTree(start_inv, true)

-- Perk: Like to do OT
local function ApplyLikeToDoOT(inst)
	inst.components.sanity.night_drain_mult = 0
end

-- Perk: Servant mindset
local function ApplyServantMindset(inst)
	inst.components.combat.damagemultiplier = 0.8
	inst.components.combat.min_attack_period = 1
	inst.components.health.absorb = -0.2
end

-- Perk: Quick, quick. Master is calling
local function ApplyMasterIsCalling(inst)
    inst.components.locomotor.walkspeed = 5
	inst.components.locomotor.runspeed = 7.2
end

-- Perk: Holding a grudge
local function ApplyRevengeBuff(inst)
	inst.components.combat.damagemultiplier = 1.5
	inst.components.combat.min_attack_period = 0.5
	inst.components.health.absorb = 0
    inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 9
	inst.components.sanity.dapperness = -0.5
	inst.components.moisture.maxMoistureRate = 0
end

local function RemoveRevengeBuff(inst)
	ApplyServantMindset(inst)
	ApplyMasterIsCalling(inst)
	inst.components.sanity.dapperness = 0
	inst.components.moisture.maxMoistureRate = 0.75
end

local function OnTransformed(inst)
    inst:RemoveEventCallback("animover", OnTransformed)
    inst:RemoveTag("NOCLICK")
	if inst:HasTag("holdinggrudge") then
		inst.AnimState:SetBuild("themaid_revenge")

		inst:DoTaskInTime(0, function()	inst.components.talker:Say("I know you lied! YOU KILLED PLOY !!") end)
	else
		inst.AnimState:SetBuild("themaid")
	end

	if inst.components.playercontroller ~= nil then
        inst.components.playercontroller:Enable(true)
    end
end

local function Transform(inst)
	if inst.components.playercontroller ~= nil then
		inst.components.playercontroller:Enable(false)
	end

	inst.components.locomotor:Stop()
	inst.components.locomotor:Clear()
	inst:ClearBufferedAction()
	inst:AddTag("NOCLICK")
	inst.AnimState:PlayAnimation("skin_change")
	if inst:HasTag("holdinggrudge") then
		inst.AnimState:PushAnimation("laugh", false)
	else
		inst.AnimState:PushAnimation("yawn", false)
	end
	inst.SoundEmitter:PlaySound("dontstarve/common/together/skin_change")

	inst:ListenForEvent("animover", OnTransformed)
end

local function TurnBackToNormal(inst)
	RemoveRevengeBuff(inst)
	inst:RemoveTag("holdinggrudge")
	Transform(inst)
end

local function TurnIntoRevengeForm(inst)
	ApplyRevengeBuff(inst)
	inst:AddTag("holdinggrudge")
	Transform(inst)
end

local function OnSanityDrop(inst, data)
	if inst:HasTag("playerghost") or inst.components.health and inst.components.health:IsDead() then
		return
	end
	-- If sanity drops below 1, we become a shadow creature.
	if inst:HasTag("holdinggrudge") and inst.components.sanity.current < 1 then  
		TurnBackToNormal(inst)
		inst.AnimState:PlayAnimation("yawn")
		inst.AnimState:PushAnimation("idle", false)
		inst.components.talker:Say("Oh, no..I\'ve lost my mind...")
	end
end

-- When the character is revived from human
local function OnBecameHuman(inst)
	ApplyLikeToDoOT(inst)
	ApplyServantMindset(inst)
	ApplyMasterIsCalling(inst)
	if inst:HasTag("holdinggrudge") then
		inst:RemoveTag("holdinggrudge")
	end
end

local function OnBecameGhost(inst)
	RemoveRevengeBuff(inst)
end

-- When loading or spawning the character
local function OnCharacterLoad(inst)
    inst:ListenForEvent("ms_respawnedfromghost", OnBecameHuman)
    inst:ListenForEvent("ms_becameghost", OnBecameGhost)
	inst:ListenForEvent("sanitydelta", OnSanityDrop)

    if inst:HasTag("playerghost") then
        OnBecameGhost(inst)
    else
        OnBecameHuman(inst)
    end
end

local function Revenge(inst)
	if inst:HasTag("holdinggrudge") then
		TurnBackToNormal(inst)
	elseif inst.components.sanity.current > 5 then
		TurnIntoRevengeForm(inst)
	else
		inst:DoTaskInTime(0, function()	inst.components.talker:Say("I can\'t seek revenge now...") end)
		inst:DoTaskInTime(2, function()	inst.components.talker:Say("May need to wait few more seconds") end)
	end
end

-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon("themaid.tex")
	
	inst:AddComponent("keyhandler")
    inst.components.keyhandler:AddActionListener("themaid", TUNING.THEMAID.REVENGEKEY, "REVENGE")
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- Set starting inventory
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default

	-- choose which sounds this character will play
	inst.soundsname = "wendy"

	-- Stats	
	inst.components.health:SetMaxHealth(TUNING.THEMAID_HEALTH)
	inst.components.hunger:SetMax(TUNING.THEMAID_HUNGER)
	inst.components.sanity:SetMax(TUNING.THEMAID_SANITY)
	inst.components.hunger.hungerrate = 0.5
	inst.components.hunger.burnrate = 0.5

	-- A bit bigger than extended character
	inst.Transform:SetScale(1.2, 1.2, 1.2)

	inst.OnLoad = OnCharacterLoad
    inst.OnNewSpawn = OnCharacterLoad
end

AddModRPCHandler("themaid", "REVENGE", Revenge)

return MakePlayerCharacter("themaid", prefabs, assets, common_postinit, master_postinit, prefabs)
