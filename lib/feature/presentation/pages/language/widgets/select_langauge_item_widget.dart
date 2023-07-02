import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';

class SelectLangaugeItemWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String iconPath;
  final String title;

  const SelectLangaugeItemWidget({
    super.key,
    required this.onTap,
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(27),
            topLeft: Radius.circular(27),
            bottomRight: Radius.circular(17),
            topRight: Radius.circular(17),
          ),
          color: Colors.white.withOpacity(0.2),
        ),
        height: 55,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 55,
              width: 55,
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(55),
                color: AppColors.whiteColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(55),
                child: Image.asset(
                  iconPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
