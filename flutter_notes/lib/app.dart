import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/edit_note_page.dart';
import 'providers/auth_provider.dart';

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
      onGenerateRoute: (settings) {
        // Fallback to home if route not found
        return MaterialPageRoute(builder: (_) => const HomePage());
      },
      builder: (context, child) {
        final auth = context.watch<AuthProvider>();
        return child!;
      },
    );
  }
}
