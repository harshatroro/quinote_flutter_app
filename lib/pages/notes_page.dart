import 'package:flutter/material.dart';
import 'package:quinote_flutter_app/models/note.dart';

class NotesPage extends StatefulWidget {
  final Note note;

  const NotesPage({
    super.key,
    required this.note,
  });

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late String body;
  late String heading;
  late Note note;
  TextEditingController bodyTextEditingController = TextEditingController();
  TextEditingController headingTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    note = widget.note;
    body = note.body;
    heading = note.heading;
    bodyTextEditingController.text = body;
    headingTextEditingController.text = heading;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          heading.substring(0, heading.length > 15 ? 15 : heading.length) + (heading.length > 15 ? "..." : ""),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          note.saveNote();
          Navigator.pop(context);
        },
        tooltip: 'Save Note',
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: bodyTextEditingController,
                    decoration: const InputDecoration(
                      labelText: "Note's Heading",
                    ),
                    onChanged: (text) {
                      setState(() {
                        heading = text;
                      });
                    },
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: headingTextEditingController,
                      decoration: const InputDecoration(
                        labelText: "Your note goes here...",
                      ),
                      onChanged: (text) {
                        setState(() {
                          body = text;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
