///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

// @strict-types


#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий
		
Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	ПредыдущееЗначение = 	Константы.ПутьКТомуБезУчетаРегиональныхНастроек.Получить();
	
	Если ПредыдущееЗначение <> Значение 
			И РаботаСФайламиВТомахСлужебный.ЕстьТомаХраненияФайлов() Тогда
		
		ОбщегоНазначения.СообщитьПользователю(
			НСтр("ru='Изменение способа формирования пути к тому запрещено. Есть файлы в томах.'"),
			,,,Отказ);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли