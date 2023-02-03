extends Node



class_name Shroom_base

var resource_points = 10
var title = "Shroom"
var base_draft_amount = 3
var base_card_pick_amount = 1
var cardpack_array = []

func change_resource_points(points):
	self.resource_points += points

func change_draft_amount(draft_amount):
	self.base_draft_amount += draft_amount

func change_cardpicks(picks):
	self.base_card_pick_amount += picks
	
func add_cards(cards):
	self.cardpack_array.append(cards)
	
func remove_card_by_index(index):
	self.cardpack_array.remove(index)
