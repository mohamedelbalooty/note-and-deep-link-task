import 'package:flutter/material.dart';
import 'package:note_task/src/view_model/home_view_model/home_view_model.dart';
import 'package:note_task/src/view_model/home_view_model/states.dart';
import 'package:note_task/utils/theme/colors.dart';
import 'package:provider/provider.dart';
import '../app_components.dart';
import '../create_note_view/create_note_view.dart';
import '../note_details_view/note_details_view.dart';
import 'components.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const String id = 'HomeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<HomeViewModel>().initializeDynamicLink(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Note App',
        ),
        leading: IconButtonUtil(
          icon: Icons.add,
          color: whiteClr,
          onClick: () => onNavigate(context, page: const CreateNoteView()),
        ),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, provider, child) {
          if (provider.getNotesStates == GetNotesStates.initialState) {
            provider.getNotes();
            return const LoadingUtil();
          } else if (provider.getNotesStates == GetNotesStates.loadingState) {
            return const LoadingUtil();
          } else if (provider.getNotesStates == GetNotesStates.loadedStata) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              itemCount: provider.notes!.length,
              itemBuilder: (_, index) => NoteCardWidget(
                index: index,
                note: provider.notes![index],
                onClick: () => onNavigate(
                  context,
                  page: NoteDetailsView(id: provider.notesId![index]),
                ),
                onDelete: () => provider
                    .deleteNote(id: provider.notesId![index])
                    .then((value) =>
                        onShowToast(toastMessage: provider.deleteMessage!)),
                onEdit: () => onNavigate(
                  context,
                  page: CreateNoteView(
                    isUpdate: true,
                    note: provider.notes![index],
                    id: provider.notesId![index],
                  ),
                ),
                onCopy: () => provider.generateDynamicLink(
                    note: provider.notes![index].note,
                    id: provider.notesId![index]),
              ),
              separatorBuilder: (_, index) => const SizedBox(height: 10),
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
