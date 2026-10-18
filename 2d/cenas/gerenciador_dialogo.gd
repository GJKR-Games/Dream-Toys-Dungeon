extends Node2D

@onready var dialogue_label = $CanvasLayer/Panel/RichTextLabel
@onready var panel = $CanvasLayer/Panel

func _ready():
	panel.visible = false # Esconde a caixa de diálogo ao iniciar

func show_dialogue(text: String):
	dialogue_label.text = text
	panel.visible = true
	# Opcional: Pausar o jogo ou congelar o player aqui

func close_dialogue():
	panel.visible = false

func _input(event):
	if panel.visible and event.is_action_pressed("ui_interact"): # Tecla Enter/Espaço
		panel.visible = false # Fecha o diálogo ao apertar o botão
