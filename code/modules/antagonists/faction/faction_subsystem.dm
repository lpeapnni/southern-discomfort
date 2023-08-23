///Forces the faction objectives via variable editing. Used for debugging.
GLOBAL_VAR(faction_objective_override)

SUBSYSTEM_DEF(faction_objectives)
	name = "Faction Objectives"
	flags = SS_NO_FIRE
	var/datum/faction_objectives/current_objectives

/datum/controller/subsystem/faction_objectives/Initialize(start_timeofday)
	// set objectives
	if(!GLOB.faction_objective_override)
		var/objectives_to_use = pick(subtypesof(/datum/faction_objectives))
		current_objectives = new objectives_to_use
	else
		current_objectives = new GLOB.faction_objective_override

	// spawn items for faction objectives
	for(var/obj/effect/spawner/faction_item/faction_item_spawner in GLOB.faction_item_spawners)
		faction_item_spawner.spawn_item()

	// send intel message to all message terminals
	if(current_objectives.intel_message)
		for(var/obj/machinery/msgterminal/i_hate_the_fbi_and_i_hate_the_cia in GLOB.allTerminals)
			i_hate_the_fbi_and_i_hate_the_cia.createmessage("A little birdie", "INTEL REPORT", current_objectives.intel_message, 2) // 2 = high message priority
	return ..()

/datum/controller/subsystem/faction_objectives/stat_entry(msg)
	msg = "Current Faction Objectives: [current_objectives.name]"
	return ..()
