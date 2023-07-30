import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/auth/domain/entities/entities.dart';
import 'package:rsk_talon/features/auth/presentation/cubit/sign_in/sign_in_cubit.dart';
import 'package:rsk_talon/features/user/presentation/cubit/cubit.dart';
import 'package:rsk_talon/features/user/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> lang = {};
  String langCode = '';

  UserEntity? userInfo;

  @override
  void didChangeDependencies() {
    BlocProvider.of<TalonCubit>(context).getUserInfo();

    langCode = Localizations.localeOf(context).languageCode;

    if (langCode.isNotEmpty) {
      lang = switch (langCode) {
        'ky' => {"code": langCode, "text": "Кыргызча"},
        'en' => {"code": langCode, "text": "English"},
        'ru' => {"code": langCode, "text": "Русский"},
        _ => {"code": langCode, "text": "Русский"},
      };
      setState(() {});
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  PopupMenuButton(
                    color: Colors.white,
                    padding: const EdgeInsets.all(0),
                    enableFeedback: false,
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          onTap: () async {
                            await BlocProvider.of<SignInCubit>(context)
                                .logout();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteConst.signInPage,
                              (route) => false,
                            );
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).logout,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.logout_outlined),
                            ],
                          ),
                        ),
                      ];
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              CustomAppBarWidget(
                title: S.of(context).myAccount,
                centerTitle: true,
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).interfaceLanguage,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        _threeItemPopup(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${S.of(context).phoneNumberText}:',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<TalonCubit, TalonState>(
                          builder: (context, state) {
                            if (state is UserFromCacheLoaded) {
                              userInfo = state.user;
                            }

                            return Container(
                              height: 50,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.50, color: Colors.white),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 15),
                                  Text(
                                    userInfo?.phoneNumber ?? "0777665544",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Color(0xFF5C5C5C),
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${S.of(context).passwordText}:',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 50,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '********',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF5C5C5C),
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(context, '');
                                  },
                                  icon: const Icon(Icons.edit),
                                  color: AppColors.primary,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomButtonWidget(
                      onTap: () {
                        Navigator.pushNamed(context, RouteConst.myTicketsPage);
                      },
                      title: S.of(context).viewMyTickets,
                      width: double.infinity,
                      height: 54,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _threeItemPopup() => PopupMenuButton(
        padding: EdgeInsets.zero,
        color: Colors.white,
        offset: Offset.zero,
        position: PopupMenuPosition.over,
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          padding: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.50, color: Colors.white),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            lang['text'].toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () async {
                try {
                  await BlocProvider.of<LanguageCubit>(context)
                      .changeLanguage("ky");
                  lang = {"code": "ky", "text": "Кыргызча"};
                  setState(() {});
                } catch (e) {
                  log(e.toString());
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage("assets/icons/ky.png"),
                    ),
                    SizedBox(width: 10),
                    Text("Кыргызча"),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              onTap: () async {
                try {
                  await BlocProvider.of<LanguageCubit>(context)
                      .changeLanguage("ru");
                  lang = {"code": "ru", "text": "Русский"};
                  setState(() {});
                } catch (e) {
                  log(e.toString());
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage("assets/icons/ru.png"),
                    ),
                    SizedBox(width: 10),
                    Text("Русский"),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              onTap: () async {
                try {
                  await BlocProvider.of<LanguageCubit>(context)
                      .changeLanguage("en");
                  lang = {"code": "en", "text": "English"};
                  setState(() {});
                } catch (e) {
                  log(e.toString());
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage("assets/icons/en.png"),
                    ),
                    SizedBox(width: 10),
                    Text("English"),
                  ],
                ),
              ),
            ),
          ];
        },
      );
}
