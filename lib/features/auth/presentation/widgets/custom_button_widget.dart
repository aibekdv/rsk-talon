import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';

class CustomButtonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final double? radius;
  final VoidCallback? onPressed;
  final bool? isSubmitBtn;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;

  const CustomButtonWidget({
    super.key,
    this.width,
    this.height,
    required this.title,
    this.onPressed,
    this.radius,
    this.isSubmitBtn = false,
    this.padding,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: borderColor != null
            ? Colors.transparent
            : isSubmitBtn!
                ? AppColors.authBtnColor
                : AppColors.authBtnColorDark,
        disabledBackgroundColor: borderColor != null
            ? Colors.transparent
            : AppColors.disableBtnColor,
        minimumSize:
            (width != null && height != null) ? Size(width!, height!) : null,
        shape: RoundedRectangleBorder(
          side: borderColor != null
              ? BorderSide(color: borderColor!)
              : BorderSide(
                  color: isSubmitBtn!
                      ? AppColors.authBtnColor
                      : AppColors.authBtnColorDark,
                ),
          borderRadius: BorderRadius.circular(radius ?? 15),
        ),
        padding: padding,
        elevation: borderColor != null ? 0 : null,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
