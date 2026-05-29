extends Node2D
class_name EntityVisuals

@onready var sprite: Sprite2D = $EntitySprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPRITE_DEFAULT_POSITION := Vector2.ZERO
const SPRITE_DEFAULT_SCALE := Vector2.ONE
const SPRITE_DEFAULT_ROTATION := 0.0


func play_idle() -> void:
	reset_sprite_transform()
	play_animation("idle")


func play_move(direction: Vector2) -> void:
	if direction != Vector2.ZERO:
		sprite.rotation = direction.angle()

	play_animation("move")


func play_interact(target: Interactable) -> void:
	var animation_name := "interact"

	if target != null and target.interaction_animation != "":
		animation_name = target.interaction_animation

	play_animation(animation_name)


func play_animation(animation_name: String) -> void:
	if animation_player == null:
		return

	if not animation_player.has_animation(animation_name):
		return

	if animation_player.current_animation == animation_name:
		return

	animation_player.play(animation_name)

func reset_sprite_transform() -> void:
	sprite.position = SPRITE_DEFAULT_POSITION
	sprite.scale = SPRITE_DEFAULT_SCALE
	sprite.rotation = SPRITE_DEFAULT_ROTATION
