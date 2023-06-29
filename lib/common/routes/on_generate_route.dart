import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/presentation/pages/pages.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments as ScreenRouteArgs?;

    switch (settings.name) {
      case RouteConst.homePage:
        return PageTransition(
          child: const HomePage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
      case RouteConst.selectBranchPage:
        return PageTransition(
          child: const SelectBranchPage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
      case RouteConst.aboutBranchPage:
        return PageTransition(
          child: const AboutBranchPage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
      case RouteConst.selectClientTypePage:
        return PageTransition(
          child: const SelectTypeClientPage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
      case RouteConst.selectServicePage:
        return PageTransition(
          child: const ServicesPage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
      case RouteConst.listOfDocPage:
        return PageTransition(
          child: const ListOfDocPage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
      case RouteConst.selectQueuePage:
        return PageTransition(
          child: const QueueTimePage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
      case RouteConst.myTicketsPage:
        return PageTransition(
          child: MyTicketsPage(isCreatedTicket: args?.isCreatedTicket),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
      case RouteConst.mapBranchPage:
        return PageTransition(
          child: const TheBranchMapPage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
      

      default:
        return PageTransition(
          child: const ErrorPage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          'ErrorPage',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ScreenRouteArgs {
  final bool? isCreatedTicket;

  ScreenRouteArgs({this.isCreatedTicket});
}
