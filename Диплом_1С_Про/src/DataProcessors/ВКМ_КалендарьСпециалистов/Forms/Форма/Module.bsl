
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	НачалоПериода = НачалоНедели(ТекущаяДатаСеанса());
	КонецПериода = КонецНедели(ТекущаяДатаСеанса());
	
	Планировщик.ТекущиеПериодыОтображения.Добавить(НачалоПериода, КонецПериода);
	
	ОбновитьПланировщик();
		
КонецПроцедуры

&НаКлиенте
Процедура Обновить(Команда)
	
	ОбновитьПланировщик();

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_ВКМ_ОбслуживаниеКлиента" Тогда
		
		ОбновитьПланировщик();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПланировщикПередСозданием(Элемент, Начало, Конец, ЗначенияИзмерений, Текст, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ЗначенияЗаполнения = Новый Структура;
	ЗначенияЗаполнения.Вставить("ДатаПроведенияРабот", Начало);
	ЗначенияЗаполнения.Вставить("ВремяНачалаРаботПлан", Начало);
	ЗначенияЗаполнения.Вставить("ВремяОкончанияРаботПлан", Конец);
	ЗначенияЗаполнения.Вставить("Специалист", ПользователиКлиент.ТекущийПользователь());
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения);
	
	ОткрытьФорму("Документ.ВКМ_ОбслуживаниеКлиента.Форма.ФормаДокумента", ПараметрыФормы);

КонецПроцедуры



&НаСервере
Процедура ОбновитьПланировщик()

	НачалоПериода = НачалоНедели(ТекущаяДатаСеанса());
	КонецПериода = КонецНедели(ТекущаяДатаСеанса());
	
	Планировщик.Элементы.Очистить();

	ЗаявкиНаОбслуживание = Документы.ВКМ_ОбслуживаниеКлиента.Выбрать(НачалоПериода, КонецПериода);
	
	Пока ЗаявкиНаОбслуживание.Следующий() Цикл
		
		НачалоОбслуживания = ЗаявкиНаОбслуживание.ДатаПроведенияРабот + 
				(ЗаявкиНаОбслуживание.ВремяНачалаРаботПлан - Дата(1, 1, 1));
		КонецОбслуживания = ЗаявкиНаОбслуживание.ДатаПроведенияРабот + 
				(ЗаявкиНаОбслуживание.ВремяОкончанияРаботПлан -	Дата(1, 1, 1));
		
		ЭлементПланировщика = Планировщик.Элементы.Добавить(НачалоОбслуживания, КонецОбслуживания);
		ЭлементПланировщика.Значение = ЗаявкиНаОбслуживание.Ссылка;
		ЭлементПланировщика.Текст = ЗаявкиНаОбслуживание.ОписаниеПроблемы;
		
	КонецЦикла;
	
	
	
	
КонецПроцедуры