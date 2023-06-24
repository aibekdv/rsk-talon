import 'package:flutter/material.dart';
import 'package:rsk_talon/pages/select_branch_page.dart';
import 'package:rsk_talon/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> cityOfList = [
    'Бишкек',
    'Ош',
    'Жалал-абад',
    'Кара-кол',
    'Талас',
    'Кара-Балта',
    'Кемин',
    // 'Кызыл-Кия',
    // 'Токмок',
    // 'Чолпон-Ата'
  ];
  bool isOpenDropdown = false;

  @override
  void dispose() {
    // TODO: implement dispose
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Center(
                  child: SizedBox(
                    height: 120,
                    child: Image.asset(
                      'assets/images/large_logo.png',
                      width: 162.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  'Шаг 1/5',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                SelectOptionWidget(
                  title: 'Выберите город',
                  onMenuStateChange: (isOpen) {
                    isOpenDropdown = !isOpenDropdown;
                    setState(() {});
                  },
                  onTapItem: (value) {
                    print(value);
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectBranchPage(),
                          ),
                        );
                      },
                    );
                  },
                  isOpenDropdown: isOpenDropdown,
                  items: cityOfList,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "У Вас уже есть талон?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomButtonWidget(
                      onTap: () {},
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      title: 'Да',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
