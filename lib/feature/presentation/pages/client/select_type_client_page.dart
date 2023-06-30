import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';

class SelectTypeClientPage extends StatefulWidget {
  final BranchEntity branchItem;

  const SelectTypeClientPage({super.key, required this.branchItem});

  @override
  State<SelectTypeClientPage> createState() => _SelectTypeClientPageState();
}

class _SelectTypeClientPageState extends State<SelectTypeClientPage> {
  bool isCompleted = false;

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
                title: 'Выберите тип клиента',
                centerTitle: true,
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Шаг 3/5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButtonWidget(
                      onTap: isCompleted
                          ? () {}
                          : () {
                              Navigator.pushNamed(
                                context,
                                RouteConst.selectServicePage,
                                arguments: ScreenRouteArgs(
                                  clientType: 'Юр. лицо',
                                  isPensioner: isCompleted,
                                  selectBranchItem: widget.branchItem,
                                ),
                              );
                            },
                      title: 'Юридическое лицо',
                      width: double.infinity,
                      height: 70.0,
                      bgColor: isCompleted
                          ? Colors.black.withOpacity(.2)
                          : Colors.white,
                      borderRadius: 20,
                      textStyle: TextStyle(
                        color: isCompleted
                            ? Colors.white.withOpacity(.2)
                            : const Color(0xff0E3584),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButtonWidget(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteConst.selectServicePage,
                          arguments: ScreenRouteArgs(
                            clientType: 'Физ. лицо',
                            isPensioner: isCompleted,
                            selectBranchItem: widget.branchItem,
                          ),
                        );
                      },
                      title: 'Физическое лицо',
                      width: double.infinity,
                      height: 70.0,
                      bgColor: Colors.white,
                      borderRadius: 20,
                      textStyle: const TextStyle(
                        color: Color(0xff0E3584),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: 245,
                        child: CheckboxListTile(
                          title: const Text(
                            'Я пенсионер(-ка)',
                            style: TextStyle(color: Colors.white),
                          ),
                          activeColor: Colors.white,
                          checkColor: Colors.black,
                          value: isCompleted,
                          contentPadding: const EdgeInsets.all(0),
                          onChanged: (newValue) {
                            isCompleted = !isCompleted;
                            setState(() {});
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          side: MaterialStateBorderSide.resolveWith(
                            (states) => const BorderSide(
                                width: 1.0, color: Colors.white),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
