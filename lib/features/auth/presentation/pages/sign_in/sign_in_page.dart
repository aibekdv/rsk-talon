import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/auth/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isCompleted = false;
  bool isValidatePhone = false;
  bool isValidatePassword = false;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
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
                          S.of(context).enterInfoForLogin,
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
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isCompleted = !isCompleted;
                                  setState(() {});
                                });
                              },
                              child: SizedBox(
                                width: 165,
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scaleX: .8,
                                      scaleY: .8,
                                      alignment: Alignment.centerLeft,
                                      child: Checkbox(
                                        value: isCompleted,
                                        activeColor: Colors.transparent,
                                        checkColor: Colors.white,
                                        visualDensity: VisualDensity.compact,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3.0),
                                        ),
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                          (states) => const BorderSide(
                                            width: 1.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          isCompleted = value!;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    Text(
                                      S.of(context).rememberMe,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteConst.resetStepOne,
                                );
                              },
                              child: Text(
                                S.of(context).forgotPassword,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        CustomButtonWidget(
                          title: S.of(context).loginText,
                          onPressed: phoneController.text.length > 9 &&
                                  passwordController.text.length > 7
                              ? _submitPhone
                              : null,
                          width: double.infinity,
                          height: 54,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.7,
                              height: 1,
                              color: Colors.white,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                S.of(context).orText,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.7,
                              height: 1,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomButtonWidget(
                          onPressed: () {
                            Navigator.pushNamed(context, RouteConst.signUpPage);
                          },
                          title: S.of(context).createAccountText,
                          width: double.infinity,
                          height: 54,
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
      print(phoneController.text);
    }
  }
}
