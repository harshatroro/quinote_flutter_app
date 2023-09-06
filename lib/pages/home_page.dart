import 'package:flutter/material.dart';
import 'package:quinote_flutter_app/db/database_repository.dart';
import 'package:quinote_flutter_app/models/note.dart';
import 'package:quinote_flutter_app/pages/notes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    getNotesData();
  }

  List<Note> notes = [];

  void getNotesData() {
    DatabaseRepository databaseRepository = DatabaseRepository();
    setState(() {
      notes.addAll(databaseRepository.notes() as Iterable<Note>);
    });
  }

  List<GestureDetector> generateCards() {
    List<GestureDetector> cardList = <GestureDetector>[];
    for (var note in notes) {
        cardList.add(
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotesPage(note: note)
                ),
              );
            },
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      note.heading,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    Text(
                      note.body,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        );
      }
    return cardList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Notes App",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            primary: false,
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            children: generateCards(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotesPage(note: Note.empty())
              )
          );
        },
        tooltip: 'Create New Note',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}