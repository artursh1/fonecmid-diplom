
&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	ДатаПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ДатаПриИзмененииНаСервере()
	
	Сообщение = Справочники.ВКМ_УведомленияТелеграмБоту.СоздатьЭлемент();
	Сообщение.ТекстСообщения = СтрШаблон("Изменена дата документа № %1, дата %2", 
			Объект.Номер, Объект.Дата);
	Сообщение.Записать();

КонецПроцедуры

&НаКлиенте
Процедура ВремяНачалаРаботПланПриИзменении(Элемент)
	ВремяНачалаРаботПланПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ВремяНачалаРаботПланПриИзмененииНаСервере()
	
	Сообщение = Справочники.ВКМ_УведомленияТелеграмБоту.СоздатьЭлемент();
	Сообщение.ТекстСообщения = СтрШаблон("Изменено время начала работ в документе № %1, дата %2", 
			Объект.Номер, Объект.Дата);
	Сообщение.Записать();

КонецПроцедуры

&НаКлиенте
Процедура ВремяОкончанияРаботПланПриИзменении(Элемент)
	ВремяОкончанияРаботПланПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ВремяОкончанияРаботПланПриИзмененииНаСервере()
	
	Сообщение = Справочники.ВКМ_УведомленияТелеграмБоту.СоздатьЭлемент();
	Сообщение.ТекстСообщения = СтрШаблон("Изменено время окончания работ в документе № %1, дата %2", 
			Объект.Номер, Объект.Дата);
	Сообщение.Записать();

КонецПроцедуры

&НаКлиенте
Процедура СпециалистПриИзменении(Элемент)
	СпециалистПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура СпециалистПриИзмененииНаСервере()
	
	Сообщение = Справочники.ВКМ_УведомленияТелеграмБоту.СоздатьЭлемент();
	Сообщение.ТекстСообщения = СтрШаблон("Изменен специалист в документе № %1, дата %2", 
			Объект.Номер, Объект.Дата);
	Сообщение.Записать();

КонецПроцедуры

#Область ОписаниеПеременных

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды

КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
    
    Оповестить("Запись_ВКМ_ОбслуживаниеКлиента", , Объект.Ссылка);

КонецПроцедуры





#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы //<ИмяТаблицыФормы>

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды

&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
    
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
    
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)

    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);

КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()

    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);

КонецПроцедуры

// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти
