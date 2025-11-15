import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:taches/models/note.dart';
import 'package:taches/providers/notes_provider.dart';
import 'package:taches/services/database_helper.dart';

void main() {
  sqfliteFfiInit();
  DatabaseHelper.setTestingFactory(databaseFactoryFfi);

  test('NotesProvider add and load notes', () async {
    final provider = NotesProvider();
    final now = DateTime.now().toIso8601String();
    await provider.addNote(Note(title: 'A', content: 'B', createdAt: now, updatedAt: now));
    await provider.loadNotes();
    expect(provider.notes.length, 1);
    expect(provider.notes.first.title, 'A');
  });
}
