import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get helloWorld => '¡Hola, mundo!';

  @override
  String get signInToContinue => 'Inicia sesión para continuar';

  @override
  String get email => 'Correo electrónico';

  @override
  String get pleaseEnterAnEmail => 'Por favor, introduce un correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get pleaseEnterAPassword => 'Por favor, introduce una contraseña';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get dontHaveAnAccount => '¿No tienes una cuenta?';

  @override
  String get register => 'Regístrate';

  @override
  String get loginFailed => 'Error al iniciar sesión. Por favor, verifica tu correo electrónico y contraseña.';

  @override
  String get error => 'Error';

  @override
  String get ok => 'Aceptar';

  @override
  String get createAnAccount => 'Crea una cuenta';

  @override
  String get fullName => 'Nombre completo';

  @override
  String get pleaseEnterYourName => 'Por favor, introduce tu nombre';

  @override
  String get alreadyHaveAnAccount => '¿Ya tienes una cuenta?';

  @override
  String get hiWelcomeTo => '¡Hola! Bienvenido a';

  @override
  String get fantasies => 'fantasías';

  @override
  String get perfectOrganizationTool => 'La herramienta perfecta para organizar la escritura, la creación de mundos y la planificación';

  @override
  String get getStartedNow => 'Comienza ahora';

  @override
  String get alreadyAUser => '¿Ya eres usuario?';

  @override
  String get noProjectSelected => 'Ningún proyecto seleccionado';

  @override
  String get noProjectsAvailable => 'No hay proyectos disponibles';

  @override
  String get chapterSavedSuccessfully => '¡Capítulo guardado con éxito!';

  @override
  String failedToSaveChapter(Object error) {
    return 'No se pudo guardar el capítulo: $error';
  }

  @override
  String get title => 'Título';

  @override
  String get number => 'Número';

  @override
  String get chapters => 'Capítulos';

  @override
  String get noChapterAvailable => 'No hay capítulos disponibles.';

  @override
  String get addNewProject => 'Agregar nuevo proyecto';

  @override
  String get projectTitle => 'Título del proyecto';

  @override
  String get pleaseEnterProjectTitle => 'Por favor, ingrese un título para el proyecto';

  @override
  String get projectDescription => 'Descripción del proyecto';

  @override
  String get pleaseEnterDescription => 'Por favor, ingrese una descripción';

  @override
  String get noImageSelected => 'No se ha seleccionado ninguna imagen';

  @override
  String get addProject => 'Agregar proyecto';

  @override
  String get pleaseFillInAllFields => 'Por favor, complete todos los campos';

  @override
  String get chooseAProject => 'Elige un proyecto';

  @override
  String get workingOnToday => '¿En cuál trabajaremos hoy?';

  @override
  String get failedToLoadProjects => 'Error al cargar los proyectos';

  @override
  String get sidebarHome => 'Inicio';

  @override
  String get sidebarNotes => 'Notas';

  @override
  String get sidebarWriting => 'Escritura';

  @override
  String get sidebarResearch => 'Investigación';

  @override
  String get sidebarLogout => 'Cerrar sesión';

  @override
  String get sidebarProjectTitle => 'Proyecto seleccionado';

  @override
  String get sidebarToggleCollapse => 'Expandir/Colapsar barra lateral';

  @override
  String get addNewNote => 'Agregar nueva nota';

  @override
  String get saveNote => 'Guardar';

  @override
  String get selectNoteType => 'Seleccionar tipo de nota';

  @override
  String get simpleNote => 'Nota simple';

  @override
  String get characterNote => 'Nota de personaje';

  @override
  String get worldbuildingNote => 'Nota de creación de mundos';

  @override
  String get loading => 'Cargando...';

  @override
  String get noteNotFound => 'Nota no encontrada';

  @override
  String errorMessage(Object message) {
    return 'Error: $message';
  }

  @override
  String get showAll => 'Mostrar todo';

  @override
  String get worldbuilding => 'Creación de mundos';

  @override
  String get characters => 'Personajes';

  @override
  String get outline => 'Esquema';

  @override
  String get noNotesAvailable => 'No hay notas disponibles.';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get unsupportedNoteType => 'Tipo de nota no compatible';

  @override
  String get addItem => 'Agregar elemento';

  @override
  String get edit => 'Editar';

  @override
  String get preview => 'Vista previa';

  @override
  String get delete => 'Eliminar';

  @override
  String get confirmDelete => 'Confirmar eliminación';

  @override
  String get areYouSureDeleteNote => '¿Estás seguro de que deseas eliminar esta nota?';
}
