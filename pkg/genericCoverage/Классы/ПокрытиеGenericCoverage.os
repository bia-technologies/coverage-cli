#Использовать "../internal/localization"
#Использовать asserts
#Использовать fs

Перем ДанныеПокрытия;
Перем ЛокализованныеСтроки;

#Область ПрограммныйИнтерфейс

// Добавляет сведения о покрытии строки в текущий отчет.
//
// Параметры:
//   ИмяФайла - Строка - Имя файла программного модуля
//   НомерСтроки - Число - Номер строки в файле для которого устанавливается отметка
//   ЕстьПокрытие - Булево - Отметка о покрытии. Если строка уже покрыта то признак не меняется.
//
Процедура УстановитьПокрытиеСтроки(ИмяФайла, НомерСтроки, ЕстьПокрытие) Экспорт
	
	Утверждения.ПроверитьРавенство(ТипЗнч(ИмяФайла), Тип("Строка"), ЛокализованныеСтроки.УтверждениеИмяФайлаТип);
	Утверждения.ПроверитьРавенство(ТипЗнч(НомерСтроки), Тип("Число"), ЛокализованныеСтроки.УтверждениеНомерСтрокиТип);
	Утверждения.ПроверитьЗаполненность(НомерСтроки, ЛокализованныеСтроки.УтверждениеНомерСтрокиЗаполненность);
	Утверждения.ПроверитьРавенство(ТипЗнч(ЕстьПокрытие), Тип("Булево"), ЛокализованныеСтроки.УтверждениеЕстьПокрытиеТип);
	
	ИмяФайлаНезависимоеОС = ИмяФайлаНезависимоеОС(ИмяФайла);

	ДанныеПокрытияФайла = ДанныеПокрытия.Получить(ИмяФайлаНезависимоеОС);
	
	Если ДанныеПокрытияФайла = Неопределено Тогда
		ДанныеПокрытияФайла = Новый Соответствие;
		ДанныеПокрытия.Вставить(ИмяФайлаНезависимоеОС, ДанныеПокрытияФайла);
	КонецЕсли;
	
	УстановитьПокрытиеСтрокиВнутренний(ДанныеПокрытияФайла, НомерСтроки, ЕстьПокрытие);
	
КонецПроцедуры

// Добавляет сведения о покрытии строк в текущий отчет. Работает аналогично функции УстановитьПокрытиеСтроки.
//
// Параметры:
//   ИмяФайла - Строка - Имя файла программного модуля
//   ПокрытиеСтрок - Массив - Массив структур с данными покрытия
//		* Структура
//			* НомерСтроки - Число - Номер строки в файле для которого устанавливается отметка
//          * ЕстьПокрытие - Булево - Отметка о покрытии. Если строка уже покрыта то признак не меняется.
//
Процедура УстановитьПокрытиеСтрок(ИмяФайла, ПокрытиеСтрок) Экспорт
	
	Утверждения.ПроверитьРавенство(ТипЗнч(ИмяФайла), Тип("Строка"), ЛокализованныеСтроки.УтверждениеИмяФайлаТип);
	Утверждения.ПроверитьРавенство(ТипЗнч(ПокрытиеСтрок), Тип("Массив"), ЛокализованныеСтроки.УтверждениеПокрытиеСтрокТип);
	
	ДанныеПокрытияФайла = ДанныеПокрытия.Получить(ИмяФайла);
	
	Если ДанныеПокрытияФайла = Неопределено Тогда
		ДанныеПокрытияФайла = Новый Соответствие;
		ДанныеПокрытия.Вставить(ИмяФайла, ДанныеПокрытияФайла);
	КонецЕсли;
	
	Для Каждого ПокрытиеСтроки Из ПокрытиеСтрок Цикл
		
		Утверждения.ПроверитьРавенство(ТипЗнч(ПокрытиеСтроки), Тип("Структура"),
			ЛокализованныеСтроки.УтверждениеПокрытиеСтрокиТип);
		
		НомерСтроки = ПокрытиеСтроки.НомерСтроки;
		ЕстьПокрытие = ПокрытиеСтроки.ЕстьПокрытие;
		
		Утверждения.ПроверитьРавенство(ТипЗнч(НомерСтроки), Тип("Число"), ЛокализованныеСтроки.УтверждениеНомерСтрокиТип);
		Утверждения.ПроверитьЗаполненность(НомерСтроки, ЛокализованныеСтроки.УтверждениеНомерСтрокиЗаполненность);
		Утверждения.ПроверитьРавенство(ТипЗнч(ЕстьПокрытие), Тип("Булево"), ЛокализованныеСтроки.УтверждениеЕстьПокрытиеТип);
		
		УстановитьПокрытиеСтрокиВнутренний(ДанныеПокрытияФайла, НомерСтроки, ЕстьПокрытие);
		
	КонецЦикла;
	
КонецПроцедуры

// Получение списка имен программных модулей для которых есть покрытие в текущем отчете.
//
//  Возвращаемое значение:
//   Массив - Список имён программных модулей
//		* Строка - Имя файла программного модуля
//
Функция ПрограммныеМодули() Экспорт
	
	ПокрытыеМодули = Новый Массив;
	Для Каждого ДанныеПокрытияФайла Из ДанныеПокрытия Цикл
		ПокрытыеМодули.Добавить(ДанныеПокрытияФайла.Ключ);
	КонецЦикла;
	
	Возврат ПокрытыеМодули;
	
КонецФункции

// Получение списка покрытых строк для указанного программного модуля
//
// Параметры:
//    ИмяФайла - Строка - Имя файла программного модуля
//
//  Возвращаемое значение:
//   Массив - Список структур с данными покрытия
//		* Стуктура - Данные покрытия
//			* НомерСтроки - Число - Номер строки в файле для которого устанавливается отметка
//          * ЕстьПокрытие - Булево - Отметка о покрытии.
//
Функция СтрокиПрограммныхМодулей(ИмяФайла) Экспорт
	
	Утверждения.ПроверитьРавенство(ТипЗнч(ИмяФайла), Тип("Строка"), ЛокализованныеСтроки.УтверждениеИмяФайлаТип);
	
	Результат = Новый Массив;
	
	ДанныеПокрытияФайла = ДанныеПокрытия.Получить(ИмяФайла);
	Если ДанныеПокрытия = Неопределено Тогда
		Возврат Результат;
	КонецЕсли;
	
	Для Каждого ПокрытиеСтроки1 Из ДанныеПокрытияФайла Цикл
		
		ПокрытиеСтроки = НовоеПокрытиеСтроки();
		ПокрытиеСтроки.НомерСтроки = ПокрытиеСтроки1.Ключ;
		ПокрытиеСтроки.ЕстьПокрытие = ПокрытиеСтроки1.Значение;
		Результат.Добавить(ПокрытиеСтроки);
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Прочитать отчет из файла
//
// Параметры:
//   ФайлGenericCoverage - Строка - XML файл с отчетом genericCoverage
//
Процедура Прочитать(ФайлGenericCoverage) Экспорт
	
	Утверждения.ПроверитьРавенство(ТипЗнч(ФайлGenericCoverage), Тип("Строка"),
		ЛокализованныеСтроки.УтверждениеИмяФайлаТип);
	Утверждения.ПроверитьИстину(ФС.ФайлСуществует(ФайлGenericCoverage),
		ЛокализованныеСтроки.УтверждениеИмяФайлаСуществование);
	
	ДанныеПокрытия = Новый Соответствие;
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.ОткрытьФайл(ФайлGenericCoverage);
	ЧтениеXML.ПерейтиКСодержимому();
	
	ОписаниеТипаБулево = Новый ОписаниеТипов("Булево");
	ОписаниеТипаЧисло = Новый ОписаниеТипов("Число");
	Пока ЧтениеXML.Прочитать() И ЧтениеXML.ЛокальноеИмя = "file" Цикл
		
		SourcePath = ЧтениеXML.ПолучитьАтрибут("path");
		
		ДанныеПокрытияФайла = Новый Соответствие;
		ДанныеПокрытия.Вставить(ИмяФайлаПриЧтении(SourcePath), ДанныеПокрытияФайла);
		
		Пока ЧтениеXML.Прочитать() И ЧтениеXML.ЛокальноеИмя = "lineToCover" Цикл
			
			lineNumber = ОписаниеТипаЧисло.ПривестиЗначение(ЧтениеXML.ПолучитьАтрибут("lineNumber"));
			covered = ОписаниеТипаБулево.ПривестиЗначение(ЧтениеXML.ПолучитьАтрибут("covered"));
			
			УстановитьПокрытиеСтрокиВнутренний(ДанныеПокрытияФайла, lineNumber, covered);
			
		КонецЦикла;
		
	КонецЦикла;
	
	ЧтениеXML.Закрыть();
	
КонецПроцедуры

// Сохранить текущий отчет в файле
//
// Параметры:
//   ФайлGenericCoverage - Строка - Имя формируемого XML-файла
//
Процедура Записать(ФайлGenericCoverage) Экспорт
	
	Утверждения.ПроверитьРавенство(ТипЗнч(ФайлGenericCoverage), Тип("Строка"),
		ЛокализованныеСтроки.УтверждениеИмяФайлаТип);
	
	ЗаписьXML = Новый ЗаписьXML;
	ЗаписьXML.ОткрытьФайл(ФайлGenericCoverage);
	ЗаписьXML.ЗаписатьОбъявлениеXML();
	ЗаписьXML.ЗаписатьНачалоЭлемента("coverage");
	ЗаписьXML.ЗаписатьАтрибут("version", "1");
	
	Для каждого ДанныеПокрытияФайла Из ДанныеПокрытия Цикл
		
		ЗаписьXML.ЗаписатьНачалоЭлемента("file");
		ЗаписьXML.ЗаписатьАтрибут("path", ИмяФайлаДляЗаписи(ДанныеПокрытияФайла.Ключ));
		
		Для Каждого ПокрытиеСтроки Из ДанныеПокрытияФайла.Значение Цикл
			
			ЗаписьXML.ЗаписатьНачалоЭлемента("lineToCover");
			ЗаписьXML.ЗаписатьАтрибут("lineNumber", XMLСтрока(ПокрытиеСтроки.Ключ));
			ЗаписьXML.ЗаписатьАтрибут("covered", XMLСтрока(ПокрытиеСтроки.Значение));
			ЗаписьXML.ЗаписатьКонецЭлемента(); // lineToCover
			
		КонецЦикла;
		
		ЗаписьXML.ЗаписатьКонецЭлемента(); // file
		
	КонецЦикла;
	
	ЗаписьXML.ЗаписатьКонецЭлемента(); // coverage
	ЗаписьXML.Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПриСозданииОбъекта() Экспорт
	ДанныеПокрытия = Новый Соответствие;
	ЛокализованныеСтроки = ЛокализованныеРесурсыПокрытиеGenericCoverage.ЛокализованныеСтроки();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура УстановитьПокрытиеСтрокиВнутренний(ДанныеПокрытияФайла, НомерСтроки, ЕстьПокрытие)
	
	ЕстьПокрытиеСтроки = ДанныеПокрытияФайла.Получить(НомерСтроки);
	Если ЕстьПокрытиеСтроки = Неопределено ИЛИ (ЕстьПокрытиеСтроки = Ложь И ЕстьПокрытие) Тогда
		ДанныеПокрытияФайла.Вставить(НомерСтроки, ЕстьПокрытие);
	КонецЕсли;
	
КонецПроцедуры

Функция НовоеПокрытиеСтроки()
	
	ПокрытиеСтроки = Новый Структура;
	ПокрытиеСтроки.Вставить("НомерСтроки", 0);
	ПокрытиеСтроки.Вставить("ЕстьПокрытие", Ложь);
	
	Возврат ПокрытиеСтроки;
	
КонецФункции

Функция ИмяФайлаДляЗаписи(ИмяФайла)

	Если ПолучитьРазделительПути() = "\" Тогда
		Возврат СтрЗаменить(ИмяФайла, "\", "/");
	Иначе
		Возврат ИмяФайла;
	КонецЕсли;

КонецФункции

Функция ИмяФайлаПриЧтении(ИмяФайла)

	Если ПолучитьРазделительПути() = "\" Тогда
		Возврат СтрЗаменить(ИмяФайла, "/", "\");
	Иначе
		Возврат ИмяФайла;
	КонецЕсли;

КонецФункции

#КонецОбласти