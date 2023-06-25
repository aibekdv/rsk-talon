import 'package:flutter/material.dart';
import 'package:rsk_talon/feature/presentation/pages/tickets/widgets/widgets.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({super.key});

  @override
  State<MyTicketsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: ListView.separated(
                    itemBuilder: (context, index) => Padding(
                      padding:
                          EdgeInsets.fromLTRB(0, 0, 0, index == 3 ? 15 : 0),
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
          ),
        ),
      ),
    );
  }
}
