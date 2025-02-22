import 'package:flutter/material.dart';

class Snackbar {
  final String text;
  final IconData icon;
  final int duration;
  final Color color;
  final Color backgroundcolor;

  Snackbar(
      {required this.text,
      this.icon = Icons.info,
      this.duration = 3,
      this.color = Colors.white,
      this.backgroundcolor = Colors.blueAccent});

  // 스낵바 보여주기
  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: TextStyle(color: color),
          )
        ],
      ),
      duration: Duration(seconds: duration),
      backgroundColor: backgroundcolor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ));
  }
}
