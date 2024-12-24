import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/widgets/category_tabs.dart';
import 'package:writing_app/screens/notes/widgets/notes_list.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String currentCategory = 'Show All';

  void updateCategory(String category) {
    setState(() {
      currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SidebarLayout(
      activeRoute: '/notes',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 30,
                spreadRadius: 6,
              )
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              CategoryTabs(
                currentCategory: currentCategory,
                onCategorySelected: updateCategory,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: NotesList(currentCategory: currentCategory),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
