import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class ListOfDocPage extends StatefulWidget {
  final BranchEntity branchItem;
  final bool isPensioner;
  final String clientType;
  final ServiceEntity serviceItem;

  const ListOfDocPage({
    super.key,
    required this.branchItem,
    required this.isPensioner,
    required this.clientType,
    required this.serviceItem,
  });

  @override
  State<ListOfDocPage> createState() => _ListOfDocPageState();
}

class _ListOfDocPageState extends State<ListOfDocPage> {
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
                title:
                    ' ${widget.clientType} < ${S.of(context).listofdocuments}',
                centerTitle: true,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(.1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S
                                .of(context)
                                .listOfDocumentsRequiredForASpecificService,
                            style: const TextStyle(
                              color: AppColors.whiteColor ,
                              fontSize: 16.0,
                              height: 2,
                            ),
                          ),
                          const SizedBox(height: 20),
                           Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: (){},
                                icon: const Icon(
                                  Icons.save_alt,
                                  color: AppColors.whiteColor ,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButtonWidget(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteConst.selectQueuePage,
                          arguments: ScreenRouteArgs(
                            clientType: widget.clientType,
                            isPensioner: widget.isPensioner,
                            selectBranchItem: widget.branchItem,
                            selectServiceItem: widget.serviceItem,
                          ),
                        );
                      },
                      title: S.of(context).selectqueue,
                      width: double.infinity,
                      height: 50.0,
                      bgColor: AppColors.primaryBtnColor,
                      borderRadius: 20,
                      textStyle: const TextStyle(
                        color: AppColors.whiteColor ,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
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
