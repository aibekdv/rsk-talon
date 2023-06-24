import 'package:flutter/material.dart';
import 'package:rsk_talon/widgets/widgets.dart';

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
              Image.asset(
                'assets/icons/appar.png',
                width: 162.0,
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
                  padding: const EdgeInsets.symmetric(horizontal: 30),
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
                              onTap: () {},
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
                              onTap: () {},
                              title: 'Сегодня, 10:00',
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
                        onTap: () {},
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
}
