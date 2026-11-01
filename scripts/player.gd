extends CharacterBody3D

@export var speed := 4.2
@export var mouse_sensitivity := 0.002
var gravity := 18.0
var camera: Camera3D
var yaw := 0.0
var pitch := 0.0

func _ready():
    camera = $Camera3D
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if not OS.has_feature("mobile") else Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event):
    if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
        yaw -= event.relative.x * mouse_sensitivity
        pitch = clamp(pitch - event.relative.y * mouse_sensitivity, -1.1, 1.1)
        rotation.y = yaw
        camera.rotation.x = pitch
    elif event is InputEventScreenDrag:
        yaw -= event.relative.x * 0.004
        pitch = clamp(pitch - event.relative.y * 0.004, -1.1, 1.1)
        rotation.y = yaw
        camera.rotation.x = pitch

func _physics_process(delta):
    var input_dir = Vector2(
        Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
        Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    )
    var dir = (transform.basis * Vector3(input_dir.x,0,input_dir.y)).normalized()
    velocity.x = dir.x * speed
    velocity.z = dir.z * speed
    if not is_on_floor():
        velocity.y -= gravity * delta
    else:
        velocity.y = 0
    move_and_slide()
