import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const CategoryTile({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(snapshot: snapshot,),
          ),
        );
      },
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot["icon"]),
      ),
      title: Text(
        snapshot["title"],
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
      ),
    );
  }
}
