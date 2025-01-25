import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get helloWorld => 'Witaj, świecie!';

  @override
  String get signInToContinue => 'Zaloguj się, aby kontynuować';

  @override
  String get email => 'E-mail';

  @override
  String get pleaseEnterAnEmail => 'Proszę wprowadzić e-mail';

  @override
  String get password => 'Hasło';

  @override
  String get pleaseEnterAPassword => 'Proszę wprowadzić hasło';

  @override
  String get login => 'Zaloguj się';

  @override
  String get dontHaveAnAccount => 'Nie masz konta?';

  @override
  String get register => 'Zarejestruj się';

  @override
  String get loginFailed => 'Logowanie nie powiodło się. Sprawdź swój e-mail i hasło.';

  @override
  String get error => 'Błąd';

  @override
  String get ok => 'OK';

  @override
  String get createAnAccount => 'Utwórz konto';

  @override
  String get fullName => 'Imię i nazwisko';

  @override
  String get pleaseEnterYourName => 'Proszę podać swoje imię i nazwisko';

  @override
  String get alreadyHaveAnAccount => 'Masz już konto?';

  @override
  String get hiWelcomeTo => 'Cześć! Witamy w';

  @override
  String get fantasies => 'fantazjach';

  @override
  String get perfectOrganizationTool => 'Idealne narzędzie do organizacji pisania, budowania światów i planowania';

  @override
  String get getStartedNow => 'Rozpocznij teraz';

  @override
  String get alreadyAUser => 'Jesteś już użytkownikiem?';

  @override
  String get noProjectSelected => 'Nie wybrano projektu';

  @override
  String get noProjectsAvailable => 'Brak dostępnych projektów';

  @override
  String get chapterSavedSuccessfully => 'Rozdział zapisano pomyślnie!';

  @override
  String failedToSaveChapter(Object error) {
    return 'Nie udało się zapisać rozdziału: $error';
  }

  @override
  String get title => 'Tytuł';

  @override
  String get number => 'Numer';

  @override
  String get chapters => 'Rozdziały';

  @override
  String get noChapterAvailable => 'Brak dostępnych rozdziałów.';

  @override
  String get addNewProject => 'Dodaj nowy projekt';

  @override
  String get projectTitle => 'Tytuł projektu';

  @override
  String get pleaseEnterProjectTitle => 'Proszę wprowadzić tytuł projektu';

  @override
  String get projectDescription => 'Opis projektu';

  @override
  String get pleaseEnterDescription => 'Proszę wprowadzić opis';

  @override
  String get noImageSelected => 'Nie wybrano obrazu';

  @override
  String get addProject => 'Dodaj projekt';

  @override
  String get pleaseFillInAllFields => 'Proszę wypełnić wszystkie pola';

  @override
  String get chooseAProject => 'Wybierz projekt';

  @override
  String get workingOnToday => 'Nad którym dziś pracujemy?';

  @override
  String get failedToLoadProjects => 'Nie udało się załadować projektów';

  @override
  String get sidebarHome => 'Strona główna';

  @override
  String get sidebarNotes => 'Notatki';

  @override
  String get sidebarWriting => 'Pisanie';

  @override
  String get sidebarResearch => 'Badania';

  @override
  String get sidebarLogout => 'Wyloguj się';

  @override
  String get sidebarProjectTitle => 'Wybrany projekt';

  @override
  String get sidebarToggleCollapse => 'Rozwiń/Zwiń pasek boczny';

  @override
  String get addNewNote => 'Dodaj nową notatkę';

  @override
  String get saveNote => 'Zapisz';

  @override
  String get selectNoteType => 'Wybierz typ notatki';

  @override
  String get simpleNote => 'Prosta notatka';

  @override
  String get characterNote => 'Notatka o postaci';

  @override
  String get worldbuildingNote => 'Notatka o budowaniu świata';

  @override
  String get loading => 'Ładowanie...';

  @override
  String get noteNotFound => 'Notatka nie znaleziona';

  @override
  String errorMessage(Object message) {
    return 'Błąd: $message';
  }
}
