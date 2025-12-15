import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  String text;
  Function() onPressed;
  Color color;
  DefaultButton({
    required this.text,
    required this.onPressed,
    this.color = const Color(0xFF1E3C72),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
