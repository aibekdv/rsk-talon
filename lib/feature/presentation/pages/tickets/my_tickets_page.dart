import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/presentation/pages/tickets/widgets/widgets.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';

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
  bool isEmpty = false;

  @override
  void initState() {
    isSuccess = widget.isCreatedTicket;
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        isSuccess = false;
        setState(() {});
      },
    );
    super.initState();
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
            color: Color(0xff0D3584),
          ),
          child: isEmpty
              ? _ticketEmpty()
              : isSuccess != null && isSuccess == true
                  ? _ticketSuccess()
                  : _ticketBuilder(),
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
        const CustomAppBarWidget(
          title: 'Мои талоны',
          centerTitle: true,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: ListView.separated(
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.fromLTRB(
                    0, index == 0 ? 20 : 0, 0, index == 3 ? 15 : 0),
                child: const TicketItemWidget(),
              ),
              separatorBuilder: (context, index) => Column(
                children: [
                  Divider(
                    color: Colors.white.withOpacity(.6),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              itemCount: 4,
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
          const Text(
            'Талон успешно создан!',
            style: TextStyle(
              color: Colors.white,
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
        Image.asset(
          'assets/icons/appar.png',
          width: 162.0,
        ),
        const SizedBox(
          height: 25,
        ),
        const CustomAppBarWidget(
          title: 'Мои талоны',
          centerTitle: true,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "У вас пока не талоны",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 15),
                CustomButtonWidget(
                  onTap: () {},
                  width: double.infinity,
                  height: 54,
                  title: 'Добавить талон',
                  textStyle: const TextStyle(
                    color: Colors.white,
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
