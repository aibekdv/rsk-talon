import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/auth/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class ResetPasswordPage3 extends StatefulWidget {
  const ResetPasswordPage3({super.key});

  @override
  State<ResetPasswordPage3> createState() => _ResetPasswordPage3State();
}

class _ResetPasswordPage3State extends State<ResetPasswordPage3> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  bool isCompleted = false;
  bool isValidatePassword = false;
  bool isValidateConfirmPassword = false;

  @override
  void dispose() {
    passwordController.dispose();
    passwordConfirmController.dispose();
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
                          labelText: S.of(context).enterNewPassword,
                          hinText: S.of(context).examplePassword,
                          infoText: S.of(context).passwordInfoText,
                          controller: passwordController,
                          inputType: TextInputType.phone,
                          isError: isValidatePassword,
                          validator: (value) {
                            if (isValidPhoneNumber(value!) == null) {
                              setState(() => isValidatePassword = true);
                              return '';
                            } else {
                              setState(() => isValidatePassword = false);
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        CustomInputWidget(
                          labelText: S.of(context).confirmNewPassword,
                          hinText: S.of(context).examplePassword,
                          infoText: S.of(context).passwordInfoText,
                          controller: passwordConfirmController,
                          inputType: TextInputType.phone,
                          isError: isValidateConfirmPassword,
                          validator: (value) {
                            if (isValidPhoneNumber(value!) == null) {
                              setState(() => isValidateConfirmPassword = true);
                              return '';
                            } else {
                              setState(() => isValidateConfirmPassword = false);
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
      print(passwordController.text);
    }
  }
}
