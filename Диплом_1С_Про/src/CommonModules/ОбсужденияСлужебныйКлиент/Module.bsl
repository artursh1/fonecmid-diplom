///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

// @strict-types


#Область СлужебныйПрограммныйИнтерфейс

Функция Подключены() Экспорт
	
	Возврат ОбсужденияСлужебныйВызовСервера.Подключены();
	
КонецФункции

Процедура ПоказатьПодключение(ОписаниеЗавершения = Неопределено) Экспорт
	
	ОткрытьФорму("Обработка.ПодключениеОбсуждений.Форма",,,,,, ОписаниеЗавершения);
	
КонецПроцедуры

Процедура ПоказатьОтключение() Экспорт
	
	Если Не ОбсужденияСлужебныйВызовСервера.Подключены() Тогда 
		ПоказатьПредупреждение(, НСтр("ru = 'Обсуждения уже отключены ранее.'"));
		Возврат;
	КонецЕсли;
	
	Кнопки = Новый СписокЗначений;
	Кнопки.Добавить("Отключить", НСтр("ru = 'Отключить'"));
	Кнопки.Добавить(КодВозвратаДиалога.Нет);
	
	Оповещение = Новый ОписаниеОповещения("ПослеОтветаНаВопросОбОтключении", ЭтотОбъект);
	
	ПоказатьВопрос(Оповещение, НСтр("ru = 'Отключить обсуждения?'"),
		Кнопки,, КодВозвратаДиалога.Нет);
	
КонецПроцедуры

Процедура ПослеЗаписиПользователя(Форма, ОписаниеЗавершения) Экспорт
	
	Если Не Форма.ПредлагатьОбсуждения Тогда
		ВыполнитьОбработкуОповещения(ОписаниеЗавершения);
		Возврат;
	КонецЕсли;
	
	Форма.ПредлагатьОбсуждения = Ложь;
		
	ОповещениеОЗавершении = Новый ОписаниеОповещения("ПредлагатьОбсужденияЗавершение", ЭтотОбъект, ОписаниеЗавершения);
	ПараметрыВопроса = СтандартныеПодсистемыКлиент.ПараметрыВопросаПользователю();
	ПараметрыВопроса.ПредлагатьБольшеНеЗадаватьЭтотВопрос = Истина;
	ПараметрыВопроса.Заголовок = НСтр("ru = 'Обсуждения (система взаимодействий)'");
	СтандартныеПодсистемыКлиент.ПоказатьВопросПользователю(ОповещениеОЗавершении, Форма.ПредлагатьОбсужденияТекст,
		РежимДиалогаВопрос.ДаНет, ПараметрыВопроса);
	
КонецПроцедуры

Процедура ПриПолученииФормыВыбораПользователейСистемыВзаимодействия(НазначениеВыбора, Форма, ИдентификаторОбсуждения, Параметры, ВыбраннаяФорма, СтандартнаяОбработка) Экспорт

	Параметры.Вставить("ВыборУчастниковОбсуждения", Истина);
	Параметры.Вставить("РежимВыбора", Истина);
	Параметры.Вставить("ЗакрыватьПриВыборе", Ложь);
	Параметры.Вставить("МножественныйВыбор", Истина);
	Параметры.Вставить("РасширенныйПодбор", Истина);
	Параметры.Вставить("ВыбранныеПользователи", Новый Массив);
	Параметры.Вставить("ЗаголовокФормыПодбора", НСтр("ru='Участники обсуждения'"));
	
	СтандартнаяОбработка = Ложь;
	
	ВыбраннаяФорма = "Справочник.Пользователи.ФормаВыбора";

КонецПроцедуры

Процедура ПоказатьНастройкуИнтеграцииСВнешнимиСистемами() Экспорт
	ОткрытьФорму("Обработка.ПодключениеОбсуждений.Форма.НастройкиСообщенийИзДругихПрограмм",,ЭтотОбъект);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура НачатьПодборУчастниковОбсуждения(Элемент) Экспорт
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("РежимВыбора", Истина);
	ПараметрыФормы.Вставить("ЗакрыватьПриВыборе", Ложь);
	ПараметрыФормы.Вставить("МножественныйВыбор", Истина);
	ПараметрыФормы.Вставить("РасширенныйПодбор", Истина);
	ПараметрыФормы.Вставить("ВыбранныеПользователи", Новый Массив);
	ПараметрыФормы.Вставить("ЗаголовокФормыПодбора", НСтр("ru='Участники обсуждения'"));
	
	ОткрытьФорму("Справочник.Пользователи.ФормаВыбора", ПараметрыФормы,Элемент,,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

Процедура ПоказатьИнформациюОбИнтеграции(Форма, ОписаниеИнтеграции, ОповещениеОбИзмененииИнтеграции) Экспорт

	Оповещение = Новый ОписаниеОповещения("СозданиеИнтеграцииЗавершение", ЭтотОбъект,
		Новый Структура("Оповещение", ОповещениеОбИзмененииИнтеграции));
		
	ТипыИнтеграции = ОбсужденияСлужебныйКлиентСервер.ТипыВнешнихСистем();
	ИмяФормы = "Обработка.ПодключениеОбсуждений.Форма";
	Если ОписаниеИнтеграции.Тип = ТипыИнтеграции.ВКМ_Телеграм Тогда
		ИмяФормы = ИмяФормы + ".СозданиеБотаТелеграм";
	ИначеЕсли ОписаниеИнтеграции.Тип = ТипыИнтеграции.ВКонтакте Тогда	
		ИмяФормы = ИмяФормы + ".СозданиеБотаВКонтакте";
	КонецЕсли;
		
	ОткрытьФорму(ИмяФормы,
		ОписаниеИнтеграции,
		Форма,,,,
		Оповещение,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура СозданиеИнтеграцииЗавершение(Результат, ДополнительныеПараметры) Экспорт

	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(ДополнительныеПараметры.Оповещение, Истина);

КонецПроцедуры

Процедура ПослеОтветаНаВопросОбОтключении(КодВозврата, Контекст) Экспорт
	
	Если КодВозврата = "Отключить" Тогда 
		ПриОтключении();
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриОтключении()
	
	Оповещение = Новый ОписаниеОповещения("ПослеУспешногоОтключения", ЭтотОбъект,,
		"ПриОбработкеОшибкиОтключения", ЭтотОбъект);
	
	Попытка
		СистемаВзаимодействия.НачатьОтменуРегистрацииИнформационнойБазы(Оповещение);
	Исключение
		ПриОбработкеОшибкиОтключения(ИнформацияОбОшибке(), Ложь, Неопределено);
	КонецПопытки;
	
КонецПроцедуры

Процедура ПослеУспешногоОтключения(Контекст) Экспорт
	
	Оповестить("ОбсужденияПодключены", Ложь);
	
КонецПроцедуры

Процедура ПриОбработкеОшибкиОтключения(ИнформацияОбОшибке, СтандартнаяОбработка, Контекст) Экспорт 
	
	СтандартнаяОбработка = Ложь;
	
	ЖурналРегистрацииКлиент.ДобавитьСообщениеДляЖурналаРегистрации(
		НСтр("ru = 'Обсуждения.Ошибка отмены регистрации информационной базы'",
			ОбщегоНазначенияКлиент.КодОсновногоЯзыка()),
		"Ошибка",
		ПодробноеПредставлениеОшибки(ИнформацияОбОшибке),, Истина);
	
	ПоказатьИнформациюОбОшибке(ИнформацияОбОшибке);
	
КонецПроцедуры

Процедура ПредлагатьОбсужденияЗавершение(Результат, ОписаниеЗавершения) Экспорт
	
	Если Результат = Неопределено Тогда
		ВыполнитьОбработкуОповещения(ОписаниеЗавершения);
		Возврат;
	КонецЕсли;
	
	Если Результат.БольшеНеЗадаватьЭтотВопрос Тогда
		ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекСохранить("НастройкиПрограммы", "ПредлагатьОбсуждения", Ложь);
	КонецЕсли;
	
	Если Результат.Значение = КодВозвратаДиалога.Да Тогда
		ПоказатьПодключение();
		Возврат;
	КонецЕсли;
	ВыполнитьОбработкуОповещения(ОписаниеЗавершения);
	
КонецПроцедуры

#КонецОбласти