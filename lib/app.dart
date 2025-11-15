import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/edit_note_page.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/edit': (context) => const EditNotePage(),
      },
    );
  }
}
