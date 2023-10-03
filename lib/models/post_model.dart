import 'package:flutter/material.dart';

class PostModel {
  PostModel({
    required this.title,
    required this.content,
    required this.icon,
  });

  String title;
  List<Widget> content;
  String icon;
}
