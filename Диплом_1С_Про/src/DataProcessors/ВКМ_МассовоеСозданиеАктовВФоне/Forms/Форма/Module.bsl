// @strict-types

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СоздатьДокументыРеализации(Команда)
	
	// 1. Запуск фонового задания на сервере.
 	ДлительнаяОперация = НачатьСозданиеДокументовРеализацииНаСервере();
 
	 // 2. Подключение обработчика завершения фонового задания.
 	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
 	ОповещениеОЗавершении = Новый ОписаниеОповещения("ПриЗавершенииСозданияДокументовРеализации", ЭтотОбъект);
 	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, ОповещениеОЗавершении, ПараметрыОжидания);	
		
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции


&НаСервере
Функция НачатьСозданиеДокументовРеализацииНаСервере()
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияФункции(УникальныйИдентификатор);
 	Возврат ДлительныеОперации.ВыполнитьФункцию(ПараметрыВыполнения, 
 		"Обработки.ВКМ_МассовоеСозданиеАктовВФоне.ВыполнитьМассовоеСозданиеАктов", 
 		Объект.Период.ДатаНачала, Объект.Период.ДатаОкончания);
	
КонецФункции


&НаКлиенте
Процедура ПриЗавершенииСозданияДокументовРеализации(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда // Пользователь отменил задание.
		Возврат;
	КонецЕсли;
 
	СписокРеализацийМассив = ПолучитьИзВременногоХранилища(Результат.АдресРезультата);
	ЗаполнитьСписокРеализаций(СписокРеализацийМассив);
	
КонецПроцедуры

&НаКлиенте
Процедура  ЗаполнитьСписокРеализаций(СписокРеализацийМассив);
	
	Объект.СписокРеализаций.Очистить(); 
	
	Для Каждого СписокСтруктура Из СписокРеализацийМассив Цикл 
		
		НоваяСтрока = Объект.СписокРеализаций.Добавить();
		НоваяСтрока.Договор = СписокСтруктура.Договор;       
		НоваяСтрока.РеализацияПоДоговору = СписокСтруктура.Реализация;
		
	КонецЦикла;
	
КонецПроцедуры


#КонецОбласти
