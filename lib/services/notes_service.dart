import 'package:cloud_firestore/cloud_firestore.dart';

class NotesService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> notesRef(String uid) =>
      _db.collection('users').doc(uid).collection('notes');

  Stream<QuerySnapshot<Map<String, dynamic>>> notesStream(String uid) {
    return notesRef(uid).orderBy('updatedAt', descending: true).snapshots();
  }

  Future<void> addNote(String uid, String title, String body) {
    final now = DateTime.now();
    return notesRef(uid).add({
      'title': title,
      'body': body,
      'createdAt': now.toUtc(),
      'updatedAt': now.toUtc(),
    });
  }

  Future<void> updateNote(String uid, String docId, String title, String body) {
    final now = DateTime.now();
    return notesRef(uid).doc(docId).update({
      'title': title,
      'body': body,
      'updatedAt': now.toUtc(),
    });
  }

  Future<void> deleteNote(String uid, String docId) {
    return notesRef(uid).doc(docId).delete();
  }
}
