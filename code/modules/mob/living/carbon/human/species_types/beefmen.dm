// GLOBAL_LIST_INIT(color_list_beefman, list("Very Rare" = "c62461", "Rare" = "c91745", "Medium Rare" = "e73f4e", "Medium" = "fd7f8b", "Medium Well" = "e7a5ab", "Well Done" = "b9a6a8" ))

// TO DO:
//
// Death Sound
//

/datum/species/beefman
	name = "Beefman"
	id = "beefman"
	say_mod = "gurgles"
	sexes = FALSE
	default_color = "e73f4e"
	species_traits = list( NOEYESPRITES, NO_UNDERWEAR, DYNCOLORS, AGENDER, EYECOLOR) // EYECOLOR
	mutant_bodyparts = list("beefmouth", "beefeyes")
	inherent_traits = list(TRAIT_RESISTCOLD, TRAIT_EASYDISMEMBER, TRAIT_COLDBLOODED, TRAIT_SLEEPIMMUNE ) // , TRAIT_LIMBATTACHMENT)
	default_features = list("beefcolor" = "e73f4e","beefmouth" = "Smile 1", "beefeyes" = "Olives")
	offset_features = list(OFFSET_UNIFORM = list(0,2), OFFSET_ID = list(0,2), OFFSET_GLOVES = list(0,-4), OFFSET_GLASSES = list(0,3), OFFSET_EARS = list(0,3), OFFSET_SHOES = list(0,0), \
						   OFFSET_S_STORE = list(0,2), OFFSET_FACEMASK = list(0,3), OFFSET_HEAD = list(0,3), OFFSET_FACE = list(0,3), OFFSET_BELT = list(0,3), OFFSET_BACK = list(0,2), \
						   OFFSET_SUIT = list(0,2), OFFSET_NECK = list(0,3))

	skinned_type = /obj/item/reagent_containers/food/snacks/faggot // NO SKIN //  /obj/item/stack/sheet/animalhide/human
	meat = /obj/item/reagent_containers/food/snacks/meat/slab //What the species drops on gibbing
	toxic_food = DAIRY | PINEAPPLE //NONE
	disliked_food = VEGETABLES | FRUIT // | FRIED// GROSS | RAW
	liked_food = RAW | MEAT // JUNKFOOD | FRIED
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	attack_verb = "meat"
	speedmod = -0.2	// this affects the race's speed. positive numbers make it move slower, negative numbers make it move faster
	armor = -2		// overall defense for the race... or less defense, if it's negative.
	punchdamagelow = 1       //lowest possible punch damage. if this is set to 0, punches will always miss
	punchdamagehigh = 5 // 10      //highest possible punch damage
	inert_mutation = MUTATE // in DNA.dm
	deathsound = 'sound/Fulpsounds/beef_die.ogg'
	attack_sound = 'sound/Fulpsounds/beef_hit.ogg'
	special_step_sounds = list('sound/Fulpsounds/footstep_splat1.ogg','sound/Fulpsounds/footstep_splat2.ogg','sound/Fulpsounds/footstep_splat3.ogg','sound/Fulpsounds/footstep_splat4.ogg')//Sounds to override barefeet walkng
	grab_sound = 'sound/Fulpsounds/beef_grab.ogg'//Special sound for grabbing

	var/dehydrate = 0
	var/list/datum/brain_trauma/startTraumas = list( /datum/brain_trauma/mild/hallucinations, /datum/brain_trauma/mild/phobia/strangers )
	    // list( /datum/brain_trauma/mild/phobia/strangers, /datum/brain_trauma/mild/phobia/doctors, /datum/brain_trauma/mild/phobia/authority )



/proc/proof_beefman_features(var/list/inFeatures)
	// Missing Defaults in DNA? Randomize!
	if (inFeatures["beefcolor"] == null || inFeatures["beefcolor"] == "")
		inFeatures["beefcolor"] = GLOB.color_list_beefman[pick(GLOB.color_list_beefman)]
	if (inFeatures["beefeyes"] == null || inFeatures["beefeyes"] == "")
		inFeatures["beefeyes"] = pick(GLOB.eyes_beefman)
	if (inFeatures["beefmouth"] == null || inFeatures["beefmouth"] == "")
		inFeatures["beefmouth"] = pick(GLOB.mouths_beefman)

/datum/species/beefman/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)


	// Missing Defaults in DNA? Randomize!
	proof_beefman_features(C.dna.features)

	.=..()

	if(ishuman(C)) // Taken DIRECTLY from ethereal!
		var/mob/living/carbon/human/H = C

		// 1) COLOR: Default to Medium Rare
		//if (H.dna.features["beefcolor"] == null || H.dna.features["beefcolor"] == "")
		//	fixed_mut_color =  GLOB.color_list_beefman["Medium Rare"]
		//else
		fixed_mut_color = H.dna.features["beefcolor"]
		default_color = fixed_mut_color // "#" +

		// 2) BODYPARTS
		C.part_default_head = /obj/item/bodypart/head/beef
		C.part_default_chest = /obj/item/bodypart/chest/beef
		C.part_default_l_arm = /obj/item/bodypart/l_arm/beef
		C.part_default_r_arm = /obj/item/bodypart/r_arm/beef
		C.part_default_l_leg = /obj/item/bodypart/l_leg/beef
		C.part_default_r_leg = /obj/item/bodypart/r_leg/beef
		C.ReassignForeignBodyparts()


	// Speak Russian
	C.grant_language(/datum/language/russian) // Don't remove on loss. You simply know it.
	C.selected_default_language = /datum/language/russian

	// Be Spooked but Educated
	C.gain_trauma(pick(startTraumas))
	C.gain_trauma(/datum/brain_trauma/special/bluespace_prophet/phobetor)
	// NOTE: To remove, use cure_trauma_type()


/mob/living/carbon/proc/ReassignForeignBodyparts()
	if (get_bodypart(BODY_ZONE_HEAD)?.type != part_default_head)  // <----- I think :? is used for procs instead of .? ...but apparently BYOND does that swap for you. //(!istype(get_bodypart(BODY_ZONE_HEAD), part_default_head))
		qdel(get_bodypart(BODY_ZONE_HEAD))
		new part_default_head().replace_limb(src,TRUE)
	if (get_bodypart(BODY_ZONE_CHEST)?.type != part_default_chest)
		qdel(get_bodypart(BODY_ZONE_CHEST))
		new part_default_chest().replace_limb(src,TRUE)
	if (get_bodypart(BODY_ZONE_L_ARM)?.type != part_default_l_arm)
		qdel(get_bodypart(BODY_ZONE_L_ARM))
		new part_default_l_arm().replace_limb(src,TRUE)
	if (get_bodypart(BODY_ZONE_R_ARM)?.type != part_default_r_arm)
		qdel(get_bodypart(BODY_ZONE_R_ARM))
		new part_default_r_arm().replace_limb(src,TRUE)
	if (get_bodypart(BODY_ZONE_L_LEG)?.type != part_default_l_leg)
		qdel(get_bodypart(BODY_ZONE_L_LEG))
		new part_default_l_leg().replace_limb(src,TRUE)
	if (get_bodypart(BODY_ZONE_R_LEG)?.type != part_default_r_leg)
		qdel(get_bodypart(BODY_ZONE_R_LEG))
		new part_default_r_leg().replace_limb(src,TRUE)

/datum/species/beefman/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	..()

	// 2) BODYPARTS
	C.part_default_head = /obj/item/bodypart/head
	C.part_default_chest = /obj/item/bodypart/chest
	C.part_default_l_arm = /obj/item/bodypart/l_arm
	C.part_default_r_arm = /obj/item/bodypart/r_arm
	C.part_default_l_leg = /obj/item/bodypart/l_leg
	C.part_default_r_leg = /obj/item/bodypart/r_leg
	C.ReassignForeignBodyparts()

	C.cure_trauma_type(/datum/brain_trauma/special/bluespace_prophet/phobetor)





/datum/species/beefman/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_beefman_name(gender)
	return capitalize(beefman_name(gender))


/datum/species/beefman/spec_life(mob/living/carbon/human/H)	// This is your life ticker.
	..()
	// 		** BLEED YOUR JUICES **         // BODYTEMP_NORMAL = 310.15    // AC set to 293

	// Step 1) Being burned keeps the juices in.
	var/searJuices = H.getFireLoss_nonProsthetic() / 10

	// Step 2) Bleed out those juices by warmth, minus burn damage.
	H.bleed_rate = CLAMP((H.bodytemperature - 285) / 20 - searJuices, 0, 5) // Every 20 points above 285 increases bleed rate. Don't worry, you're cold blooded.

	// Step 3) If we're salted, we'll bleed more (it gets reset next tick)
	if (dehydrate > 0)
		H.bleed_rate += 2
		dehydrate -= 0.5

	// Replenish Blood Faster!
	if (dehydrate <= 0 && H.bleed_rate <= 0 && H.blood_volume < BLOOD_VOLUME_NORMAL)
		H.blood_volume += 2

// TO-DO // Drop lots of meat on gib?
/datum/species/beefman/spec_death(gibbed, mob/living/carbon/human/H)
	return ..()

/datum/species/beefman/before_equip_job(datum/job/J, mob/living/carbon/human/H)

	// Pre-Equip: Give us a sash so we don't end up with a Uniform!

	var/obj/item/clothing/under/bodysash/newSash
	switch(J.title)
		// Assistant
		if("Assistant")
			newSash = new /obj/item/clothing/under/bodysash()
		// Security
		if("Security Officer", "Warden", "Detective", "Head of Security")
			newSash = new /obj/item/clothing/under/bodysash/security()
		// Medical
		if("Medical Doctor", "Chemist", "Geneticist", "Virologist", "Chief Medical Officer")
			newSash = new /obj/item/clothing/under/bodysash/medical()
		// Science
		if("Scientist", "Roboticist", "Research Director")
			newSash = new /obj/item/clothing/under/bodysash/science()
		// Cargo
		if("Cargo Technician", "Quartermaster", "Shaft Miner")
			newSash = new /obj/item/clothing/under/bodysash/cargo()
		// Engineer
		if("Station Engineer", "Atmospheric Technician", "Chief Engineer")
			newSash = new /obj/item/clothing/under/bodysash/engineer()
		// Command
		if("Captain", "Head of Personnel")
			newSash = new /obj/item/clothing/under/bodysash/command()
		// Clown
		if("Clown")
			newSash = new /obj/item/clothing/under/bodysash/clown()
		// Mime
		if("Mime")
			newSash = new /obj/item/clothing/under/bodysash/mime()
		// Civilian
		else
			newSash = new /obj/item/clothing/under/bodysash/civilian()

	H.equip_to_slot_or_del(newSash, SLOT_W_UNIFORM) // equip_to_slot_or_del

	return ..()

/datum/species/beefman/after_equip_job(datum/job/J, mob/living/carbon/human/H)
	..() //  H.update_mutant_bodyparts()   <--- SWAIN NOTE base does that only

	// DO NOT DO THESE DURING GAIN/LOSS (we only want to assign them once on round start)

	// 		JOB GEAR

	// Remove coat! We don't wear that as a Beefboi
	if (H.wear_suit)
		qdel(H.wear_suit)



/datum/species/beefman/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	. = ..() // Let species run its thing by default, TRUST ME
	// Salt HURTS
	if(chem.type == /datum/reagent/saltpetre || chem.type == /datum/reagent/consumable/sodiumchloride)
		H.adjustToxLoss(0.5, 0) // adjustFireLoss
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		if (prob(5) || dehydrate == 0)
			to_chat(H, "<span class='alert'>Your beefy mouth tastes dry.<span>")
		dehydrate ++
		return TRUE
	// Regain BLOOD
	else if(istype(chem, /datum/reagent/consumable/nutriment) || istype(chem, /datum/reagent/iron))
		if (H.blood_volume < BLOOD_VOLUME_NORMAL)
			H.blood_volume += 2
			H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
			return TRUE

// TO-DO // Weak to salt etc!
/datum/species/beefman/check_species_weakness(obj/item, mob/living/attacker)
	return ..() // 0  //This is not a boolean, it's the multiplier for the damage that the user takes from the item.It is added onto the check_weakness value of the mob, and then the force of the item is multiplied by this value



////////
//LIFE//
////////

/datum/species/beefman/handle_digestion(mob/living/carbon/human/H)
	..()

// TO-DO // Do funny stuff with Radiation
/datum/species/beefman/handle_mutations_and_radiation(mob/living/carbon/human/H)
	. = ..()



//////////////////
// ATTACK PROCS //
//////////////////

/datum/species/beefman/help(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	// Bleed On
	if (user != target && user.bleed_rate)
		target.add_mob_blood(user)
	return ..()

/datum/species/beefman/grab(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	// Bleed On
	if (user != target && user.bleed_rate)
		target.add_mob_blood(user) //  from atoms.dm, this is how you bloody something!
	return ..()

/datum/species/beefman/disarm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	// Targeting Self? With "DISARM"
	if (user == target)
		var/target_zone = user.zone_selected
		var/list/allowedList = list ( BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG )
		var/obj/item/bodypart/affecting = user.get_bodypart(check_zone(user.zone_selected)) //stabbing yourself always hits the right target

		if ((target_zone in allowedList) && affecting)

			user.visible_message("[user] grabs onto [p_their()] own [affecting.name] and pulls.", \
					 	 "<span class='notice'>You grab hold of your [affecting.name] and yank hard.</span>")
			if (!do_mob(user,target))
				return FALSE

			user.visible_message("[user]'s [affecting.name] comes right off in their hand.", "<span class='notice'>Your [affecting.name] pops right off.</span>")
			playsound(get_turf(user), 'sound/Fulpsounds/beef_hit.ogg', 40, 1)

			// Destroy Limb, Drop Meat, Pick Up
			var/obj/item/I = affecting.drop_limb() //  <--- This will return a meat vis drop_meat(), even if only Beefman limbs return anything.
			if (I)
				user.put_in_hands(I)

			return FALSE
	return ..()

/datum/species/beefman/spec_unarmedattacked(mob/living/carbon/human/user, mob/living/carbon/human/target)
	// Bleed On
	if (user != target && user.bleed_rate)
		target.add_mob_blood(user) //  from atoms.dm, this is how you bloody something!
	return ..()


/datum/species/beefman/spec_attacked_by(obj/item/I, mob/living/user, obj/item/bodypart/affecting, intent, mob/living/carbon/human/H)

	// MEAT LIMBS: If our limb is missing, and we're using meat, stick it in!
	if (!affecting && intent == INTENT_DISARM && istype(I, /obj/item/reagent_containers/food/snacks/meat/slab))// /obj/item/bodypart))
		var/target_zone = user.zone_selected
		var/list/allowedList = list ( BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG )

		if ((target_zone in allowedList))
			if (user == H)
				user.visible_message("[user] begins mashing [I] into [H]'s torso.", \
						 	 "<span class='notice'>You begin mashing [I] into your torso.</span>")
			else
				user.visible_message("[user] begins mashing [I] into [H]'s torso.", \
						 	 "<span class='notice'>You begin mashing [I] into [H]'s torso.</span>")
			if (!do_mob(user,H))
				return FALSE
			// Attach the part!
			var/obj/item/bodypart/newBP = H.newBodyPart(target_zone, FALSE)
			newBP.attach_limb(H)
			newBP.give_meat(H, I)
			H.visible_message("The meat sprouts digits and becomes [H]'s new [newBP.name]!", "<span class='notice'>The meat sprouts digits and becomes your new [newBP.name]!</span>")
			playsound(get_turf(H), 'sound/Fulpsounds/beef_grab.ogg', 50, 1)

			return FALSE

	return ..() // TRUE FALSE

			//// OUTSIDE PROCS ////

// taken from _HELPERS/mobs.dm
/proc/random_unique_beefman_name(gender, attempts_to_find_unique_name=10)
	for(var/i in 1 to attempts_to_find_unique_name)
		. = capitalize(beefman_name(gender))

		if(!findname(.))
			break

// taken from _HELPERS/names.dm
/proc/beefman_name(gender)
	return "[pick(GLOB.experiment_names)] \Roman[rand(1,49)]: '[pick(GLOB.russian_names)]'"
























			// INTEGRATION //

/mob/living/carbon/human/species/beefman
	race = /datum/species/beefman

/obj/item/bodypart/
	var/icon/icon_greyscale = 'icons/mob/human_parts_greyscale.dmi'
	var/obj/item/reagent_containers/food/snacks/meat/slab/myMeatType = /obj/item/reagent_containers/food/snacks/meat/slab // For remembering what kind of meat this was made of. Default is base meat slab.
	var/amCondemned = FALSE // I'm about to be destroyed. Don't add blood to me, and throw null error crap next tick.
/obj/item/bodypart/add_mob_blood(mob/living/M) // Cancel adding blood if I'm deleting.
	if (!amCondemned)
		..()

/mob/living/carbon
	// Type References for Bodyparts
	var/obj/item/bodypart/head/part_default_head = /obj/item/bodypart/head
	var/obj/item/bodypart/chest/part_default_chest = /obj/item/bodypart/chest
	var/obj/item/bodypart/l_arm/part_default_l_arm = /obj/item/bodypart/l_arm
	var/obj/item/bodypart/r_arm/part_default_r_arm = /obj/item/bodypart/r_arm
	var/obj/item/bodypart/l_leg/part_default_l_leg = /obj/item/bodypart/l_leg
	var/obj/item/bodypart/r_leg/part_default_r_leg = /obj/item/bodypart/r_leg


		// MEAT-TO-LIMB
		// 1) Save Meat's type
		// 2) Get all original Reagent TYPES from "list_reagents" on the meat itself - these reagents (TYPEPATHS) have the starter values. Save those values.
		// 3) Sort through thisMeat.reagents.reagent_list, which has ALL CURRENT reagents (ACTUAL DATUMS) inside the meat. Add up all those values.
		// 3) Percent = Compare the STARTER VALUES in list_reagents against the CURRENT VALUES in thisMeat.reagents.reagent_list/
		// 4) Inject ALL OTHER CHEMS into bloodstream

		// LIMB-TO-MEAT
		// 1) Create new meat
		// 2) Sort through all reagent datums in newMeat.list_reagents and adjust each version in newMeat.reagents.reagent_list/(REAGENT)/.volume
		// 3) Apply a small part of my body's metabolic reagents to the meat. Check how Feed does this.

// Meat has been assigned to this NEW limb! Give it meat and damage me as needed.
/obj/item/bodypart/proc/give_meat(mob/living/carbon/human/H, obj/item/reagent_containers/food/snacks/meat/slab/inMeatObj)
	// Assign Type
	myMeatType = inMeatObj.type

		// Adjust Health (did you eat some of this?)

	// Get Original Amount
	var/amountOriginal
	for (var/R in inMeatObj.list_reagents) // <---- List of TYPES and the starting AMOUNTS
		amountOriginal += inMeatObj.list_reagents[R]
	// Get Current Amount (of original reagents only)
	var/amountCurrent
	for (var/datum/reagent/R in inMeatObj.reagents.reagent_list) // <---- Actual REAGENT DATUMS and their VOLUMES
		// This datum exists in the original list?
		if (locate(R.type) in inMeatObj.list_reagents)
			amountCurrent += R.volume
			// Remove it from Meat (all others are about to be injected)
			inMeatObj.reagents.remove_reagent(R.type, R.volume)
	inMeatObj.reagents.update_total()
	// Set Health:
	var/percentHealth = 1 - amountCurrent / amountOriginal
	receive_damage(brute = max_damage * percentHealth)

	// Apply meat's Reagents to Me
	if(inMeatObj.reagents && inMeatObj.reagents.total_volume)
		inMeatObj.reagents.reaction(owner, INJECT, inMeatObj.reagents.total_volume) // Run Reaction: what happens when what they have mixes with what I have?
		inMeatObj.reagents.trans_to(owner, inMeatObj.reagents.total_volume)	// Run transfer of 1 unit of reagent from them to me.

	qdel(inMeatObj)


/obj/item/bodypart/proc/drop_meat(mob/inOwner)
	// If owner is NOT inside of something (cloner)
	if (myMeatType != null)
		var/obj/item/reagent_containers/food/snacks/meat/slab/newMeat =	new myMeatType(src.loc)///obj/item/reagent_containers/food/snacks/meat/slab(src.loc)

			// Adjust Reagents by Health Percent

		var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
		for (var/datum/reagent/R in newMeat.reagents.reagent_list)
			R.volume *= percentHealth
		newMeat.reagents.update_total()

		// Apply my Reagents to Meat
		if(inOwner.reagents && inOwner.reagents.total_volume)
			inOwner.reagents.reaction(newMeat, INJECT, 20 / inOwner.reagents.total_volume) // Run Reaction: what happens when what they have mixes with what I have?
			inOwner.reagents.trans_to(newMeat, 20)	// Run transfer of 1 unit of reagent from them to me.

		. = newMeat // Return MEAT

	qdel(src)

/obj/item/bodypart/head/beef
	icon = 'icons/Fulpicons/fulp_bodyparts.dmi'
	icon_greyscale = 'icons/Fulpicons/fulp_bodyparts.dmi'

/obj/item/bodypart/chest/beef
	icon = 'icons/Fulpicons/fulp_bodyparts.dmi'
	icon_greyscale = 'icons/Fulpicons/fulp_bodyparts.dmi'

/obj/item/bodypart/r_arm/beef
	icon = 'icons/Fulpicons/fulp_bodyparts.dmi'
	icon_greyscale = 'icons/Fulpicons/fulp_bodyparts.dmi'
	//aux_layer = HANDS_LAYER // Default in bodyparts.dm is HANDS_PART_LAYER. We want hands to just...appear on top
/obj/item/bodypart/r_arm/beef/drop_limb(special) // from dismemberment.dm
	amCondemned = TRUE
	var/mob/owner_cache = owner
	..() // Create Meat, Remove Limb
	return drop_meat(owner_cache)

/obj/item/bodypart/l_arm/beef
	icon = 'icons/Fulpicons/fulp_bodyparts.dmi'
	icon_greyscale = 'icons/Fulpicons/fulp_bodyparts.dmi'
	//aux_layer = HANDS_LAYER // Default in bodyparts.dm is HANDS_PART_LAYER. We want hands to just...appear on top
/obj/item/bodypart/l_arm/beef/drop_limb(special) // from dismemberment.dm
	amCondemned = TRUE
	var/mob/owner_cache = owner
	..() // Create Meat, Remove Limb
	return drop_meat(owner_cache)

/obj/item/bodypart/r_leg/beef
	icon = 'icons/Fulpicons/fulp_bodyparts.dmi'
	icon_greyscale = 'icons/Fulpicons/fulp_bodyparts.dmi'
/obj/item/bodypart/r_leg/beef/drop_limb(special) // from dismemberment.dm
	amCondemned = TRUE
	var/mob/owner_cache = owner
	..() // Create Meat, Remove Limb
	return drop_meat(owner_cache)

/obj/item/bodypart/l_leg/beef
	icon = 'icons/Fulpicons/fulp_bodyparts.dmi'
	icon_greyscale = 'icons/Fulpicons/fulp_bodyparts.dmi'
/obj/item/bodypart/l_leg/beef/drop_limb(special) // from dismemberment.dm
	amCondemned = TRUE
	var/mob/owner_cache = owner
	..() // Create Meat, Remove Limb
	return drop_meat(owner_cache)


















// SPRITE PARTS //

//GLOBAL_LIST_INIT(eyes_beefman, list( "Peppercorns", "Capers", "Olives" ))
//GLOBAL_LIST_INIT(mouths_beefman, list( "Smile1", "Smile2", "Frown1", "Frown2", "Grit1", "Grit2" ))
/datum/sprite_accessory/beef/
	icon = 'icons/Fulpicons/fulp_bodyparts.dmi'

	// please make sure they're sorted alphabetically and, where needed, categorized
	// try to capitalize the names please~
	// try to spell
	// you do not need to define _s or _l sub-states, game automatically does this for you

/datum/sprite_accessory/beef/eyes
	color_src = EYECOLOR	//Currently only used by mutantparts so don't worry about hair and stuff. This is the source that this accessory will get its color from. Default is MUTCOLOR, but can also be HAIR, FACEHAIR, EYECOLOR and 0 if none.
/datum/sprite_accessory/beef/eyes/peppercorns
	name = "Peppercorns"
	icon_state = "peppercorns"
/datum/sprite_accessory/beef/eyes/olives
	name = "Olives"
	icon_state = "olives"
/datum/sprite_accessory/beef/eyes/capers
	name = "Capers"
	icon_state = "capers"
/datum/sprite_accessory/beef/eyes/cloves
	name = "Cloves"
	icon_state = "cloves"

/datum/sprite_accessory/beef/mouth
	use_static = TRUE
	color_src = 0
/datum/sprite_accessory/beef/mouth/smile1
	name = "Smile 1"
	icon_state = "smile1"
/datum/sprite_accessory/beef/mouth/smile2
	name = "Smile 2"
	icon_state = "smile2"
/datum/sprite_accessory/beef/mouth/frown1
	name = "Frown 1"
	icon_state = "frown1"
/datum/sprite_accessory/beef/mouth/frown2
	name = "Frown 2"
	icon_state = "frown2"
/datum/sprite_accessory/beef/mouth/grit1
	name = "Grit 1"
	icon_state = "grit1"
/datum/sprite_accessory/beef/mouth/grit2
	name = "Grit 2"
	icon_state = "grit2"



/// found in cargo.dm etc. in modules/clothing/under/job

/obj/item/clothing/under/bodysash/
	name = "body sash"
	desc = "A simple body sash, slung from shoulder to hip."
	icon = 'icons/Fulpicons/fulpclothing.dmi'
	icon_state = "assistant" // Inventory Icon
	item_color = "assistant" // The worn item Icon
	item_state = "sash" // In-hand Icon
	worn_icon = 'icons/Fulpicons/fulpclothing_worn.dmi'
	body_parts_covered = CHEST // |GROIN|ARMS
	lefthand_file = 'icons/Fulpicons/fulpclothing_hold_left.dmi'
	righthand_file = 'icons/Fulpicons/fulpclothing_hold_right.dmi'

/obj/item/clothing/under/bodysash/security
	name = "security sash"
	icon_state = "security"
	item_color = "security" // The worn item state
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small
/obj/item/clothing/under/bodysash/medical
	name = "medical sash"
	icon_state = "medical"
	item_color = "medical" // The worn item state
/obj/item/clothing/under/bodysash/science
	name = "science sash"
	icon_state = "science"
	item_color = "science" // The worn item state
/obj/item/clothing/under/bodysash/cargo
	name = "cargo sash"
	icon_state = "cargo"
	item_color = "cargo" // The worn item state
/obj/item/clothing/under/bodysash/engineer
	name = "engineer sash"
	icon_state = "engineer"
	item_color = "engineer" // The worn item state
/obj/item/clothing/under/bodysash/civilian
	name = "civilian sash"
	icon_state = "civilian"
	item_color = "civilian" // The worn item state
/obj/item/clothing/under/bodysash/command
	name = "command sash"
	icon_state = "command"
	item_color = "command" // The worn item state
/obj/item/clothing/under/bodysash/clown
	name = "clown sash"
	icon_state = "clown"
	item_color = "clown" // The worn item state
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small
/obj/item/clothing/under/bodysash/mime
	name = "mime sash"
	icon_state = "mime"
	item_color = "mime" // The worn item state




////////////	CUSTOM TRAUMAS



/datum/brain_trauma/special/bluespace_prophet/phobetor
	name = "Sleepless Dreamer"
	desc = "The patient, after undergoing untold psychological hardship, believes they can travel between the dreamscapes of this dimension."
	scan_desc = "awoken sleeper"
	gain_text = "<span class='notice'>Your mind snaps, and you wake up. You <i>really</i> wake up.</span>"
	lose_text = "<span class='warning'>You succumb once more to the sleepless dream of the unwoken.</span>"

/datum/brain_trauma/special/bluespace_prophet/phobetor/on_life()
	if(world.time > next_portal)
		next_portal = world.time + 100

		// Round One: Pick a Nearby Turf
		var/list/turf/possible_turfs = return_valid_floor_in_range(owner, 6, 0, TRUE) // Source, Range, Has Floor
		if(!LAZYLEN(possible_turfs))
			return
		// First Pick:
		var/turf/first_turf = pick(possible_turfs)
		if(!first_turf)
			return

		// Round Two: Pick an even Further Turf
		possible_turfs = return_valid_floor_in_range(first_turf, 20, 6, TRUE) // Source, Range, Has Floor
		possible_turfs -= first_turf
		if(!LAZYLEN(possible_turfs))
			return
		// Second Pick:
		var/turf/second_turf = pick(possible_turfs)
		if(!second_turf)
			return

		var/obj/effect/hallucination/simple/bluespace_stream/phobetor/first = new (first_turf, owner)
		var/obj/effect/hallucination/simple/bluespace_stream/phobetor/second = new (second_turf, owner)

		first.linked_to = second
		second.linked_to = first
		first.seer = owner
		second.seer = owner


/obj/effect/hallucination/simple/bluespace_stream
	use_without_hands = TRUE // A Swain addition.

/obj/effect/hallucination/simple/bluespace_stream/phobetor
	name = "phobetor tear"
	desc = "A subdimensional rip in reality, which gives extra-spacial passage to those who have woken from the sleepless dream."
	/*light_color = "#FF88AA"
	light_range = 2
	light_power = 2*/
	image_icon = 'icons/Fulpicons/fulp_effects.dmi'
	image_state = "phobetor_tear"
	image_layer = ABOVE_LIGHTING_LAYER // Place this above shadows so it always glows.
	exist_length = 500

/obj/effect/hallucination/simple/bluespace_stream/phobetor/attack_hand(mob/user)
	if(user != seer || !linked_to)
		return
	if (user.loc != src.loc)
		to_chat(user, "Step into the Tear before using it.")
		return
	// Is this, or linked, stream being watched?
	if (check_location_seen(user, get_turf(user)))
		to_chat(user, "<span class='warning'>Not while you're being watched.</span>")
		return
	if (check_location_seen(user, get_turf(linked_to)))
		to_chat(user, "<span class='warning'>Your destination is being watched.</span>")
		return
	to_chat(user, "<span class='notice'>You slip unseen through the Phobetor Tear.</span>")
	user.playsound_local(null, 'sound/magic/wand_teleport.ogg', 30, FALSE, pressure_affected = FALSE)

	//new /obj/effect/temp_visual/bluespace_fissure(get_turf(src))
	//new /obj/effect/temp_visual/bluespace_fissure(get_turf(linked_to))
	user.forceMove(get_turf(linked_to))




