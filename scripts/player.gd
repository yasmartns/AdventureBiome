extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const DOUBLE_JUMP_VELOCITY = -300.0  # Pode ajustar o valor se necessário.

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chaoAtual = null

@onready var animated_sprite = $AnimatedSprite2D
# Variáveis para controle do pulo
var jump_count = 0  # Conta o número de pulos usados.

func _physics_process(delta):
	# Adiciona a gravidade.
	if not is_on_floor():
		
		velocity.y += gravity * delta

	# Lógica para o pulo.
	if Input.is_action_just_pressed("jump") and !Input.is_action_pressed("baixo"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_count = 1  # O pulo inicial no chão.
		elif jump_count == 1:  # Se já foi dado um pulo e ainda está no ar, faz o duplo pulo.
			velocity.y = DOUBLE_JUMP_VELOCITY
			jump_count = 2  # Registra que o pulo duplo foi usado.
	
	if is_on_floor() and chaoAtual:
		if (Input.is_action_pressed("baixo") and Input.is_action_just_pressed("jump")):
			chaoAtual.get_node("CollisionShape2D").rotation_degrees = 180
	# Detecta o movimento horizontal
	var direction = Input.get_axis("move_left", "move_right")
	
	# Inverte o sprite conforme a direção do movimento
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Reproduz as animações de acordo com o estado do personagem
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:  # O personagem está subindo (pulo)
			if jump_count == 1:  # Se for o primeiro pulo
				animated_sprite.play("jump")
			elif jump_count == 2:  # Se for o pulo duplo
				animated_sprite.play("jump")  # Pode criar uma animação separada para o pulo duplo.
		else:  # O personagem está caindo
			animated_sprite.play("fall")

	# Aplica o movimento horizontal
	if direction:
		velocity.x = direction * SPEED
	else:
		
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Resetando o contador de pulos quando o personagem tocar o chão
	if is_on_floor():
		jump_count = 0  # Resetando o pulo quando estiver no chão.


func _on_area_2d_body_entered(body):
	
	if (body.is_in_group("Plataformas") and chaoAtual == null):
		chaoAtual = body
		


func _on_area_2d_body_exited(body):
	if (body == chaoAtual):
		chaoAtual.get_node("CollisionShape2D").rotation_degrees = 0
		chaoAtual = null
