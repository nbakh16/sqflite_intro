import 'package:flutter/material.dart';
import 'package:sqflite_intro/data/local/db_helper.dart';
import 'package:sqflite_intro/models/note_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<NoteModel> notes = [];
  DBHelper? dbRef;

  final titleTEC = TextEditingController();
  final descTEC = TextEditingController();

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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            onPressed: () {
              dbRef!.clearDatabase();
              getNotes();
            },
            icon: const Text(
              'Clear DB',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: notes.isEmpty
          ? const Center(
              child: Text('No notes!'),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (_, i) {
                NoteModel note = notes[i];
                return ListTile(
                  leading: Text(note.id.toString()),
                  title: Text(note.title),
                  subtitle: Text(note.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await dbRef!.delete(note.id);
                          getNotes();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          titleTEC.text = note.title;
                          descTEC.text = note.description;
                          _updateNoteBottomSheet(context, note.id);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNoteBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNoteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleTEC,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descTEC,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  dbRef!.addNote(
                    note: NoteModel(
                      title: titleTEC.text.trim(),
                      description: descTEC.text.trim(),
                    ),
                  );
                  getNotes();
                  Navigator.pop(context);
                  titleTEC.clear();
                  descTEC.clear();
                },
                child: const Text('Add Note'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateNoteBottomSheet(BuildContext context, int id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleTEC,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descTEC,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  dbRef!.update(
                    NoteModel(
                      id: id,
                      title: titleTEC.text.trim(),
                      description: descTEC.text.trim(),
                      isDone: 0,
                    ),
                  );
                  getNotes();
                  Navigator.pop(context);
                  titleTEC.clear();
                  descTEC.clear();
                },
                child: const Text('Update Note'),
              ),
            ],
          ),
        );
      },
    );
  }
}
