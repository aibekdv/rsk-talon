import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/presentation/cubit/cubit.dart';
import 'package:rsk_talon/feature/presentation/pages/tickets/widgets/widgets.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class MyTicketsPage extends StatefulWidget {
  final bool? isCreatedTicket;

  const MyTicketsPage({
    super.key,
    this.isCreatedTicket = false,
  });

  @override
  State<MyTicketsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage> {
  bool? isSuccess;
  late bool isEmpty;
  bool isLoading = false;
  List<TalonEntity> talonList = [];
  List<ServiceEntity> serviceList = [];

  @override
  void initState() {
    super.initState();

    isSuccess = widget.isCreatedTicket;
    isEmpty = talonList.isEmpty;
    setState(() {});

    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        isSuccess = false;
        setState(() {});
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<TalonCubit>(context).getCachedTalons();
    BlocProvider.of<TalonCubit>(context).fetchServicesFromServer();
  }

  @override
  void dispose() {
    isSuccess = true;
    super.dispose();
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
              color: AppColors.primary),
          child: BlocBuilder<TalonCubit, TalonState>(
            builder: (context, state) {
              if (state is TalonCacheLoading) {
                isLoading = true;
              } else if (state is TalonCacheSuccess) {
                talonList = state.talonList;
                isEmpty = talonList.isEmpty;
              } else if (state is ServiceLoading) {
                isLoading = true;
              } else if (state is ServiceSuccess) {
                serviceList = state.serviceList;
                isLoading = false;
              }
              return isEmpty
                  ? _ticketEmpty()
                  : isSuccess != null && isSuccess == true
                      ? _ticketSuccess()
                      : _ticketBuilder();
            },
          ),
        ),
      ),
    );
  }

  Widget _ticketBuilder() {
    return Column(
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
          title: S.of(context).mytickets,
          centerTitle: true,
          isFromCreate: widget.isCreatedTicket ?? false,
        ),
        isLoading
            ? const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  ),
                ),
              )
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: ListView.separated(
                    itemCount: talonList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        index == 0 ? 20 : 0,
                        0,
                        index == 3 ? 15 : 0,
                      ),
                      child: TicketItemWidget(
                        talonItem: talonList[index],
                        serviceType: serviceName(
                              serviceList,
                              talonList[index].service!,
                            ) ??
                            talonList[index].service.toString(),
                      ),
                    ),
                    separatorBuilder: (context, index) => Column(
                      children: [
                        Divider(
                          color: Colors.white.withOpacity(.6),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _ticketSuccess() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/icons/success.png',
              width: 92,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            S.of(context).ticketCreated,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ticketEmpty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, RouteConst.homePage),
          child: Image.asset(
            'assets/icons/appar.png',
            width: 162.0,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        CustomAppBarWidget(
          title: S.of(context).mytickets,
          centerTitle: true,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 250,
                    child: Text(
                      S.of(context).youDontHaveTicketsYet,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButtonWidget(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteConst.homePage),
                  width: double.infinity,
                  height: 54,
                  title: S.of(context).add,
                  textStyle: const TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String? serviceName(List<ServiceEntity> services, int? id) {
  if (id != null && services.isNotEmpty) {
    var res = services.where((element) => element.id == id);
    return res.first.name;
  }
  return null;
}
