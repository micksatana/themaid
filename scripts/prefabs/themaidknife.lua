local assets =
{
	-- Animation files used for the item.
	Asset("ANIM", "anim/themaidknife.zip"),

	-- Inventory image and atlas file used for the item.
    Asset("ATLAS", "images/inventoryimages/themaidknife.xml"),
    Asset("IMAGE", "images/inventoryimages/themaidknife.tex"),
}
prefabs = {
    "themaidknife",
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", -- Symbol to override.
    	"themaidknife", -- Animation bank we will use to overwrite the symbol.
    	"themaidknife") -- Symbol to overwrite it with.
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end

local function init()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("themaidknife")
    inst.AnimState:SetBuild("themaidknife")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("sharp")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(50)

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/themaidknife.xml"
    inst.components.inventoryitem.imagename = "themaidknife"
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end
return  Prefab("common/inventory/themaidknife", init, assets, prefabs)