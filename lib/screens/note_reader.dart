import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notification/screens/new_note.dart';
import 'package:flutter_local_notification/style/app_style.dart';

class note_reader_screen extends StatefulWidget {
  note_reader_screen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<note_reader_screen> createState() => _note_reader_screenState();
}

class _note_reader_screenState extends State<note_reader_screen> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc["color_id"];
    return Scaffold(
      backgroundColor: app_style.cardscolor[color_id],
      appBar: AppBar(
        backgroundColor: app_style.cardscolor[color_id],
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["note_title"],
              style: app_style.mainTitle,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              widget.doc["creation_date"],
              style: app_style.dateTitle,
            ),
            SizedBox(
              height: 28.0,
            ),
            Text(
              widget.doc["note_concent"],
              style: app_style.mainContent,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new_note(widget.doc),
              ));
        },
        label: Icon(Icons.edit),
      ),
    );
  }
}
