import 'dart:io';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/user/domain/entities/talon_entity.dart';
import 'package:rsk_talon/features/user/presentation/cubit/talon/talon_cubit.dart';
import 'package:rsk_talon/features/user/presentation/pages/tickets/pdf/make_pdf.dart';
import 'package:rsk_talon/generated/l10n.dart';
import 'package:translit/translit.dart';
import 'package:pdf/widgets.dart' as pw;

class TicketItemWidget extends StatefulWidget {
  final TalonEntity talonItem;
  final String status;

  const TicketItemWidget({
    super.key,
    required this.talonItem,
    required this.status,
  });

  @override
  State<TicketItemWidget> createState() => _TicketItemWidgetState();
}

class _TicketItemWidgetState extends State<TicketItemWidget> {
  bool isDownloadSuccess = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.delayed(const Duration(seconds: 1), () {
      String status = widget.status.toLowerCase();

      if (status == 'complited' || status == 'completed') {
        BlocProvider.of<TalonCubit>(context)
            .setTokenToCache(widget.talonItem.token!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.parse(widget.talonItem.appointmentDate!);
    final DateTime currentDateTime = DateTime.now();
    var res = dateTime.difference(currentDateTime);
    String langCode = Localizations.localeOf(context).languageCode;

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
                      widget.talonItem.token!.toUpperCase(),
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
                widget.talonItem.serviceName.toString(),
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
                              .format(DateTime.parse(
                                  widget.talonItem.appointmentDate!))
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
                          text: DateFormat('jm').format(DateTime.parse(
                              widget.talonItem.appointmentDate!)),
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
                              '${langCode == 'en' ? Translit().toTranslit(source: widget.talonItem.branch!.city!) : widget.talonItem.branch!.city}:  ${langCode == 'en' ? Translit().toTranslit(source: widget.talonItem.branch!.address!) : widget.talonItem.branch!.address}',
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
                          selectBranchItem: widget.talonItem.branch,
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
                  res.inSeconds > 0
                      ? S.of(context).remainingMin(
                            formatDurationTime(res).$1,
                            formatDurationTime(res).$2,
                          )
                      : S.of(context).statusText(widget.status),
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
                  onPressed: () async {
                    setState(() => isDownloadSuccess = true);
                    final pdf = await makePdf(widget.talonItem, context);
                    bool isGranted = await requestStoragePermission();

                    if (isGranted) {
                      Future.delayed(const Duration(milliseconds: 600),
                          () async {
                        await savePdf(pdf, widget.talonItem).then((value) {
                          toast(msg: S.of(context).downloadedSuccessfully);
                          setState(() => isDownloadSuccess = false);
                        });
                      });
                    }
                  },
                  icon: !isDownloadSuccess
                      ? const Icon(Icons.save_alt)
                      : const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Colors.white,
                          ),
                        ),
                  color: AppColors.whiteColor,
                  iconSize: 22,
                ),
                IconButton(
                  onPressed: () {
                    _dialogForRemoveTicket(context, talon: widget.talonItem);
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

(String, String) formatDurationTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  return (duration.inHours.toString(), twoDigitMinutes);
}

Future<void> savePdf(pw.Document pdf, TalonEntity talon) async {
  final directory = await getExternalStorageDirectory();
  if (directory != null) {
    final file = File("${directory.path}/ticket_${talon.token}.pdf");

    final pdfFile = await pdf.save();
    await file.writeAsBytes(pdfFile);

    DocumentFileSavePlus().saveFile(
      pdfFile,
      'ticket_${talon.token}.pdf',
      'ticket_${talon.token}/.pdf',
    );
  }
}

Future<bool> requestStoragePermission() async {
  if (await Permission.storage.isGranted) {
    return true;
  } else {
    final status = await Permission.storage.request();
    return status.isGranted;
  }
}
