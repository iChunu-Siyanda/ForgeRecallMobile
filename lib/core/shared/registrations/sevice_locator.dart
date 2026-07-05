import 'package:forge_recall/core/shared/registrations/register_firebase_module.dart';
import 'package:forge_recall/core/shared/registrations/register_project_detail_module.dart';
import 'package:forge_recall/core/shared/registrations/register_question_module.dart';
import 'package:forge_recall/core/shared/registrations/register_recall_module.dart';
import 'package:forge_recall/core/shared/registrations/register_topic_module.dart';

Future<void> setupLocator() async {
  registerFirebaseModule();
  registerQuestionModule();
  //registerProjectsModule();
  registerProjectDetailModule();
  registerTopicModule();
  registerRecallModule();
}
