# building_risk_manager.gd
class_name BuildingRiskManager
extends RefCounted

var fortress_state: FortressState

func process_tick():

	for building_id in fortress_state.building_state_map:

		var building := fortress_state.building_state_map[building_id]

		for effect in building.definition.inherent_effects:

			var current := building.effect_accumulation.get(
				effect.effect_type,
				0.0
			)

			current += effect.base_value

			building.effect_accumulation[
				effect.effect_type
			] = current

			if current >= effect.trigger_threshold:
				trigger_effect(building, effect)
