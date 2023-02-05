extends CardAttackNode

class_name CardAddAttack1

var ATTACK_AMOUNT = 10
var DEACTIVATION_TIME = 5
var timer = 0
var activated = false

# Called when the node enters the scene tree for the first time.
func card_effect():
	GameEngine.player_damage_output += ATTACK_AMOUNT
	activated = true

func _process(delta):
	if activated == false: return
	
	timer += delta
	if (timer >= DEACTIVATION_TIME):
		GameEngine.player_damage_output -= ATTACK_AMOUNT
		timer = 0
		activated = false
		GameEngine.get_card_manager().reset_card(self)
