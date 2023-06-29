import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';

class QueueTimePage extends StatefulWidget {
  const QueueTimePage({super.key});

  @override
  State<QueueTimePage> createState() => _QueueTimePageState();
}

class _QueueTimePageState extends State<QueueTimePage> {
  final List numbers = List.generate(30, (index) => "Item ${++index}");

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
                title: 'Юр.лицо < Услуга 1 < Очередь',
                centerTitle: true,
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Шаг 5/5',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 20),
                            CustomButtonWidget(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteConst.myTicketsPage,
                                  arguments:
                                      ScreenRouteArgs(isCreatedTicket: true),
                                );
                              },
                              title: 'Встать в конец очереди',
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              width: double.infinity,
                              height: 48,
                              bgColor: Colors.transparent,
                              borderColor: Colors.white,
                            ),
                            const SizedBox(height: 10),
                            const Center(
                                child: Text(
                              "или",
                              style: TextStyle(color: Colors.white),
                            )),
                            const SizedBox(height: 10),
                            CustomButtonWidget(
                              onTap: () {
                                _dialogBuilder(context);
                              },
                              title: 'Выбрать время',
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              width: double.infinity,
                              height: 48,
                              bgColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 60),
                      CustomButtonWidget(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteConst.myTicketsPage,
                            arguments: ScreenRouteArgs(isCreatedTicket: true),
                          );
                        },
                        title: 'Создать талон',
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        width: double.infinity,
                        height: 54,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выберите время'),
          content: const SizedBox(
            height: 100,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Сегодня'),
                      Text('10 00'),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Сб, июнь 17'),
                      Text('12 00'),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Вс, июнь 18'),
                      Text('11 05'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'ОК',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Отменить',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
