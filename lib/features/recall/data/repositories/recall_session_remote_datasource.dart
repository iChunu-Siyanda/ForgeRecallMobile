import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forge_recall/features/recall/data/datasource/recall_session_remote_datasource.dart';
import 'package:forge_recall/features/recall/data/model/recall_session_modal.dart';

class RecallSessionRemoteDatasourceImpl implements RecallSessionRemoteDatasource{
  final FirebaseFirestore firestore;

  RecallSessionRemoteDatasourceImpl(this.firestore);
  
  @override
  Future<void> saveSession(RecallSessionModel session) async {
    await firestore
        .collection('users')
        .doc(session.userId)
        .collection('recall_sessions')
        .doc(session.id)
        .set(session.toMap());
  }
  
  @override
  Stream<List<RecallSessionModel>> getSessions({
    required String userId,
    String? projectId,
  }) {
    Query query = firestore
        .collection('users')
        .doc(userId)
        .collection('recall_sessions')
        .orderBy('completedAt', descending: false);

    if (projectId != null) {
      query = query.where('projectId', isEqualTo: projectId);
    }

    return query.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => RecallSessionModel.fromMap(
                doc.data() as Map<String, dynamic>,
              ))
          .toList(),
    );
  }
}
