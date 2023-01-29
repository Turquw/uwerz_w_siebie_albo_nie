import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notification/style/app_style.dart';

Widget noteCard(Function()? ontap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: app_style.cardscolor[doc['color_id']],
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["note_title"],
            style: app_style.mainTitle,
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            doc["creation_date"],
            style: app_style.dateTitle,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            doc["note_concent"],
            style: app_style.mainContent,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    ),
  );
}
