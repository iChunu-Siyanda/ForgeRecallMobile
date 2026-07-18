import 'package:forge_recall/core/shared/entites/topic_query.dart';
import 'package:forge_recall/features/projects/domain/entities/project_card_entity.dart';
import 'package:forge_recall/features/projects/domain/entities/project_stats.dart';
import 'package:forge_recall/features/projects/domain/repositories/project_repository.dart';
import 'package:forge_recall/features/projects/presentation/services/calculate_project_stats.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetProjects {
  final ProjectRepository projectRepository;
  final TopicRepository topicRepository;
  final ProjectStats projectStats;
  GetProjects({
    required this.projectRepository,
    required this.topicRepository, 
    required this.projectStats,
  });

  Stream<List<ProjectCardEntity>> call(String userId) {
    return projectRepository.getProjects(userId).switchMap((projects){
      if(projects.isEmpty){
        return Stream.value(<ProjectCardEntity>[]);
      }

      final streams = projects.map((project){
        return topicRepository.getTopics(TopicQuery(projectId: project.id)).map((topic){
          final stats = CalculateProjectStats.calculateStatistics(topic);

          return ProjectCardEntity(
            project: project, 
            masteryPercentage: stats.masteryPercentage, 
            totalTopics: stats.totalTopics,
            dueTopics: stats.dueTopics, 
            daysSinceStudy: stats.daysSinceStudy, 
            lastStudied: stats.lastStudied, 
          );
        });
      });

      return Rx.combineLatestList(streams,);
    });
  } 
}
