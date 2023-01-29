import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notification/screens/TEST.dart';
import 'package:flutter_local_notification/style/app_style.dart';

class new_note extends StatefulWidget {
  new_note(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<new_note> createState() => _new_noteState();
}

class _new_noteState extends State<new_note> {
  int color_id = Random().nextInt(app_style.cardscolor.length);
  String date_time = DateTime.now().toString();
  TextEditingController _tileControler = TextEditingController();
  TextEditingController _mainControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app_style.cardscolor[color_id],
      appBar: AppBar(
        backgroundColor: app_style.cardscolor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "add new note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.00),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: _tileControler,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.doc["note_title"],
              labelText: widget.doc["note_title"],
            ),
            style: app_style.mainTitle,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            date_time,
            style: app_style.dateTitle,
          ),
          SizedBox(
            height: 28.0,
          ),
          TextField(
            controller: _mainControler,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.doc["note_concent"],
                labelText: widget.doc["note_concent"]),
            style: app_style.mainContent,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: app_style.accentcolor,
        onPressed: () {
          FirebaseFirestore.instance
              .collection('notes')
              .doc(widget.doc.id)
              .update({
            "note_title": _tileControler.text,
            "note_concent": _mainControler.text,
            "color_id": color_id
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => note(),
              ));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
