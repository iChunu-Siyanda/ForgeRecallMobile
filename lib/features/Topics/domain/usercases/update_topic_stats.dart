import 'package:flutter/material.dart';
import 'package:forge_recall/features/topics/domain/entities/update_stats_params.dart';
import 'package:forge_recall/features/topics/domain/repositories/topic_repository.dart';

class UpdateTopicStatsUseCase {
  final TopicRepository repository;

  UpdateTopicStatsUseCase(this.repository);

  Future<void> call(
    UpdateStatsParams params,
  ) async {
    debugPrint("UpdateTopicStatsUseCase ID:${params.topicId}");
    
    final existingTopic = await repository.fetchTopicById(
      params.topicId, params.projectId,
    );

    final updatedTopic = existingTopic.copyWith(
      masteryScore: params.masteryScore,
      cognitiveDifficulty: params.cognitiveDifficulty,
      studyCount: params.studyCount,
      lastStudiedAt: params.lastStudiedAt,
    );
    // debugPrint(existingTopic.masteryScore.toString());
    // debugPrint(updatedTopic.masteryScore.toString());
    // debugPrint(updatedTopic.studyCount.toString());
    // debugPrint('Awaiting Repository');
    await repository.updateTopicStats(
      updatedTopic,
    );
    //debugPrint('Repository finished');
  }
}
