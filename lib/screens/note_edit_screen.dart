import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/notes_service.dart';

class NoteEditScreen extends StatefulWidget {
  final String? docId;
  final String? initialTitle;
  final String? initialBody;
  const NoteEditScreen({this.docId, this.initialTitle, this.initialBody, super.key});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _title = TextEditingController();
  final _body = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _title.text = widget.initialTitle ?? '';
    _body.text = widget.initialBody ?? '';
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final uid = Provider.of<AuthService>(context, listen: false).user!.uid;
    final service = NotesService();
    if (widget.docId == null) {
      await service.addNote(uid, _title.text, _body.text);
    } else {
      await service.updateNote(uid, widget.docId!, _title.text, _body.text);
    }
    setState(() => _saving = false);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.docId == null ? 'New Note' : 'Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          TextField(controller: _title, decoration: const InputDecoration(labelText: 'Title')),
          const SizedBox(height: 8),
          Expanded(child: TextField(controller: _body, decoration: const InputDecoration(labelText: 'Body'), maxLines: null, expands: true)),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _saving ? null : _save, child: _saving ? const CircularProgressIndicator() : const Text('Save')),
        ]),
      ),
    );
  }
}
