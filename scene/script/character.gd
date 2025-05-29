extends CharacterBody2D
@onready var anim = $AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const GRAVITY = 1200.0  
var is_dead: bool = false
var is_pass: bool = false
#func _ready():
 #var door = get_node_or_null("/root/YourScene/Door")  # 改成實際門的路徑
 #if door:
  #door.connect("player_entered_door", Callable(self, "_on_player_entered_door"))
func _pass():
 is_pass = true
 anim.play("disappear")
 await anim.animation_finished
func _on_death_animation_finished():
	# 這裡可以添加重新載入場景或其他你想做的操作
 print("死亡動畫播放完畢")
 GameState.death_count=GameState.death_count+1
	# 如果你想重新載入場景，可以在這裡加上
 get_tree().reload_current_scene()

func die():
	
 if is_dead:
  return
 is_dead = true
 velocity = Vector2.ZERO
 anim.play("die")
 await anim.animation_finished
 print("check")
 #_on_death_animation_finished()  # 動畫結束後執行後續操作
 return
func _physics_process(delta: float) -> void:
 # 加重力
 if is_dead or is_pass:
  return 
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
  #print("check22")
 else:
  anim.play("run")   # 左右移動時播
 if is_dead:
  return
