
/**********************Talos 13 Moon**************************/

//Floors/Platings//

/turf/open/floor/plating/asteroid/moon
	name = "moon sand"
	baseturfs = /turf/open/floor/plating/asteroid/moon
	icon = 'icons/turf/talos-moon.dmi'
	var/smooth_icon = 'icons/turf/talos-moonrock1.dmi'
	var/icon_craters = 'icons/turf/talos-craters.dmi'
	icon_state = "moonrock"
	base_icon_state = "moonrock"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	smoothing_groups = list(SMOOTH_GROUP_MOON)
	canSmoothWith = list(SMOOTH_GROUP_MOON)
	environment_type = "moon"
	initial_gas_mix = AIRLESS_ATMOS
	floor_variance = 0
	digResult = /obj/item/stack/ore/glass/moon
	var/topturf = TRUE

/turf/open/floor/plating/asteroid/moon/lowest
	baseturfs = /turf/open/chasm/moon
	topturf = FALSE //stops craters being underground

/turf/open/floor/plating/asteroid/moon/getDug()
	var/offset_randomiser = "rand(-15,15)"
	. = ..()
	new digResult(src, 5)
	if(postdig_icon_change)
		if(!postdig_icon)
			add_overlay(image(icon, "moonsand_dug", FLOAT_LAYER, offset_randomiser, offset_randomiser, offset_randomiser))
	dug = TRUE

/turf/open/floor/plating/asteroid/moon/Initialize()
	. = ..()
	if(smoothing_flags & SMOOTH_BITMASK)
		var/matrix/M = new
		M.Translate(-4, -4)
		transform = M
		icon = smooth_icon
		icon_state = "[icon_state]-[smoothing_junction]"
	addtimer(CALLBACK(src, /atom/.proc/update_icon), 1)


/turf/open/floor/plating/asteroid/moon/update_icon()
	var/offset_randomiser = rand(-10,10)
	var/rock_randomiser = "moonrocks_[rand(1,16)]"
	var/icon_state_crater = pickweight(list("large" = 1, "medium" = 5, "small" = 20))
	if(prob(30))
		add_overlay(image('icons/turf/talos-moon.dmi', rock_randomiser, FLOAT_LAYER, offset_randomiser, offset_randomiser, offset_randomiser))
	else if(prob(1) && topturf)
		add_overlay(image(icon_craters, icon_state_crater, FLOAT_LAYER + 1, offset_randomiser, offset_randomiser, offset_randomiser))

//Chasm//

/turf/open/chasm/moon
	icon = 'icons/turf/floors/moonchasm.dmi'
	icon_state = "chasm-255"
	base_icon_state = "chasm"
	initial_gas_mix = AIRLESS_ATMOS
	baseturfs = /turf/open/chasm/moon

/turf/open/chasm/moon/Initialize()
	. = ..()
	var/datum/component/chasm/chasm_component = GetComponent(/datum/component/chasm)
	chasm_component.fallable = FALSE

/turf/open/chasm/moon/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = 'icons/turf/talos-moon.dmi'
	underlay_appearance.icon_state = "moonsand"
	return TRUE

//Walls/Rock//

/turf/closed/mineral/random/moon
	name = "moon rock"
	icon = 'icons/turf/walls/moon_wall.dmi'
	smooth_icon = 'icons/turf/walls/moon_wall.dmi'
	icon_state = "rock-0"
	base_icon_state = "rock"
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS)
	defer_change = TRUE
	environment_type = "moon"
	turf_type = /turf/open/floor/plating/asteroid/moon
	baseturfs = /turf/open/floor/plating/asteroid/moon
	initial_gas_mix = AIRLESS_ATMOS
	old_rock = FALSE
	old_scan = FALSE

	mineralChance = 10
	mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 5, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/silver = 12, /obj/item/stack/ore/plasma = 20, /obj/item/stack/ore/iron = 40, /obj/item/stack/ore/titanium = 11,
		/obj/item/stack/ore/bluespace_crystal = 1)

/turf/closed/mineral/random/moon/lowest
	/turf/open/floor/plating/asteroid/moon/lowest

/turf/closed/mineral/random/high_chance/moon
	name = "moon rock"
	icon = 'icons/turf/walls/moon_wall.dmi'
	smooth_icon = 'icons/turf/walls/moon_wall.dmi'
	icon_state = "rock-0"
	base_icon_state = "rock"
	smoothing_flags = SMOOTH_BITMASK
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS)
	defer_change = TRUE
	environment_type = "moon"
	turf_type = /turf/open/floor/plating/asteroid/moon
	baseturfs = /turf/open/floor/plating/asteroid/moon
	initial_gas_mix = AIRLESS_ATMOS
	old_rock = FALSE
	old_scan = FALSE
	mineralChance = 25
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 35, /obj/item/stack/ore/diamond = 30, /obj/item/stack/ore/gold = 45, /obj/item/stack/ore/titanium = 45,
		/obj/item/stack/ore/silver = 50, /obj/item/stack/ore/plasma = 50, /obj/item/stack/ore/bluespace_crystal = 20)

/turf/closed/mineral/random/high_chance/moon/lowest
	/turf/open/floor/plating/asteroid/moon/lowest

/turf/closed/mineral/strong/moon
	name = "moon core"
	icon = 'icons/turf/walls/moon_wall_core.dmi'
	smooth_icon = 'icons/turf/walls/moon_wall_core.dmi'
	icon_state = "rock-0"
	base_icon_state = "rock"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_MINERAL_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS)
	defer_change = TRUE
	environment_type = "moon"
	turf_type = /turf/open/floor/plating/asteroid/moon
	baseturfs = /turf/open/floor/plating/asteroid/moon
	initial_gas_mix = AIRLESS_ATMOS
	old_rock = FALSE
	old_scan = FALSE
