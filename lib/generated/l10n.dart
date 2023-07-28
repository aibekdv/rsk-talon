// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello!`
  String get hello {
    return Intl.message(
      'Hello!',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Please select an interface language.`
  String get selectLanguageText {
    return Intl.message(
      'Please select an interface language.',
      name: 'selectLanguageText',
      desc: '',
      args: [],
    );
  }

  /// `Step`
  String get step {
    return Intl.message(
      'Step',
      name: 'step',
      desc: '',
      args: [],
    );
  }

  /// `You already have a ticket?`
  String get doYouHaveTicket {
    return Intl.message(
      'You already have a ticket?',
      name: 'doYouHaveTicket',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Leave feedback`
  String get leavefeedback {
    return Intl.message(
      'Leave feedback',
      name: 'leavefeedback',
      desc: '',
      args: [],
    );
  }

  /// `Please rate the service in the bank`
  String get reviewText {
    return Intl.message(
      'Please rate the service in the bank',
      name: 'reviewText',
      desc: '',
      args: [],
    );
  }

  /// `Select city`
  String get selectCity {
    return Intl.message(
      'Select city',
      name: 'selectCity',
      desc: '',
      args: [],
    );
  }

  /// `Select branch`
  String get selectbranch {
    return Intl.message(
      'Select branch',
      name: 'selectbranch',
      desc: '',
      args: [],
    );
  }

  /// `Bank branch`
  String get bankbranch {
    return Intl.message(
      'Bank branch',
      name: 'bankbranch',
      desc: '',
      args: [],
    );
  }

  /// `Address:`
  String get address {
    return Intl.message(
      'Address:',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get thursday {
    return Intl.message(
      'Thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `Doesn't work`
  String get notOpen {
    return Intl.message(
      'Doesn\'t work',
      name: 'notOpen',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Select client type`
  String get clientType {
    return Intl.message(
      'Select client type',
      name: 'clientType',
      desc: '',
      args: [],
    );
  }

  /// `Legal entity`
  String get legal {
    return Intl.message(
      'Legal entity',
      name: 'legal',
      desc: '',
      args: [],
    );
  }

  /// `Individual`
  String get individual {
    return Intl.message(
      'Individual',
      name: 'individual',
      desc: '',
      args: [],
    );
  }

  /// `I'm a pensioner`
  String get pensioner {
    return Intl.message(
      'I\'m a pensioner',
      name: 'pensioner',
      desc: '',
      args: [],
    );
  }

  /// `Select a service`
  String get seleckservis {
    return Intl.message(
      'Select a service',
      name: 'seleckservis',
      desc: '',
      args: [],
    );
  }

  /// `List of Documents`
  String get listofdocuments {
    return Intl.message(
      'List of Documents',
      name: 'listofdocuments',
      desc: '',
      args: [],
    );
  }

  /// `Select queue`
  String get selectqueue {
    return Intl.message(
      'Select queue',
      name: 'selectqueue',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Stand at the end of the queue`
  String get togetinline {
    return Intl.message(
      'Stand at the end of the queue',
      name: 'togetinline',
      desc: '',
      args: [],
    );
  }

  /// `Select time`
  String get selectTime {
    return Intl.message(
      'Select time',
      name: 'selectTime',
      desc: '',
      args: [],
    );
  }

  /// `Create a ticket`
  String get createaticket {
    return Intl.message(
      'Create a ticket',
      name: 'createaticket',
      desc: '',
      args: [],
    );
  }

  /// `My tickets`
  String get mytickets {
    return Intl.message(
      'My tickets',
      name: 'mytickets',
      desc: '',
      args: [],
    );
  }

  /// `Your number`
  String get yournumber {
    return Intl.message(
      'Your number',
      name: 'yournumber',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `19 minutes left`
  String get minutes {
    return Intl.message(
      '19 minutes left',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Delete ticket?`
  String get deleteticket {
    return Intl.message(
      'Delete ticket?',
      name: 'deleteticket',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Ticket created successfully!`
  String get ticketCreated {
    return Intl.message(
      'Ticket created successfully!',
      name: 'ticketCreated',
      desc: '',
      args: [],
    );
  }

  /// `Services not found`
  String get servicesNotFound {
    return Intl.message(
      'Services not found',
      name: 'servicesNotFound',
      desc: '',
      args: [],
    );
  }

  /// `List of documents required for the service you have chosen`
  String get listOfDocumentsRequiredForASpecificService {
    return Intl.message(
      'List of documents required for the service you have chosen',
      name: 'listOfDocumentsRequiredForASpecificService',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loadingText {
    return Intl.message(
      'Loading',
      name: 'loadingText',
      desc: '',
      args: [],
    );
  }

  /// `The bank does not work at the time you have chosen!`
  String get theBankDoesNotWorkAtTheTimeYouHave {
    return Intl.message(
      'The bank does not work at the time you have chosen!',
      name: 'theBankDoesNotWorkAtTheTimeYouHave',
      desc: '',
      args: [],
    );
  }

  /// `You don't have tickets yet.`
  String get youDontHaveTicketsYet {
    return Intl.message(
      'You don\'t have tickets yet.',
      name: 'youDontHaveTicketsYet',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get serviceText {
    return Intl.message(
      'Service',
      name: 'serviceText',
      desc: '',
      args: [],
    );
  }

  /// `Remaining: {reHour} h {reMin} m`
  String remainingMin(Object reHour, Object reMin) {
    return Intl.message(
      'Remaining: $reHour h $reMin m',
      name: 'remainingMin',
      desc: '',
      args: [reHour, reMin],
    );
  }

  /// `The server is down. \nPlease try again later!`
  String get errorPage {
    return Intl.message(
      'The server is down. \nPlease try again later!',
      name: 'errorPage',
      desc: '',
      args: [],
    );
  }

  /// `Status: {statusText}`
  String statusText(Object statusText) {
    return Intl.message(
      'Status: $statusText',
      name: 'statusText',
      desc: '',
      args: [statusText],
    );
  }

  /// `Files uploaded successfully!`
  String get allFilesDownloaded {
    return Intl.message(
      'Files uploaded successfully!',
      name: 'allFilesDownloaded',
      desc: '',
      args: [],
    );
  }

  /// `Documents not found`
  String get documentFileNotFound {
    return Intl.message(
      'Documents not found',
      name: 'documentFileNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for your feedback!`
  String get thanksForYourFeedback {
    return Intl.message(
      'Thanks for your feedback!',
      name: 'thanksForYourFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Please select a date and time in the future!`
  String get pleaseSelectADateAndTimeInTheFuture {
    return Intl.message(
      'Please select a date and time in the future!',
      name: 'pleaseSelectADateAndTimeInTheFuture',
      desc: '',
      args: [],
    );
  }

  /// `Queue`
  String get queueText {
    return Intl.message(
      'Queue',
      name: 'queueText',
      desc: '',
      args: [],
    );
  }

  /// `No connection`
  String get noInternetConnection {
    return Intl.message(
      'No connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Please check your connection.`
  String get checkYourConnection {
    return Intl.message(
      'Please check your connection.',
      name: 'checkYourConnection',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get cityText {
    return Intl.message(
      'City',
      name: 'cityText',
      desc: '',
      args: [],
    );
  }

  /// `Downloaded successfully!`
  String get downloadedSuccessfully {
    return Intl.message(
      'Downloaded successfully!',
      name: 'downloadedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `ELECTRONIC QUEUE`
  String get electronicQueueText {
    return Intl.message(
      'ELECTRONIC QUEUE',
      name: 'electronicQueueText',
      desc: '',
      args: [],
    );
  }

  /// `Ticket number`
  String get ticketNumberText {
    return Intl.message(
      'Ticket number',
      name: 'ticketNumberText',
      desc: '',
      args: [],
    );
  }

  /// `Branch`
  String get branchText {
    return Intl.message(
      'Branch',
      name: 'branchText',
      desc: '',
      args: [],
    );
  }

  /// `Client type`
  String get clientTypeText {
    return Intl.message(
      'Client type',
      name: 'clientTypeText',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get timeText {
    return Intl.message(
      'Time',
      name: 'timeText',
      desc: '',
      args: [],
    );
  }

  /// `Fax`
  String get faxText {
    return Intl.message(
      'Fax',
      name: 'faxText',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message(
      'Remember me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `My account`
  String get myAccount {
    return Intl.message(
      'My account',
      name: 'myAccount',
      desc: '',
      args: [],
    );
  }

  /// `View my tickets`
  String get viewMyTickets {
    return Intl.message(
      'View my tickets',
      name: 'viewMyTickets',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get backText {
    return Intl.message(
      'Back',
      name: 'backText',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get nextText {
    return Intl.message(
      'Next',
      name: 'nextText',
      desc: '',
      args: [],
    );
  }

  /// `Password recovery`
  String get passwordRecovery {
    return Intl.message(
      'Password recovery',
      name: 'passwordRecovery',
      desc: '',
      args: [],
    );
  }

  /// `Enter the required information to update your password`
  String get requiredInformationPassword {
    return Intl.message(
      'Enter the required information to update your password',
      name: 'requiredInformationPassword',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumberText {
    return Intl.message(
      'Phone number',
      name: 'phoneNumberText',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get enterPhoneNumberText {
    return Intl.message(
      'Enter phone number',
      name: 'enterPhoneNumberText',
      desc: '',
      args: [],
    );
  }

  /// `Example: (996)123-456-789 or 0555-123-456`
  String get examplePhoneNumberText {
    return Intl.message(
      'Example: (996)123-456-789 or 0555-123-456',
      name: 'examplePhoneNumberText',
      desc: '',
      args: [],
    );
  }

  /// `Get a ticket`
  String get getTicketText {
    return Intl.message(
      'Get a ticket',
      name: 'getTicketText',
      desc: '',
      args: [],
    );
  }

  /// `Choose an action`
  String get chooseActionText {
    return Intl.message(
      'Choose an action',
      name: 'chooseActionText',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code`
  String get enterTheCodeText {
    return Intl.message(
      'Enter the code',
      name: 'enterTheCodeText',
      desc: '',
      args: [],
    );
  }

  /// `Example: JG09FD`
  String get exampleCodeText {
    return Intl.message(
      'Example: JG09FD',
      name: 'exampleCodeText',
      desc: '',
      args: [],
    );
  }

  /// `Code sent to your phone number`
  String get theCodeSentToPhoneText {
    return Intl.message(
      'Code sent to your phone number',
      name: 'theCodeSentToPhoneText',
      desc: '',
      args: [],
    );
  }

  /// `Enter new passowrd`
  String get enterNewPassword {
    return Intl.message(
      'Enter new passowrd',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 characters. Example: sjFhdkok_56`
  String get passwordInfoText {
    return Intl.message(
      'At least 8 characters. Example: sjFhdkok_56',
      name: 'passwordInfoText',
      desc: '',
      args: [],
    );
  }

  /// `Example: Qwerty12345`
  String get examplePassword {
    return Intl.message(
      'Example: Qwerty12345',
      name: 'examplePassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm new password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcomeText {
    return Intl.message(
      'Welcome!',
      name: 'welcomeText',
      desc: '',
      args: [],
    );
  }

  /// `Enter the information you added during registration`
  String get enterInfoForLogin {
    return Intl.message(
      'Enter the information you added during registration',
      name: 'enterInfoForLogin',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginText {
    return Intl.message(
      'Login',
      name: 'loginText',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get orText {
    return Intl.message(
      'Or',
      name: 'orText',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get createAccountText {
    return Intl.message(
      'Create an account',
      name: 'createAccountText',
      desc: '',
      args: [],
    );
  }

  /// `Enter the information to be used when logging into the application`
  String get enterInfoForRegister {
    return Intl.message(
      'Enter the information to be used when logging into the application',
      name: 'enterInfoForRegister',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enterPasswordText {
    return Intl.message(
      'Enter password',
      name: 'enterPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get repeatPassword {
    return Intl.message(
      'Confirm password',
      name: 'repeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must match above`
  String get passwordEqualPasswordText {
    return Intl.message(
      'Password must match above',
      name: 'passwordEqualPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get doYouHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'doYouHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Interface language:`
  String get interfaceLanguage {
    return Intl.message(
      'Interface language:',
      name: 'interfaceLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordText {
    return Intl.message(
      'Password',
      name: 'passwordText',
      desc: '',
      args: [],
    );
  }

  /// `Successfully removed!`
  String get successfullyRemoved {
    return Intl.message(
      'Successfully removed!',
      name: 'successfullyRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ky'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
