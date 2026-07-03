import 'package:forge_recall/core/shared/register_firebase_module.dart';
import 'package:forge_recall/core/shared/register_project_detail_module.dart';
import 'package:forge_recall/core/shared/register_question_module.dart';
import 'package:forge_recall/core/shared/register_recall_module.dart';
import 'package:forge_recall/core/shared/register_topic_module.dart';

Future<void> setupLocator() async {
  registerFirebaseModule();
  registerQuestionModule();
  //registerProjectsModule();
  registerProjectDetailModule();
  registerTopicModule();
  registerRecallModule();
}
