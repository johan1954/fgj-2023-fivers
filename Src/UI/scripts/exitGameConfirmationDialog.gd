extends Node


func delete_all():
	print("Kiitos ohjelman käytöstä!")
	GlobalAudio.playSoundEffect()
	var map = get_node("/root/Map")
	for child in map.get_children():
		child.queue_free()
	get_tree().quit()
