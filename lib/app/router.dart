import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/analytics/presentation/pages/analytics.dart';
import 'package:forge_recall/features/auth/presentation/navigation/auth_firebase.dart';
import 'package:forge_recall/features/auth/presentation/page/forgot_password_page.dart';
import 'package:forge_recall/features/auth/presentation/page/login_page.dart';
import 'package:forge_recall/features/auth/presentation/page/register_page.dart';
import 'package:forge_recall/features/profile/presentation/pages/profile.dart';
import 'package:forge_recall/features/projects/presentation/pages/project_detail_screen.dart';
import 'package:forge_recall/features/projects/presentation/pages/projects.dart';
import 'package:forge_recall/features/questions/domain/entities/question_entity.dart';
import 'package:forge_recall/features/questions/presentation/pages/notes_input_page.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_bloc.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_event.dart';
import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_state.dart';
import 'package:forge_recall/features/recall/presentation/pages/recall.dart';
import 'package:forge_recall/features/recall/presentation/pages/recall_session_page.dart';
import 'package:forge_recall/features/recall/presentation/pages/session_complete_page.dart';
import 'package:forge_recall/features/splash/presentation/pages/splash.dart';
import 'package:forge_recall/core/navigation/main_navigation.dart';
import 'package:forge_recall/features/dashboard/presentation/pages/dashboard.dart';
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

      GoRoute(
        path: '/topicsKnowledgePage',
        builder: (context, state) {
          final topicEntity = state.extra as TopicEntity;
          return TopicKnowledgePage(topic: topicEntity);
        }
      ),

      GoRoute(
        path: '/notesInput',
        builder: (context, state) {
          final topic = state.extra as TopicEntity;

          return NotesInputPage(
            topic: topic,
          );
        },
      ),

      GoRoute(
        path: '/recall-session',
        builder: (context, state) {
          final questions = state.extra as List<QuestionEntity>;

          return BlocProvider(
            create: (_) => RecallLabBloc()..add(StartRecallSessionEvent(questions,),),
            child: const RecallSessionPage(),
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
          return MainNavigation(child: child);
        },

        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const Dashboard(),
          ),

          GoRoute(
            path: '/projects',
            builder: (context, state) {
                return const Projects();
            },
          ),

          GoRoute(
            path: '/recall',
            builder: (context, state) {
              final questions =
                  state.extra as List<QuestionEntity>;

              return RecallPage(
                questions: questions,
              );
            },
          ),

          GoRoute(
            path: '/analytics',
            builder: (context, state) => const Analytics(),
          ),

          GoRoute(
            path: '/profile',
            builder: (context, state) => const Profile(),
          ),
        ],
      ),
    ],
  );
}
