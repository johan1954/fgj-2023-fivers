extends Node



class_name Shroom_base

var resource_points = 10
var title = "Shroom"
var base_draft_amount = 3
var base_card_pick_amount = 1

func change_resource_points(points):
	self.resource_points += points

func change_draft_amount(draft_amount):
	self.base_draft_amount += draft_amount

func change_cardpicks(picks):
	self.base_card_pick_amount += picks
	
