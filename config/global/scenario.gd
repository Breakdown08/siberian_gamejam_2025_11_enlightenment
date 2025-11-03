extends Node

static func event(_signal:Signal) -> String: return _signal.get_name()

# Актеры:
const ACTOR_HERO:String = "Главный герой"
const ACTOR_FRIEND:String = "Женя"
const ACTOR_NONE:String = "..." # закадровый голос главного героя

# Ключи для хода сюжета
const KEY_ACTOR = "actor"
const KEY_SPEECH = "speech"
const KEY_EVENTS = "events"

# Сценарные события:
signal friend_has_come # друг пришел
signal friend_has_left # друг ушел
signal cutscene_on # катсцена началась
signal cutscene_off # катсцена закончилась
signal encryption_machine_try_code_breaking(key:String) # шифр. машинка ввод символов
signal oscilloscope_write_params(params:PackedInt32Array) # записаны параметры крутилок осциллографа в дневник
signal computer_try_send_signal(params:PackedInt32Array) # отправлен сигнал параметров через компьютер
signal computer_response(respone:String) # ответ компьютера на сигнал

# Сценарные ключи
const ENCRYPTION_MACHINE_PASSWORD:String = "тест"
const ENCRYPTION_MACHINE_ANSWER:String = "Я УсиЩ, ПРОЗРЕЙ фото с ГлазиЩем"
const OSCILLOSCOPE_PARAMS:PackedInt32Array = [0, 1, 2, 3, 4]
const NOTIFICATION_UPDATE_DIARY:String = "Запись в дневнике обновлена..."

# Ход сценария:
var data_base:Array[Dictionary] = [
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Как всегда пунктуален. Уже на протяжении нескольких месяцев Женя приходит в одно и то же время, чтобы принести мне новую порцию еды",
		KEY_EVENTS : [event(self.cutscene_on)]
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "и энергетиков, а заодно вынести мой мусор. Не знаю, чтобы я делал без такого понимающего друга.",
	},
	{
		KEY_EVENTS : [event(self.friend_has_come)]
	},
	{
		KEY_ACTOR : ACTOR_FRIEND,
		KEY_SPEECH : "Привет! Как продвигается твое расследование?"
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Расследование... Когда-то мой отец занимался этим и заразил меня своей идеей вычислить инопланетян. Он погиб,"
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "не доведя дело до конца, а я взял на себя решение этой задачи. Перечитав его дневники, переслушав все программы и подкасты"
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "я не приблизился ни на сантиметр к разгадке этой тайны..."
	},
	{
		KEY_ACTOR : ACTOR_HERO,
		KEY_SPEECH : "Все в той же точке. Я закончил читать последний сохранённый отцом дневник, все остальные он сжег, когда понял, что за ним следят."
	},
]
