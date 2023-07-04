import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:intl/intl.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/feature/domain/entities/talon_entity.dart';
import 'package:rsk_talon/feature/presentation/cubit/talon/talon_cubit.dart';
import 'package:rsk_talon/generated/l10n.dart';

class TicketItemWidget extends StatelessWidget {
  final String serviceType;
  final TalonEntity talonItem;

  const TicketItemWidget({
    super.key,
    required this.serviceType,
    required this.talonItem,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.parse(talonItem.appointmentDate!);
    final DateTime currentDateTime = DateTime.now();
    var res = dateTime.difference(currentDateTime);

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(.8)),
            gradient: LinearGradient(colors: [
              Colors.white.withOpacity(.2),
              Colors.white.withOpacity(.06),
            ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${S.of(context).yournumber}:",
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      talonItem.token!.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                      textAlign: TextAlign.end,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "${S.of(context).serviceText}:",
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                serviceType,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${S.of(context).date}:\n',
                          style: const TextStyle(
                            height: 1.5,
                            color: AppColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: DateFormat('MMMMd')
                              .format(
                                  DateTime.parse(talonItem.appointmentDate!))
                              .capitalize(),
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 60),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${S.of(context).time}:\n',
                          style: const TextStyle(
                            height: 1.5,
                            color: AppColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: DateFormat('jm').format(
                              DateTime.parse(talonItem.appointmentDate!)),
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${S.of(context).address}\n',
                          style: const TextStyle(
                            height: 1.5,
                            color: AppColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${talonItem.branch!.city}:  ${talonItem.branch!.address}',
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteConst.mapBranchPage,
                        arguments: ScreenRouteArgs(
                          selectBranchItem: talonItem.branch,
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: 180,
                child: Text(
                  res.inMinutes > 0
                      ? S.of(context).remainingMin(res.inMinutes)
                      : S.of(context).statusText(talonItem.status.toString()),
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.save_alt),
                  color: AppColors.whiteColor,
                  iconSize: 22,
                ),
                IconButton(
                  onPressed: () {
                    _dialogForRemoveTicket(context, talon: talonItem);
                  },
                  color: AppColors.whiteColor,
                  icon: const Icon(
                    CupertinoIcons.delete_simple,
                  ),
                  iconSize: 22,
                  splashRadius: 20,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Future<void> _dialogForRemoveTicket(
    BuildContext context, {
    required TalonEntity talon,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            S.of(context).deleteticket,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          contentPadding: const EdgeInsets.all(25),
          actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                S.of(context).yes,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                BlocProvider.of<TalonCubit>(context).deleteTalonItem(talon);
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                S.of(context).cancel,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
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
