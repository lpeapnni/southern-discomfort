/obj/effect/spawner/faction_item
	name = "faction objective item spawner"
	var/spawn_on_turf = TRUE
	var/associated_faction // antagonist datum type

/obj/effect/spawner/faction_item/Initialize()
	. = ..()
	GLOB.faction_item_spawners += src

/obj/effect/spawner/faction_item/Destroy()
	GLOB.faction_item_spawners -= src
	. = ..()

/obj/effect/spawner/faction_item/proc/spawn_item()
	if(associated_faction && SSfaction_objectives.current_objectives)
		var/datum/faction_objectives/current_objectives = SSfaction_objectives.current_objectives
		if(current_objectives.faction_items[associated_faction])
			var/atom/A = spawn_on_turf ? get_turf(src) : loc
			var/item_to_spawn = current_objectives.faction_items[associated_faction]
			new item_to_spawn(A)
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/faction_item/legion
	name = "legion objective item spawner"
	associated_faction = /datum/antagonist/faction/legion

/obj/effect/spawner/faction_item/ncr
	name = "NCR objective item spawner"
	associated_faction = /datum/antagonist/faction/legion

/obj/effect/spawner/faction_item/bos
	name = "BOS objective item spawner"
	associated_faction = /datum/antagonist/faction/bos

/obj/effect/spawner/faction_item/tribal
	name = "tribal objective item spawner"
	associated_faction = /datum/antagonist/faction/tribal
