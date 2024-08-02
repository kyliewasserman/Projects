class_name World
extends Node2D

static var flappystar1 = false
static var flappystar2 = false
static var flappystar3 = false

static var mazestar1 = false
static var mazestar3 = false

static var questCompleted = false
static var questCompleted2 = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$tips.show()
	$tips/tipsTimer.start()
	await $tips/tipsTimer.timeout
	$tips.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# translate the last score to star strings
	if Goblin.lastScore >= 12:
		questCompleted = true
		flappystar3 = true
	elif Goblin.lastScore >= 5:
		# questCompleted = true
		flappystar2 = true
	elif Goblin.lastScore >= 1:
		flappystar1 = true

	
	if flappystar3:
		$UI/Game2Stars.text = str("SSS")
	elif flappystar2:
		$UI/Game2Stars.text = str("SS")
	elif flappystar1:
		$UI/Game2Stars.text = str("S")
	
	# translate the last score to star strings
		# done within 30 seconds
	if Game3.starAmount == 1:
		mazestar1 = true
		
	# done within 60 seconds
	elif Game3.starAmount == 3:
		questCompleted2 = true
		mazestar3 = true
		
	if mazestar3:
		$UI/Game1Stars.text = str("SSS")
	elif mazestar1:
		$UI/Game1Stars.text = str("S")
	
