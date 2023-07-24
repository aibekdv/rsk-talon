import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/auth/presentation/pages/pages.dart';
import 'package:rsk_talon/features/user/domain/entities/branch_entity.dart';
import 'package:rsk_talon/features/user/domain/entities/service_entity.dart';
import 'package:rsk_talon/features/user/presentation/pages/pages.dart';
import 'package:rsk_talon/generated/l10n.dart';

final class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments as ScreenRouteArgs?;

    switch (settings.name) {
      // Home page route
      case RouteConst.homePage:
        return PageTransition(
          child: const NetworkWrapper(child: HomePage()),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
        );

      // Select city page route
      case RouteConst.selectCityPage:
        return PageTransition(
          child: const NetworkWrapper(child: SelectCityPage()),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
        );

      // Profile page route
      case RouteConst.profilePage:
        return PageTransition(
          child: const NetworkWrapper(child: ProfilePage()),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
        );

      // Select branch page route
      case RouteConst.selectBranchPage:
        return PageTransition(
          child: NetworkWrapper(
            child: SelectBranchPage(
              branchEntity: args!.branchItems!,
              cityName: args.cityName!,
            ),
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );

      // About branch page route
      case RouteConst.aboutBranchPage:
        return PageTransition(
          child: NetworkWrapper(
              child: AboutBranchPage(branchItem: args!.selectBranchItem!)),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );

      // Select client type page route
      case RouteConst.selectClientTypePage:
        return PageTransition(
          child: NetworkWrapper(
              child: SelectTypeClientPage(branchItem: args!.selectBranchItem!)),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );

      // Select service page route
      case RouteConst.selectServicePage:
        return PageTransition(
          child: NetworkWrapper(
            child: ServicesPage(
              clientType: args!.clientType!,
              isPensioner: args.isPensioner!,
              branchItem: args.selectBranchItem!,
            ),
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );

      // List of Document page route
      case RouteConst.listOfDocPage:
        return PageTransition(
          child: NetworkWrapper(
            child: ListOfDocPage(
              branchItem: args!.selectBranchItem!,
              clientType: args.clientType!,
              isPensioner: args.isPensioner!,
              serviceItem: args.selectServiceItem!,
            ),
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );

      // Select queue page route
      case RouteConst.selectQueuePage:
        return PageTransition(
          child: NetworkWrapper(
            child: QueueTimePage(
              branchItem: args!.selectBranchItem!,
              clientType: args.clientType!,
              isPensioner: args.isPensioner!,
              serviceItem: args.selectServiceItem!,
            ),
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );

      // My ticket page route
      case RouteConst.myTicketsPage:
        return PageTransition(
          child: NetworkWrapper(
              child: MyTicketsPage(isCreatedTicket: args?.isCreatedTicket)),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );

      // Map branch page route
      case RouteConst.mapBranchPage:
        return PageTransition(
          child: const NetworkWrapper(child: TheBranchMapPage()),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );

      // Sign in page route
      case RouteConst.signInPage:
        return PageTransition(
          child: const NetworkWrapper(child: SignInPage()),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );

      // Sign up page route
      case RouteConst.signUpPage:
        return PageTransition(
          child: const NetworkWrapper(child: SignUpPage()),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );

      // Reset password 1 page route
      case RouteConst.resetStepOne:
        return PageTransition(
          child: const NetworkWrapper(child: ResetPasswordPage1()),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );

      // Reset password 2 page route
      case RouteConst.resetStepTwo:
        return PageTransition(
          child: const NetworkWrapper(child: ResetPasswordPage2()),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );

      // Reset password 3 page route
      case RouteConst.resetStepThree:
        return PageTransition(
          child: const NetworkWrapper(child: ResetPasswordPage3()),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );

      // Error page route
      default:
        return PageTransition(
          child: const NetworkWrapper(child: ErrorPage()),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
        );
    }
  }
}

// Error page
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

// Route arguments
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
