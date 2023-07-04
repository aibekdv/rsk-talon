import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final TextStyle textStyle;
  final double width;
  final double height;
  final Color? bgColor;
  final double? borderRadius;
  final Color? borderColor;
  final bool? isSelectTime;

  const CustomButtonWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.textStyle,
    this.width = 80.0,
    this.height = 35.0,
    this.bgColor,
    this.borderRadius = 15,
    this.borderColor,
    this.isSelectTime = false,
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
          color: bgColor ?? AppColors.primaryBtnColor,
          borderRadius: BorderRadius.circular(borderRadius!),
          border: borderColor != null ? Border.all(color: Colors.white) : null,
        ),
        child: isSelectTime!
            ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 35,
                    color: AppColors.primary,
                  ),
                  Text(
                    title,
                    style: textStyle,
                  ),
                  const Icon(
                    Icons.expand_more,
                  )
                ],
              )
            : Center(child: Text(title, style: textStyle)),
      ),
    );
  }
}
