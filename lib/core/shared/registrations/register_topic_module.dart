import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forge_recall/features/questions/data/datasource/questions_remote_datasource.dart';
import 'package:forge_recall/features/topics/data/datasource/topic_remote_datasource.dart';
import 'package:forge_recall/features/topics/data/repositories/topic_remote_datasource_impl.dart';
import 'package:forge_recall/features/topics/data/repositories/topic_repository_impl.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';
import 'package:forge_recall/features/topics/domain/usercases/create_topic.dart';
import 'package:forge_recall/features/topics/domain/usercases/delete_topic.dart';
import 'package:forge_recall/features/topics/domain/usercases/get_topics.dart';
import 'package:forge_recall/features/topics/domain/usercases/toggle_favorite_use_case.dart';
import 'package:forge_recall/features/topics/domain/usercases/update_topic.dart';
import 'package:forge_recall/features/topics/presentation/bloc/topic_bloc.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

void registerTopicModule() {
  //Datasources
  getIt.registerLazySingleton<TopicRemoteDatasource>(
    () => TopicRemoteDatasourceImpl(getIt<FirebaseFirestore>(),),
  );

  //Repositories
  getIt.registerLazySingleton<TopicRepository>(
    () => TopicRepositoryImpl(
      getIt<TopicRemoteDatasource>(),
      getIt<QuestionsRemoteDatasource>(),
    ),
  );
  
  //Usecases
  getIt.registerLazySingleton(
    () => CreateTopicUseCase(getIt(),),
  );

  getIt.registerLazySingleton(
    () => UpdateTopicUseCase(getIt(),),
  );

  getIt.registerLazySingleton(
    () => GetTopicsUseCase(getIt(),),
  );

  getIt.registerLazySingleton(
    () => DeleteTopicUseCase(getIt(),),
  );

  getIt.registerLazySingleton(
    () => ToggleFavoriteUseCase(getIt(),),
  );
  
  //Bloc
  getIt.registerFactory(
    () => TopicBloc.name(
      createTopic: getIt(),
      updateTopic: getIt(),
      getTopics: getIt(),
      deleteTopic: getIt(),
      toggleFavorite: getIt(),
    ),
  );
}
