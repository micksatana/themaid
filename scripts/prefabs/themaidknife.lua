local assets =
{
	Asset("ANIM", "anim/themaidknife.zip"),
    Asset("ANIM", "anim/swap_themaidknife.zip"),
}
prefabs = {
}

local function OnEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_themaidknife", "swap_themaidknife")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end

local function OnUnequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end

local function init()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("themaidknife")
    inst.AnimState:SetBuild("themaidknife")
    inst.AnimState:PlayAnimation("idle")

	inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon( "themaidknife.tex" )

    MakeInventoryFloatable(inst, "med", 0.2, 0.7)
    MakeInventoryPhysics(inst)

    
    inst.entity:SetPristine()
    
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(66)

    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.CHOP, 1.5)
    inst.components.tool:SetAction(ACTIONS.MINE, 1.5)
    inst.components.tool:SetAction(ACTIONS.DIG, 1.5)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/themaidknife.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    MakeHauntableLaunch(inst)

    return inst
end

STRINGS.NAMES.THEMAIDKNIFE = "Joy's Knife"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.THEMAIDKNIFE = "Extremely deadly sharp! It also can be used as universal tool."

return  Prefab("common/inventory/themaidknife", init, assets, prefabs)