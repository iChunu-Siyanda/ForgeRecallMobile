import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forge_recall/features/questions/data/repositories/questions_remote_datasource_impl.dart';
import 'package:forge_recall/features/questions/data/repositories/questions_repository_impl.dart';
import 'package:forge_recall/features/questions/domain/usecases/get_topics_questions_user_case.dart';
import 'package:forge_recall/features/questions/domain/usecases/save_questions_use_case.dart';
import 'package:forge_recall/features/topics/data/repositories/topic_remote_datasource_impl.dart';
import 'package:forge_recall/features/topics/data/repositories/topic_repository_impl.dart';
import 'package:forge_recall/features/topics/domain/usercases/create_topic.dart';
import 'package:forge_recall/features/topics/domain/usercases/delete_topic.dart';
import 'package:forge_recall/features/topics/domain/usercases/get_topics.dart';
import 'package:forge_recall/features/topics/domain/usercases/update_topic.dart';

class AppDependencies {
  static final firestore = FirebaseFirestore.instance;

  //Questions
  static final questionsDatasource =  QuestionsRemoteDatasourceImpl(firestore,);
  static final questionsRepository =  QuestionsRepositoryImpl(questionsDatasource,);
  static final saveQuestionsUseCase = SaveQuestionsUseCase(questionsRepository,);
  static final getQuestionsUseCase =  GetTopicsQuestionsUseCase(questionsRepository,);

  //Topics
  static final topicsDatasource = TopicRemoteDatasourceImpl(firestore,);
  static final topicRepository = TopicRepositoryImpl(topicsDatasource,questionsDatasource);
  static final createTopic = CreateTopicUseCase(topicRepository); 
  static final updateTopic = UpdateTopicUseCase(topicRepository);
  static final getTopics = GetTopicsUseCase(topicRepository);
  static final deleteTopic = DeleteTopicUseCase(topicRepository);
}

// The instance member 'topicsDatasource' can't be accessed in an initializer.
// Try replacing the reference to the instance member with a different expressiondartimplicit_this_reference_in_initializer
// TopicRemoteDatasourceImpl get topicsDatasource
// Type: TopicRemoteDatasourceImpl

// Why is the questionsDatasource not giving this error
// The reason questionsDatasource isn't giving you an error, while topicsDatasource is, comes down to one single keyword: static.
// Here is exactly what is happening under the hood and how to fix it.
// The Root Cause: static vs instance fields
// In Dart, when a class is being initialized, its instance fields (fields without the static keyword) are all created at the same time. Because they are being born at the very same moment, they are not allowed to look at or depend on each other during initialization.
// Why the Questions section works
// You marked everything in the Questions section as static final.
// Static variables belong to the class itself, not to a specific instance of the class. Because they are static, Dart initializes them in a safe, sequential order. questionsRepository is allowed to look at questionsDatasource because they are both static class-level constants.
// Why the Topics section fails
// You omitted the static keyword for the Topics variables. Because they are regular instance variables, Dart tries to initialize them all at once when an object of AppDependencies is created.
// When topicRepository tries to read topicsDatasource, Dart panics and says: "Whoa, hold on! topicsDatasource belongs to the instance, but the instance isn't fully built yet. I can't let you read it yet."
