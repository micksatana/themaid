local assets = {
	Asset("ANIM", "anim/themaidpill.zip"),
    Asset("ATLAS", "images/inventoryimages/themaidpill.xml"),
}

local prefabs = {}

local function init(Sim)
    local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallPropagator(inst)

	inst.AnimState:SetBank("themaidpill")
	inst.AnimState:SetBuild("themaidpill")
	inst.AnimState:PlayAnimation("idle")

	inst:AddTag("preparedfood")
	inst:AddTag("themaidpill")

    inst.entity:SetPristine()
    
    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("edible")
	inst.components.edible.foodtype = FOODTYPE.GOODIES
	inst.components.edible.healthvalue = 0
	inst.components.edible.hungervalue = 0
	inst.components.edible.sanityvalue = 40

	inst:AddComponent("inspectable")
	inst:AddComponent("tradable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/themaidpill.xml"

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	return inst
end
STRINGS.NAMES.THEMAIDPILL  = "Joy's Pill"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.THEMAIDPILL= "Greatly boost sanity"

return Prefab("themaidpill", init, assets, prefabs)