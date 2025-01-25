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
  String get chapter_saved_successfully => '¡Capítulo guardado con éxito!';

  @override
  String failed_to_save_chapter(Object error) {
    return 'No se pudo guardar el capítulo: $error';
  }

  @override
  String get no_project_selected => 'Ningún proyecto seleccionado';

  @override
  String get title => 'Título';

  @override
  String get number => 'Número';

  @override
  String get chapters => 'Capítulos';

  @override
  String get no_chapter_available => 'No hay capítulos disponibles.';

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
}
