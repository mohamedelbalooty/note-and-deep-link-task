import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/note.dart';
import '../../view_model/create_note_view_model/create_note_view_model.dart';
import '../app_components.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({Key? key, this.isUpdate, this.note, this.id})
      : super(key: key);
  final bool? isUpdate;
  final Note? note;
  final String? id;

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate == true) {
      _noteController = TextEditingController(text: widget.note!.note);
    } else {
      _noteController = TextEditingController();
    }
  }

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Note'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormFiledUtil(
                    label: 'Enter note',
                    controller: _noteController,
                    onValidate: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter you note please !';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                  Consumer<CreateNoteViewModel>(
                    builder: (context, provider, child) {
                      return ElevatedButtonUtil(
                        title: widget.isUpdate != true ? 'Create' : 'Update',
                        onClick: () {
                          if (_globalKey.currentState!.validate()) {
                            if (widget.isUpdate != true) {
                              provider
                                  .createNote(
                                      note: Note(
                                          note: _noteController.text,
                                          time: Timestamp.now()))
                                  .then((value) {
                                onShowToast(
                                    toastMessage: provider.createMessage!);
                                onPop(context);
                              });
                            } else {
                              provider
                                  .updateNote(
                                      note: Note(
                                          note: _noteController.text,
                                          time: Timestamp.now()),
                                      id: widget.id!)
                                  .then((value) {
                                onShowToast(
                                    toastMessage: provider.updateMessage!);
                                onPop(context);
                              });
                            }
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }
}
