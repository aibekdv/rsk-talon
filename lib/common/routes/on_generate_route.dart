import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/domain/entities/branch_entity.dart';
import 'package:rsk_talon/feature/domain/entities/service_entity.dart';
import 'package:rsk_talon/feature/presentation/pages/pages.dart';
import 'package:rsk_talon/generated/l10n.dart';

final class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments as ScreenRouteArgs?;

    switch (settings.name) {
      case RouteConst.homePage:
        return PageTransition(
          child: const HomePage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
        );
      case RouteConst.selectBranchPage:
        return PageTransition(
          child: SelectBranchPage(
            branchEntity: args!.branchItems!,
            cityName: args.cityName!,
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
      case RouteConst.aboutBranchPage:
        return PageTransition(
          child: AboutBranchPage(branchItem: args!.selectBranchItem!),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
      case RouteConst.selectClientTypePage:
        return PageTransition(
          child: SelectTypeClientPage(branchItem: args!.selectBranchItem!),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
      case RouteConst.selectServicePage:
        return PageTransition(
          child: ServicesPage(
            clientType: args!.clientType!,
            isPensioner: args.isPensioner!,
            branchItem: args.selectBranchItem!,
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
      case RouteConst.listOfDocPage:
        return PageTransition(
          child: ListOfDocPage(
            branchItem: args!.selectBranchItem!,
            clientType: args.clientType!,
            isPensioner: args.isPensioner!,
            serviceItem: args.selectServiceItem!,
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
      case RouteConst.selectQueuePage:
        return PageTransition(
          child: QueueTimePage(
            branchItem: args!.selectBranchItem!,
            clientType: args.clientType!,
            isPensioner: args.isPensioner!,
            serviceItem: args.selectServiceItem!,
          ),
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
  final String? message;
  const ErrorPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              message ?? S.of(context).errorPage,
              style: const TextStyle(
                color: AppColors.whiteColor,
                height: 2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class ScreenRouteArgs {
  final bool? isCreatedTicket;
  final List<BranchEntity>? branchItems;
  final BranchEntity? selectBranchItem;
  final ServiceEntity? selectServiceItem;
  final String? clientType;
  final bool? isPensioner;
  final String? cityName;

  ScreenRouteArgs({
    this.branchItems,
    this.selectBranchItem,
    this.isCreatedTicket,
    this.clientType,
    this.isPensioner,
    this.selectServiceItem,
    this.cityName,
  });
}
