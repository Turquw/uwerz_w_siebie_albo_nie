import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notification/style/app_style.dart';
import 'package:torch_light/torch_light.dart';

class note_editor extends StatefulWidget {
  const note_editor({super.key});

  @override
  State<note_editor> createState() => _note_editorState();
}

class _note_editorState extends State<note_editor> {
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
              controller: _tileControler,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'note title'),
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
                  border: InputBorder.none, hintText: 'note main'),
              style: app_style.mainContent,
            ),
          ]),
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            child: Icon(Icons.save),
            onPressed: () {
              FirebaseFirestore.instance.collection('notes').add({
                "note_title": _tileControler.text,
                "creation_date": date_time,
                "note_concent": _mainControler.text,
                "color_id": color_id
              }).then((value) {
                Navigator.pop(context);
              }).catchError(
                  (error) => print("Nie udało sie dodać notatki $error"));
            },
            heroTag: null,
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: Icon(Icons.location_pin),
            onPressed: () {},
            heroTag: null,
          )
        ]));
  }

  void tortch() {
    TorchLight.disableTorch();
  }
}
