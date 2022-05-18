import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:note_task/src/model/error_result.dart';
import '../../../../utils/constants/database_constants.dart';
import '../../../../utils/helper/firebase_helper.dart';
import '../../../model/note.dart';
import 'note_service_repository.dart';

class NoteServiceImplementation extends NoteServiceRepository {
  @override
  Future<Either<String, String>> createNote({required Note note}) async {
    try {
      await FirebaseHelper.firebaseFireStore
          .collection(notesCollection)
          .add(note.toJson());
      return const Left('Note created successfully');
    } catch (exception) {
      return const Right('Note not created, something went wrong !');
    }
  }

  @override
  Future<Either<String, String>> updateNote(
      {required Note note, required String id}) async {
    try {
      await FirebaseHelper.firebaseFireStore
          .collection(notesCollection)
          .doc(id)
          .update(note.toJson());
      return const Left('Note updated successfully');
    } catch (exception) {
      return const Right('Note not updated, something went wrong !');
    }
  }

  @override
  Future<Either<String, String>> deleteNote({required String id}) async {
    try {
      await FirebaseHelper.firebaseFireStore
          .collection(notesCollection)
          .doc(id)
          .delete();
      return const Left('Note deleted successfully');
    } catch (exception) {
      return const Right('Note not deleted, something went wrong !');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getNotes() {
    return FirebaseHelper.firebaseFireStore
        .collection(notesCollection)
        .snapshots();
  }

  @override
  Future<Either<Note, ErrorResult>> getNote({required String id}) async{
    try{
      Note? note;
      await FirebaseHelper.firebaseFireStore
          .collection(notesCollection).doc(id).get().then((value) {
            note = Note.fromJson(value.data()!);
      });
      return Left(note!);
    }catch(exception){
      ErrorResult errorResult = const ErrorResult(
          message: 'Note not updated, something went wrong !',
          image: 'assets/images/error.png');
      return Right(errorResult);
    }
  }
}
