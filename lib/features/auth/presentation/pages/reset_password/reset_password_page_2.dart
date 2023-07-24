import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/auth/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class ResetPasswordPage2 extends StatefulWidget {
  const ResetPasswordPage2({super.key});

  @override
  State<ResetPasswordPage2> createState() => _ResetPasswordPage2State();
}

class _ResetPasswordPage2State extends State<ResetPasswordPage2> {
  final _formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();

  bool isCompleted = false;
  bool isValidateCode = false;

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            color: AppColors.primary,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Image.asset(
                  'assets/icons/appar.png',
                  width: 162.0,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          S.of(context).passwordRecovery,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          S.of(context).requiredInformationPassword,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomInputWidget(
                          labelText: S.of(context).enterTheCodeText,
                          hinText: S.of(context).exampleCodeText,
                          infoText: S.of(context).theCodeSentToPhoneText,
                          controller: codeController,
                          inputType: TextInputType.phone,
                          isError: isValidateCode,
                          validator: (value) {
                            if (isValidPhoneNumber(value!) == null) {
                              setState(() => isValidateCode = true);
                              return '';
                            } else {
                              setState(() => isValidateCode = false);
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButtonWidget(
                              title: S.of(context).backText,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 10,
                              ),
                              borderColor: Colors.white,
                            ),
                            CustomButtonWidget(
                              title: S.of(context).nextText,
                              onPressed: _submitPhone,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submitPhone() {
    if (_formKey.currentState!.validate()) {
      print(codeController.text);
    }
  }
}
