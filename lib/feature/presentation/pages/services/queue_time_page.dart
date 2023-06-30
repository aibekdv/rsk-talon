import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/presentation/cubit/talon/talon_cubit.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';

class QueueTimePage extends StatefulWidget {
  final BranchEntity branchItem;
  final bool isPensioner;
  final String clientType;
  final ServiceEntity serviceItem;

  const QueueTimePage({
    super.key,
    required this.branchItem,
    required this.isPensioner,
    required this.clientType,
    required this.serviceItem,
  });

  @override
  State<QueueTimePage> createState() => _QueueTimePageState();
}

class _QueueTimePageState extends State<QueueTimePage> {
  bool isSelectedTime = false;
  bool isCreatedTicket = false;

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
              CustomAppBarWidget(
                title:
                    '${widget.clientType} < ${widget.serviceItem.name?.substring(0, 12)} < Очередь',
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
                          BlocBuilder<TalonCubit, TalonState>(
                            builder: (context, state) {
                              bool isLoading = false;

                              if (state is TalonLoading) {
                                isLoading = true;
                              } else if (state is TalonFailure) {
                                isLoading = false;
                                toast(msg: state.message, isError: true);
                              } else if (state is TalonSuccess) {
                                isLoading = false;
                                isCreatedTicket = true;
                                print("created: " + isCreatedTicket.toString());
                              }

                              return CustomButtonWidget(
                                onTap: () {
                                  BlocProvider.of<TalonCubit>(context)
                                      .createNewTalon(
                                    TalonEntity(
                                      branch: widget.branchItem.id,
                                      isPensioner: widget.isPensioner,
                                      clientType: widget.clientType,
                                      service: widget.serviceItem.id,
                                    ),
                                  );

                                  Future.delayed(
                                      const Duration(
                                        seconds: 2,
                                      ), () {
                                    if (isCreatedTicket == true) {
                                      return Navigator.pushNamed(
                                        context,
                                        RouteConst.myTicketsPage,
                                        arguments: ScreenRouteArgs(
                                          isCreatedTicket: isCreatedTicket,
                                        ),
                                      );
                                    }
                                  });
                                },
                                isLoading: isLoading,
                                title: 'Встать в конец очереди',
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                width: double.infinity,
                                height: 48,
                                bgColor: Colors.transparent,
                                borderColor: Colors.white,
                              );
                            },
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
                      onTap: isSelectedTime
                          ? () {
                              Navigator.pushNamed(
                                context,
                                RouteConst.myTicketsPage,
                                arguments:
                                    ScreenRouteArgs(isCreatedTicket: true),
                              );
                            }
                          : () {},
                      title: 'Создать талон',
                      width: double.infinity,
                      height: 54,
                      bgColor:
                          !isSelectedTime ? Colors.black.withOpacity(.2) : null,
                      borderRadius: 20,
                      textStyle: TextStyle(
                        color: !isSelectedTime
                            ? Colors.white.withOpacity(.2)
                            : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(text: 'Пожалуйста выберите время\n'),
                            TextSpan(
                              text: 'или\n',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            TextSpan(text: 'Нажмите встать в конец очереди'),
                          ],
                        ),
                      ),
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
