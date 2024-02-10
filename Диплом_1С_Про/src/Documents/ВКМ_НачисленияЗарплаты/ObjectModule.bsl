#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
		
	Если Начисления.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;    
	
	МинимальнаяДатаНачала = Неопределено;
	МаксимальнаяДатаОкончания = Неопределено;
	
	Для Каждого Строка Из Начисления Цикл
		
			Если Не ЗначениеЗаполнено(МинимальнаяДатаНачала)
				Или МинимальнаяДатаНачала > Строка.ДатаНачала Тогда
				МинимальнаяДатаНачала = Строка.ДатаНачала;
			КонецЕсли;
			Если Не ЗначениеЗаполнено(МаксимальнаяДатаОкончания)
				Или МаксимальнаяДатаОкончания < Строка.ДатаОкончания Тогда
				МаксимальнаяДатаОкончания = Строка.ДатаОкончания;
			КонецЕсли;		
				
	КонецЦикла;
	
	Запрос = Новый Запрос;
	Запрос.Текст =	"ВЫБРАТЬ
	              	|	ВКМ_НачисленияЗарплатыНачисления.Сотрудник КАК Сотрудник,
	              	|	ВКМ_НачисленияЗарплатыНачисления.ВидРасчета КАК ВидРасчета,
	              	|	ВКМ_НачисленияЗарплатыНачисления.ДатаНачала КАК ДатаНачала,
	              	|	ВКМ_НачисленияЗарплатыНачисления.ДатаОкончания КАК ДатаОкончания,
	              	|	ВКМ_НачисленияЗарплатыНачисления.ГрафикРаботы КАК ГрафикРаботы
	              	|ПОМЕСТИТЬ ВТ_ДанныеДокумента
	              	|ИЗ
	              	|	Документ.ВКМ_НачисленияЗарплаты.Начисления КАК ВКМ_НачисленияЗарплатыНачисления
	              	|ГДЕ
	              	|	ВКМ_НачисленияЗарплатыНачисления.Ссылка = &Ссылка
	              	|;
	              	|
	              	|////////////////////////////////////////////////////////////////////////////////
	              	|ВЫБРАТЬ
	              	|	ВКМ_УсловияОплатыСотрудниковСрезПоследних.Оклад КАК Оклад,
	              	|	ВКМ_УсловияОплатыСотрудниковСрезПоследних.ПроцентОтРабот КАК ПроцентОтРабот,
	              	|	ВКМ_УсловияОплатыСотрудниковСрезПоследних.Сотрудник КАК Сотрудник
	              	|ПОМЕСТИТЬ ВТ_ОкладПроцент
	              	|ИЗ
	              	|	РегистрСведений.ВКМ_УсловияОплатыСотрудников.СрезПоследних(
	              	|			&ДатаНачала,
	              	|			Сотрудник В
	              	|				(ВЫБРАТЬ
	              	|					ВТ_ДанныеДокумента.Сотрудник КАК Сотрудник
	              	|				ИЗ
	              	|					ВТ_ДанныеДокумента КАК ВТ_ДанныеДокумента)) КАК ВКМ_УсловияОплатыСотрудниковСрезПоследних
	              	|;
	              	|
	              	|////////////////////////////////////////////////////////////////////////////////
	              	|ВЫБРАТЬ
	              	|	ВКМ_ВыполненныеСотрудникомРаботыОбороты.СуммаКОплатеОборот КАК СуммаКОплатеОборот,
	              	|	ВКМ_ВыполненныеСотрудникомРаботыОбороты.Сотрудник КАК Сотрудник
	              	|ПОМЕСТИТЬ ВТ_ПроцентОтРабот
	              	|ИЗ
	              	|	РегистрНакопления.ВКМ_ВыполненныеСотрудникомРаботы.Обороты(
	              	|			&ДатаНачала,
	              	|			&ДатаОкончания,
	              	|			,
	              	|			Сотрудник В
	              	|				(ВЫБРАТЬ
	              	|					ВТ_ДанныеДокумента.Сотрудник КАК Сотрудник
	              	|				ИЗ
	              	|					ВТ_ДанныеДокумента КАК ВТ_ДанныеДокумента)) КАК ВКМ_ВыполненныеСотрудникомРаботыОбороты
	              	|;
	              	|
	              	|////////////////////////////////////////////////////////////////////////////////
	              	|ВЫБРАТЬ
	              	|	ВТ_ДанныеДокумента.Сотрудник КАК Сотрудник,
	              	|	ВТ_ДанныеДокумента.ВидРасчета КАК ВидРасчета,
	              	|	ВТ_ДанныеДокумента.ДатаНачала КАК ДатаНачала,
	              	|	ВТ_ДанныеДокумента.ДатаОкончания КАК ДатаОкончания,
	              	|	ВЫБОР
	              	|		КОГДА ВТ_ДанныеДокумента.ВидРасчета = ЗНАЧЕНИЕ(ПланВидовРасчета.ВКМ_ОсновныеНачисления.Оклад)
	              	|			ТОГДА ВТ_ОкладПроцент.Оклад
	              	|		КОГДА ВТ_ДанныеДокумента.ВидРасчета = ЗНАЧЕНИЕ(ПланВидовРасчета.ВКМ_ОсновныеНачисления.ПроцентОтРабот)
	              	|			ТОГДА ВТ_ОкладПроцент.ПроцентОтРабот
	              	|		ИНАЧЕ НЕОПРЕДЕЛЕНО
	              	|	КОНЕЦ КАК Показатель,
	              	|	ВТ_ДанныеДокумента.ГрафикРаботы КАК ГрафикРаботы,
	              	|	-ВТ_ПроцентОтРабот.СуммаКОплатеОборот КАК СуммаПроцентовЗаРаботу
	              	|ИЗ
	              	|	ВТ_ДанныеДокумента КАК ВТ_ДанныеДокумента
	              	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ОкладПроцент КАК ВТ_ОкладПроцент
	              	|		ПО ВТ_ДанныеДокумента.Сотрудник = ВТ_ОкладПроцент.Сотрудник
	              	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ПроцентОтРабот КАК ВТ_ПроцентОтРабот
	              	|		ПО ВТ_ДанныеДокумента.Сотрудник = ВТ_ПроцентОтРабот.Сотрудник";
	
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("ДатаНачала", МинимальнаяДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания", МаксимальнаяДатаОкончания);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл 
		
		Движение = Движения.ВКМ_ОсновныеНачисления.Добавить();
		Движение.ПериодРегистрации = Дата;
		Движение.ВидРасчета = Выборка.ВидРасчета;
		Движение.Сотрудник = Выборка.Сотрудник;
		Движение.ПериодДействияНачало = Выборка.ДатаНачала;
		Движение.ПериодДействияКонец = Выборка.ДатаОкончания;
		Движение.ДнейОтработано = (Движение.ПериодДействияКонец - Движение.ПериодДействияНачало)/86400 + 1;
		Движение.Показатель = Выборка.Показатель;
		Движение.ГрафикРаботы = Выборка.ГрафикРаботы; 
						
		Если Движение.ВидРасчета = ПланыВидовРасчета.ВКМ_ОсновныеНачисления.Отпускные Тогда
			Движение.БазовыйПериодНачало = НачалоМесяца(ДобавитьМесяц(Движение.ПериодДействияНачало, - 12));
			Движение.БазовыйПериодКонец = КонецМесяца(ДобавитьМесяц(Движение.БазовыйПериодНачало, 11)); 
			Движение.ДнейОтработано = (Движение.ПериодДействияКонец - Движение.ПериодДействияНачало)/86400 + 1;
			Движение.Показатель = Неопределено;
		КонецЕсли;
		
		Если Движение.ВидРасчета = ПланыВидовРасчета.ВКМ_ОсновныеНачисления.ПроцентОтРабот Тогда
			Движение.Показатель = Выборка.Показатель;
			Движение.Сумма = Выборка.СуммаПроцентовЗаРаботу;
			Движение.ДнейОтработано = Неопределено; 
		КонецЕсли; 
		 									
	КонецЦикла;
    	
	СформироватьСторноЗаписи();
	
	Движения.ВКМ_ОсновныеНачисления.Записать();
	Движения.ВКМ_Удержания.Записать();
		
	РасчитатьОклад();  
	
	РасчитатьОтпускные(); 
	
	СформироватьДвиженияУдержанияИВзаиморасчеты();
	
	Движения.ВКМ_Удержания.Записать(); 
	Движения.ВКМ_ВзаиморасчетыССотрудниками.Записать();
	    	
КонецПроцедуры

# КонецОбласти

# Область СлужебныеПроцедурыИФункции

Процедура СформироватьСторноЗаписи()
	
	СторноЗаписи = Движения.ВКМ_ОсновныеНачисления.ПолучитьДополнение();
	
	Для Каждого Запись Из СторноЗаписи Цикл
		
		Движение = Движения.ВКМ_ОсновныеНачисления.Добавить();
		ЗаполнитьЗначенияСвойств(Движение, Запись);
		Движение.ПериодРегистрации = Дата;
		Движение.ПериодДействияНачало = Запись.ПериодДействияНачалоСторно;
		Движение.ПериодДействияКонец = Запись.ПериодДействияКонецСторно;
		Движение.Сторно = Истина;
		
	КонецЦикла;
	
КонецПроцедуры


Процедура 	РасчитатьОклад()  
    		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияДанныеГрафика.ЗначениеПериодДействия, 0) КАК ПланЧасов,
		|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияДанныеГрафика.ЗначениеФактическийПериодДействия, 0) КАК ФактЧасов,
		|	ВКМ_ОсновныеНачисленияДанныеГрафика.Сотрудник КАК Сотрудник,
		|	ВКМ_ОсновныеНачисленияДанныеГрафика.ВидРасчета КАК ВидРасчета,
		|	ВКМ_ОсновныеНачисленияДанныеГрафика.НомерСтроки КАК НомерСтроки
		|ИЗ
		|	РегистрРасчета.ВКМ_ОсновныеНачисления.ДанныеГрафика(
		|			ВидРасчета = ЗНАЧЕНИЕ(ПланВидовРасчета.ВКМ_ОсновныеНачисления.Оклад)
		|				И Регистратор = &Ссылка) КАК ВКМ_ОсновныеНачисленияДанныеГрафика";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		Движение = Движения.ВКМ_ОсновныеНачисления[Выборка.НомерСтроки - 1];
		Движение.Сумма = Движение.Показатель * Выборка.ФактЧасов / Выборка.ПланЧасов;
        Движение.ДнейОтработано = Выборка.ФактЧасов; 
							
		Если Движение.Сторно Тогда
			Движение.Сумма = - Движение.Сумма;
			Движение.ДнейОтработано = - Движение.ДнейОтработано;
		КонецЕсли; 
	КонецЦикла;	
	
	Движения.ВКМ_ОсновныеНачисления.Записать(, Истина);
		
КонецПроцедуры

Процедура   РасчитатьОтпускные()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВКМ_ОсновныеНачисления.НомерСтроки КАК НомерСтроки,
		|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления.ДнейОтработано, 0) КАК ДнейОтпуска,
		|	ВКМ_ОсновныеНачисления.Сотрудник КАК Сотрудник,
		|	ВКМ_ОсновныеНачисления.ВидРасчета КАК ВидРасчета,
		|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления.СуммаБаза, 0) КАК СуммаНачислений12мес,
		|	ЕСТЬNULL(ВКМ_ОсновныеНачисленияДанныеГрафика.ЗначениеБазовыйПериод, 0) КАК ФактДней12мес
		|ИЗ
		|	РегистрРасчета.ВКМ_ОсновныеНачисления КАК ВКМ_ОсновныеНачисления
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ВКМ_ОсновныеНачисления.БазаВКМ_ОсновныеНачисления(
		|				&Измерения,
		|				&Измерения,
		|				,
		|				ВидРасчета = &Отпуск
		|					И Регистратор = &Ссылка) КАК ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления
		|		ПО ВКМ_ОсновныеНачисления.НомерСтроки = ВКМ_ОсновныеНачисленияБазаВКМ_ОсновныеНачисления.НомерСтроки
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрРасчета.ВКМ_ОсновныеНачисления.ДанныеГрафика(
		|				ВидРасчета = &Отпуск
		|					И Регистратор = &Ссылка) КАК ВКМ_ОсновныеНачисленияДанныеГрафика
		|		ПО ВКМ_ОсновныеНачисления.НомерСтроки = ВКМ_ОсновныеНачисленияДанныеГрафика.НомерСтроки
		|ГДЕ
		|	ВКМ_ОсновныеНачисления.ВидРасчета = &Отпуск
		|	И ВКМ_ОсновныеНачисления.Регистратор = &Ссылка";    
	
	Измерения = Новый Массив;
	Измерения.Добавить("Сотрудник");
	
	Запрос.УстановитьПараметр("Измерения", Измерения);
	Запрос.УстановитьПараметр("Отпуск", ПланыВидовРасчета.ВКМ_ОсновныеНачисления.Отпускные);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		Движение = Движения.ВКМ_ОсновныеНачисления[Выборка.НомерСтроки - 1];
		Движение.Показатель = ?(Выборка.ФактДней12мес = 0, 0, Выборка.СуммаНачислений12мес / Выборка.ФактДней12мес);
		СуммаОтпускных = Движение.Показатель * Выборка.ДнейОтпуска; 
		Движение.Сумма = СуммаОтпускных;
	КонецЦикла;
	
	Движения.ВКМ_ОсновныеНачисления.Записать(, Истина);
		
КонецПроцедуры

Процедура СформироватьДвиженияУдержанияИВзаиморасчеты() 
		 	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВКМ_ОсновныеНачисления.ВидРасчета КАК ВидРасчета,
		|	ВКМ_ОсновныеНачисления.Сторно КАК Сторно,
		|	ВКМ_ОсновныеНачисления.Сотрудник КАК Сотрудник,
		|	ВКМ_ОсновныеНачисления.Сумма КАК Сумма
		|ИЗ
		|	РегистрРасчета.ВКМ_ОсновныеНачисления КАК ВКМ_ОсновныеНачисления
		|ГДЕ
		|	ВКМ_ОсновныеНачисления.Регистратор = &Ссылка
		|ИТОГИ
		|	СУММА(Сумма)
		|ПО
		|	Сотрудник";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	ВидРасчетаУд = ПланыВидовРасчета.ВКМ_Удержания.НДФЛ;
    
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаСотрудник = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам,"Сотрудник");
	
	Пока ВыборкаСотрудник.Следующий() Цикл  
		//взаиморасчеты
		Движение = Движения.ВКМ_ВзаиморасчетыССотрудниками.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Сотрудник = ВыборкаСотрудник.Сотрудник;
		Движение.Сумма = ВыборкаСотрудник.Сумма * 87 / 100;
       
		Выборка = ВыборкаСотрудник.Выбрать(); 
		Пока Выборка.Следующий() Цикл 
		    //удержания
			Движение = Движения.ВКМ_Удержания.Добавить();
			Движение.Сторно = Выборка.Сторно;
			Движение.ВидРасчета = ВидРасчетаУд;
			Движение.ПериодРегистрации = Дата;
			Движение.Сотрудник = Выборка.Сотрудник;
			Движение.Сумма = Выборка.Сумма * 13 / 100;
			Движение.База = Выборка.ВидРасчета;
	
		КонецЦикла;
	КонецЦикла;	
	
	
	
	КонецПроцедуры
	
#КонецОбласти
		




