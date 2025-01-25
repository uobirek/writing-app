import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get email => 'Email';

  @override
  String get pleaseEnterAnEmail => 'Please enter an email';

  @override
  String get password => 'Password';

  @override
  String get pleaseEnterAPassword => 'Please enter a password';

  @override
  String get login => 'Login';

  @override
  String get dontHaveAnAccount => 'Don\'t have an account?';

  @override
  String get register => 'Register';

  @override
  String get loginFailed => 'Login failed. Please check your email and password.';

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get createAnAccount => 'Create an account';

  @override
  String get fullName => 'Full Name';

  @override
  String get pleaseEnterYourName => 'Please enter your name';

  @override
  String get alreadyHaveAnAccount => 'Already have an account?';

  @override
  String get hiWelcomeTo => 'Hi! Welcome to';

  @override
  String get fantasies => 'fantasies';

  @override
  String get perfectOrganizationTool => 'Perfect organization tool for writing, worldbuilding, and outlining';

  @override
  String get getStartedNow => 'Get started now';

  @override
  String get alreadyAUser => 'Already a User?';

  @override
  String get noProjectSelected => 'No project selected';

  @override
  String get noProjectsAvailable => 'No projects available';

  @override
  String get chapterSavedSuccessfully => 'Chapter saved successfully!';

  @override
  String failedToSaveChapter(Object error) {
    return 'Failed to save chapter: $error';
  }

  @override
  String get title => 'Title';

  @override
  String get number => 'Number';

  @override
  String get chapters => 'Chapters';

  @override
  String get noChapterAvailable => 'No chapter available.';

  @override
  String get addNewProject => 'Add New Project';

  @override
  String get projectTitle => 'Project Title';

  @override
  String get pleaseEnterProjectTitle => 'Please enter a project title';

  @override
  String get projectDescription => 'Project Description';

  @override
  String get pleaseEnterDescription => 'Please enter a description';

  @override
  String get noImageSelected => 'No image selected';

  @override
  String get addProject => 'Add Project';

  @override
  String get pleaseFillInAllFields => 'Please fill in all fields';

  @override
  String get chooseAProject => 'Choose a project';

  @override
  String get workingOnToday => 'Which one are we working on today?';

  @override
  String get failedToLoadProjects => 'Failed to load projects';

  @override
  String get sidebarHome => 'Home';

  @override
  String get sidebarNotes => 'Notes';

  @override
  String get sidebarWriting => 'Writing';

  @override
  String get sidebarResearch => 'Research';

  @override
  String get sidebarLogout => 'Logout';

  @override
  String get sidebarProjectTitle => 'Selected Project';

  @override
  String get sidebarToggleCollapse => 'Expand/Collapse Sidebar';

  @override
  String get addNewNote => 'Add New Note';

  @override
  String get saveNote => 'Save';

  @override
  String get selectNoteType => 'Select Note Type';

  @override
  String get simpleNote => 'Simple Note';

  @override
  String get characterNote => 'Character Note';

  @override
  String get worldbuildingNote => 'Worldbuilding Note';

  @override
  String get loading => 'Loading...';

  @override
  String get noteNotFound => 'Note not found';

  @override
  String errorMessage(Object message) {
    return 'Error: $message';
  }
}
