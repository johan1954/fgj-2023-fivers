extends Node

class_name CardManager

var card_container: CardButtonManager

var base_cardpack : Array[CardBase]
var active_cardpack : Array[CardBase]
var pending_card : CardBase
var pending_card_button : CardButton
var timer : float = 0
var victory_condition_timer : float = 0
var game_stopped = false

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	card_container = get_node("/root/Scene/UI/Control/CardContainer")
	var card_add_attack = CardAddAttack1.new()
	var card_reduce_attack = CardReduceAttack1.new()
	var card_neutralize_node = CardNeutralizeNode.new()
	base_cardpack.append(card_add_attack)
	base_cardpack.append(card_reduce_attack)
	base_cardpack.append(card_neutralize_node)
	pass # Replace with function body.

func create_cards_from_pack(amount : int):
	if base_cardpack.size() == 0:
		return
	var card = base_cardpack.pick_random()
	base_cardpack.erase(card)
	active_cardpack.append(card)
	card_container.new_button(card, self)

func handle_button_press(card_button: CardButton, card : CardBase):
	if card is CardAddAttack1:
		card.card_effect()
		card_container.remove_button(card_button)
	elif card is CardNeutralizeNode:
		pending_card = card
		pending_card_button = card_button
		
func handle_node_press(node: MapNode):
	if pending_card == null:
		return
	pending_card.card_effect(node)
	card_container.remove_button(pending_card_button)
	pending_card = null
	pending_card_button = null
		
func reset_card(card):
	active_cardpack.erase(card)
	base_cardpack.append(card)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_stopped == true:
		return
	
	victory_condition_timer += delta
	
	if (victory_condition_timer >= 3):
		victory_condition_timer = victory_condition_timer - 3
		check_victory_lose_condition()
	
	if base_cardpack.size() == 0:
		timer = 0
		return
	
	for card in active_cardpack:
		card._process(delta)
	
	timer += delta
	
	if (timer >= GameEngine.DRAFT_TIMER):
		create_cards_from_pack(3)
		timer = timer - GameEngine.DRAFT_TIMER

func check_victory_lose_condition():
	var number_of_enemy_nodes = 0
	var number_of_player_nodes = 0
	for node in GameEngine.map_state.nodes:
		if node.belongs_to == Enums.Owner.PLAYER:
			number_of_player_nodes += 1
		if node.belongs_to == Enums.Owner.ENEMY:
			number_of_enemy_nodes += 1
	
	if number_of_enemy_nodes == 0:
		var dialog = AcceptDialog.new()
		dialog.dialog_text = "Your mushroom is victorious!"
		dialog.title = "Victory!"
		dialog.ok_button_text = "OK"
		dialog.visible = true
		get_tree().get_current_scene().add_child(dialog,true)
		game_stopped = true
	
	if number_of_player_nodes == 0:
		var dialog = AcceptDialog.new()
		dialog.dialog_text = "Your have been eliminated!"
		dialog.title = "Lose"
		dialog.ok_button_text = "OK"
		dialog.visible = true
		get_tree().get_current_scene().add_child(dialog,true)
		game_stopped = true
