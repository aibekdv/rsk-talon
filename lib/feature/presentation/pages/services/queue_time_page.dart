import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/domain/entities/entities.dart';
import 'package:rsk_talon/feature/presentation/cubit/talon/talon_cubit.dart';
import 'package:rsk_talon/feature/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

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
  bool isLoading = false;

  DateTime currentYear = DateTime(DateTime.now().year);
  DateTime selectedDateTime = DateTime.now();
  late DateTime initialData;


  @override
  Widget build(BuildContext context) {
    var selectedTimeFormated =
        "${DateFormat('yMMMEd').format(selectedDateTime)} ${DateFormat('jm').format(selectedDateTime)}";

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover,
              ),
              color: AppColors.primary),
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
                    '${widget.clientType} < ${widget.serviceItem.name!.length > 9 ? "${widget.serviceItem.name!.substring(0, 10)}.." : widget.serviceItem.name} < Очередь',
                centerTitle: true,
              ),
              const SizedBox(
                height: 60,
              ),
              SingleChildScrollView(
                child: Padding(
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
                            Text(
                              '${S.of(context).step} 5/5 ',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 20),
                            BlocBuilder<TalonCubit, TalonState>(
                              builder: (context, state) {
                                if (state is TalonFromCacheLoading) {
                                  isLoading = true;
                                } else if (state is TalonFailure) {
                                  isLoading = false;
                                } else if (state is TalonFromCacheSuccess) {
                                  isCreatedTicket = true;
                                  Future.delayed(
                                      const Duration(milliseconds: 300), () {
                                    if (isCreatedTicket == true) {
                                      Navigator.pushNamed(
                                        context,
                                        RouteConst.myTicketsPage,
                                        arguments: ScreenRouteArgs(
                                          isCreatedTicket: isCreatedTicket,
                                        ),
                                      );
                                    }
                                  });
                                }

                                return CustomButtonWidget(
                                  onTap: () {
                                    BlocProvider.of<TalonCubit>(context)
                                        .createNewTalon(
                                      TalonEntity(
                                        branch: widget.branchItem,
                                        isPensioner: widget.isPensioner,
                                        clientType: widget.clientType,
                                        service: widget.serviceItem.id,
                                      ),
                                    );
                                  },
                                  title: S.of(context).togetinline,
                                  textStyle: const TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  width: double.infinity,
                                  height: 48,
                                  bgColor: Colors.transparent,
                                  borderColor: AppColors.whiteColor,
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            Center(
                                child: Text(
                              S.of(context).or,
                              style: const TextStyle(color: Colors.white),
                            )),
                            const SizedBox(height: 10),
                            CustomButtonWidget(
                              onTap: () => _selectDate(
                                S
                                    .of(context)
                                    .theBankDoesNotWorkAtTheTimeYouHave,
                                S
                                    .of(context)
                                    .pleaseSelectADateAndTimeInTheFuture,
                              ),
                              title: isSelectedTime
                                  ? selectedTimeFormated
                                  : S.of(context).selectTime,
                              textStyle: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                              width: double.infinity,
                              height: 48,
                              bgColor: AppColors.whiteColor,
                              isSelectTime: !isSelectedTime,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomButtonWidget(
                        onTap: isSelectedTime
                            ? () {
                                BlocProvider.of<TalonCubit>(context)
                                    .createNewTalon(
                                  TalonEntity(
                                    branch: widget.branchItem,
                                    isPensioner: widget.isPensioner,
                                    clientType: widget.clientType,
                                    service: widget.serviceItem.id,
                                    appointmentDate:
                                        selectedDateTime.toString(),
                                  ),
                                );
                              }
                            : () {},
                        title: S.of(context).createaticket,
                        width: double.infinity,
                        height: 54,
                        bgColor: !isSelectedTime
                            ? Colors.black.withOpacity(.2)
                            : null,
                        borderRadius: 20,
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: !isSelectedTime
                              ? Colors.white.withOpacity(.2)
                              : AppColors.whiteColor,
                        ),
                      ),
                      BlocBuilder<TalonCubit, TalonState>(
                        builder: (context, state) {
                          if (state is TalonFromCacheLoading) {
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 20),
                                  const SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    S.of(context).loadingText,
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool defineSelectable(DateTime val) {
    DateTime now = DateTime.now();
    if (val.isBefore(now)) {
      return false;
    } else if (val.weekday == DateTime.saturday ||
        val.weekday == DateTime.sunday) {
      return false;
    } else {
      return true;
    }
  }

  Future<TimeOfDay?> pickTime() async {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  Future<void> _selectDate(
    String errorText,
    String isBeforeTimeErrorText,
  ) async {
    DateTime initialDate = DateTime.now();
    while (!defineSelectable(initialDate)) {
      initialDate = initialDate.add(const Duration(days: 1));
    }

    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      selectableDayPredicate: defineSelectable,
      firstDate: DateTime(currentYear.year),
      lastDate: DateTime(currentYear.year + 1),
    );

    if (date == null) return;

    final TimeOfDay? time = await pickTime();

    if (time == null) return;

    DateTime selectedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    if (selectedDateTime.isBefore(DateTime.now())) {
      toast(
        msg: isBeforeTimeErrorText,
        isError: true,
      );
      return;
    }

    if (time.hour < 8 || time.hour > 16) {
      toast(msg: errorText, isError: true);
      return;
    }

    setState(() {
      isSelectedTime = true;
      this.selectedDateTime = selectedDateTime;
    });
  }
}
