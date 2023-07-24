import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/user/domain/entities/branch_entity.dart';
import 'package:rsk_talon/features/user/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';
import 'package:translit/translit.dart';

class AboutBranchPage extends StatefulWidget {
  final BranchEntity branchItem;

  const AboutBranchPage({
    super.key,
    required this.branchItem,
  });

  @override
  State<AboutBranchPage> createState() => _AboutBranchPageState();
}

class _AboutBranchPageState extends State<AboutBranchPage> {
  @override
  Widget build(BuildContext context) {
    String langCode = Localizations.localeOf(context).languageCode;

    List<Map<String, dynamic>> schedule = [
      {
        'weekDay': S.of(context).monday,
        'time':
            '${widget.branchItem.workTimeStart!}-${widget.branchItem.workTimeEnd!}',
      },
      {
        'weekDay': S.of(context).tuesday,
        'time':
            '${widget.branchItem.workTimeStart!}-${widget.branchItem.workTimeEnd!}',
      },
      {
        'weekDay': S.of(context).wednesday,
        'time':
            '${widget.branchItem.workTimeStart!}-${widget.branchItem.workTimeEnd!}',
      },
      {
        'weekDay': S.of(context).thursday,
        'time':
            '${widget.branchItem.workTimeStart!}-${widget.branchItem.workTimeEnd!}',
      },
      {
        'weekDay': S.of(context).friday,
        'time':
            '${widget.branchItem.workTimeStart!}-${widget.branchItem.workTimeEnd!}',
      },
      {
        'weekDay': S.of(context).saturday,
        'time': S.of(context).notOpen,
      },
      {
        'weekDay': S.of(context).sunday,
        'time': S.of(context).notOpen,
      },
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 90, 166),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            color: AppColors.primary,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: const ShapeDecoration(
                          color: Color(0x33D9D9D9),
                          shape: OvalBorder(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteConst.profilePage);
                            },
                            child: Image.asset(
                              "assets/icons/user.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    'assets/images/large_logo.png',
                    width: 162.0,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                CustomAppBarWidget(
                  title: S.of(context).bankbranch,
                  centerTitle: true,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "${S.of(context).address} ${langCode == 'en' ? Translit().toTranslit(source: widget.branchItem.address!) : widget.branchItem.address}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: SizedBox(
                          width: 230,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...schedule
                                  .map((item) => Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item['weekDay'],
                                            style: const TextStyle(
                                              color: AppColors.whiteColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            item['time'],
                                            style: const TextStyle(
                                              color: AppColors.whiteColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ))
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      CustomButtonWidget(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteConst.selectClientTypePage,
                            arguments: ScreenRouteArgs(
                                selectBranchItem: widget.branchItem),
                          );
                        },
                        title: S.of(context).next,
                        textStyle: const TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        width: double.infinity,
                        height: 54.0,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
