@tool
extends Node3D

@export var is_lit = true:
	set(value):
		$bulb.set_visible(value)
		is_lit = value
