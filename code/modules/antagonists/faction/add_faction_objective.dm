/mob/living/proc/add_legion_objective()
	set name = "Add Legion Objective"
	set category = "IC"
	add_faction_objective(/datum/antagonist/faction/legion, list("Legion Legate", "Legion Centurion", "Legion Veteran Decanus"))

/mob/living/proc/add_ncr_objective()
	set name = "Add NCR Objective"
	set category = "IC"
	add_faction_objective(/datum/antagonist/faction/ncr, list("NCR Lieutenant","NCR Sergeant First Class","NCR Captain", "NCR Colonel"))


/mob/living/proc/add_faction_objective(antag_datum_type, list/whitelisted_jobs)
	if(islist(mind.antag_datums))
		var/datum/antagonist/faction/antag_datum = locate(antag_datum_type) in mind.antag_datums

		// check to make sure the verb is being used by the right people
		if(!mind)
			return
		if(!antag_datum)
			to_chat(usr, "<span class='warning'>You aren't in a faction! You shouldn't have this verb, send a bug report!</span>")
			return
		var/whitelisted_job = FALSE
		for(var/job_indx in whitelisted_jobs)
			if(job == job_indx)
				whitelisted_job = TRUE
				break
		if(!whitelisted_job)
			to_chat(usr, "<span class='warning'>You aren't a commander of your faction!</span>")
			return

		// confirm objective overwrite
		if(antag_datum.my_faction.additional_objective)
			var/confirm = input("Making a new objective will overwrite the previously made additional objective. Are you \
			sure you wish to continue?", "New Faction Objective") in list("Yes", "No")
			if(confirm == "No")
				return

		// now make the new objective
		var/new_objectives = input(usr, "Write a short summary of what you want \
		as a additional objective for your faction. Make sure it doesn't contradict your faction's already \
		existing objective if it exists!.", "New Faction Objective") as null|message
		new_objectives = sanitize(new_objectives)
		if(isnull(new_objectives))
			return
		to_chat(usr, "<span class='notice'>You've submitted a request for a new objective for [antag_datum.faction_name]. You'll be told whether it has been approved or denied soon.</span>")
		message_admins("[ADMIN_LOOKUPFLW(usr)] wishes to set a new objective for [antag_datum.faction_name]. '[new_objectives]' \
		<br>[ADMIN_APPROVEOBJECTIVE(src, new_objectives, antag_datum)] or [ADMIN_DENYOBJECTIVE(src, antag_datum)]?")
	else
		return
