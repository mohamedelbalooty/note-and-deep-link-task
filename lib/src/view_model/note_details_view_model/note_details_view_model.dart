import 'package:flutter/material.dart';
import 'package:note_task/src/model/note.dart';
import '../../model/error_result.dart';
import '../../services/remote_sevices/note_service/note_service_implementation.dart';
import 'states.dart';

class NoteDetailsViewModel extends ChangeNotifier {
  NoteDetailsViewModel() {
    noteService = NoteServiceImplementation();
    getNoteStates = GetNoteStates.initialState;
  }

  late GetNoteStates getNoteStates;
  late NoteServiceImplementation noteService;

  Note? _note;

  Note? get note => _note;

  ErrorResult? _errorResult;

  ErrorResult? get errorResult => _errorResult;

  Future<void> getNote({required String id}) async {
    getNoteStates = GetNoteStates.loadingState;
    await noteService.getNote(id: id).then((value) {
      value.fold((left) {
        _note = left;
        getNoteStates = GetNoteStates.loadedStata;
      }, (right) {
        _errorResult = right;
        getNoteStates = GetNoteStates.errorState;
      });
    });
    notifyListeners();
  }

  void disposeData(){
    _note = null;
  }
}
