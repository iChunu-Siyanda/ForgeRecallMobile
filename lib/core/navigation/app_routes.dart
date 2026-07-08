class AppRoutes {
  AppRoutes._();
  //Splash
  static const splash = '/';

  //Auth
  static const auth = '/auth';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';

  //Projects
  static const projects = '/projects';
  static const projectDetailRoute = '/project-detail/:id';
  static String projectDetail(String id) => '/project-detail/$id';
  static const topicKnowledge = '/topic-knowledge';
  static const notesInput = '/notes-input';
  static const previewQuestions = '/questions-preview';
  static const recallSession = '/recall-session';
  static const sessionComplete = '/session-complete';
  
  //Search
  static const search = '/search';

  //Today
  static const today = '/today';

  //Library
  static const library = '/library';
  static const libraryTopic = '/library-topic';
  static const libraryProject = '/library-project';
  static const librarySavedQuestions = '/library-saved-questions';

  //Analytics
  static const analytics = '/analytics';

  //Profile
  static const profile = '/profile';
}
