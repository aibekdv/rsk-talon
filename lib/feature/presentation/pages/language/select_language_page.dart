import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/presentation/cubit/language/language_cubit.dart';
import 'package:rsk_talon/feature/presentation/pages/language/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({super.key});

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  List<Map<String, dynamic>> langs = [
    {"title": "Кыргызча", "code": "ky", "imagePath": "assets/icons/ky.png"},
    {"title": "Русский", "code": "ru", "imagePath": "assets/icons/ru.png"},
    {"title": "English", "code": "en", "imagePath": "assets/icons/en.png"},
  ];

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
              color: AppColors.primary),
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
    );
  }
}
