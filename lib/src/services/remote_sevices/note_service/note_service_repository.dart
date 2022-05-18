import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:note_task/src/model/error_result.dart';
import '../../../model/note.dart';

abstract class NoteServiceRepository {
  Future<Either<String, String>> createNote({required Note note});

  Future<Either<String, String>> updateNote(
      {required Note note, required String id});

  Future<Either<String, String>> deleteNote({required String id});

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotes();

  Future<Either<Note, ErrorResult>> getNote({required String id});
}
