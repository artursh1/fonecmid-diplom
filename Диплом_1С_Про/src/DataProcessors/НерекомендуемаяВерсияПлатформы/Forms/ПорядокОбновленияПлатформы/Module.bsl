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
	
	ИмяМакета = ?(ОбщегоНазначения.ИнформационнаяБазаФайловая(), 
		"ПорядокОбновленияДляФайловойБазы", "ПорядокОбновленияДляКлиентСервернойБазы");
	
	КоллекцияМакетов = Метаданные.Обработки.НерекомендуемаяВерсияПлатформы.Макеты;
	
	ЛокализованноеИмяМакета = ИмяМакета + "_" + ТекущийЯзык().КодЯзыка;
	Макет                   = КоллекцияМакетов.Найти(ЛокализованноеИмяМакета);
	
	Если Макет = Неопределено Тогда
		ЛокализованноеИмяМакета = ИмяМакета + "_" + ОбщегоНазначения.КодОсновногоЯзыка();
		Макет                   = КоллекцияМакетов.Найти(ЛокализованноеИмяМакета);
	КонецЕсли;
	
	Если Макет = Неопределено Тогда
		ЛокализованноеИмяМакета = ИмяМакета;
	КонецЕсли;
	
	МакетПорядокОбновления = Обработки.НерекомендуемаяВерсияПлатформы.ПолучитьМакет(ЛокализованноеИмяМакета);
	
	ПорядокОбновленияПлатформы = МакетПорядокОбновления.ПолучитьТекст();
	
	Если ПустаяСтрока(ПорядокОбновленияПлатформы) Тогда
		МакетПорядокОбновления.КодЯзыкаМакета = ОбщегоНазначения.КодОсновногоЯзыка();
		ПорядокОбновленияПлатформы = МакетПорядокОбновления.ПолучитьТекст();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПорядокОбновленияПрограммыПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	Если ДанныеСобытия.Href <> Неопределено Тогда
		СтандартнаяОбработка = Ложь;
		ФайловаяСистемаКлиент.ОткрытьНавигационнуюСсылку(ДанныеСобытия.Href);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПечатьИнструкции(Команда)
	Элементы.ПорядокОбновленияПлатформы.Документ.execCommand("Print");
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПорядокОбновленияПрограммыДокументСформирован(Элемент)
	// Видимость команды печати
	Если Не Элемент.Документ.queryCommandSupported("Print") Тогда
		Элементы.ПечатьИнструкции.Видимость = Ложь;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти