extends CardBase

class_name CardNeutralizeNode

func card_effect(node: MapNode):
	node.neutralize_node()
	GameEngine.get_card_manager().reset_card(self)

func _process(delta):
	pass

func _init():
	title = "Neutralize"
	descrition = "Destory fungus\nby clicking node"
