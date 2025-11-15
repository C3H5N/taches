import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_notes/models/note.dart';

void main() {
  test('Note toMap/fromMap roundtrip', () {
    final note = Note(
      id: 1,
      title: 'Titre',
      content: 'Contenu',
      createdAt: DateTime(2024, 1, 1).toIso8601String(),
      updatedAt: DateTime(2024, 1, 2).toIso8601String(),
    );
    final map = note.toMap();
    final back = Note.fromMap(map);
    expect(back.id, 1);
    expect(back.title, 'Titre');
    expect(back.content, 'Contenu');
    expect(back.createdAt, note.createdAt);
    expect(back.updatedAt, note.updatedAt);
  });
}
