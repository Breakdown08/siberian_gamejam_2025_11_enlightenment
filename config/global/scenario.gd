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
		KEY_SPEECH : "Как всегда пунктуален. Уже на протяжении нескольких месяцев Женя приходит в одно и то же время.",
		KEY_EVENTS : [event(self.cutscene_on)]
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Он приносит мне еду и энергетики, а заодно выносит мусор. Не знаю, чтобы я делал без такого понимающего друга.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Последние несколько лет вся моя жизнь – поиск инопланетян. Я уверен, что мой отец добрался до правды и поэтому его устранили.",
	}, 
	{
		KEY_ACTOR : ACTOR_NONE, 
		KEY_SPEECH : "В комнату врывается свежий воздух, когда мой друг открывает дверь.",
	}, 
	{	
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : " Я не помню какой сейчас месяц и день недели: ем, пью кофе – все за столом, все с радио и отцовскими дневниками.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Когда я видел последний раз солнечный свет?",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Не помню, если не считать те редкие лучи, проникающие в мою комнату сквозь занавески на окна.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Я на секунду отрываюсь от последнего дневника отца, в момент, когда Женя обращается ко мне.",
	},
	{
		KEY_EVENTS : [event(self.friend_has_come)],
		KEY_ACTOR : ACTOR_FRIEND,
		KEY_SPEECH : "Привет! Как продвигается твое расследование?",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Расследование... Когда-то мой отец занимался этим и заразил меня своей идеей вычислить инопланетян.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Он погиб, не доведя дело до конца, а я взял на себя решение этой задачи. Перечитав его дневники, переслушав все программы и подкасты",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "я не приблизился ни на сантиметр к разгадке этой тайны...",
	},
	{
		KEY_ACTOR : ACTOR_HERO,
		KEY_SPEECH : "Все в той же точке. Я закончил читать последний сохранённый отцом дневник, все остальные он сжег, когда понял, что за ним следят.",
	},
	{
		KEY_ACTOR : ACTOR_FRIEND,
		KEY_SPEECH : "Там есть подсказки, что делать дальше?",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Что ему сказать? Что дневник — это набор бессвязных букв и символов?",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Набор точек и палочек? Что это все выглядит как записи сумасшедшего?",
	},
	{
		KEY_ACTOR : ACTOR_HERO,
		KEY_SPEECH : "Нет, он не оставил ни одной зацепки. Я даже не понимаю, что он искал.",
	},
	{
		KEY_ACTOR : ACTOR_HERO,
		KEY_SPEECH : "Если бы была возможность найти его друга, узнать, как они хотели связаться с пришельцами.",
	},
	{
		KEY_ACTOR : ACTOR_HERO,
		KEY_SPEECH : "Но друг отца давно не выходил на связь. Я не знаю где он и что с ним.",
	},
	{
		KEY_ACTOR : ACTOR_FRIEND,
		KEY_SPEECH : "Продолжай поиски, мне кажется, что у тебя все получится.",
	},
	{
		KEY_ACTOR : ACTOR_HERO,
		KEY_SPEECH : "Я тоже хочу верить в это. Но нужная волна…",
	},
	{
		KEY_ACTOR : ACTOR_HERO,
		KEY_SPEECH : "Мне кажется, что ответ где-то рядом, но постоянно ускользает от меня.",
	},
	{
		KEY_ACTOR : ACTOR_HERO,
		KEY_SPEECH : "За столько лет поисков я попробовал подключиться к такому большому количеству сигналов, что даже перестал записывать их в дневнике.",
	},
	{
		KEY_ACTOR : ACTOR_HERO,
		KEY_SPEECH : "И ничего. Один раз мне показалось, что я вышел на связь с кем-то или чем-то, но…",
	},
	{
		KEY_ACTOR : ACTOR_FRIEND,
		KEY_SPEECH : "Мы же пришли к выводу, что это просто кто-то решил подшутить, не думаю, что ты в тот момент услышал пришельцев или типа того.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Тот спорный случай, когда я услышал сквозь помехи какие-то непонятные обрывки слов, стук.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Думал, что это Морзе.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Женя помог тогда это расшифровать, но ничего там не обнаружил.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Я купил, конечно, себе азбуку Морзе,",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "но доводы Жени о том, что это всего лишь шутка, были достаточно убедительны, чтобы я не брался декодировать это сам.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "К тому же, в тот момент Женя тоже получил какой-то сигнал.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "В нем говорилось, что мой отец что-то нашел и это что-то у меня в доме."
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Правда мы так и не узнали, что, а Женя отказывается говорить и подключаться еще раз к тому источнику информации.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Думаю, этот информатор сильно напугал его, иначе он бы все сделал, чтобы помочь мне.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Он всегда помогает.",
	},
	{
		KEY_ACTOR : ACTOR_HERO,
		KEY_SPEECH : "Да, думаю ты прав. Но если это не радио?",
	},
	{
		KEY_ACTOR : ACTOR_HERO,
		KEY_SPEECH : "Почему тогда отец так хотел, чтобы я был именно радиомехаником?",
	},
	{
		KEY_ACTOR : ACTOR_HERO,
		KEY_SPEECH : "Вдруг все это время мы идем по ложному следу?",
	},
	{
		KEY_ACTOR : ACTOR_HERO,
		KEY_SPEECH : "Почему ты думаешь, что твой сигнал был не шуткой?",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Я собирался связать свою жизнь с астрономией, думал, что это приблизит меня к делу отца."
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Но он настоял на радио.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Я надеялся, что это как-то связано с инопланетянами.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Но больше никаких подсказок он мне не оставил.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Я и правда стал радиомехаником, даже пытался работать. Но эта работа…",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Она только отвлекала меня от дела всей моей жизни.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Да, это дело не приносит мне денег, да меня обеспечивает моя бабушка.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Но разве не лучше знать, что я полностью посвятил себя любимому делу,",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "не тратя ресурс на бесполезную, хоть и дающую финансы, работу?",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Да, из-за одержимости продолжить дело отца я стал нелюдимым домоседом.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Что ж, зато не спился и меня не убили на улице.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Да, если это случится, то меня хотя бы не придется искать – я буду дома за радио.",
	},
	{
		KEY_ACTOR : ACTOR_FRIEND,
		KEY_SPEECH : "Может он и пытался как-то намекнуть тебе на то, где нужно искать. Но тот сигнал был ошибкой.",
	},
	{
		KEY_ACTOR : ACTOR_FRIEND,
		KEY_SPEECH : "Может это должен был быть другой сигнал? Он не оставлял подсказки что нужно искать?",
	},
	{
		KEY_ACTOR : ACTOR_FRIEND,
		KEY_SPEECH : "Какие-нибудь цифры, буквы? Какой-то ключ, который натолкнет тебя на нужную зацепку?",
	},
	{
		KEY_ACTOR : ACTOR_FRIEND, 
		KEY_SPEECH : "Я думаю, что это где-то здесь, может мы пока не видим, не замечаем, но в какой-то момент прозрение дойдет до нас.",
	},
	{
		KEY_ACTOR : ACTOR_FRIEND,
		KEY_SPEECH : "Слушай, не буду тебя отвлекать, но подумай над тем, что я сказал. Пока. И не отчаивайся!",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Не отчаивайся… Мне кажется за столько лет поисков я уже забыл это слово.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Каждый день начинаю с дневников, пытаясь сдвинуться с мертвой точки. Вся моя жизни – радио, это мое хобби, мое увлечение, моя миссия."
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Но что, если я думаю не в ту сторону? Может быть, тот сигнал и был ключом?",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Я часто встречал букву «Щ» в разговорах отца с другом. А последняя волна как раз напоминала эту букву.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "А последняя волна как раз напоминала эту букву. Вдруг я набрел тогда на инопланетян?",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Возможно нужно попробовать подключиться еще раз? Может быть, я смогу поймать более стабильную волну?",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Что если предыдущая расшифровка ничего не дала, потому что я записал что-то неправильно?"
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "В любом случае, если я не попробую вопросов меньше не станет.",
	},
	{
		KEY_ACTOR : ACTOR_NONE,
		KEY_SPEECH : "Пожалуй, время попробовать начать все сначала и воспроизвести ту букву на осциллографе.",
	},
	{
		KEY_EVENTS : [event(self.cutscene_off)]
	}
]
