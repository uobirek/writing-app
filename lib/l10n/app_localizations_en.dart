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

  @override
  String get showAll => 'Show All';

  @override
  String get worldbuilding => 'Worldbuilding';

  @override
  String get characters => 'Characters';

  @override
  String get outline => 'Outline';

  @override
  String get noNotesAvailable => 'No notes available.';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get unsupportedNoteType => 'Unsupported note type';

  @override
  String get addItem => 'Add Item';

  @override
  String get edit => 'Edit';

  @override
  String get preview => 'Preview';

  @override
  String get delete => 'Delete';

  @override
  String get confirmDelete => 'Confirm Delete';

  @override
  String get areYouSureDeleteNote => 'Are you sure you want to delete this note?';

  @override
  String get characterDetails => 'Character Details';

  @override
  String get name => 'Name';

  @override
  String get role => 'Role';

  @override
  String get gender => 'Gender';

  @override
  String get age => 'Age';

  @override
  String get physicalAppearance => 'Physical Appearance';

  @override
  String get eyeColor => 'Eye Color';

  @override
  String get hairColor => 'Hair Color';

  @override
  String get skinColor => 'Skin Color';

  @override
  String get fashionStyle => 'Fashion Style';

  @override
  String get distinguishingFeatures => 'Distinguishing Features';

  @override
  String get notSpecified => 'Not specified';

  @override
  String get personalityTraits => 'Personality Traits';

  @override
  String get keyFamilyMembers => 'Key Family Members';

  @override
  String get notableEvents => 'Notable Events';

  @override
  String get characterGrowth => 'Character Growth';

  @override
  String get goals => 'Goals';

  @override
  String get internalConflicts => 'Internal Conflicts';

  @override
  String get externalConflicts => 'External Conflicts';

  @override
  String get coreValues => 'Core Values';

  @override
  String get outlineDetails => 'Outline Details';

  @override
  String get genre => 'Genre';

  @override
  String get themes => 'Themes';

  @override
  String get acts => 'Acts';

  @override
  String get conflicts => 'Conflicts';

  @override
  String get subplots => 'Subplots';

  @override
  String get notes => 'Notes';

  @override
  String get none => 'None';

  @override
  String get noActsAvailable => 'No acts available';

  @override
  String get worldbuildingDetails => 'Worldbuilding Details';

  @override
  String get placeName => 'Place Name';

  @override
  String get geography => 'Geography';

  @override
  String get culture => 'Culture';

  @override
  String get pointsOfInterest => 'Points of Interest';

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
