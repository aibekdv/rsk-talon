import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/domain/entities/branch_entity.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';

class AboutBranchPage extends StatefulWidget {
  final BranchEntity branchItem;

  const AboutBranchPage({
    super.key,
    required this.branchItem,
  });

  @override
  State<AboutBranchPage> createState() => _AboutBranchPageState();
}

class _AboutBranchPageState extends State<AboutBranchPage> {
  List<Map<String, dynamic>> schedule = [
    {
      'weekDay': 'Понедельник',
      'time': '09:00-17:00',
    },
    {
      'weekDay': 'Вторник',
      'time': '09:00-17:00',
    },
    {
      'weekDay': 'Среда',
      'time': '09:00-17:00',
    },
    {
      'weekDay': 'Четверг',
      'time': '09:00-17:00',
    },
    {
      'weekDay': 'Пятница',
      'time': '09:00-17:00',
    },
    {
      'weekDay': 'Суббота',
      'time': '10:00-15:00',
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
               const CustomAppBarWidget(
                title:'Филиал банка' ,
                centerTitle: true,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Center(
                      child: Text(
                        "Адрес: ${widget.branchItem.address}",
                        style: const TextStyle(
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
                        Navigator.pushNamed(
                          context,
                          RouteConst.selectClientTypePage,
                          arguments: ScreenRouteArgs(selectBranchItem: widget.branchItem),
                        );
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
