import 'package:quinote_flutter_app/db/database_repository.dart';

class Note {
  String heading;
  String body;
  bool isPinned;
  int? id;

  static DatabaseRepository databaseRepository = DatabaseRepository();

  Note({
    required this.heading,
    required this.body,
    required this.isPinned,
    this.id
  });

  Note.empty()
    : heading = "",
      body = "",
      isPinned = false;

  Future<int> saveNote() async {
    if(id != null) {
      return await databaseRepository.insertNote(this);
    } else {
      return await databaseRepository.updateNote(this);
    }
  }

  factory Note.fromJson(Map<String, dynamic> map) {
    return Note(
      heading: map['heading'],
      body: map['body'],
      isPinned: map['isPinned'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'heading': heading,
      'body': body,
      'isPinned': isPinned,
    };
  }
}