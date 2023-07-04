import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class SelectTypeClientPage extends StatefulWidget {
  final BranchEntity branchItem;

  const SelectTypeClientPage({super.key, required this.branchItem});

  @override
  State<SelectTypeClientPage> createState() => _SelectTypeClientPageState();
}

class _SelectTypeClientPageState extends State<SelectTypeClientPage> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            ),
            color: AppColors.primary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteConst.homePage,
                  );
                },
                child: Image.asset(
                  'assets/icons/appar.png',
                  width: 162.0,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
               CustomAppBarWidget(
                title:S.of(context).clientType,
                centerTitle: true,
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      '${S.of(context).step} 3/5',
                      style: const TextStyle(
                        color: AppColors.whiteColor ,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButtonWidget(
                      onTap: isCompleted
                          ? () {}
                          : () {
                              Navigator.pushNamed(
                                context,
                                RouteConst.selectServicePage,
                                arguments: ScreenRouteArgs(
                                  clientType: S.of(context).legal,
                                  isPensioner: isCompleted,
                                  selectBranchItem: widget.branchItem,
                                ),
                              );
                            },
                      title: S.of(context).legal,
                      width: double.infinity,
                      height: 70.0,
                      bgColor: isCompleted
                          ? Colors.black.withOpacity(.2)
                          : AppColors.whiteColor ,
                      borderRadius: 20,
                      textStyle: TextStyle(
                        color: isCompleted
                            ? Colors.white.withOpacity(.2)
                            : AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButtonWidget(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteConst.selectServicePage,
                          arguments: ScreenRouteArgs(
                            clientType: S.of(context).individual,
                            isPensioner: isCompleted,
                            selectBranchItem: widget.branchItem,
                          ),
                        );
                      },
                      title: S.of(context).individual,
                      width: double.infinity,
                      height: 70.0,
                      bgColor: AppColors.whiteColor ,
                      borderRadius: 20,
                      textStyle: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: 220,
                        child: CheckboxListTile(
                          title:  Text(
                            S.of(context).pensioner,
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          activeColor: AppColors.whiteColor ,
                          checkColor: Colors.black,
                          value: isCompleted,
                          contentPadding: const EdgeInsets.all(0),
                          onChanged: (newValue) {
                            isCompleted = !isCompleted;
                            setState(() {});
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          side: MaterialStateBorderSide.resolveWith(
                            (states) => const BorderSide(
                                width: 1.0, color: Colors.white),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
