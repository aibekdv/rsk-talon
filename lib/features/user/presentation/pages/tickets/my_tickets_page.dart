import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'package:rsk_talon/features/user/presentation/cubit/cubit.dart';
import 'package:rsk_talon/features/user/presentation/pages/tickets/widgets/widgets.dart';
import 'package:rsk_talon/features/user/presentation/widgets/widgets.dart';
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
  bool isLoading = false;
  List<TalonEntity> talonList = [];

  @override
  void initState() {
    super.initState();

    isSuccess = widget.isCreatedTicket;
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
    BlocProvider.of<TalonCubit>(context).getTalonsFromServer();
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
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            color: AppColors.primary,
          ),
          child: BlocBuilder<TalonCubit, TalonState>(
            builder: (context, state) {
              if (state is TalonFromServerLoading) {
                isLoading = true;
              } else if (state is TalonFromServerSuccess) {
                talonList = state.talonList;
                talonList =  List.from(talonList.reversed);
                isLoading = false;
              }
              return isSuccess != null && isSuccess == true
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
            Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: const ShapeDecoration(
                    color: Color(0x33D9D9D9),
                    shape: OvalBorder(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteConst.profilePage);
                      },
                      child: Image.asset(
                        "assets/icons/user.png",
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        CustomAppBarWidget(
          title: S.of(context).mytickets,
          centerTitle: true,
          isFromCreate: widget.isCreatedTicket ?? false,
        ),
        if (isLoading)
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.whiteColor,
              ),
            ),
          ),
        if (talonList.isNotEmpty)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () {
                  return BlocProvider.of<TalonCubit>(context)
                      .getTalonsFromServer();
                },
                child: ListView.separated(
                  itemCount: talonList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        index == 0 ? 20 : 0,
                        0,
                        index == 3 ? 15 : 0,
                      ),
                      child: TicketItemWidget(
                        talonItem: talonList[index],
                      ),
                    );
                  },
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
          ),
        if (isLoading == false && talonList.isEmpty) _ticketEmpty()
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
    return Expanded(
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
              onTap: () => Navigator.pushNamed(context, RouteConst.homePage),
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
    );
  }
}
