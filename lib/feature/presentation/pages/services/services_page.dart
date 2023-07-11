import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/presentation/cubit/talon/talon_cubit.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class ServicesPage extends StatefulWidget {
  final BranchEntity branchItem;
  final bool isPensioner;
  final String clientType;

  const ServicesPage({
    super.key,
    required this.branchItem,
    required this.isPensioner,
    required this.clientType,
  });

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  List<ServiceEntity> serviceList = [];
  String? lang;

  @override
  void didChangeDependencies() {
    BlocProvider.of<TalonCubit>(context).fetchServicesFromServer();
    lang = Localizations.localeOf(context).languageCode;
    super.didChangeDependencies();
  }

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
                title: S.of(context).seleckservis,
                centerTitle: true,
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${S.of(context).step} 4/5',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<TalonCubit, TalonState>(
                builder: (context, state) {
                  if (state is ServiceLoading) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    );
                  } else if (state is ServiceFailure) {
                    return ErrorPage(message: state.message);
                  } else if (state is ServiceSuccess) {
                    serviceList = state.serviceList;
                  }
                  return Expanded(
                    child: serviceList.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent:
                                  MediaQuery.of(context).size.width / 2,
                              childAspectRatio: 3 / 1.2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: serviceList.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteConst.listOfDocPage,
                                  arguments: ScreenRouteArgs(
                                    clientType: widget.clientType,
                                    isPensioner: widget.isPensioner,
                                    selectBranchItem: widget.branchItem,
                                    selectServiceItem: serviceList[index],
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: index % 2 == 0
                                      ? const BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        )
                                      : const BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          topLeft: Radius.circular(15),
                                        ),
                                ),
                                child: Text(
                                  getServiceLangText(serviceList[index], lang!)
                                      .toString(),
                                  style: const TextStyle(
                                    color: Color(0xff0E3584),
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              S.of(context).servicesNotFound,
                              style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? getServiceLangText(ServiceEntity data, String codeLang) {
  for (var langName in data.langNames!) {
    if (langName.lang == codeLang) {
      return langName.text;
    }
  }
  return null;
}
