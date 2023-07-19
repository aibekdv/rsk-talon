import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/user/data/models/models.dart';
import 'package:rsk_talon/features/user/domain/entities/entities.dart';
import 'package:rsk_talon/features/user/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class ListOfDocPage extends StatefulWidget {
  final BranchEntity branchItem;
  final bool isPensioner;
  final String clientType;
  final ServiceEntity serviceItem;

  const ListOfDocPage({
    super.key,
    required this.branchItem,
    required this.isPensioner,
    required this.clientType,
    required this.serviceItem,
  });

  @override
  State<ListOfDocPage> createState() => _ListOfDocPageState();
}

class _ListOfDocPageState extends State<ListOfDocPage> {
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).languageCode;
    super.didChangeDependencies();
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
            color: AppColors.primary,
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
                    ' ${widget.clientType} < ${S.of(context).listofdocuments}',
                centerTitle: true,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(.1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${S
                                .of(context)
                                .listOfDocumentsRequiredForASpecificService}:",
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 16.0,
                              height: 2,
                            ),
                          ),
                          if (widget.serviceItem.documents != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  ...widget.serviceItem.documents!.map(
                                    (e) => Text(
                                      "• ${getLangText(e.langNames!, lang!)}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButtonWidget(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteConst.selectQueuePage,
                          arguments: ScreenRouteArgs(
                            clientType: widget.clientType,
                            isPensioner: widget.isPensioner,
                            selectBranchItem: widget.branchItem,
                            selectServiceItem: widget.serviceItem,
                          ),
                        );
                      },
                      title: S.of(context).selectqueue,
                      width: double.infinity,
                      height: 50.0,
                      bgColor: AppColors.primaryBtnColor,
                      borderRadius: 20,
                      textStyle: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
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
}

String? getLangText(List<LangModel> langNameList, String lang) {
  for (var item in langNameList) {
    if (item.lang == lang) {
      return item.text;
    }
  }
  return null;
}
