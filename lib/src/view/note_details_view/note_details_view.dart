import 'package:flutter/material.dart';
import 'package:note_task/src/view_model/note_details_view_model/states.dart';
import 'package:provider/provider.dart';
import '../../../utils/theme/colors.dart';
import '../../view_model/note_details_view_model/note_details_view_model.dart';
import '../app_components.dart';

class NoteDetailsView extends StatefulWidget {
  const NoteDetailsView({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<NoteDetailsView> createState() => _NoteDetailsViewState();
}

class _NoteDetailsViewState extends State<NoteDetailsView> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<NoteDetailsViewModel>().getNote(id: widget.id);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Note Details',
        ),
      ),
      body: Consumer<NoteDetailsViewModel>(
        builder: (context, provider, child) {
          if (provider.getNoteStates == GetNoteStates.initialState) {
            return const LoadingUtil();
          } else if (provider.getNoteStates == GetNoteStates.loadingState) {
            return const LoadingUtil();
          } else if (provider.getNoteStates == GetNoteStates.loadedStata) {
            return Center(
              child: Card(
                margin: const EdgeInsets.all(15),
                shape: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: mainClr, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    provider.note!.note,
                    style: const TextStyle(
                      color: blackClr,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          } else {
            return ErrorResultUtil(
              errorResult: provider.errorResult!,
            );
          }
        },
      ),
    );
  }
}
