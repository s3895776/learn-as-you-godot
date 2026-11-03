extends CanvasLayer
#@onready var health_container = $HealthContainer 
#var hearts : Array = [] 
#@onready var score_text : Label = $ScoreText 
@onready var player = get_parent()
@export var item_space: TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
# Subscribe to signals 
# player.OnUpdateHealth.connect(_update_hearts) 
# player.OnUpdateScore.connect(_update_score)
	Events.draw_ui.connect(_display_item)
	
# initial player values
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _display_item(texture : Texture2D):
	#player.get_player_inventory().show_inventory_item()
	item_space.set_texture(texture)
