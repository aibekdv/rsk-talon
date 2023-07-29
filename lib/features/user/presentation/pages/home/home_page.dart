import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/user/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Column(
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      S.of(context).chooseActionText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomButtonWidget(
                      title: S.of(context).getTicketText,
                      height: 60,
                      textStyle: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      bgColor: Colors.white,
                      borderColor: Colors.white,
                      borderRadius: 20,
                      onTap: () {
                        Navigator.pushNamed(context, RouteConst.selectCityPage);
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomButtonWidget(
                      title: S.of(context).myAccount,
                      height: 60,
                      leadingIcon: Image.asset(
                        "assets/icons/user.png",
                        width: 24,
                        height: 24,
                      ),
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                      bgColor: Colors.transparent,
                      borderColor: Colors.white,
                      borderRadius: 20,
                      onTap: () {
                        Navigator.pushNamed(context, RouteConst.profilePage);
                      },
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
