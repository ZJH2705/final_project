extends CharacterBody2D
@onready var anim = $AnimatedSprite2D
const SPEED = 200.0
const JUMP_VELOCITY = -300.0
const GRAVITY = 1200.0  
var touching_door = false
func _ready():
 var door = get_node_or_null("/root/YourScene/Door")  # 改成實際門的路徑
 if door:
  door.connect("player_entered_door", Callable(self, "_on_player_entered_door"))

func _on_player_entered_door():
 print("Player touched the door!")
 touching_door = true
 # 例如：播放一個動畫或切換場景
 anim.play("enter_door")
 # 或執行場景切換
 # get_tree().change_scene_to_file("res://next_scene.tscn")
 
func _physics_process(delta: float) -> void:
 # 加重力
 if not is_on_floor():
  velocity.y += GRAVITY * delta

 # 跳躍
 if Input.is_action_just_pressed("ui_up") and is_on_floor():
  velocity.y = JUMP_VELOCITY
 
 # 左右移動
 var direction := Input.get_axis("ui_left", "ui_right")
 if direction:
  velocity.x = direction * SPEED
 
 # <<< 左右翻轉角色
  if direction < 0:
   anim.flip_h = true  # 往左：水平翻轉
  elif direction > 0:
   anim.flip_h = false # 往右：正常
 else:
  velocity.x = move_toward(velocity.x, 0, SPEED)
 
 move_and_slide()
 if velocity.x == 0:
  anim.play("idle")  # 靜止時播放待機動畫
 else:
  anim.play("run")   # 左右移動時播放跑步動畫
