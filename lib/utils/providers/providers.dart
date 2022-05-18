import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../src/view_model/create_note_view_model/create_note_view_model.dart';
import '../../src/view_model/home_view_model/home_view_model.dart';
import '../../src/view_model/note_details_view_model/note_details_view_model.dart';

class Providers {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
    ),
    ChangeNotifierProvider<CreateNoteViewModel>(
      create: (_) => CreateNoteViewModel(),
    ),
    ChangeNotifierProvider<NoteDetailsViewModel>(
      create: (_) => NoteDetailsViewModel(),
    ),
  ];
}
