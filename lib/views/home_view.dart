import 'package:flutter/material.dart';
import 'package:sqflite_intro/data/local/db_helper.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Map<String, dynamic>> notes = [];
  DBHelper? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = DBHelper.getInstance;
    getNotes();
  }

  void getNotes() async {
    notes = await dbRef!.getAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: notes.isEmpty
          ? const Center(
              child: Text('No notes!'),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (_, i) {
                return ListTile(
                  leading: Text(notes[i][DBHelper.COL_NOTE_SERIAL].toString()),
                  title: Text(notes[i][DBHelper.COL_NOTE_TITLE]),
                  subtitle: Text(notes[i][DBHelper.COL_NOTE_DESC]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dbRef!.addNote(title: 'Demo Title', desc: 'Demo Description');
          getNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
