
#Использовать 1commands

Перем Лог;

#Область КомандаПриложения

Процедура ОписаниеКоманды(Команда) Экспорт

	Команда.Опция("i infobase", , "Имя предмета отладки")
		.ТСтрока()
		.Обязательный();

	Команда.Опция("o output", , "Файл с результатами отладки в формате csv")
		.ТСтрока()
		.Обязательный();

	Команда.Опция("u debugger", , "Сервер отладки")
		.ТСтрока();
	
	Команда.Опция("p password", , "Пароль на сервере отладки")
		.ТСтрока()
		.ВОкружении("DBGS_PASSWORD");

	Команда.Опция("t timeout", , "Таймаут итерации")
		.ТЧисло();

	Команда.Опция("a areaname", , "Пространство имен отладки")
		.ТСтрока();

КонецПроцедуры

Процедура ВыполнитьКоманду(Знач Команда) Экспорт
	
	Лог = ПараметрыПриложения.Лог();
	Если Команда.ЗначениеОпции("debug") Тогда
		ПараметрыПриложения.ВключитьРежимОтладки();
	КонецЕсли;

	ПутьМодуляEDT = РасположениеEDT();

	ИдентификаторПроцесса = ЗапуститьПроцессПокрытия(Команда, ПутьМодуляEDT);

	Лог.Отладка(СтрШаблон("Идентификатор процесса покрытия: %1", ИдентификаторПроцесса));

	СоздатьPIDФайл(ИдентификаторПроцесса);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция РасположениеEDT()

	ПеременныеСредыКоманды = Новый Соответствие;
	ПеременныеСредыКоманды.Вставить("JAVA_TOOL_OPTIONS", "-Dfile.encoding=UTF-8");

	Команда = Новый Команда();
	Команда.УстановитьПеременныеСреды(ПеременныеСредыКоманды);
	Команда.УстановитьКодировкуВывода(КодировкаТекста.UTF8);
	Команда.УстановитьСтрокуЗапуска("ring edt locations list 2>nul");
	КодВозврата = Команда.Исполнить();
	ВыводКоманды = Команда.ПолучитьВывод();
	
	Если КодВозврата < 0 Тогда
		ВызватьИсключение "Ошибка вызова модуля ring:
			|" + ВыводКоманды;
	КонецЕсли;

	МассивРасположенийEDT = СтрРазделить(ВыводКоманды, Символы.ПС, Ложь);
	РасположениеEDT = Неопределено;
	МаскаПлагинов = ОбъединитьПути("plugins", "com._1c.g5.v8.dt.debug*.jar");
	Для Каждого СтрокаРасположениеEDT Из МассивРасположенийEDT Цикл
		
		ЧистаяСтрокаРасположениеEDT = СокрЛП(СтрокаРасположениеEDT);
		Если НайтиФайлы(ЧистаяСтрокаРасположениеEDT, МаскаПлагинов).Количество() > 0 Тогда
			РасположениеEDT = ЧистаяСтрокаРасположениеEDT;
			Прервать;
		КонецЕсли;	

	КонецЦикла;

	Если РасположениеEDT = Неопределено Тогда
		ТекстСообщения = "Не найдено расположение EDT";
		Лог.Ошибка(ТекстСообщения);
		ВызватьИсключение ТекстСообщения;
	Иначе
		Лог.Отладка(СтрШаблон("Путь модуля EDT: %1", РасположениеEDT));
	КонецЕсли;

	Возврат РасположениеEDT;

КонецФункции

Функция ЗапуститьПроцессПокрытия(Команда, ПутьМодуляEDT)
	
	ПредметОтладки = Команда.ЗначениеОпции("infobase");
	ИмяФайла       = Команда.ЗначениеОпции("output");
	СерверОтладки  = Команда.ЗначениеОпции("debugger");
	ПарольОтладки  = Команда.ЗначениеОпции("password");
	Таймаут        = Команда.ЗначениеОпции("timeout");

	КаталогПриложения = ПараметрыПриложения.КаталогПриложения();

	ПутьКлассовEDT      = ОбъединитьПути(ПутьМодуляEDT, "plugins", "*");
	ПутьКлассовCoverage = ОбъединитьПути(КаталогПриложения, "vendor", "Coverage41C", "lib");
	ПутьКлассовCoverage = ОбъединитьПути(ПутьКлассовCoverage, "*");

	ПутиКлассов = Новый Массив;
	ПутиКлассов.Добавить(ПутьКлассовEDT);
	ПутиКлассов.Добавить(ПутьКлассовCoverage);

	ПутьКлассов = СтрСоединить(ПутиКлассов, ";");

	Команда = Новый Команда;
	Команда.УстановитьИсполнениеЧерезКомандыСистемы(Ложь);
	Команда.ПерехватыватьПотоки(Ложь);
	Команда.УстановитьКоманду("java");
	Команда.ДобавитьПараметр(СтрШаблон("-cp ""%1""", ПутьКлассов));
	Команда.ДобавитьПараметр("com.clouds42.Coverage41C");
	Команда.ДобавитьПараметр(СтрШаблон("--infobase=""%1""", ПредметОтладки));
	Команда.ДобавитьПараметр(СтрШаблон("--out=""%1""",      ИмяФайла));
	Команда.ДобавитьПараметр(СтрШаблон("--debugger=""%1""", СерверОтладки));

	Процесс = Команда.ЗапуститьПроцесс();

	Возврат Процесс.Идентификатор;

КонецФункции

Процедура СоздатьPIDФайл(ИдентификаторПроцесса)

	ИмяФайла = СтрШаблон("coverage.%1.pid", XMLСтрока(ИдентификаторПроцесса));
	ПолноеИмяФайла = ОбъединитьПути(КаталогВременныхФайлов(), ИмяФайла);
	
	ЗаписьТекста = Новый ЗаписьТекста;
	ЗаписьТекста.Открыть(ПолноеИмяФайла);
	ЗаписьТекста.Закрыть();

	Лог.Отладка(СтрШаблон("Создан pid-файл: %1", ПолноеИмяФайла));

КонецПроцедуры

#КонецОбласти
