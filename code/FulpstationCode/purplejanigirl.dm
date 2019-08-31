// The living legend finally comes to Fulpstation in actual code. Currently exists as a outfit for Admins to equip people with along with mop water. Water polluted by dirt, vomit, and blood.
// PURPLE JANIGIRL CLOTHING
/datum/outfit/purplejanigirl // [FULP] [PNX] [BLU]
	name = "Purple Janigirl"

	head = /obj/item/clothing/head/soft/purple
	mask = /obj/item/clothing/mask/breath/janigirl
	neck = /obj/item/clothing/neck/scarf/purple
	gloves = /obj/item/clothing/gloves/color/janigirl
	belt = /obj/item/pda/janitor
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/janitor/skirt
	shoes = /obj/item/clothing/shoes/galoshes/dry/janigirl
	back = /obj/item/storage/backpack/janigirl
	backpack_contents = list(/obj/item/reagent_containers/glass/bottle/water/janigirl=3)

/obj/item/clothing/mask/breath/janigirl
	name = "janigirl breath mask"
	color = "#da00ff"

/obj/item/clothing/gloves/color/janigirl
	desc = "These gloves will protect the wearer from electric shock."
	name = "janigirl gloves"
	icon_state = "black"
	item_state = "blackgloves"
	item_color="black"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	resistance_flags = NONE
	color = "#da00ff"

/obj/item/storage/backpack/janigirl
	name = "janigirl backpack"
	desc = "You wear this on your back and put items into it."
	color = "#da00ff"

/obj/item/clothing/shoes/galoshes/dry/janigirl
	name = "janigirl galoshes"
	desc = "A pair of purple rubber boots, designed to prevent slipping on wet surfaces while also drying them."
	color = "#da00ff"

// JANIGIRL MOP WATER
/obj/item/reagent_containers/glass/bottle/water/janigirl
	name = "bottle of Janigirl mop water"
	desc = "This bottle contains a sizable amount of Janigirl mop water, acquired from Purple Janigirl herself. Contents may contain biohazardous materials."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "smallbottle"
	item_state = "bottle"
	list_reagents = list(/datum/reagent/toxin/spewium = 10, /datum/reagent/water/mop = 20)
	//list_reagents = list(/datum/reagent/toxin/minttoxin = 3, /datum/reagent/toxin/bad_food = 5, /datum/reagent/toxin/fentanyl = 2, /datum/reagent/toxin/spewium = 10, /datum/reagent/water = 30)
	spawned_disease = /datum/disease/advance/random
	materials = list(/datum/material/glass=0)
	volume = 50
	amount_per_transfer_from_this = 10
/datum/reagent/water/mop
	taste_description = "dirty water"

 // SYNDIEGIRL MOP WATER
 // To be completed. WIll appear in the Syndie-Bundle B kit for Purple Janigirl. The spray acts as a somewhat powerful burning toxin.
