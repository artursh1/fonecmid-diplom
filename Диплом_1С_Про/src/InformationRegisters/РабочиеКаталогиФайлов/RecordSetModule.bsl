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

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Количество() = 1 Тогда
		Папка = Получить(0).Папка;
		Путь = Получить(0).Путь;
		
		Если ПустаяСтрока(Путь) Тогда
			Возврат;
		КонецЕсли;						
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	ПапкиФайлов.Ссылка,
			|	ПапкиФайлов.Наименование
			|ИЗ
			|	Справочник.ПапкиФайлов КАК ПапкиФайлов
			|ГДЕ
			|	ПапкиФайлов.Родитель = &Ссылка";
		
		Запрос.УстановитьПараметр("Ссылка", Папка);
		
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		Пока Выборка.Следующий() Цикл
			
			РабочийКаталог = Путь;
			// Добавляем слэш в конце, если его нет - того же типа, что уже был - т.к. он нужен на клиенте, 
			//  а ПередЗаписью исполняется на сервере.
			РабочийКаталог = ОбщегоНазначенияКлиентСервер.ДобавитьКонечныйРазделительПути(РабочийКаталог);
			
			РабочийКаталог = РабочийКаталог + Выборка.Наименование;
			РабочийКаталог = ОбщегоНазначенияКлиентСервер.ДобавитьКонечныйРазделительПути(РабочийКаталог);
			
			РаботаСФайламиСлужебныйВызовСервера.СохранитьРабочийКаталогПапки(
				Выборка.Ссылка, РабочийКаталог);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли