import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../providers/notes_provider.dart';
import '../core/utils/validators.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  Note? _editing;
  bool _saving = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Note && _editing == null) {
      _editing = args;
      _titleCtrl.text = args.title;
      _contentCtrl.text = args.content;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final nowIso = DateTime.now().toIso8601String();
      if (_editing == null) {
        final newNote = Note(
          title: _titleCtrl.text.trim(),
          content: _contentCtrl.text.trim(),
          createdAt: nowIso,
          updatedAt: nowIso,
        );
        await context.read<NotesProvider>().addNote(newNote);
      } else {
        final updated = _editing!.copyWith(
          title: _titleCtrl.text.trim(),
          content: _contentCtrl.text.trim(),
          updatedAt: nowIso,
        );
        await context.read<NotesProvider>().updateNote(updated);
      }
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Note sauvegardée')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = _editing != null;
    final dateFmt = DateFormat('dd MMM yyyy, HH:mm');

    String subtitle() {
      if (_editing == null) return 'Nouvelle note';
      return 'Créée: ' + dateFmt.format(DateTime.parse(_editing!.createdAt)) +
          '  •  Modifiée: ' + dateFmt.format(DateTime.parse(_editing!.updatedAt));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Modifier la note' : 'Nouvelle note'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Sauver'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(subtitle(), style: Theme.of(context).textTheme.labelMedium),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(hintText: 'Titre'),
                validator: (v) => Validators.notEmpty(v, field: 'Titre'),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: TextFormField(
                  controller: _contentCtrl,
                  decoration: const InputDecoration(hintText: 'Contenu'),
                  maxLines: null,
                  expands: true,
                  validator: (v) => Validators.notEmpty(v, field: 'Contenu'),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  OutlinedButton(onPressed: _saving ? null : () => Navigator.of(context).maybePop(), child: const Text('Annuler')),
                  const SizedBox(width: 8),
                  FilledButton(onPressed: _saving ? null : _save, child: const Text('Sauvegarder')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
