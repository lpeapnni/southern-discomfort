// yeah, this is just mostly stolen from tg families
// (like thats a bad thing, families is always fun as fuck)

/datum/antagonist/faction // base class for faction antag objectives
	name = "Faction Member"
	roundend_category = "faction"
	antagpanel_category = "Faction"
	show_in_antagpanel = FALSE //should only show subtypes
	show_to_ghosts = TRUE
	var/faction_name = "Faction"
	/// The overarching family that the owner of this datum is a part of. Family teams are generic and imprinted upon by the per-person antagonist datums.
	var/datum/team/faction/my_faction
	/// The abbreviation of the family corresponding to this family member datum.
	var/faction_id = "IDK"
	/// Type of team to create when creating the gang in the first place. Used for renames.
	var/faction_team_type = /datum/team/faction

/datum/antagonist/faction/create_team(team_given) // gets called whenever add_antag_datum() is called on a mind
	if(team_given)
		my_faction = team_given
		return
	// if theres no preexisting team given we see if one already exists
	var/found_faction = FALSE
	for(var/datum/team/faction/faction_team in get_all_teams(/datum/team/faction))
		if(faction_team.name == faction_name)
			my_faction = faction_team
			found_faction = TRUE
			break
	// if not, we make a new one
	if(!found_faction)
		var/new_faction = new faction_team_type()
		my_faction = new_faction 
		my_faction.name = faction_name
		my_faction.faction_id = faction_id
		my_faction.faction_datum = src
		my_faction.current_objectives = SSfaction_objectives.current_objectives

/datum/antagonist/faction/get_team()
	return my_faction

/datum/antagonist/faction/greet()
	if(my_faction.current_objectives.faction_objectives[src.type] || my_faction.additional_objective)
		to_chat(usr, "<span class='notice'><b>[faction_name] Objectives:</b></span>")
		if(my_faction.current_objectives.faction_objectives[src.type])
			to_chat(usr, "<span class='notice'>Main Objective: [my_faction.current_objectives.faction_objectives[src.type]]</span>")
		if(my_faction.additional_objective)
			to_chat(usr, "<span class='notice'>[my_faction.current_objectives.faction_objectives[src.type] ? "Additional " : ""]Objective: [my_faction.additional_objective]</span>")

/datum/team/faction
	/// The abbreviation of this family.
	var/faction_id = "IDK"
	/// The specific, occupied family member antagonist datum that is used to reach the handler / check objectives, and from which the above properties (sans points) are inherited.
	var/datum/antagonist/faction/faction_datum
	/// The current faction objectives.
	var/datum/faction_objectives/current_objectives
	/// Additional objective added by players
	var/additional_objective

/datum/team/faction/roundend_report()
	var/list/report = list()
	report += "<span class='header'>[name]:</span>"
	if(current_objectives.everyone_objective)
		report += "Objective: [current_objectives.everyone_objective]"
	else
		var/assigned_objective = current_objectives.faction_objectives[faction_datum.type]
		if(assigned_objective || additional_objective)
			if(assigned_objective)
				report += "Main Objective: [assigned_objective]"
			if(additional_objective)
				report += "[assigned_objective ? "Additional " : ""]Objective: [additional_objective]"

		else
			report += "This faction had no objectives to complete." // factions can be set no objectives

	return "<div class='panel redborder'>[report.Join("<br>")]</div>"

/datum/team/faction/proc/set_additional_objective(var/new_objective)
	additional_objective = new_objective
	for(var/datum/mind/faction_member in members)
		to_chat(faction_member, "<span class='notice'>A new objective has been assigned: [additional_objective]</span>")

// here are the actual factions

/datum/team/faction/legion
	faction_id = "LEG"

/datum/antagonist/faction/legion
	show_in_antagpanel = TRUE
	name = "Legionary"
	roundend_category = "The Boreal Legion"
	faction_name = "The Boreal Legion"
	faction_id = "LEG"
	faction_team_type = /datum/team/faction/legion

/datum/team/faction/ncr
	faction_id = "NCR"

/datum/antagonist/faction/ncr
	show_in_antagpanel = TRUE
	name = "PRNC Soldier"
	roundend_category = "The People's Republic of New California"
	faction_name = "The Californian People's Liberation Force"
	faction_id = "NCR"
	faction_team_type = /datum/team/faction/ncr

/datum/team/faction/bos
	faction_id = "BOS"

/datum/antagonist/faction/bos
	show_in_antagpanel = TRUE
	name = "Brotherhood of Steel Cultist"
	roundend_category = "The Brotherhood of Steel"
	faction_name = "Brotherhood of Steel"
	faction_id = "BOS"
	faction_team_type = /datum/team/faction/bos

// undecided on these
/datum/team/faction/tribal
	faction_id = "TRIB"

/datum/antagonist/faction/tribal
	show_in_antagpanel = TRUE
	name = "Tribal"
	roundend_category = "The tribals"
	faction_name = "Tribals"
	faction_id = "TRIB"
	faction_team_type = /datum/team/faction/tribal

/datum/team/faction/bighorn
	faction_id = "TOWN"

/datum/antagonist/faction/bighorn
	show_in_antagpanel = TRUE
	name = "Bighorn Citizen"
	roundend_category = "Bighorn"
	faction_name = "Bighorn"
	faction_id = "TOWN"
	faction_team_type = /datum/team/faction/bighorn

