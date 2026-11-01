extends CharacterBody3D
var target: Node3D
var points=[Vector3(7,1,-2),Vector3(7,1,5),Vector3(-2,1,-5),Vector3(-8,1,-2)]
var index=0
func _ready(): target=get_meta("target")
func _physics_process(delta):
    if not is_instance_valid(target): return
    var dest=target.global_position if global_position.distance_to(target.global_position)<10 else points[index]
    if global_position.distance_to(dest)<1: index=(index+1)%points.size(); dest=points[index]
    var d=dest-global_position; d.y=0
    if d.length()>.1:
        d=d.normalized(); velocity.x=d.x*(3.4 if global_position.distance_to(target.global_position)<10 else 2.0); velocity.z=d.z*(3.4 if global_position.distance_to(target.global_position)<10 else 2.0)
        look_at(Vector3(dest.x,global_position.y,dest.z),Vector3.UP)
    if not is_on_floor(): velocity.y-=18*delta
    else: velocity.y=0
    move_and_slide()
