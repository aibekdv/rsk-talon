import 'package:flutter/material.dart';
import 'package:rsk_talon/pages/queue_time_page.dart';

import 'package:rsk_talon/widgets/custom_appbar_widget.dart';
import 'package:rsk_talon/widgets/custom_button_widget.dart';

class FourthPage extends StatefulWidget {
  const FourthPage({super.key});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
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
                title: 'Услуга 1 < Список документов',
                centerTitle: true,
              ),
              const SizedBox(height: 30),
              Center(
                child: Container(
                  height: 400,
                  width: 340,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff34619D),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Здесь будит список документов',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        ' требуемых для определенной услуги.',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        ' Например:',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'паспорт;',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'справка о доходах;',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'заверенная копия трудовой книжки;',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'военный билет (либо приписное удостоверение);',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'документы, подтверждающие семейное положение.',
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 250, top: 140),
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.save_alt,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: CustomButtonWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QueueTimePage(),
                      ),
                    );
                  },
                  title: ' Выбрадь очередь',
                  width: 340,
                  height: 50.0,
                  bgColor: const Color(0xff2E79BD),
                  borderRadius: 20,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
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
