import 'package:flutter/material.dart';
import 'package:rsk_talon/feature/domain/entities/branch_entity.dart';
import 'package:rsk_talon/feature/presentation/pages/home/home.dart';
import 'package:rsk_talon/generated/l10n.dart';

class LanguagesHome extends StatefulWidget {
  const LanguagesHome({super.key, required List<BranchEntity> branchesList});

  @override
  State<LanguagesHome> createState() => _LanguagesHomeState();
}

class _LanguagesHomeState extends State<LanguagesHome> {
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
              Center(
                child: Text(
                  S.of(context).selectLanguageText,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(27),
                        topLeft: Radius.circular(27),
                        bottomRight: Radius.circular(17),
                        topRight: Radius.circular(17),
                      ),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    height: 55,
                    width: 340,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(55),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(55), //add border radius
                            child: Image.asset(
                              'assets/flags/kyrgyz.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          'Кыргызча',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(27),
                          bottomRight: Radius.circular(17),
                          topRight: Radius.circular(17),
                          topLeft: Radius.circular(27)),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    height: 56,
                    width: 340,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(55),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(55.0), //add border radius
                            child: Image.asset(
                              'assets/flags/rus.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          'Русский',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(27),
                          bottomRight: Radius.circular(17),
                          topRight: Radius.circular(17),
                          topLeft: Radius.circular(27)),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    height: 56,
                    width: 340,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(55),
                              color: Colors.white),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(55.0), //add border radius
                            child: Image.asset(
                              'assets/flags/america.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          'English',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
