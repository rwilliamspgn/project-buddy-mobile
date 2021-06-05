import 'package:flutter/material.dart';
import 'package:project_buddy_mobile/env/config.dart';

class PButton extends StatelessWidget {
  final String label;
  final bool full;
  final Function()? onTap;

  const PButton({
    Key? key,
    required this.label,
    this.full: false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget button = ElevatedButton(
      onPressed: this.onTap,
      child: Text(
        this.label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.resolveWith((states) => Config.primaryColor),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        padding:
            MaterialStateProperty.resolveWith((states) => EdgeInsets.all(12.0)),
      ),
    );

    if (this.full) {
      return FractionallySizedBox(
        widthFactor: 1.0,
        child: button,
      );
    }
    return button;
  }
}
