import 'package:flutter/material.dart';
import '../../model/note.dart';
import '../../services/remote_sevices/note_service/note_service_implementation.dart';
import 'states.dart';

class CreateNoteViewModel extends ChangeNotifier {
  CreateNoteViewModel() {
    noteService = NoteServiceImplementation();
  }

  late CreateNoteStates createNoteStates;
  late UpdateNoteStates updateNoteStates;

  late NoteServiceImplementation noteService;

  String? _createMessage;

  String? get createMessage => _createMessage;

  String? _updateMessage;

  String? get updateMessage => _updateMessage;

  Future<void> createNote({required Note note}) async {
    createNoteStates = CreateNoteStates.loadingState;
    notifyListeners();
    await noteService.createNote(note: note).then((value) {
      value.fold((left) {
        _createMessage = left;
        createNoteStates = CreateNoteStates.successStata;
      }, (right) {
        _createMessage = right;
        createNoteStates = CreateNoteStates.errorState;
      });
    });
    notifyListeners();
  }

  Future<void> updateNote({required Note note, required String id}) async {
    updateNoteStates = UpdateNoteStates.loadingState;
    notifyListeners();
    await noteService.updateNote(id: id, note: note).then((value) {
      value.fold((left) {
        _updateMessage = left;
        updateNoteStates = UpdateNoteStates.successStata;
      }, (right) {
        _updateMessage = right;
        updateNoteStates = UpdateNoteStates.errorState;
      });
    });
    notifyListeners();
  }
}
