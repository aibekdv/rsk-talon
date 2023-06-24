import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final TextStyle textStyle;
  final double width;
  final double height;
  final Color? bgColor;
  final double? borderRadius;

  const CustomButtonWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.textStyle,
    this.width = 80.0,
    this.height = 35.0,
    this.bgColor = const Color(0xff2E79BD),
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        textStyle: textStyle,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
      ),
      onPressed: onTap,
      child: Text(title, style: textStyle),
    );
  }
}
