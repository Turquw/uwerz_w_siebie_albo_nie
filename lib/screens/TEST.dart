import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, QuerySnapshot;
import 'package:flutter/material.dart';
import 'package:flutter_local_notification/screens/note_editor.dart';
import 'package:flutter_local_notification/screens/note_reader.dart';
import 'package:flutter_local_notification/style/app_style.dart';
import 'package:flutter_local_notification/widgets/note_card.dart';
import 'package:google_fonts/google_fonts.dart';

class note extends StatefulWidget {
  const note({super.key});

  @override
  State<note> createState() => _noteState();
}

class _noteState extends State<note> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app_style.maincolor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("fireNotes"),
        centerTitle: true,
        backgroundColor: app_style.maincolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "you recent notes",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("notes").snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      children: snapshot.data!.docs
                          .map<Widget>((note) => noteCard(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          note_reader_screen(note),
                                    ));
                              }, note))
                          .toList(),
                    );
                  }
                  return Text(
                    "nie ma tu notatek",
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => note_editor(),
              ));
        },
        label: Icon(Icons.add),
      ),
    );
  }
}
