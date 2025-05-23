#Использовать strings
#Использовать logos

Перем Лог;

Перем Основная Экспорт; // Число
Перем Второстепенная Экспорт; // Число
Перем Патч Экспорт; // число

Перем ПреРелиз Экспорт; // Массив
Перем МетаданныеСборки Экспорт; // Массив;
Перем ОшибкаЧтенияВерсии Экспорт;

Процедура ПриСозданииОбъекта(Знач ВерсияСтрокой)

	Основная = 0;
	Второстепенная = 0;
	Патч = 0;
	ПреРелиз = Новый Массив;
	МетаданныеСборки = Новый Массив;

	Прочитать(ВерсияСтрокой);

КонецПроцедуры

// Возвращает наличие ошибки при чтении версии
//
// Возвращаемое значение:
//   булево - истина / ложь
Функция Ошибка() Экспорт
	
	Возврат Не ПустаяСтрока(ОшибкаЧтенияВерсии);

КонецФункции

// Возвращает описание ошибки при чтении версии
//
// Возвращаемое значение:
//   строка - подробное описание чтения версии из строки
Функция ПолучитьОписаниеОшибки() Экспорт
	Возврат ОшибкаЧтенияВерсии;
КонецФункции

// Возвращает строковое представление версии
//
// Возвращаемое значение:
//   строка - строковое представление версии (типа: 1.0.0, 2.0.0)
Функция ВСтроку() Экспорт
	
	СтрокаВерсии = СтрШаблон("%1.%2.%3", Строка(Основная), Строка(Второстепенная), Строка(Патч));

	Если ПреРелиз.Количество() Тогда
		СтрокаВерсии = СтрокаВерсии + "-" + СтрСоединить(ПреРелиз, ".");
	КонецЕсли;

	Если МетаданныеСборки.Количество() Тогда
		СтрокаВерсии = СтрокаВерсии + "+" + СтрСоединить(МетаданныеСборки, ".");
	КонецЕсли;
	
	Возврат СтрокаВерсии;
	
КонецФункции

// Выполняет сравнение версии с входящей версией
//
// Параметры:
//   ВходящаяВерсия - Класс Версия - версия для сравнения
// Возвращаемое значение:
//   Число - результат сравнения в числе (0 = Равны, -1 = Меньше, 1 = Больше), относительно входящей версии
Функция Сравнить(Знач ВходящаяВерсия) Экспорт
	
	Лог.Отладка("Класс входящей версии %1", ВходящаяВерсия);
	
	Если НЕ Основная = ВходящаяВерсия.Основная Тогда
		
		Возврат ?(Основная > ВходящаяВерсия.Основная, 1,-1);

	КонецЕсли;

	Если НЕ Второстепенная = ВходящаяВерсия.Второстепенная Тогда
		
		Возврат ?(Второстепенная > ВходящаяВерсия.Второстепенная,1,-1);

	КонецЕсли;

	Если НЕ Патч = ВходящаяВерсия.Патч Тогда
		
		Возврат ?(Патч > ВходящаяВерсия.Патч,1,-1);

	КонецЕсли;

	Если ПреРелиз.Количество() = 0 
		И ВходящаяВерсия.ПреРелиз.Количество() = 0 Тогда
		Возврат 0;
	КонецЕсли;

	Если ПреРелиз.Количество() = 0 
		И ВходящаяВерсия.ПреРелиз.Количество() > 0 Тогда
		Возврат 1;
	КонецЕсли;

	Если ПреРелиз.Количество() > 0 
		И ВходящаяВерсия.ПреРелиз.Количество() = 0 Тогда
		Возврат -1;
	КонецЕсли;

	Возврат СравнитьПререлизы(ВходящаяВерсия.ПреРелиз);
	
КонецФункции

// Проверяет равенство версии с входящей версией
//
// Параметры:
//   ВходящаяВерсия - Класс Версия - версия для сравнения
// Возвращаемое значение:
//   Булево - истина / ложь
Функция Равны(Знач ВходящаяВерсия) Экспорт
	Возврат Сравнить(ВходящаяВерсия) = 0;
КонецФункции

// Проверяет не равенство версии с входящей версией
//
// Параметры:
//   ВходящаяВерсия - Класс Версия - версия для сравнения
// Возвращаемое значение:
//   Булево - истина / ложь
Функция НеРавны(Знач ВходящаяВерсия) Экспорт
	Возврат НЕ Сравнить(ВходящаяВерсия) = 0;
КонецФункции

// Проверяет, что текущая версия меньше входящей версии
//
// Параметры:
//   ВходящаяВерсия - Класс Версия - версия для сравнения
// Возвращаемое значение:
//   Булево - истина / ложь
Функция Меньше(Знач ВходящаяВерсия) Экспорт
	Возврат Сравнить(ВходящаяВерсия) = -1;
КонецФункции

// Проверяет, что текущая версия меньше или равна входящей версии
//
// Параметры:
//   ВходящаяВерсия - Класс Версия - версия для сравнения
// Возвращаемое значение:
//   Булево - истина / ложь
Функция МеньшеИлиРавны(Знач ВходящаяВерсия) Экспорт
	Возврат Сравнить(ВходящаяВерсия) <= 0;
КонецФункции

// Проверяет, что текущая версия больше входящей версии
//
// Параметры:
//   ВходящаяВерсия - Класс Версия - версия для сравнения
// Возвращаемое значение:
//   Булево - истина / ложь
Функция Больше(Знач ВходящаяВерсия) Экспорт
	Возврат Сравнить(ВходящаяВерсия) = 1;
КонецФункции

// Проверяет, что текущая версия больше или равна входящей версии
//
// Параметры:
//   ВходящаяВерсия - Класс Версия - версия для сравнения
// Возвращаемое значение:
//   Булево - истина / ложь
Функция БольшеИлиРавны(Знач ВходящаяВерсия) Экспорт
	Возврат Сравнить(ВходящаяВерсия) >= 0;
КонецФункции

Функция СравнитьПреРелизы(Знач Сравниваемое)
	// Поэлементное сравнение
	Для Сч = 0 По Макс(ПреРелиз.ВГраница(), Сравниваемое.ВГраница()) Цикл
		// Больший набор предрелизных символов имеет больший приоритет,
		// чем меньший набор, если сравниваемые идентификаторы равны =>
		// если компоненты будут равны, побеждает тот, у кого компонентов больше

		Если Сч > ПреРелиз.ВГраница() Тогда
			Возврат -1;
		ИначеЕсли Сч > Сравниваемое.ВГраница() Тогда
			Возврат 1;
		КонецЕсли;

		Текущий = ПреРелиз[Сч];
		Входящий = Сравниваемое[Сч];

		Если Текущий = Входящий Тогда
			Продолжить;
		КонецЕсли;

		// Численные идентификаторы имеют низший приоритет
		Если ТипЗнч(Текущий) <> ТипЗнч(Входящий) Тогда
			Возврат ?(ТипЗнч(Текущий) = Тип("Строка"), 1, -1);
		КонецЕсли;

		Возврат ?(Текущий > Входящий, 1, -1);

	КонецЦикла;

	Возврат 0;
КонецФункции

Процедура Прочитать(Знач ВерсияСтрокой)
	
	Если СтрДлина(ВерсияСтрокой) = 0 Тогда
		ОшибкаЧтенияВерсии = "Длина строки версии 0";
		Возврат; 
	КонецЕсли;

	ВерсияСтрокой = ПодготовитьКЧтению(ВерсияСтрокой);

	Парсер = Новый ПарсерВерсии(ВерсияСтрокой);
	Парсер.Следующий();

	Попытка
		ПрочитатьЧислоДоРазделителя(Парсер, Основная, "Основная версия");
		ПрочитатьРазделитель(Парсер, ".");
		ПрочитатьЧислоДоРазделителя(Парсер, Второстепенная, "Второстепенная версия");
		ПрочитатьРазделитель(Парсер, ".");
		ПрочитатьЧислоДоРазделителя(Парсер, Патч, "Версия патча");
		ПрочитатьХвостовыеМассивы(Парсер);
	Исключение
		ОшибкаЧтенияВерсии = ИнформацияОбОшибке().Описание;
	КонецПопытки;

КонецПроцедуры

Процедура ПрочитатьРазделитель(Знач Парсер, Знач Разделитель)

	ТекущийТокен = Парсер.Текущий();
	Если ТекущийТокен.Тип = Парсер.ТипКонецТекста Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущийТокен.Тип = Парсер.ТипРазделитель Тогда
		Если Разделитель = ТекущийТокен.Значение Тогда
			СледующийТокен = Парсер.Следующий();
			Если СледующийТокен.Тип = Парсер.ТипКонецТекста Тогда
				ВызватьИсключение СтрШаблон("Неожиданный конец строки версии, нет данных после разделителя <%1>", Разделитель);
			КонецЕсли;
			Возврат;
		КонецЕсли;
	КонецЕсли;

	ВызватьИсключение СтрШаблон("Ожидается разделитель <%1>, но получен <%2>", Разделитель, ТекущийТокен.Значение);

КонецПроцедуры

Процедура ПрочитатьЧислоДоРазделителя(Знач Парсер, Результат, Знач УточнениеИсключения)
	Токен = Парсер.Текущий();
	Если Токен.Тип = Парсер.ТипКонецТекста Тогда
		Возврат;
	КонецЕсли;

	Если Токен.Тип = Парсер.ТипЧисло Тогда
		Результат = Число(Токен.Значение);
    ИначеЕсли Токен.Тип = Парсер.ТипОшибка Тогда
        ВызватьИсключение Токен.Значение;
	Иначе
		ВызватьИсключение СтрШаблон("%1 <%2> должна содержать только цифры", УточнениеИсключения, Токен.Значение);
	КонецЕсли;

	Парсер.Следующий();
КонецПроцедуры

Процедура ПрочитатьХвостовыеМассивы(Знач Парсер)
	Токен = Парсер.Текущий();
	Если Токен.Тип = Парсер.ТипКонецТекста Тогда
		Возврат;
	КонецЕсли;

	Если Токен.Тип <> Парсер.ТипРазделитель или Токен.Значение = "." Тогда
		ВызватьИсключение "Ожидается разделитель пререлизной версии <-> или метаданных сборки <+>, получен <" + Токен.Значение + ">";
	КонецЕсли;

	ПрочитатьПреРелиз(Парсер);
	ПрочитатьМетаданныеСборки(Парсер);

КонецПроцедуры

Процедура ПрочитатьПреРелиз(Знач Парсер)
	Если Парсер.Текущий().Значение = "-" Тогда
		Парсер.Следующий();
		СобратьМассивИзКомпонентов(Парсер, ПреРелиз, "+");
	КонецЕсли;
КонецПроцедуры

Процедура ПрочитатьМетаданныеСборки(Знач Парсер)
    Если Парсер.Текущий().Значение = "+" Тогда
		Парсер.Следующий();
		СобратьМассивИзКомпонентов(Парсер, МетаданныеСборки, "");
	КонецЕсли;
КонецПроцедуры

Процедура СобратьМассивИзКомпонентов(Знач Парсер, Знач МассивКомпонентов, Знач ПрерватьПо)
	
	Пока Истина Цикл
		МассивКомпонентов.Добавить(ПрочитатьКомпонент(Парсер));
		Если Парсер.Текущий().Значение = ПрерватьПо или Парсер.Текущий().Тип = Парсер.ТипКонецТекста Тогда
			Прервать;
		КонецЕсли;

		ПрочитатьРазделитель(Парсер, ".");

	КонецЦикла;

КонецПроцедуры

Функция ПрочитатьКомпонент(Знач Парсер)
	Токен = Парсер.Текущий();
	Если Токен.Тип = Парсер.ТипЧисло Тогда
		Парсер.Следующий();
		Возврат Число(Токен.Значение);
	ИначеЕсли Токен.Тип = Парсер.ТипТекст Тогда
		Текст = "";
		ТекТокен = Парсер.Текущий();
		Пока ТекТокен.Тип = Парсер.ТипТекст или ТекТокен.Значение = "-" Цикл
			Текст = Текст + ТекТокен.Значение;
			ТекТокен = Парсер.Следующий();
		КонецЦикла;
		Возврат Текст;
	Иначе
		ВызватьИсключение СтрШаблон("Ожидается компонент версии, но получен <%1>", ?(Токен.Значение = "", "EOF", Токен.Значение));
	КонецЕсли;
КонецФункции

Функция ПодготовитьКЧтению(Знач СтрокаВерсии)
	
	Если СтрНачинаетсяС(СтрокаВерсии, "v") Тогда
		СтрокаВерсии = Сред(СтрокаВерсии, 2);
	КонецЕсли;

	Возврат СтрокаВерсии;

КонецФункции

Лог = Логирование.ПолучитьЛог("oscript.lib.semver.version");
