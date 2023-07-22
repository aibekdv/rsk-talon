// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(reHour, reMin) => "Осталось: ${reHour} ч ${reMin} м";

  static String m1(statusText) => "Статус: ${statusText}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Добавить"),
        "address": MessageLookupByLibrary.simpleMessage("Адрес:"),
        "allFilesDownloaded":
            MessageLookupByLibrary.simpleMessage("Файлы успешно загружены!"),
        "bankbranch": MessageLookupByLibrary.simpleMessage("Филиал банка"),
        "branchText": MessageLookupByLibrary.simpleMessage("Филиал"),
        "cancel": MessageLookupByLibrary.simpleMessage("Отменить"),
        "checkYourConnection": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, проверьте подключение."),
        "cityText": MessageLookupByLibrary.simpleMessage("Город"),
        "clientType":
            MessageLookupByLibrary.simpleMessage("Выберите тип клиента"),
        "clientTypeText": MessageLookupByLibrary.simpleMessage("Тип клиента"),
        "createaticket": MessageLookupByLibrary.simpleMessage("Создать талон"),
        "date": MessageLookupByLibrary.simpleMessage("Дата"),
        "deleteticket": MessageLookupByLibrary.simpleMessage("Удалить талон?"),
        "doYouHaveTicket":
            MessageLookupByLibrary.simpleMessage("У вас уже есть талон?"),
        "documentFileNotFound":
            MessageLookupByLibrary.simpleMessage("Документы не найдены"),
        "downloadedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Успешно скачано!"),
        "electronicQueueText":
            MessageLookupByLibrary.simpleMessage("ЭЛЕКТРОННАЯ ОЧЕРЕДЬ"),
        "errorPage": MessageLookupByLibrary.simpleMessage(
            "Сервер не работает. \nПожалуйста повторите попытку позже!"),
        "faxText": MessageLookupByLibrary.simpleMessage("Факс"),
        "friday": MessageLookupByLibrary.simpleMessage("Пятница"),
        "hello": MessageLookupByLibrary.simpleMessage("Привет!"),
        "individual": MessageLookupByLibrary.simpleMessage("Физическое лицо"),
        "leavefeedback": MessageLookupByLibrary.simpleMessage("Оставить отзыв"),
        "legal": MessageLookupByLibrary.simpleMessage("Юридическое лицо"),
        "listOfDocumentsRequiredForASpecificService":
            MessageLookupByLibrary.simpleMessage(
                "Список документов, необходимых для выбранной вами услуги"),
        "listofdocuments":
            MessageLookupByLibrary.simpleMessage("Список документов"),
        "loadingText": MessageLookupByLibrary.simpleMessage("Загрузка"),
        "map": MessageLookupByLibrary.simpleMessage("Карта"),
        "monday": MessageLookupByLibrary.simpleMessage("Понедельник"),
        "mytickets": MessageLookupByLibrary.simpleMessage("Мои талоны"),
        "next": MessageLookupByLibrary.simpleMessage("Далее"),
        "noInternetConnection":
            MessageLookupByLibrary.simpleMessage("Нет соединения"),
        "notOpen": MessageLookupByLibrary.simpleMessage("Не работает"),
        "or": MessageLookupByLibrary.simpleMessage("или"),
        "pensioner": MessageLookupByLibrary.simpleMessage("Я пенсионер(-ка)"),
        "pleaseSelectADateAndTimeInTheFuture":
            MessageLookupByLibrary.simpleMessage(
                "Пожалуйста, выберите дату и время в будущем!"),
        "queueText": MessageLookupByLibrary.simpleMessage("Очередь"),
        "remainingMin": m0,
        "reviewText": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, оцените обслуживание в банке"),
        "saturday": MessageLookupByLibrary.simpleMessage("Суббота"),
        "seleckservis": MessageLookupByLibrary.simpleMessage("Выберите услугу"),
        "selectCity": MessageLookupByLibrary.simpleMessage("Выберите город"),
        "selectLanguageText": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, выберите язык интерфейса."),
        "selectTime": MessageLookupByLibrary.simpleMessage("Выбрать время"),
        "selectbranch": MessageLookupByLibrary.simpleMessage("Выберите филиал"),
        "selectqueue": MessageLookupByLibrary.simpleMessage("Выбрать очередь"),
        "serviceText": MessageLookupByLibrary.simpleMessage("Услуга"),
        "servicesNotFound":
            MessageLookupByLibrary.simpleMessage("Услуги не найдены"),
        "statusText": m1,
        "step": MessageLookupByLibrary.simpleMessage("Шаг"),
        "sunday": MessageLookupByLibrary.simpleMessage("Воскресенье"),
        "thanksForYourFeedback":
            MessageLookupByLibrary.simpleMessage("Спасибо за ваш отзыв!"),
        "theBankDoesNotWorkAtTheTimeYouHave":
            MessageLookupByLibrary.simpleMessage(
                "Банк не работает в выбранное вами время!"),
        "thursday": MessageLookupByLibrary.simpleMessage("Четверг"),
        "ticketCreated":
            MessageLookupByLibrary.simpleMessage("Талон успешно создан!"),
        "ticketNumberText":
            MessageLookupByLibrary.simpleMessage("Номер талона"),
        "time": MessageLookupByLibrary.simpleMessage("Время"),
        "timeText": MessageLookupByLibrary.simpleMessage("Время"),
        "togetinline":
            MessageLookupByLibrary.simpleMessage("Встать в конец очереди"),
        "tuesday": MessageLookupByLibrary.simpleMessage("Вторник"),
        "wednesday": MessageLookupByLibrary.simpleMessage("Среда"),
        "yes": MessageLookupByLibrary.simpleMessage("Да"),
        "youDontHaveTicketsYet":
            MessageLookupByLibrary.simpleMessage("У Вас пока нет талонов."),
        "yournumber": MessageLookupByLibrary.simpleMessage("Ваш номер")
      };
}
