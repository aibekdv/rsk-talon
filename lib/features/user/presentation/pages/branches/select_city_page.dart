import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/user/data/models/models.dart';
import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'package:rsk_talon/features/user/presentation/cubit/cubit.dart';
import 'package:rsk_talon/features/user/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_rating/star_rating.dart';
import 'package:translit/translit.dart';
import 'package:rsk_talon/service_locator.dart' as di;

class SelectCityPage extends StatefulWidget {
  const SelectCityPage({super.key});

  @override
  State<SelectCityPage> createState() => _SelectCityPageState();
}

class _SelectCityPageState extends State<SelectCityPage> {
  bool isReviewVisible = false;
  int starLength = 5;
  double _rating = 0;

  bool isOpenDropdown = false;
  List<String> cityOfList = [];
  List<BranchEntity>? branchesList;
  TalonEntity? talonItem;
  String? langCode;

  @override
  void initState() {
    super.initState();
    if (isReviewVisible) {
      Future.delayed(
        const Duration(seconds: 5),
        () {
          setState(() {
            isReviewVisible = false;
          });
        },
      );
    }
  }

  @override
  void dispose() {
    isOpenDropdown = false;
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    BlocProvider.of<BranchCubit>(context).loadBranches();
    String? tokenCache =
        await BlocProvider.of<TalonCubit>(context).getTokenFromCache();
    talonItem = tokenCache != null
        ? TalonModel.fromJson(
            jsonDecode(tokenCache),
          )
        : null;
    langCode = Localizations.localeOf(context).languageCode;

    log(talonItem.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 90, 166),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            color: AppColors.primary,
          ),
          child: BlocBuilder<TalonCubit, TalonState>(
            builder: (context, state) {
              if (state is ReviewSucces) {
                talonItem = state.talon;
              }

              return Stack(
                children: [
                  if (talonItem != null)
                    GestureDetector(
                      onTap: () {
                        isReviewVisible = !isReviewVisible;
                        setState(() {});
                      },
                      child: AnimatedContainer(
                        width: double.infinity,
                        height: isReviewVisible ? 85 : 40,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xff2C92EE).withOpacity(.5),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0),
                          ),
                        ),
                        duration: const Duration(milliseconds: 100),
                        child: isReviewVisible
                            ? SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      S.of(context).reviewText,
                                      style: const TextStyle(
                                        color: AppColors.whiteColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 5),
                                    StarRating(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      between: 5,
                                      starSize: 30,
                                      color: Colors.yellow,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      length: starLength,
                                      rating: _rating,
                                      onRaitingTap: (rating) {
                                        setState(() => _rating = rating);
                                        Future.delayed(
                                          const Duration(seconds: 2),
                                          () {
                                            if (talonItem != null) {
                                              BlocProvider.of<TalonCubit>(
                                                      context)
                                                  .sendReviewToServer(
                                                talon: talonItem!,
                                                rating: rating.toInt(),
                                                successMsg: S
                                                    .of(context)
                                                    .thanksForYourFeedback,
                                              );
                                              Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () {
                                                di
                                                    .sl<SharedPreferences>()
                                                    .remove(
                                                      AppConsts.TOKEN_TALON,
                                                    );
                                              });
                                              setState(() => talonItem = null);
                                            }
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 700), () {
                                              setState(
                                                () => isReviewVisible = false,
                                              );
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Text(
                                  S.of(context).leavefeedback,
                                  style: const TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  BlocListener<BranchCubit, BranchState>(
                    listener: (context, state) {
                      if (state is BranchSuccess) {
                        branchesList = state.brancheList;
                        if (branchesList != null && branchesList!.isNotEmpty) {
                          for (var element in branchesList!) {
                            cityOfList.add(element.city!);
                          }
                          setState(() {
                            if (langCode! == "en") {
                              cityOfList = uniqueArray(cityOfList)
                                  .map(
                                    (e) => Translit().toTranslit(source: e),
                                  )
                                  .toList();
                            }

                            cityOfList = uniqueArray(cityOfList);
                          });
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: cityOfList.isNotEmpty
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 25),
                          if (cityOfList.isNotEmpty && talonItem == null)
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
                              ],
                            ),
                          if (cityOfList.isNotEmpty)
                            const SizedBox(
                              height: 80,
                            ),
                          Column(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 120,
                                  child: Image.asset(
                                    'assets/images/large_logo.png',
                                    width: 162.0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              cityOfList.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${S.of(context).step} 1/5',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        SelectOptionWidget(
                                          title: S.of(context).selectCity,
                                          onMenuStateChange: (isOpen) {
                                            isOpenDropdown = !isOpenDropdown;
                                            setState(() {});
                                          },
                                          onTapItem: (value) {
                                            List<BranchEntity> listBranch = [];
                                            for (var branche in branchesList!) {
                                              if (branche.city ==
                                                  Translit().unTranslit(
                                                      source: value)) {
                                                listBranch.add(branche);
                                              }
                                            }
                                            Future.delayed(
                                              const Duration(milliseconds: 100),
                                              () {
                                                Navigator.pushNamed(
                                                  context,
                                                  RouteConst.selectBranchPage,
                                                  arguments: ScreenRouteArgs(
                                                    branchItems: listBranch,
                                                    cityName: value,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          isOpenDropdown: isOpenDropdown,
                                          items: cityOfList,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              S.of(context).doYouHaveTicket,
                                              style: const TextStyle(
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            CustomButtonWidget(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  RouteConst.myTicketsPage,
                                                );
                                              },
                                              textStyle: const TextStyle(
                                                color: AppColors.whiteColor,
                                              ),
                                              title: S.of(context).yes,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

List<String> uniqueArray(List<String> arr) {
  List<String> newArr = [];
  for (var obj in arr) {
    if (newArr.contains(obj)) {
      continue;
    }
    newArr.add(obj);
  }
  return newArr;
}
