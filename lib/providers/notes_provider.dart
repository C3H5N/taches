import 'package:flutter/foundation.dart';
import '../models/note.dart';
import '../services/database_helper.dart';

class NotesProvider extends ChangeNotifier {
  final _db = DatabaseHelper.instance;
  List<Note> _notes = [];
  List<Note> get notes => _notes;
  bool _loading = false;
  bool get isLoading => _loading;

  Future<void> loadNotes() async {
    _loading = true;
    notifyListeners();
    try {
      _notes = await _db.getAllNotes();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> addNote(Note note) async {
    await _db.insertNote(note);
    await loadNotes();
  }

  Future<void> updateNote(Note note) async {
    await _db.updateNote(note);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await _db.deleteNote(id);
    await loadNotes();
  }
}
