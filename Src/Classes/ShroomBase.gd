extends Node2D

class_name Shroom_base

var resource_points = 10
var title = "Shroom"
# Base values
var base_draft_amount = 3
var base_card_pick_amount = 1
var base_expand_speed = 1
var base_dmg = 0
var base_node_health_change_speed = 0
# Card arrays
var cardpack_array = []
var hand_cards_array = []
# RNG class

var rng = RandomNumberGenerator.new()

# Class methods
func change_resource_points(points):
	self.resource_points += points

func change_draft_amount(draft_amount):
	self.base_draft_amount += draft_amount

func change_cardpicks(picks):
	self.base_card_pick_amount += picks
	
func add_cards_to_pack(cards):
	self.cardpack_array.append(cards)
	
func remove_card_from_pack(index):
	self.cardpack_array.remove_at(index)

func remove_card_from_hand(index):
	self.hand_cards_array.remove_at(index)
	
func draft_cards():
	var selected = []
	for _i in range(0, self.base_draft_amount):
		selected.append(rng.randi_range(0, self.base_draft_amount-1))
		
	return selected
