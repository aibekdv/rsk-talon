import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/user/presentation/cubit/language/language_cubit.dart';
import 'package:rsk_talon/features/user/presentation/pages/language/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({super.key});

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  @override
  Widget build(BuildContext context) {
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
          child: BlocListener<LanguageCubit, LanguageState>(
            listener: (context, state) {
              if (state is ChangeLanguage) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteConst.homePage,
                  (route) => false,
                );
              }
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
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
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            S.of(context).selectLanguageText,
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SelectLangaugeItemWidget(
                          onTap: () {
                            BlocProvider.of<LanguageCubit>(context)
                                .changeLanguage("ky");
                          },
                          iconPath: "assets/icons/ky.png",
                          title: "Кыргызча",
                        ),
                        const SizedBox(height: 15),
                        SelectLangaugeItemWidget(
                          onTap: () {
                            BlocProvider.of<LanguageCubit>(context)
                                .changeLanguage("ru");
                          },
                          iconPath: "assets/icons/ru.png",
                          title: "Русский",
                        ),
                        const SizedBox(height: 15),
                        SelectLangaugeItemWidget(
                          onTap: () {
                            BlocProvider.of<LanguageCubit>(context)
                                .changeLanguage("en");
                          },
                          iconPath: "assets/icons/en.png",
                          title: "English",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
