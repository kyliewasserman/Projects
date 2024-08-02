extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -480.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var lastTimeLeft
var currentTimeLeft

var levelCount = 0

func _ready():
	pass

func _physics_process(delta):
	# Handle jump.
	var direction1 = Input.get_axis("move_foward", "move_backward")
	if direction1:
		velocity.y = direction1 * SPEED
		$CollisionShape2D.scale.x = 1
		#$AnimatedSprite2D.play("wrun")
		if direction1 < 0:
			$AnimatedSprite2D.play("wrun")
		else:
			$AnimatedSprite2D.play("srun")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		#$AnimatedSprite2D.play("idle")
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		$CollisionShape2D.scale.y = 1
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#$AnimatedSprite2D.play("idle")
	
	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("idle")

	
	move_and_slide()
	


func _on_innerwater_child_entered_tree(node):
	velocity.x = 0
	velocity.y = 0


func _on_building_1_body_entered(body):
	#get_tree().change_scene_to_file("res://PuzzleGame/game_1.tscn")
	get_tree().change_scene_to_file("res://MazeGame/game 3.tscn")


func _on_building_2_body_entered(body):
	get_tree().change_scene_to_file("res://FlappyGame/game_2.tscn")

func _on_castle_body_entered(body):
	# for this game you can only get 1 or 3 stars - 1 star for running out of time, 3 stars for finishing in time	
	Game3.starAmount = 3
	get_tree().change_scene_to_file("res://MazeGame/WinGame3.tscn")
	

func _on_mazewater_1_child_entered_tree(node):
	velocity.x = 0
	velocity.y = 0

func _on_mazewater_2_child_entered_tree(node):
	velocity.x = 0
	velocity.y = 0

func _on_mazewater_3_child_entered_tree(node):
	velocity.x = 0
	velocity.y = 0

func _on_mazewater_4_child_entered_tree(node):
	velocity.x = 0
	velocity.y = 0

func _on_mazewater_5_child_entered_tree(node):
	velocity.x = 0
	velocity.y = 0


func _on_endbuilding_body_entered(body):
	get_tree().change_scene_to_file("res://endgame.tscn")
