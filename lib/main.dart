import 'package:flutter/material.dart';
import 'package:writing_app/screens/home/homescreen.dart';
import 'package:writing_app/screens/notes/notesscreen.dart';
import 'package:writing_app/screens/writing/writingscreen.dart';
import 'package:writing_app/utils/theme2.dart';
import 'package:writing_app/widgets/sidebar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _currentSection = 'Home'; // Active section

  void _navigateTo(String section) {
    setState(() {
      _currentSection = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen;

    switch (_currentSection) {
      case 'Home':
        activeScreen = HomeScreen();
        break;
      case 'Notes':
        activeScreen = NotesScreen();
        break;
      case 'Writing':
        activeScreen = WritingScreen();
        break;
      case 'Research':
        activeScreen = WritingScreen(); // Replace with ResearchScreen later
        break;
      default:
        activeScreen = HomeScreen();
    }

    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: GlobalThemeData.lightThemeData,
      darkTheme: GlobalThemeData.darkThemeData,
      title: 'Writing App',
      home: Scaffold(
        body: Row(
          children: [
            AppSidebar(
              activeSection: _currentSection,
              onSectionTap: _navigateTo,
            ),
            Expanded(child: activeScreen),
          ],
        ),
      ),
    );
  }
}
