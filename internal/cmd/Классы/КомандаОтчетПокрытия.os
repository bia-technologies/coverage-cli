
#Использовать "../../coverage"

#Область КомандаПриложения

Процедура ОписаниеКоманды(Команда) Экспорт

	Команда.Опция("i input", "", "Файл с результатами отладки в формате csv")
		.ТСтрока()
		.Обязательный();	

	Команда.Опция("o output", "", "JSON файл покрытия с указанием путей к исходным файлам")
		.ТСтрока()
		.Обязательный();	

КонецПроцедуры

Процедура ВыполнитьКоманду(Знач Команда) Экспорт

	КаталогСОтчетами = Команда.ЗначениеОпции("input");
	ФайлXML          = Команда.ЗначениеОпции("output"); 

	ДанныеОтчета = Новый Соответствие;

	ФайлыОтчетов = НайтиФайлы(КаталогСОтчетами, "*.*");
	Для Каждого ФайлОтчета Из ФайлыОтчетов Цикл

		Если ФайлОтчета.Расширение = ".json" Тогда
			ДанныеПокрытияФайл = ФорматДанныеПокрытия.ПрочитатьДанныеПокрытия(ФайлОтчета.ПолноеИмя);
		ИначеЕсли ФайлОтчета.Расширение = ".xml" Тогда
			ДанныеПокрытияФайл = ФорматДанныеПокрытия.ПрочитатьДанныеПокрытияXML(ФайлОтчета.ПолноеИмя);
		Иначе
			Продолжить;
		КонецЕсли;

		Для Каждого ДанныеПокрытияМодуляФайл Из ДанныеПокрытияФайл Цикл

			КлючДанных = ДанныеПокрытияМодуляФайл.SourcePath;
			ДанныеПокрытияМодуля = ДанныеОтчета.Получить(КлючДанных);
			Если ДанныеПокрытияМодуля = Неопределено Тогда
				ДанныеОтчета.Вставить(КлючДанных, ДанныеПокрытияМодуляФайл);
			Иначе	
				ФорматДанныеПокрытия.ДополнитьДанныеПокрытия(ДанныеПокрытияМодуля, ДанныеПокрытияМодуляФайл);
			КонецЕсли;	
		
		КонецЦикла;
	
	КонецЦикла;

	ФорматДанныеПокрытия.ЗаписатьДанныеПокрытияXML(ФайлXML, ДанныеОтчета);

КонецПроцедуры

#КонецОбласти
