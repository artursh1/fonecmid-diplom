///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

// @strict-types


#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	
	Элементы.ПоказыватьПерсональныеУчетныеЗаписиПользователей.Видимость = Пользователи.ЭтоПолноправныйПользователь();
	
	ПереключитьВидимостьПерсональныхУчетныхЗаписей(Список,
		ПоказыватьПерсональныеУчетныеЗаписиПользователей,
		Пользователи.ТекущийПользователь());
	
	ПереключитьВидимостьНедействительныхУчетныхЗаписей(Список, ПоказыватьНедействительные);
	Элементы.ВладелецУчетнойЗаписи.Видимость = ПоказыватьПерсональныеУчетныеЗаписиПользователей;
	Элементы.ПоказыватьНедействительные.Доступность = ПоказыватьПерсональныеУчетныеЗаписиПользователей;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКоманды = ОбщегоНазначения.ОбщийМодуль("ПодключаемыеКоманды");
		МодульПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПоказыватьПерсональныеУчетныеЗаписиПользователейПриИзменении(Элемент)
	
	ПереключитьВидимостьПерсональныхУчетныхЗаписей(Список,
		ПоказыватьПерсональныеУчетныеЗаписиПользователей,
		ПользователиКлиент.ТекущийПользователь());
	
	Элементы.ВладелецУчетнойЗаписи.Видимость = ПоказыватьПерсональныеУчетныеЗаписиПользователей;
	Элементы.ПоказыватьНедействительные.Доступность = ПоказыватьПерсональныеУчетныеЗаписиПользователей;
	
	ПоказыватьНедействительные = ПоказыватьНедействительные И ПоказыватьПерсональныеУчетныеЗаписиПользователей;
	ПереключитьВидимостьНедействительныхУчетныхЗаписей(Список, ПоказыватьНедействительные);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьНедействительныеПриИзменении(Элемент)
	ПереключитьВидимостьНедействительныхУчетныхЗаписей(Список, ПоказыватьНедействительные);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)

	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКомандыКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиент");
		МодульПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКомандыКлиентСервер = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиентСервер");
		МодульПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
	КонецЕсли;
КонецПроцедуры


&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКоманды = ОбщегоНазначения.ОбщийМодуль("ПодключаемыеКоманды");
		МодульПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Элементы.Список);
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры


&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКомандыКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиент");
		МодульПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Элементы.Список);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти



#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура ПереключитьВидимостьПерсональныхУчетныхЗаписей(Список, ПоказыватьПерсональныеУчетныеЗаписиПользователей, ТекущийПользователь)
	СписокПользователей = Новый Массив;
	СписокПользователей.Добавить(ПредопределенноеЗначение("Справочник.Пользователи.ПустаяСсылка"));
	СписокПользователей.Добавить(ТекущийПользователь);
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список, "ВладелецУчетнойЗаписи", СписокПользователей, ВидСравненияКомпоновкиДанных.ВСписке, ,
			Не ПоказыватьПерсональныеУчетныеЗаписиПользователей);
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ПереключитьВидимостьНедействительныхУчетныхЗаписей(Список, ПоказыватьНедействительные)
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список, "ВладелецНедействителен", Ложь, ВидСравненияКомпоновкиДанных.Равно, ,
			Не ПоказыватьНедействительные);
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	Список.УсловноеОформление.Элементы.Очистить();
	Элемент = Список.УсловноеОформление.Элементы.Добавить();
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ВладелецНедействителен");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ТекстЗапрещеннойЯчейкиЦвет);
	
КонецПроцедуры

#КонецОбласти