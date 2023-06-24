import 'package:flutter/material.dart';
import 'package:rsk_talon/pages/select_type_client_page.dart';
import 'package:rsk_talon/widgets/custom_button_widget.dart';

class AboutBranchPage extends StatefulWidget {
  const AboutBranchPage({
    super.key,
  });

  @override
  State<AboutBranchPage> createState() => _AboutBranchPageState();
}

class _AboutBranchPageState extends State<AboutBranchPage> {
  List<Map<String, dynamic>> schedule = [
    {
      'weekDay': 'Понедельник',
      'time': '10:00-20:00',
    },
    {
      'weekDay': 'Вторник',
      'time': '10:00-20:00',
    },
    {
      'weekDay': 'Среда',
      'time': '10:00-20:00',
    },
    {
      'weekDay': 'Четверг',
      'time': '10:00-20:00',
    },
    {
      'weekDay': 'Пятница',
      'time': '10:00-20:00',
    },
    {
      'weekDay': 'Суббота',
      'time': '10:00-20:00',
    },
    {
      'weekDay': 'Вскресенье',
      'time': 'не работет',
    },
  ];
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
              const SizedBox(
                height: 100,
              ),
              Center(
                child: Image.asset(
                  'assets/images/large_logo.png',
                  width: 162.0,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                width: double.infinity,
                color: const Color(0xff386AA7),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Flexible(
                      flex: 1,
                      child: Text(
                        'ОАО "РСК Банк" Октябрьский  филиал',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Адрес: 48 просп. Чуй, Бишкек",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: SizedBox(
                        width: 230,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...schedule
                                .map((item) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item['weekDay'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          item['time'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomButtonWidget(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const SelectTypeClientPage())));
                      },
                      title: 'Далее',
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      width: double.infinity,
                      height: 54.0,
                    )
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
