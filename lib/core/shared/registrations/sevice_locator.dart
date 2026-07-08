import 'package:forge_recall/core/shared/registrations/register_firebase_module.dart';
import 'package:forge_recall/core/shared/registrations/register_library_module.dart';
import 'package:forge_recall/core/shared/registrations/register_project_detail_module.dart';
import 'package:forge_recall/core/shared/registrations/register_projects_module.dart';
import 'package:forge_recall/core/shared/registrations/register_question_module.dart';
import 'package:forge_recall/core/shared/registrations/register_recall_module.dart';
import 'package:forge_recall/core/shared/registrations/register_today_module.dart';
import 'package:forge_recall/core/shared/registrations/register_topic_module.dart';

Future<void> setupLocator() async {
  registerFirebaseModule();
  registerQuestionModule();
  registerProjectsModule();
  registerLibraryModule();
  registerProjectDetailModule();
  registerTopicModule();
  registerTodayModule();
  registerRecallModule();
}
