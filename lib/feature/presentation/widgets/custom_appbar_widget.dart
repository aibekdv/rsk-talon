import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';

class CustomAppBarWidget extends StatelessWidget {
  final String title;
  final bool? centerTitle;
  final bool? isFromCreate;

  const CustomAppBarWidget({
    super.key,
    required this.title,
    this.centerTitle = false,
    this.isFromCreate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      color: Colors.white.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: isFromCreate!
                ? () => Navigator.pushNamed(context, RouteConst.homePage)
                : () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.whiteColor ,
              size: 20,
            ),
          ),
          SizedBox(width: centerTitle! == true ? 10 : 20),
          Expanded(
            child: centerTitle!
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 35),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.whiteColor ,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                : Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.whiteColor ,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ],
      ),
    );
  }
}
