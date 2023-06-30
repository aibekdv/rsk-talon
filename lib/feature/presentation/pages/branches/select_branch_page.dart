import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';

class SelectBranchPage extends StatefulWidget {
  final List<BranchEntity> branchEntity;

  const SelectBranchPage({
    super.key,
    required this.branchEntity,
  });

  @override
  State<SelectBranchPage> createState() => _SelectBranchPageState();
}

class _SelectBranchPageState extends State<SelectBranchPage> {
  List<String>? brachesOfBank;
  bool isOpenDropdown = false;

  @override
  void initState() {
    brachesOfBank = widget.branchEntity.map((e) => e.address!).toList();
    super.initState();
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
              const CustomAppBarWidget(title: 'Бишкек'),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                        late BranchEntity listBranch;
                        for (var branche in widget.branchEntity) {
                          if (branche.address == value) {
                            listBranch = BranchEntity(
                              address: branche.address,
                              city: branche.city,
                              id: branche.id,
                              maxTalonWaitTime: branche.maxTalonWaitTime,
                              terminal: branche.terminal,
                              workTimeStart: branche.workTimeStart,
                            );
                          }
                        }
                        Future.delayed(
                          const Duration(milliseconds: 100),
                          () {
                            Navigator.pushNamed(
                              context,
                              RouteConst.aboutBranchPage,
                              arguments:
                                  ScreenRouteArgs(selectBranchItem: listBranch),
                            );
                          },
                        );
                      },
                      isOpenDropdown: isOpenDropdown,
                      items: brachesOfBank!,
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
