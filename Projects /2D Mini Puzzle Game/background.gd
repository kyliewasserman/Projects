extends ParallaxBackground

var scrolling_speed = 100

func _process(delta):
	scroll_offset.x  -= scrolling_speed * delta
	
	get_node("ParallaxLayer2/AnimatedSprite2DRock1").play("default")
	get_node("ParallaxLayer2/AnimatedSprite2DRock2").play("default")
	get_node("ParallaxLayer2/AnimatedSprite2DRock3").play("default")
	get_node("ParallaxLayer2/AnimatedSprite2DRock4").play("default")
	get_node("ParallaxLayer2/AnimatedSprite2DRock5").play("default")
	get_node("ParallaxLayer2/AnimatedSprite2DRock6").play("default")
	get_node("ParallaxLayer2/AnimatedSprite2DRock8").play("default")
	get_node("ParallaxLayer2/AnimatedSprite2DRock9").play("default")
	get_node("ParallaxLayer2/AnimatedSprite2DRock10").play("default")
	get_node("ParallaxLayer2/AnimatedSprite2DRock11").play("default")
	
	
