import 'package:flutter/material.dart';

dialogMessage(BuildContext context, String title, String msg) {
  showDialog(
      context: context,
      builder: (BuildContext context) => _buildDialog(context, title, msg));
}

Widget _buildDialog(BuildContext context, title, msg) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        height: 250,
        width: 230,
        margin:
            const EdgeInsets.all(50), // to push the box half way below circle
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.only(
            top: 15, left: 10, right: 10), // spacing inside the box
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             
            ],
          ),
        ),
      ),
    ],
  );
}