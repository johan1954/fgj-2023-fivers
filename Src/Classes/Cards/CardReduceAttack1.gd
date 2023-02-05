extends "res://Src/Classes/Cards/CardBaseDefense.gd"

class_name CardReduceAttack1

var DAMAGE_REDUCE = 8
var DEACTIVATION_TIME = 10
var timer = 0
var activated = false

# Called when the node enters the scene tree for the first time.
func card_effect():
	GameEngine.enemy_damage_output -= DAMAGE_REDUCE
	activated = true

func _process(delta):
	if activated == false: return
	
	timer += delta
	if (timer >= DEACTIVATION_TIME):
		GameEngine.enemy_damage_output += DAMAGE_REDUCE
		timer = 0
		activated = false
		card_manager.reset_card(self)
