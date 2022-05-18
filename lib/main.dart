import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_task/src/view/home_view/home_view.dart';
import 'package:provider/provider.dart';
import 'utils/providers/providers.dart';
import 'utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note app',
        home: const HomeView(),
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
