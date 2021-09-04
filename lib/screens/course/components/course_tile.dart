import 'package:agile_unify/components/replace_raisedbutton.dart';
import 'package:agile_unify/core/app_colors.dart';
import 'package:agile_unify/models/course.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseTile extends StatelessWidget {
  CourseTile(this.course);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 150.0,
            child: Image.network(
              course.image,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(course.title,
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                Text(course.description, textAlign: TextAlign.start),
              ],
            ),
          ),
          ReplaceRaisedButton(
            child: Text("ACESSAR CURSO"),
            color: AppColors.purple,
            textColor: Colors.white,
            padding: EdgeInsets.zero,
            onPressed: () {
              launch("${course.url}");
            },
          ),
        ],
      ),
    );
  }
}
