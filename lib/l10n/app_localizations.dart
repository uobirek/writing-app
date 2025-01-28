import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pl')
  ];

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInToContinue;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @pleaseEnterAnEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter an email'**
  String get pleaseEnterAnEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @pleaseEnterAPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get pleaseEnterAPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your email and password.'**
  String get loginFailed;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAnAccount;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @pleaseEnterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterYourName;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @hiWelcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Hi! Welcome to'**
  String get hiWelcomeTo;

  /// No description provided for @fantasies.
  ///
  /// In en, this message translates to:
  /// **'fantasies'**
  String get fantasies;

  /// No description provided for @perfectOrganizationTool.
  ///
  /// In en, this message translates to:
  /// **'Perfect organization tool for writing, worldbuilding, and outlining'**
  String get perfectOrganizationTool;

  /// No description provided for @getStartedNow.
  ///
  /// In en, this message translates to:
  /// **'Get started now'**
  String get getStartedNow;

  /// No description provided for @alreadyAUser.
  ///
  /// In en, this message translates to:
  /// **'Already a User?'**
  String get alreadyAUser;

  /// No description provided for @noProjectSelected.
  ///
  /// In en, this message translates to:
  /// **'No project selected'**
  String get noProjectSelected;

  /// No description provided for @noProjectsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No projects available'**
  String get noProjectsAvailable;

  /// No description provided for @chapterSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Chapter saved successfully!'**
  String get chapterSavedSuccessfully;

  /// No description provided for @failedToSaveChapter.
  ///
  /// In en, this message translates to:
  /// **'Failed to save chapter: {error}'**
  String failedToSaveChapter(Object error);

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get number;

  /// No description provided for @chapters.
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get chapters;

  /// No description provided for @noChapterAvailable.
  ///
  /// In en, this message translates to:
  /// **'No chapter available.'**
  String get noChapterAvailable;

  /// No description provided for @addNewProject.
  ///
  /// In en, this message translates to:
  /// **'Add New Project'**
  String get addNewProject;

  /// No description provided for @projectTitle.
  ///
  /// In en, this message translates to:
  /// **'Project Title'**
  String get projectTitle;

  /// No description provided for @pleaseEnterProjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter a project title'**
  String get pleaseEnterProjectTitle;

  /// No description provided for @projectDescription.
  ///
  /// In en, this message translates to:
  /// **'Project Description'**
  String get projectDescription;

  /// No description provided for @pleaseEnterDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get pleaseEnterDescription;

  /// No description provided for @noImageSelected.
  ///
  /// In en, this message translates to:
  /// **'No image selected'**
  String get noImageSelected;

  /// No description provided for @addProject.
  ///
  /// In en, this message translates to:
  /// **'Add Project'**
  String get addProject;

  /// No description provided for @pleaseFillInAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields'**
  String get pleaseFillInAllFields;

  /// No description provided for @chooseAProject.
  ///
  /// In en, this message translates to:
  /// **'Choose a project'**
  String get chooseAProject;

  /// No description provided for @workingOnToday.
  ///
  /// In en, this message translates to:
  /// **'Which one are we working on today?'**
  String get workingOnToday;

  /// No description provided for @failedToLoadProjects.
  ///
  /// In en, this message translates to:
  /// **'Failed to load projects'**
  String get failedToLoadProjects;

  /// No description provided for @sidebarHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get sidebarHome;

  /// No description provided for @sidebarNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get sidebarNotes;

  /// No description provided for @sidebarWriting.
  ///
  /// In en, this message translates to:
  /// **'Writing'**
  String get sidebarWriting;

  /// No description provided for @sidebarResearch.
  ///
  /// In en, this message translates to:
  /// **'Research'**
  String get sidebarResearch;

  /// No description provided for @sidebarLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get sidebarLogout;

  /// No description provided for @sidebarProjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Selected Project'**
  String get sidebarProjectTitle;

  /// No description provided for @sidebarToggleCollapse.
  ///
  /// In en, this message translates to:
  /// **'Expand/Collapse Sidebar'**
  String get sidebarToggleCollapse;

  /// No description provided for @addNewNote.
  ///
  /// In en, this message translates to:
  /// **'Add New Note'**
  String get addNewNote;

  /// No description provided for @saveNote.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveNote;

  /// No description provided for @selectNoteType.
  ///
  /// In en, this message translates to:
  /// **'Select Note Type'**
  String get selectNoteType;

  /// No description provided for @simpleNote.
  ///
  /// In en, this message translates to:
  /// **'Simple Note'**
  String get simpleNote;

  /// No description provided for @characterNote.
  ///
  /// In en, this message translates to:
  /// **'Character Note'**
  String get characterNote;

  /// No description provided for @worldbuildingNote.
  ///
  /// In en, this message translates to:
  /// **'Worldbuilding Note'**
  String get worldbuildingNote;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @noteNotFound.
  ///
  /// In en, this message translates to:
  /// **'Note not found'**
  String get noteNotFound;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorMessage(Object message);

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show All'**
  String get showAll;

  /// No description provided for @worldbuilding.
  ///
  /// In en, this message translates to:
  /// **'Worldbuilding'**
  String get worldbuilding;

  /// No description provided for @characters.
  ///
  /// In en, this message translates to:
  /// **'Characters'**
  String get characters;

  /// No description provided for @outline.
  ///
  /// In en, this message translates to:
  /// **'Outline'**
  String get outline;

  /// No description provided for @noNotesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No notes available.'**
  String get noNotesAvailable;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @unsupportedNoteType.
  ///
  /// In en, this message translates to:
  /// **'Unsupported note type'**
  String get unsupportedNoteType;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get confirmDelete;

  /// No description provided for @areYouSureDeleteNote.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this note?'**
  String get areYouSureDeleteNote;

  /// No description provided for @characterDetails.
  ///
  /// In en, this message translates to:
  /// **'Character Details'**
  String get characterDetails;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @physicalAppearance.
  ///
  /// In en, this message translates to:
  /// **'Physical Appearance'**
  String get physicalAppearance;

  /// No description provided for @eyeColor.
  ///
  /// In en, this message translates to:
  /// **'Eye Color'**
  String get eyeColor;

  /// No description provided for @hairColor.
  ///
  /// In en, this message translates to:
  /// **'Hair Color'**
  String get hairColor;

  /// No description provided for @skinColor.
  ///
  /// In en, this message translates to:
  /// **'Skin Color'**
  String get skinColor;

  /// No description provided for @fashionStyle.
  ///
  /// In en, this message translates to:
  /// **'Fashion Style'**
  String get fashionStyle;

  /// No description provided for @distinguishingFeatures.
  ///
  /// In en, this message translates to:
  /// **'Distinguishing Features'**
  String get distinguishingFeatures;

  /// No description provided for @notSpecified.
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get notSpecified;

  /// No description provided for @personalityTraits.
  ///
  /// In en, this message translates to:
  /// **'Personality Traits'**
  String get personalityTraits;

  /// No description provided for @keyFamilyMembers.
  ///
  /// In en, this message translates to:
  /// **'Key Family Members'**
  String get keyFamilyMembers;

  /// No description provided for @notableEvents.
  ///
  /// In en, this message translates to:
  /// **'Notable Events'**
  String get notableEvents;

  /// No description provided for @characterGrowth.
  ///
  /// In en, this message translates to:
  /// **'Character Growth'**
  String get characterGrowth;

  /// No description provided for @goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goals;

  /// No description provided for @internalConflicts.
  ///
  /// In en, this message translates to:
  /// **'Internal Conflicts'**
  String get internalConflicts;

  /// No description provided for @externalConflicts.
  ///
  /// In en, this message translates to:
  /// **'External Conflicts'**
  String get externalConflicts;

  /// No description provided for @coreValues.
  ///
  /// In en, this message translates to:
  /// **'Core Values'**
  String get coreValues;

  /// No description provided for @outlineDetails.
  ///
  /// In en, this message translates to:
  /// **'Outline Details'**
  String get outlineDetails;

  /// No description provided for @genre.
  ///
  /// In en, this message translates to:
  /// **'Genre'**
  String get genre;

  /// No description provided for @themes.
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get themes;

  /// No description provided for @acts.
  ///
  /// In en, this message translates to:
  /// **'Acts'**
  String get acts;

  /// No description provided for @conflicts.
  ///
  /// In en, this message translates to:
  /// **'Conflicts'**
  String get conflicts;

  /// No description provided for @subplots.
  ///
  /// In en, this message translates to:
  /// **'Subplots'**
  String get subplots;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @noActsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No acts available'**
  String get noActsAvailable;

  /// No description provided for @worldbuildingDetails.
  ///
  /// In en, this message translates to:
  /// **'Worldbuilding Details'**
  String get worldbuildingDetails;

  /// No description provided for @placeName.
  ///
  /// In en, this message translates to:
  /// **'Place Name'**
  String get placeName;

  /// No description provided for @geography.
  ///
  /// In en, this message translates to:
  /// **'Geography'**
  String get geography;

  /// No description provided for @culture.
  ///
  /// In en, this message translates to:
  /// **'Culture'**
  String get culture;

  /// No description provided for @pointsOfInterest.
  ///
  /// In en, this message translates to:
  /// **'Points of Interest'**
  String get pointsOfInterest;

  /// No description provided for @personality.
  ///
  /// In en, this message translates to:
  /// **'Personality'**
  String get personality;

  /// No description provided for @hobbiesAndSkills.
  ///
  /// In en, this message translates to:
  /// **'Hobbies and Skills'**
  String get hobbiesAndSkills;

  /// No description provided for @otherPersonalityDetails.
  ///
  /// In en, this message translates to:
  /// **'Other Personality Details'**
  String get otherPersonalityDetails;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @failedToUpdateProject.
  ///
  /// In en, this message translates to:
  /// **'Failed to update project'**
  String get failedToUpdateProject;

  /// No description provided for @projectUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Project updated successfully'**
  String get projectUpdatedSuccessfully;

  /// No description provided for @userNotLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'User is not logged in'**
  String get userNotLoggedIn;

  /// No description provided for @enterProjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter project title'**
  String get enterProjectTitle;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already in use. Try logging in.'**
  String get emailAlreadyInUse;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Your password is too weak. Use a stronger one.'**
  String get weakPassword;

  /// No description provided for @operationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Account creation is currently disabled.'**
  String get operationNotAllowed;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed. Please try again later.'**
  String get registrationFailed;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get unexpectedError;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @goToProjects.
  ///
  /// In en, this message translates to:
  /// **'Go to Projects'**
  String get goToProjects;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logoutFailed.
  ///
  /// In en, this message translates to:
  /// **'Logout failed'**
  String get logoutFailed;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'pl': return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
