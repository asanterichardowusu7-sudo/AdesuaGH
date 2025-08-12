import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/notes_service.dart';
import 'note_edit_screen.dart';
import 'quiz_screen.dart';

class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    final uid = auth.user!.uid;
    final notesService = NotesService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('AdesuaGH - My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.quiz),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => auth.signOut(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: notesService.notesStream(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) return Center(child: Text('No notes yet. Tap + to add one.', style: Theme.of(context).textTheme.bodyLarge));
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final d = docs[i];
              final data = d.data();
              return ListTile(
                title: Text(data['title'] ?? 'Untitled'),
                subtitle: Text((data['body'] ?? '').toString(), maxLines: 1, overflow: TextOverflow.ellipsis),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NoteEditScreen(docId: d.id, initialTitle: data['title'], initialBody: data['body']))),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => notesService.deleteNote(uid, d.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NoteEditScreen())),
      ),
    );
  }
}
