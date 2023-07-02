import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class TheBranchMapPage extends StatelessWidget {
  const TheBranchMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                title: S.of(context).map,
                centerTitle: true,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Здесь бутет карта филиала",
                      style: TextStyle(
                        color: AppColors.whiteColor ,
                        fontSize: 18,
                      ),
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
