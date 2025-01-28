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
  String get fantasies => 'fantasies';

  @override
  String get perfectOrganizationTool => 'Idealne narzędzie do organizacji pisania, worldbuildingu i planowania';

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
  String get workingOnToday => 'Nad którym projektem chcesz dzisiaj pracować?';

  @override
  String get failedToLoadProjects => 'Nie udało się załadować projektów';

  @override
  String get sidebarHome => 'Strona główna';

  @override
  String get sidebarNotes => 'Notatki';

  @override
  String get sidebarWriting => 'Pisanie';

  @override
  String get sidebarResearch => 'Research';

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

  @override
  String get showAll => 'Pokaż wszystko';

  @override
  String get worldbuilding => 'Worldbuilding';

  @override
  String get characters => 'Postacie';

  @override
  String get outline => 'Outline';

  @override
  String get noNotesAvailable => 'Brak dostępnych notatek.';

  @override
  String get saveChanges => 'Zapisz zmiany';

  @override
  String get unsupportedNoteType => 'Nieobsługiwany typ notatki';

  @override
  String get addItem => 'Dodaj element';

  @override
  String get edit => 'Edytuj';

  @override
  String get preview => 'Podgląd';

  @override
  String get delete => 'Usuń';

  @override
  String get confirmDelete => 'Potwierdź usunięcie';

  @override
  String get areYouSureDeleteNote => 'Czy na pewno chcesz usunąć tę notatkę?';

  @override
  String get characterDetails => 'Szczegóły Postaci';

  @override
  String get name => 'Imię';

  @override
  String get role => 'Rola';

  @override
  String get gender => 'Płeć';

  @override
  String get age => 'Wiek';

  @override
  String get physicalAppearance => 'Wygląd Fizyczny';

  @override
  String get eyeColor => 'Kolor Oczu';

  @override
  String get hairColor => 'Kolor Włosów';

  @override
  String get skinColor => 'Kolor Skóry';

  @override
  String get fashionStyle => 'Styl Ubioru';

  @override
  String get distinguishingFeatures => 'Cecha Charakterystyczna';

  @override
  String get notSpecified => 'Nie określono';

  @override
  String get personalityTraits => 'Cechy Osobowości';

  @override
  String get keyFamilyMembers => 'Kluczowi Członkowie Rodziny';

  @override
  String get notableEvents => 'Ważne Wydarzenia';

  @override
  String get characterGrowth => 'Rozwój Postaci';

  @override
  String get goals => 'Cele';

  @override
  String get internalConflicts => 'Konflikty Wewnętrzne';

  @override
  String get externalConflicts => 'Konflikty Zewnętrzne';

  @override
  String get coreValues => 'Podstawowe Wartości';

  @override
  String get outlineDetails => 'Szczegóły Zarysu';

  @override
  String get genre => 'Gatunek';

  @override
  String get themes => 'Motywy';

  @override
  String get acts => 'Akty';

  @override
  String get conflicts => 'Konflikty';

  @override
  String get subplots => 'Wątki Poboczne';

  @override
  String get notes => 'Notatki';

  @override
  String get none => 'Brak';

  @override
  String get noActsAvailable => 'Brak dostępnych aktów';

  @override
  String get worldbuildingDetails => 'Szczegóły Świata';

  @override
  String get placeName => 'Nazwa Miejsca';

  @override
  String get geography => 'Geografia';

  @override
  String get culture => 'Kultura';

  @override
  String get pointsOfInterest => 'Ważne miejsca';

  @override
  String get personality => 'Personality';

  @override
  String get hobbiesAndSkills => 'Hobbies and Skills';

  @override
  String get otherPersonalityDetails => 'Other Personality Details';

  @override
  String get history => 'History';

  @override
  String get cancel => 'Cancel';
}
