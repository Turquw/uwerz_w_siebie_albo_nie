import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notification/style/app_style.dart';

Widget Question(Function()? ontap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["pytanie"],
            style: app_style.mainTitle,
          ),
        ],
      ),
    ),
  );
}
