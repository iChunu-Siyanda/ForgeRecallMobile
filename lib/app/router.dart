import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/core/shared/app_dependencies.dart';
import 'package:forge_recall/features/analytics/presentation/pages/analytics.dart';
import 'package:forge_recall/features/auth/presentation/navigation/auth_firebase.dart';
import 'package:forge_recall/features/auth/presentation/page/forgot_password_page.dart';
import 'package:forge_recall/features/auth/presentation/page/login_page.dart';
import 'package:forge_recall/features/auth/presentation/page/register_page.dart';
import 'package:forge_recall/features/library/presentation/pages/library_page.dart';
import 'package:forge_recall/features/profile/presentation/pages/profile.dart';
import 'package:forge_recall/features/projects/presentation/pages/project_detail_screen.dart';
import 'package:forge_recall/features/projects/presentation/pages/projects.dart';
import 'package:forge_recall/features/questions/domain/entities/question_preview_params.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_bloc.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionFetching/questions_event.dart';
import 'package:forge_recall/features/questions/presentation/bloc/questionGeneration/questions_generation_bloc.dart';
import 'package:forge_recall/features/questions/presentation/pages/notes_input_page.dart';
import 'package:forge_recall/features/questions/presentation/pages/questions_preview_page.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_bloc.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_state.dart';
import 'package:forge_recall/features/recall/presentation/pages/recall_session_page.dart';
import 'package:forge_recall/features/recall/presentation/pages/session_complete_page.dart';
import 'package:forge_recall/features/search/presentation/pages/search_page.dart';
import 'package:forge_recall/features/splash/presentation/pages/splash.dart';
import 'package:forge_recall/core/navigation/main_navigation.dart';
import 'package:forge_recall/features/today/presentation/pages/today_page.dart';
import 'package:forge_recall/features/topics/data/repositories/topic_remote_datasource_impl.dart';
import 'package:forge_recall/features/topics/data/repositories/topic_repository_impl.dart';
import 'package:forge_recall/features/topics/domain/entities/topic_entity.dart';
import 'package:forge_recall/features/topics/domain/usercases/create_topic.dart';
import 'package:forge_recall/features/topics/domain/usercases/delete_topic.dart';
import 'package:forge_recall/features/topics/domain/usercases/get_topics.dart';
import 'package:forge_recall/features/topics/domain/usercases/update_topic.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topic_bloc.dart';
import 'package:forge_recall/features/topics/presentation/pages/topic_knowledge_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const Splash()),

      GoRoute(path: '/auth', builder: (context, state) => const AuthFirebase()),

      GoRoute(
        path: '/login_page',
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: '/register_page',
        builder: (context,state) => const RegisterPage(),
      ),

      GoRoute(
        path: '/forgot_password_page',
        builder: (context, state) => const ForgotPasswordPage(),
      ),

      //1.
      GoRoute(
        path: '/projectDetail/:id',
        builder: (context, state) {
          final projectId = state.pathParameters['id']!;
          final firestore = FirebaseFirestore.instance;
          final datasource = TopicRemoteDatasourceImpl(firestore);
          final topicRepository = TopicRepositoryImpl(datasource);
          final createTopic = CreateTopicUseCase(topicRepository); 
          final updateTopic = UpdateTopicUseCase(topicRepository);
          final getTopics = GetTopicsUseCase(topicRepository);
          final deleteTopic = DeleteTopicUseCase(topicRepository);

          return BlocProvider(
            create: (_) => TopicBloc.name(
              createTopic: createTopic, 
              updateTopic: updateTopic, 
              getTopics: getTopics, 
              deleteTopic: deleteTopic,
            ),
            child: ProjectDetailScreen(
              projectId: projectId,
            ),
          );
        },
      ),

      //2.
      GoRoute(
        path: '/topicsKnowledgePage',
        builder: (context, state) {
          final topicEntity = state.extra as TopicEntity;
          return TopicKnowledgePage(topic: topicEntity);
        }
      ),

      //3.
      GoRoute(
        path: '/notesInput',
        builder: (context, state) {
          final topic = state.extra as TopicEntity;

          return NotesInputPage(
            topic: topic,
          );
        },
      ),

      //4.
      GoRoute(
        path: '/questionsPreviewPage',
        builder: (context, state) {
          final args = state.extra as QuestionPreviewParams;

          return BlocProvider(
            create: (_) => QuestionsGenerationBloc(AppDependencies.saveQuestionsUseCase,),
            child: QuestionsPreviewPage(
              topic: args.topic,
              note: args.note,
            ),
          );
        },
      ),

      //5.
      GoRoute(
        path: '/recall-session',
        builder: (context, state) {
          final topic = state.extra as TopicEntity;
          debugPrint('TOPIC: ${topic.title}');
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                lazy: false,
                create: (_){ 
                debugPrint('CREATING QUESTIONS BLOC');
                return QuestionsBloc(AppDependencies.getQuestionsUseCase,)..add(QuestionsLoadedEvent(topic.projectId,topic.id),);
              }),
              BlocProvider(
                create: (_){
                debugPrint('CREATING RECALL BLOC');
                return RecallLabBloc();
              }),
            ],

            child: RecallSessionPage(topic: topic,),
          );
        },
      ),

      GoRoute(
        path: '/session-complete',
        builder: (context, state) {
          final result = state.extra as RecallLabCompleted;

          return SessionCompletePage(
            totalQuestions: result.totalQuestions,
            easyCount: result.easyCount,
            partialCount: result.partialCount,
            forgotCount: result.forgotCount,
          );
        },
      ),
      
      ShellRoute(
        builder: (context, state, child) {
          return MainNavigation(
            child: child,
          );
        },

        routes: [
          GoRoute(
            path: '/projects',
            builder: (context, state) {
              return Projects();
            },
          ),

          GoRoute(
            path: '/search',
            builder: (context, state) {
              return const SearchPage();
            },
          ),

          GoRoute(
            path: '/today',
            builder: (context, state) {
              return const TodayPage();
            },
          ),

          GoRoute(
            path: '/library',
            builder: (context, state) {
              return const LibraryPage();
            },
          ),

          GoRoute(
            path: '/analytics',
            builder: (context, state) {
              return const Analytics();
            },
          ),

          GoRoute(
            path: '/profile',
            builder: (context, state) {
              return const Profile();
            },
          ),
        ],
      ),
    ],
  );
}
