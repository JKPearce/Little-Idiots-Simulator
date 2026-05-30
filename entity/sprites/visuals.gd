extends Node2D
class_name EntityVisuals

@onready var sprite: Sprite2D = $EntitySprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var gather_particles: GPUParticles2D = $GatherParticles
@onready var craft_particles: GPUParticles2D = $CraftParticles
# Add these later when you make them:
# @onready var eat_particles: GPUParticles2D = $EatParticles
# @onready var sleep_particles: GPUParticles2D = $SleepParticles

const SPRITE_DEFAULT_POSITION := Vector2.ZERO
const SPRITE_DEFAULT_SCALE := Vector2.ONE


func play_idle() -> void:
	reset_sprite_offset()
	play_animation("idle")


func play_move(direction: Vector2) -> void:
	reset_sprite_offset()

	if direction != Vector2.ZERO:
		sprite.rotation = direction.angle()

	play_animation("move")


func play_interact(target: Interactable) -> void:
	var animation_name := "interact"

	if target != null and target.interaction_animation != "":
		animation_name = target.interaction_animation

	play_animation(animation_name)


func play_effect(effect_name: String) -> void:
	match effect_name:
		"gather":
			_play_particles(gather_particles)

		"craft":
			_play_particles(craft_particles)

		# Add these later:
		# "eat":
		# 	_play_particles(eat_particles)
		#
		# "sleep":
		# 	_play_particles(sleep_particles)


func play_animation(animation_name: String) -> void:
	if animation_name == "":
		return

	if animation_player == null:
		return

	if not animation_player.has_animation(animation_name):
		return

	if animation_player.current_animation == animation_name:
		return

	animation_player.play(animation_name)


func _play_particles(particles: GPUParticles2D) -> void:
	if particles == null:
		return

	particles.restart()
	particles.emitting = true


func reset_sprite_offset() -> void:
	sprite.position = SPRITE_DEFAULT_POSITION
	sprite.scale = SPRITE_DEFAULT_SCALE
