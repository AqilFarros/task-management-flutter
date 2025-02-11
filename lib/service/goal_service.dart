part of 'service.dart';

class GoalService {
  String userId = AuthService()._auth.currentUser!.uid;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getGoals() {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('goals')
        .orderBy('created_at', descending: true)
        .snapshots();
  }

  Future<void> storeGoal(
      {required String title,
      required String description,
      required String deadline,
      required String priority}) async {
    await firestore.collection('users').doc(userId).collection('goals').add({
      'title': title,
      'description': description,
      'deadline': deadline,
      'priority': priority,
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateGoal(
      {required String title,
      required String description,
      required String deadline,
      required String priority,
      required String goalId}) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('goals')
        .doc(goalId)
        .update({
      "title": title,
      "description": description,
      "deadline": deadline,
      "priority": priority,
    });
  }

  Future<void> deleteGoal({required String goalId}) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('goals')
        .doc(goalId)
        .delete();
  }
}
