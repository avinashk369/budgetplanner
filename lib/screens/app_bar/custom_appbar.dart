import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function testing;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      titleSpacing: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: () => testing(),
        color: Colors.black,
      ),
      automaticallyImplyLeading: true,
    );
  }

  @override
  final Size preferredSize;

  final String title;

  CustomAppBar(
    this.title, {
    Key? key,
    required this.testing,
  })   : preferredSize = Size.fromHeight(50.0),
        super(key: key);
}
