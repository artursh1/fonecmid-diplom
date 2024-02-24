#language: ru

@tree

Функционал: Автоматизированное создание документа "Реализация" и отчета "Анализ выставленных актов"

Как Бухгалтер я хочу
сформировать документы реализации и проверить все ли акты выставлены
чтобы проверить корректность работы обработки и формирование отчета  

Когда В панели разделов я выбираю 'Добавленные объекты'
И я нажимаю на кнопку с именем 'Button0'
И Я закрываю окно ''
Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Запускаю обработку "ВКМ_Массовое создание актов"
*Запуск клиента от имени Бухгалтера
	Тогда я подключаю TestClient "ТестКлиент" логин "БухгалтерИ" пароль ""
*Бухгалтер выполняет массовое создание актов
	И В командном интерфейсе я выбираю 'Добавленные объекты' 'Массовое создание актов'
	Тогда открылось окно 'Массовое создание актов'
	И я нажимаю кнопку выбора у поля с именем "Период"
	Тогда открылось окно 'Выберите период'
	И я нажимаю на кнопку с именем 'Select'
	Тогда открылось окно 'Массовое создание актов'
	И я нажимаю на кнопку с именем 'ФормаСоздатьДокументыРеализации'
	
*Бухгалтер формирует отчёт Анализ выставленных актов
	И В командном интерфейсе я выбираю 'Добавленные объекты' 'Анализ выставленных актов'
	Тогда открылось окно 'Анализ выставленных актов'
	И в поле с именем 'Период1ДатаНачала' я ввожу текст '01.01.2024'
	И в поле с именем 'Период1ДатаОкончания' я ввожу текст '31.01.2024'
	И я нажимаю на кнопку с именем 'СформироватьОтчет'
	
*Завершение сеанса от имени Бухгалтер
	И я закрываю TestClient "ТестКлиент" 
