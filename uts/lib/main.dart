import 'package:flutter/material.dart';

import 'pages/main_shell.dart';
import 'theme/app_theme.dart';

void main() => runApp(const CineKuApp());

class CineKuApp extends StatelessWidget {
  const CineKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineKu',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const MainShell(),
    );
  }
}
