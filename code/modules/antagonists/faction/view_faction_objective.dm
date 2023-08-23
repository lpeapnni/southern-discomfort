/mob/living/proc/view_faction_objective()
	set name = "View Faction Objective"
	set category = "IC"

	if(islist(mind.antag_datums))
		for(var/antag_datum_type in subtypesof(/datum/antagonist/faction))
			if(locate(antag_datum_type) in mind.antag_datums)
				var/datum/antagonist/faction/antag_datum = locate(antag_datum_type) in mind.antag_datums
				to_chat(usr, "<span class='notice'><b>[antag_datum.faction_name] Objectives:</b></span>")
				var/assigned_objective = antag_datum.my_faction.current_objectives.faction_objectives[antag_datum_type]
				var/additional_objective = antag_datum.my_faction.additional_objective
				if(assigned_objective || additional_objective)
					if(assigned_objective)
						to_chat(usr, "<span class='notice'>Main Objective: [assigned_objective]</span>")
					if(additional_objective)
						to_chat(usr, "<span class='notice'>[assigned_objective ? "Additional " : ""]Objective: [additional_objective]</span>")
				else
					to_chat(usr, "<span class='notice'>No objectives to complete</span>")
