import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/auth/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  bool isCompleted = false;
  bool isValidatePhone = false;
  bool isValidatePassword = false;
  bool isValidateConfirmPassword = false;

  @override
  void dispose() {
    phoneController.dispose();
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
                          S.of(context).welcomeText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          S.of(context).enterInfoForRegister,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomInputWidget(
                          labelText: S.of(context).phoneNumberText,
                          hinText: S.of(context).enterPhoneNumberText,
                          infoText: S.of(context).examplePhoneNumberText,
                          controller: phoneController,
                          inputType: TextInputType.phone,
                          isError: isValidatePhone,
                          validator: (value) {
                            if (isValidPhoneNumber(value!) == null) {
                              setState(() => isValidatePhone = true);
                              return '';
                            } else {
                              setState(() => isValidatePhone = false);
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomInputWidget(
                          labelText: S.of(context).enterPasswordText,
                          hinText: S.of(context).examplePassword,
                          infoText: S.of(context).passwordInfoText,
                          isPasswordField: true,
                          controller: passwordController,
                          inputType: TextInputType.text,
                          isError: isValidatePassword,
                          validator: (value) {
                            if (value != null &&
                                value.length > 7 &&
                                passwordPattern.hasMatch(
                                  value,
                                )) {
                              setState(() => isValidatePassword = false);
                              return null;
                            } else {
                              setState(() => isValidatePassword = true);
                              return "";
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomInputWidget(
                          labelText: S.of(context).repeatPassword,
                          hinText: S.of(context).enterPasswordText,
                          isPasswordField: true,
                          infoText: S.of(context).passwordEqualPasswordText,
                          controller: passwordConfirmController,
                          inputType: TextInputType.text,
                          isError: isValidateConfirmPassword,
                          validator: (value) {
                            if (value != null &&
                                value == passwordController.text) {
                              setState(() => isValidateConfirmPassword = false);
                              return null;
                            } else {
                              setState(() => isValidateConfirmPassword = true);
                              return "";
                            }
                          },
                        ),
                        const SizedBox(height: 40),
                        CustomButtonWidget(
                          title: S.of(context).createAccountText,
                          onPressed: phoneController.text.length > 9 &&
                                  passwordController.text.length > 7
                              ? _submitPhone
                              : null,
                          width: double.infinity,
                          height: 54,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                             Text(
                              S.of(context).doYouHaveAccount,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 5),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteConst.signInPage);
                              },
                              child:  Text(
                                S.of(context).loginText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                  height: 2,
                                ),
                              ),
                            )
                          ],
                        )
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
      debugPrint(passwordController.text);
      debugPrint(phoneController.text);
    }
  }
}
