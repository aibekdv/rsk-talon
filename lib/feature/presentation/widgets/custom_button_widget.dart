import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final TextStyle textStyle;
  final double width;
  final double height;
  final Color? bgColor;
  final double? borderRadius;
  final Color? borderColor;
  final bool? isLoading;

  const CustomButtonWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.textStyle,
    this.width = 80.0,
    this.height = 35.0,
    this.bgColor = const Color(0xff2E79BD),
    this.borderRadius = 15,
    this.borderColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius!),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius!),
          border: borderColor != null ? Border.all(color: Colors.white) : null,
        ),
        child: isLoading!
            ? SizedBox(
                width: width,
                height: height,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: textStyle),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: textStyle.color),
                    ),
                  ],
                ),
              )
            : Center(child: Text(title, style: textStyle)),
      ),
    );
  }
}
