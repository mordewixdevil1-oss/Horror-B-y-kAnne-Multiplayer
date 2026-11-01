extends Node3D

var player: CharacterBody3D
var granny: Node3D
var keys := 0

func _ready():
    create_world()
    create_player()
    create_granny()

func create_world():
    var floor = MeshInstance3D.new()
    var mesh = BoxMesh.new()
    mesh.size = Vector3(18, 0.5, 18)
    floor.mesh = mesh
    floor.position.y = -0.25
    add_child(floor)

    var light = DirectionalLight3D.new()
    light.rotation_degrees = Vector3(-45, -30, 0)
    add_child(light)

    make_wall(Vector3(0, 2, -9), Vector3(18, 4, 0.3))
    make_wall(Vector3(-9, 2, 0), Vector3(0.3, 4, 18))
    make_wall(Vector3(9, 2, 0), Vector3(0.3, 4, 18))

func make_wall(pos: Vector3, size: Vector3):
    var wall = MeshInstance3D.new()
    var box = BoxMesh.new()
    box.size = size
    wall.mesh = box
    wall.position = pos
    add_child(wall)

func create_player():
    player = CharacterBody3D.new()
    player.position = Vector3(0, 1, 5)
    var camera = Camera3D.new()
    camera.position.y = 0.5
    camera.current = true
    player.add_child(camera)
    add_child(player)

func create_granny():
    granny = Node3D.new()
    granny.position = Vector3(0, 0, -4)
    var body = MeshInstance3D.new()
    var shape = CapsuleMesh.new()
    body.mesh = shape
    body.position.y = 1
    granny.add_child(body)
    add_child(granny)

func _process(delta):
    if player and granny:
        granny.position = granny.position.move_toward(
            Vector3(player.position.x, 0, player.position.z),
            delta * 0.7
        )
