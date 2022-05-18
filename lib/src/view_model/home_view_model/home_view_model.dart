import 'package:flutter/material.dart';
import 'package:note_task/src/model/error_result.dart';
import '../../model/note.dart';
import '../../services/remote_sevices/deep_link_service/note_deep_link_service_implementation.dart';
import '../../services/remote_sevices/note_service/note_service_implementation.dart';
import 'states.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    noteService = NoteServiceImplementation();
    noteDeepLinkService = NoteDeepLinkServiceImplementation();
    getNotesStates = GetNotesStates.initialState;
  }

  late DeleteNoteStates deleteNoteStates;
  late GetNotesStates getNotesStates;

  late NoteDeepLinkServiceImplementation noteDeepLinkService;
  late NoteServiceImplementation noteService;

  List<Note>? _notes;

  List<Note>? get notes => _notes;

  List<String>? _notesId;

  List<String>? get notesId => _notesId;

  ErrorResult? _errorResult;

  ErrorResult? get errorResult => _errorResult;

  String? _deleteMessage;

  String? get deleteMessage => _deleteMessage;

  Future<void> deleteNote({required String id}) async {
    deleteNoteStates = DeleteNoteStates.loadingState;
    notifyListeners();
    await noteService.deleteNote(id: id).then((value) {
      value.fold((left) {
        _deleteMessage = left;
        deleteNoteStates = DeleteNoteStates.successStata;
      }, (right) {
        _deleteMessage = right;
        deleteNoteStates = DeleteNoteStates.errorState;
      });
    });
    notifyListeners();
  }

  void getNotes() {
    getNotesStates = GetNotesStates.loadingState;
    try {
      noteService.getNotes().listen((event) {
        _notes = [];
        _notesId = [];
        for (var item in event.docs) {
          Note note = Note.fromJson(item.data());
          _notesId?.add(item.reference.id);
          _notes?.add(note);
        }
        if (_notes!.isEmpty) {
          _errorResult = const ErrorResult(
              message: 'No notes available', image: 'assets/images/empty.png');
          getNotesStates = GetNotesStates.errorState;
        } else {
          getNotesStates = GetNotesStates.loadedStata;
        }
        notifyListeners();
      });
    } catch (exception) {
      _errorResult = const ErrorResult(
          message: 'Note not updated, something went wrong !',
          image: 'assets/images/error.png');
      getNotesStates = GetNotesStates.errorState;
      notifyListeners();
    }
  }

  void initializeDynamicLink({required BuildContext context}) =>
      noteDeepLinkService.initializeDynamicLink(context: context);

  Future<void> generateDynamicLink(
          {required String note, required String id}) async =>
      await noteDeepLinkService.generateDynamicLink(note: note, id: id);
}
