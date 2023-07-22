import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as material;
import 'package:rsk_talon/generated/l10n.dart';

Future<Document> makePdf(
  TalonEntity talonEntity,
  material.BuildContext materialContext,
) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
    (await rootBundle.load('assets/images/rsk.png')).buffer.asUint8List(),
  );

  final font = await loadCustomFont();

  final appointmentDate =
      DateFormat("yMMMd").format(DateTime.parse(talonEntity.appointmentDate!));
  final appointmentTime =
      DateFormat("jm").format(DateTime.parse(talonEntity.appointmentDate!));

  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ОАО РСК банк',
                      style: Theme.of(context)
                          .header2
                          .copyWith(fontFallback: [font]),
                    ),
                    Text(
                      '${S.of(materialContext).faxText}: +996 312 65-09-45',
                      style: TextStyle(font: font),
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: Image(imageLogo),
                ),
              ],
            ),
            Container(height: 30),
            Padding(
              child: Text(
                S.of(materialContext).electronicQueueText,
                style: Theme.of(context).header1.copyWith(fontFallback: [font]),
              ),
              padding: const EdgeInsets.all(20),
            ),
            Container(height: 20),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    PaddedText(
                      S.of(materialContext).ticketNumberText,
                      font: font,
                    ),
                    PaddedText(
                      talonEntity.token!.toUpperCase(),
                      font: font,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      S.of(materialContext).cityText,
                      font: font,
                    ),
                    PaddedText(
                      '${talonEntity.branch!.city}',
                      font: font,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      S.of(materialContext).branchText,
                      font: font,
                    ),
                    PaddedText(
                      '${talonEntity.branch!.address}',
                      font: font,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      S.of(materialContext).clientTypeText,
                      font: font,
                    ),
                    PaddedText(
                      '${talonEntity.clientType}',
                      font: font,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      S.of(materialContext).serviceText,
                      font: font,
                    ),
                    PaddedText(
                      '${talonEntity.serviceName}',
                      font: font,
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      S.of(materialContext).timeText,
                      font: font,
                    ),
                    PaddedText(
                      "$appointmentDate $appointmentTime",
                      font: font,
                    )
                  ],
                ),
              ],
            ),
           
          ],
        );
      },
    ),
  );
  return pdf;
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
  final Font? font,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(font: font),
      ),
    );

Future<Font> loadCustomFont() async {
  final fontData =
      await rootBundle.load("assets/fonts/inter/Inter-Regular.ttf");
  return Font.ttf(fontData);
}
