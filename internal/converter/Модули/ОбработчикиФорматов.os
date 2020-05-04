
Перем Лог;

#Область СлужебныйПрограммныйИнтерфейс

Функция ОбработчикиФормата(МодульОбработчиков) Экспорт
	
	Лог = ПараметрыПриложения.Лог();
	
	Обработчики = Новый Соответствие;
	
	ДобавитьДелегата(Обработчики, МодульОбработчиков,
		ВидыПрограммныхМодулей.МодульУправляемогоПриложения, "НайтиМодульУправляемогоПриложения");

	ДобавитьДелегата(Обработчики, МодульОбработчиков,
		ВидыПрограммныхМодулей.МодульСеанса, "НайтиМодульСеанса");
	
	ДобавитьДелегата(Обработчики, МодульОбработчиков,
		ВидыПрограммныхМодулей.МодульВнешнегоСоединения, "НайтиМодульВнешнегоСоединения");
	
	ДобавитьДелегата(Обработчики, МодульОбработчиков,
		ВидыПрограммныхМодулей.МодульОбычногоПриложения, "НайтиМодульОбычногоПриложения");

	ДобавитьДелегата(Обработчики, МодульОбработчиков,
		ВидыПрограммныхМодулей.ОбщийМодуль, "НайтиОбщийМодуль");

	ДобавитьДелегата(Обработчики, МодульОбработчиков,
		ВидыПрограммныхМодулей.МодульМенеджераЗначения, "НайтиМодульМенеджераЗначения");

	ДобавитьДелегата(Обработчики, МодульОбработчиков,
		ВидыПрограммныхМодулей.МодульМенеджераНастроек, "НайтиМодульМенеджераНастроек");
		
	ДобавитьДелегата(Обработчики, МодульОбработчиков,
		ВидыПрограммныхМодулей.МодульМенеджера, "НайтиМодульМенеджера");		
	
	ДобавитьДелегата(Обработчики, МодульОбработчиков,
		ВидыПрограммныхМодулей.МодульОбъекта, "НайтиМодульОбъекта");
	
	ДобавитьДелегата(Обработчики, МодульОбработчиков,
		ВидыПрограммныхМодулей.МодульНабораЗаписей, "НайтиМодульНабораЗаписей");			
	
	ДобавитьДелегата(Обработчики, МодульОбработчиков,
		ВидыПрограммныхМодулей.МодульФормы, "НайтиМодульФормы");			

	ДобавитьДелегата(Обработчики, МодульОбработчиков,
		ВидыПрограммныхМодулей.МодульКоманды, "НайтиМодульКоманды");			

	Возврат Обработчики;

КонецФункции

#Область ОбработчикиОшибок

Процедура НеНайденМодульУправляемогоПриложения(ИдентификаторПрограммногоМодуля) Экспорт

	ТекстСообщения = СтрШаблон(
		"Не найден модуль управляемого приложения для конфигурации с идентификатором ""%1""", 
		ИдентификаторПрограммногоМодуля);
	Лог.Ошибка(ТекстСообщения);

КонецПроцедуры 

Процедура НеНайденМодульСеанса(ИдентификаторПрограммногоМодуля) Экспорт

	ТекстСообщения = СтрШаблон(
		"Не найден модуль сеанса для конфигурации с идентификатором ""%1""", 
		ИдентификаторПрограммногоМодуля);
	Лог.Ошибка(ТекстСообщения);

КонецПроцедуры

Процедура НеНайденМодульВнешнегоСоединения(ИдентификаторПрограммногоМодуля) Экспорт

	ТекстСообщения = СтрШаблон(
		"Не найден модуль внешнего соединения для конфигурации с идентификатором ""%1""", 
		ИдентификаторПрограммногоМодуля);
	Лог.Ошибка(ТекстСообщения);

КонецПроцедуры

Процедура НеНайденМодульОбычногоПриложения(ИдентификаторПрограммногоМодуля) Экспорт

	ТекстСообщения = СтрШаблон(
		"Не найден модуль обычного приложения для конфигурации с идентификатором ""%1""", 
		ИдентификаторПрограммногоМодуля);
	Лог.Ошибка(ТекстСообщения);

КонецПроцедуры

Процедура НеНайденОбщийМодуль(ИдентификаторПрограммногоМодуля) Экспорт
	
	ТекстСообщения = СтрШаблон(
		"Не найден общий модуль с идентификатором ""%1""", 
		ИдентификаторПрограммногоМодуля);
	Лог.Ошибка(ТекстСообщения);

КонецПроцедуры

Процедура НеНайденМодульМенеджераЗначения(ИдентификаторПрограммногоМодуля) Экспорт
	
	ТекстСообщения = СтрШаблон(
		"Не найден модуль менеджера значений для объекта с идентификатором ""%1""", 
		ИдентификаторПрограммногоМодуля);
	Лог.Ошибка(ТекстСообщения);

КонецПроцедуры

Процедура НеНайденМодульМенеджераНастроек(ИдентификаторПрограммногоМодуля) Экспорт
	
	ТекстСообщения = СтрШаблон(
		"Не найден модуль менеджера настроек для объекта с идентификатором ""%1""", 
		ИдентификаторПрограммногоМодуля);
	Лог.Ошибка(ТекстСообщения);

КонецПроцедуры

Процедура НеНайденМодульМенеджера(ИдентификаторПрограммногоМодуля) Экспорт
	
	ТекстСообщения = СтрШаблон(
		"Не найден модуль менеджера с идентификатором ""%1""", 
		ИдентификаторПрограммногоМодуля);
	Лог.Ошибка(ТекстСообщения);

КонецПроцедуры

Процедура НеНайденМодульОбъекта(ИдентификаторПрограммногоМодуля) Экспорт
	
	ТекстСообщения = СтрШаблон(
		"Не найден модуль объекта с идентификатором ""%1""", 
		ИдентификаторПрограммногоМодуля);
	Лог.Ошибка(ТекстСообщения);

КонецПроцедуры

Процедура НеНайденМодульНабораЗаписей(ИдентификаторПрограммногоМодуля) Экспорт
	
	ТекстСообщения = СтрШаблон(
		"Не найден модуль набора записей для объекта с идентификатором ""%1""", 
		ИдентификаторПрограммногоМодуля);
	Лог.Ошибка(ТекстСообщения);

КонецПроцедуры

Процедура НеНайденМодульФормы(ИдентификаторПрограммногоМодуля) Экспорт
	
	ТекстСообщения = СтрШаблон(
		"Не найден модуль формы для объекта с идентификатором ""%1""", 
		ИдентификаторПрограммногоМодуля);
	Лог.Ошибка(ТекстСообщения);

КонецПроцедуры

Процедура НеНайденМодульКоманды(ИдентификаторПрограммногоМодуля) Экспорт
	
	ТекстСообщения = СтрШаблон(
		"Не найден модуль команды для объекта с идентификатором ""%1""", 
		ИдентификаторПрограммногоМодуля);
	Лог.Ошибка(ТекстСообщения);

КонецПроцедуры

#КонецОбласти

#Область СпискиКаталогов

Функция СписокКаталоговОбщийМодуль() Экспорт

	СписокКаталогов = Новый Массив;
	СписокКаталогов.Добавить("CommonModules");
	СписокКаталогов.Добавить("HTTPServices");
	СписокКаталогов.Добавить("WebServices");

	Возврат СписокКаталогов;

КонецФункции

Функция СписокКаталоговМодульМенеджера() Экспорт
	
	СписокКаталогов = Новый Массив;
	СписокКаталогов.Добавить("ExchangePlans");
	СписокКаталогов.Добавить("FilterCriteria");
	СписокКаталогов.Добавить("SettingsStorages");
	СписокКаталогов.Добавить("Catalogs");
	СписокКаталогов.Добавить("Documents");
	СписокКаталогов.Добавить("Enums");
	СписокКаталогов.Добавить("Reports");
	СписокКаталогов.Добавить("DataProcessors");
	СписокКаталогов.Добавить("DocumentJournals");
	СписокКаталогов.Добавить("ChartsOfCharacteristicTypes");
	СписокКаталогов.Добавить("ChartsOfAccounts");
	СписокКаталогов.Добавить("ChartsOfCalculationTypes");
	СписокКаталогов.Добавить("InformationRegisters");
	СписокКаталогов.Добавить("AccumulationRegisters");
	СписокКаталогов.Добавить("AccountingRegisters");
	СписокКаталогов.Добавить("CalculationRegisters");
	СписокКаталогов.Добавить("BusinessProcesses");
	СписокКаталогов.Добавить("Tasks");

	Возврат СписокКаталогов;

КонецФункции

Функция СписокКаталоговМодульОбъекта() Экспорт
	
	СписокКаталогов = Новый Массив;
	СписокКаталогов.Добавить("ExchangePlans");
	СписокКаталогов.Добавить("Catalogs");
	СписокКаталогов.Добавить("Documents");
	СписокКаталогов.Добавить("Reports");
	СписокКаталогов.Добавить("DataProcessors");
	СписокКаталогов.Добавить("ChartsOfCharacteristicTypes");
	СписокКаталогов.Добавить("ChartsOfAccounts");
	СписокКаталогов.Добавить("ChartsOfCalculationTypes");
	СписокКаталогов.Добавить("BusinessProcesses");
	СписокКаталогов.Добавить("Tasks");

	Возврат СписокКаталогов;

КонецФункции

Функция СписокКаталоговМодульНабораЗаписей() Экспорт

	СписокКаталогов = Новый Массив;
	СписокКаталогов.Добавить("Sequences");
	СписокКаталогов.Добавить("InformationRegisters");
	СписокКаталогов.Добавить("AccumulationRegisters");
	СписокКаталогов.Добавить("AccountingRegisters");
	СписокКаталогов.Добавить("CalculationRegisters");

	Возврат СписокКаталогов;

КонецФункции

Функция СписокКаталоговМодульФормы() Экспорт
	
	СписокКаталогов = Новый Массив;
	СписокКаталогов.Добавить("ExchangePlans");
	СписокКаталогов.Добавить("FilterCriteria");
	СписокКаталогов.Добавить("SettingsStorages");
	СписокКаталогов.Добавить("Catalogs");
	СписокКаталогов.Добавить("Documents");
	СписокКаталогов.Добавить("DocumentJournals");
	СписокКаталогов.Добавить("Enums");
	СписокКаталогов.Добавить("Reports");
	СписокКаталогов.Добавить("DataProcessors");
	СписокКаталогов.Добавить("ChartsOfCharacteristicTypes");
	СписокКаталогов.Добавить("ChartsOfAccounts");
	СписокКаталогов.Добавить("ChartsOfCalculationTypes");
	СписокКаталогов.Добавить("InformationRegisters");
	СписокКаталогов.Добавить("AccumulationRegisters");
	СписокКаталогов.Добавить("AccountingRegisters");
	СписокКаталогов.Добавить("CalculationRegisters");
	СписокКаталогов.Добавить("BusinessProcesses");
	СписокКаталогов.Добавить("Tasks");

	Возврат СписокКаталогов;

КонецФункции

Функция СписокКаталоговМодульКоманды() Экспорт

	СписокКаталогов = Новый Массив;
	СписокКаталогов.Добавить("ExchangePlans");
	СписокКаталогов.Добавить("FilterCriteria");
	СписокКаталогов.Добавить("Catalogs");
	СписокКаталогов.Добавить("Documents");
	СписокКаталогов.Добавить("DocumentJournals");
	СписокКаталогов.Добавить("Enums");
	СписокКаталогов.Добавить("Reports");
	СписокКаталогов.Добавить("DataProcessors");
	СписокКаталогов.Добавить("ChartsOfCharacteristicTypes");
	СписокКаталогов.Добавить("ChartsOfAccounts");
	СписокКаталогов.Добавить("ChartsOfCalculationTypes");
	СписокКаталогов.Добавить("InformationRegisters");
	СписокКаталогов.Добавить("AccumulationRegisters");
	СписокКаталогов.Добавить("AccountingRegisters");
	СписокКаталогов.Добавить("CalculationRegisters");
	СписокКаталогов.Добавить("BusinessProcesses");
	СписокКаталогов.Добавить("Tasks");
	Возврат СписокКаталогов;

КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ДобавитьДелегата(Обработчики, МодульОбработчиков, ВидПрограммногоМодуля, ИмяДелегата)

	Делегат = Новый Действие(МодульОбработчиков, ИмяДелегата);
	Обработчики.Вставить(ВидПрограммногоМодуля, Делегат);

КонецПроцедуры

#КонецОбласти
