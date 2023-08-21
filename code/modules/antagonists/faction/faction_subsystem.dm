///Forces the faction objectives via variable editing. Used for debugging.
GLOBAL_VAR(faction_objective_override)

SUBSYSTEM_DEF(faction_objectives)
	name = "Faction Objectives"
	flags = SS_NO_FIRE
	var/datum/faction_objectives/current_objectives

/datum/controller/subsystem/faction_objectives/Initialize(start_timeofday)
	if(!GLOB.faction_objective_override)
		var/objectives_to_use = pick(subtypesof(/datum/faction_objectives))
		current_objectives = new objectives_to_use
	else
		current_objectives = new GLOB.faction_objective_override

	for(var/obj/effect/spawner/faction_item/faction_item_spawner in GLOB.faction_item_spawners)
		faction_item_spawner.spawn_item()

	return ..()

/datum/controller/subsystem/faction_objectives/stat_entry(msg)
	msg = "Current Faction Objectives: [current_objectives.name]"
	return ..()
