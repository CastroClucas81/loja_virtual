import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const CategoryTile({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(snapshot["icon"])),
      title: Text(
        snapshot["title"],
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
      ),
    );
  }
}
