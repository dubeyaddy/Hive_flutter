import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:local_db_app/hive/note_create.dart';

import 'hive_table.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  late Box<Note> noteBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    noteBox = Hive.box<Note>('notes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note List'),
      ),
      body: ListView.builder(
          itemCount: noteBox.length,
          itemBuilder: (context, index) {
            Note note = noteBox.getAt(index)!;
            return ListTile(
              title: Text(note.title),
              subtitle: Text(note.content),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  noteBox.deleteAt(index);
                  setState(() {});
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => NoteCreateScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
