import 'package:flutter/material.dart';
import 'package:rsk_talon/pages/about_branch_page.dart';
import 'package:rsk_talon/widgets/widgets.dart';

class SelectBranchPage extends StatefulWidget {
  const SelectBranchPage({
    super.key,
  });

  @override
  State<SelectBranchPage> createState() => _SelectBranchPageState();
}

class _SelectBranchPageState extends State<SelectBranchPage> {
  List<String> brachsOfBank = [
    'ОАО "РСК Банк" Октябрьский филиал',
    'ОАО "РСК Банк" Чуйский филиал',
    'ОАО "РСК Банк" Головной офис',
  ];
  bool isOpenDropdown = false;

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
                    const Text(
                      'Бишкек',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Шаг 2/5',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SelectOptionWidget(
                      title: 'Выберите филиал',
                      onMenuStateChange: (isOpen) {
                        isOpenDropdown = !isOpenDropdown;
                        setState(() {});
                      },
                      onTapItem: (value) {
                        Future.delayed(
                          const Duration(milliseconds: 100),
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutBranchPage(),
                              ),
                            );
                          },
                        );
                      },
                      isOpenDropdown: isOpenDropdown,
                      items: brachsOfBank,
                    ),
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
