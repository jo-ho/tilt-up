class_name EffectManager
extends Node

var effects: Dictionary[EffectData.Type, EffectData] = {
	EffectData.Type.FREEZE: preload("res://effect/freeze.tres"),
	EffectData.Type.ENLARGE: preload("res://effect/enlarge.tres"),
	EffectData.Type.SHRINK: preload("res://effect/shrink.tres"),
	EffectData.Type.TO_SQUARE: preload("res://effect/to_square.tres"),
	EffectData.Type.STICKY: preload("res://effect/sticky.tres"),
	EffectData.Type.FOG: preload("res://effect/fog.tres"),
	EffectData.Type.REVIVE: preload("res://effect/revive.tres"),
	EffectData.Type.STAR: preload("res://effect/star.tres"),
}

signal new_effect_received(effect: Effect)

func add_effect(type: EffectData.Type, duration_secs: float) -> void:
	for effect: Effect in get_children():
		if effect.data.type == type:
			effect.on_apply(duration_secs)
			return
	
	var new_effect: Effect = effects[type].scene.instantiate()
	new_effect.data = effects[type]
	add_child(new_effect)
	if type != EffectData.Type.STAR:
		new_effect_received.emit(new_effect)
	new_effect.on_apply(duration_secs)
