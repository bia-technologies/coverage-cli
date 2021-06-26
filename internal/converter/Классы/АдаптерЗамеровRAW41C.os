#Область ОписаниеПеременных

Перем ИмяФайлаЗамеров;
Перем ТипКонтейнера;
Перем ИмяРасширения;
Перем ИмяВнешнегоМодуля;

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура РазобратьЗамеры(Конвертер) Экспорт
	
	РегулярноеВыражение = Новый РегулярноеВыражение("\/(.{36})\/(.{36})");
	
	ЧтениеXML = Новый ЧтениеXML();
	ЧтениеXML.ОткрытьФайл(ИмяФайлаЗамеров);
	ЧтениеXML.ПерейтиКСодержимому();
	
	Пока ЧтениеXML.Прочитать() И ЧтениеXML.ЛокальноеИмя = "file" Цикл
		
		КомбинированныйИдентификатор = ЧтениеXML.ПолучитьАтрибут("path");
		Совпадение = РегулярноеВыражение.НайтиСовпадения(КомбинированныйИдентификатор)[0];
		ИдентификаторОбъекта = Совпадение.Группы[1].Значение;
		ИдентификаторСвойства = Совпадение.Группы[2].Значение;
		
		Пока ЧтениеXML.Прочитать() И ЧтениеXML.ЛокальноеИмя = "lineToCover" Цикл
			
			НомерСтроки = XMLЗначение(Тип("Число"), ЧтениеXML.ПолучитьАтрибут("lineNumber"));
			
			СтрокаЗамера = Конвертер.НоваяСтрокаЗамера();
			СтрокаЗамера.ObjectId = ИдентификаторОбъекта;
			СтрокаЗамера.PropertyId = ИдентификаторСвойства;
			СтрокаЗамера.LineNo = НомерСтроки;
			
			СтрокаЗамера.ModuleType = ТипКонтейнера;
			СтрокаЗамера.ExtentionName = ИмяРасширения;
			СтрокаЗамера.URL = ИмяВнешнегоМодуля;
			
			Конвертер.РазобратьДанныеЗамера(СтрокаЗамера);
			
			ЧтениеXML.Пропустить();
			
		КонецЦикла;
	
	КонецЦикла;
	
	ЧтениеXML.Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПриСозданииОбъекта(ПараметрИмяФайлаЗамеров, ПараметрТипКонтейнера, ПутьКОбъекту)
	
	ИмяФайлаЗамеров = ПараметрИмяФайлаЗамеров;
	ТипКонтейнера = ПараметрТипКонтейнера;
	
	Если ТипКонтейнера = ТипыКонтейнеровПрограммныхМодулей.МодульРасширения Тогда
		ИмяРасширения = ПутьКОбъекту;
		ИмяВнешнегоМодуля = Неопределено;
		
	ИначеЕсли ТипКонтейнера = ТипыКонтейнеровПрограммныхМодулей.ВнешнийМодуль Тогда
		ИмяРасширения = Неопределено;
		ИмяВнешнегоМодуля = ПутьКОбъекту;
		
	Иначе
		ИмяРасширения = Неопределено;
		ИмяВнешнегоМодуля = Неопределено;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти