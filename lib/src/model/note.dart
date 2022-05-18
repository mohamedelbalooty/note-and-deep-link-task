import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String note;
  final Timestamp time;

  const Note({required this.note, required this.time});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(note: json['note'], time: json['time']);
  }

  Map<String, dynamic> toJson() {
    return {'note': note, 'time': time};
  }
}
