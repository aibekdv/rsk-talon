import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';
import 'package:star_rating/star_rating.dart';

class HomePage extends StatefulWidget {
  final bool? isGotTicket;
  final List<BranchEntity>? branchesList;

  const HomePage({
    super.key,
    this.isGotTicket = false,
    this.branchesList,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isReviewVisible = false;
  int starLength = 5;
  double _rating = 0;

  bool isOpenDropdown = false;
  List<String> cityOfList = [];
  List<BranchEntity>? branchesList;

  @override
  void initState() {
    branchesList = widget.branchesList ?? [];
    if (branchesList != null && branchesList!.isNotEmpty) {
      for (var element in branchesList!) {
        cityOfList.add(element.city!);
      }
      cityOfList = uniqueArray(cityOfList);
      setState(() {});
    }

    if (isReviewVisible) {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          isReviewVisible = false;
          setState(() {});
        },
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    isOpenDropdown = false;
    super.dispose();
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
            ),
            color: Color(0xff0D3584),
          ),
          child: Stack(
            children: [
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
                              const Text(
                                'Пожалуйста, оцените обслуживание в банке.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              StarRating(
                                mainAxisAlignment: MainAxisAlignment.center,
                                between: 5,
                                starSize: 30,
                                color: Colors.yellow,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                length: starLength,
                                rating: _rating,
                                onRaitingTap: (rating) {
                                  Future.delayed(
                                    const Duration(seconds: 3),
                                    () {
                                      isReviewVisible = false;
                                      setState(() {});
                                    },
                                  );
                                  _rating = rating;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        )
                      : const Center(
                          child: Text(
                            "Оставить отзыв",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 130,
                    ),
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
                    const Text(
                      'Шаг 1/5',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SelectOptionWidget(
                      title: 'Выберите город',
                      onMenuStateChange: (isOpen) {
                        isOpenDropdown = !isOpenDropdown;
                        setState(() {});
                      },
                      onTapItem: (value) {
                        List<BranchEntity> listBranch = [];
                        for (var branche in branchesList!) {
                          if (branche.city == value) {
                            listBranch.add(branche);
                          }
                        }
                        print(value);
                        Future.delayed(
                          const Duration(milliseconds: 100),
                          () {
                            Navigator.pushNamed(
                              context,
                              RouteConst.selectBranchPage,
                              arguments:
                                  ScreenRouteArgs(branchItems: listBranch),
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "У Вас уже есть талон?",
                          style: TextStyle(
                            color: Colors.white,
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
                            color: Colors.white,
                          ),
                          title: 'Да',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
