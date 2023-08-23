/datum/faction_objectives
	///The name of the theme.
	var/name = "Faction Objective"
	///All gangs in the theme, typepaths of gangs.
	var/list/involved_factions = list()
	///The objectives for the gangs. Associative list, type = "objective"
	var/list/faction_objectives = list()
	///Items given to the factions. Associative list, faction type = item type
	var/list/faction_items = list()
	///If this isn't null, everyone gets this objective.
	var/list/everyone_objective = null
	///Intel message sent to faction comms consoles.
	var/intel_message = null

/datum/faction_objectives/test
	name = "Test"
	involved_factions = list(/datum/antagonist/faction/ncr, /datum/antagonist/faction/legion)
	faction_objectives = list(

		/datum/antagonist/faction/ncr = "Hello, NCR. Our numbers are going down. We need you to bring those numbers up. \
		Collect protection money from the station's departments by any means necessary. \
		If you need to 'encourage' people to pay up, do so. Get to these potential clients before the Mob does.",

		/datum/antagonist/faction/legion = "Good afternoon, LEGION. The Boss sends his regards. He also sends a message. \
		We need to collect what we're owed. The departments on this station all owe quite a lot of money to us. We intend to collect on our debts. \
		Collect the debt owed by our clients from the departments on the station. \
		Make sure to get to them before those damn mafiosos do."
	)
	intel_message = "IDFK what to put here"
