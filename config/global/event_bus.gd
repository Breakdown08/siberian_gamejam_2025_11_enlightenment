extends Node

signal screen_switched(next_screen:Main.SCREEN)
signal scene_switched(next_scene:Game.SCENE)

signal dialog(actor:String, actor_speech:String)
signal dialog_continue(actor_speech:String)
signal thought(hero_speech:String)

signal notification(message:String)

signal speech_started
signal speech_finished

signal game_started

signal scenario_id_updated(scenario_id:int)
