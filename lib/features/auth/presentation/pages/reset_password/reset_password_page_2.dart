import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/auth/presentation/cubit/reset/reset_cubit.dart';
import 'package:rsk_talon/features/auth/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class ResetPasswordPage2 extends StatefulWidget {
  final String phone;
  const ResetPasswordPage2({super.key, required this.phone});

  @override
  State<ResetPasswordPage2> createState() => _ResetPasswordPage2State();
}

class _ResetPasswordPage2State extends State<ResetPasswordPage2> {
  final _formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  bool isCompleted = false;
  bool isValidateCode = false;
  bool isValidatePassword = false;
  bool isValidateConfirmPassword = false;

  @override
  void dispose() {
    codeController.dispose();
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
                        const SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                'Не получили код?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.50,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                        const SizedBox(height: 40),
                        BlocBuilder<ResetCubit, ResetState>(
                          builder: (context, state) {
                            bool isLoading = false;

                            if (state is ResetPasswordLoading) {
                              isLoading = true;
                            } else if (state is ResetPasswordLoaded) {
                              isLoading = false;
                              Future.delayed(
                                const Duration(milliseconds: 50),
                                () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteConst.signInPage,
                                  );
                                },
                              );
                            } else if (state is ResetPasswordFailure) {
                              isLoading = false;
                            }

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButtonWidget(
                                  title: S.of(context).backText,
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                  height: 50,
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          Navigator.pop(context);
                                        },
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 10,
                                  ),
                                  borderColor: Colors.white,
                                ),
                                CustomButtonWidget(
                                  title: S.of(context).confirmText,
                                  isLoading: isLoading,
                                  onPressed: isLoading ? null : _submitForm,
                                  width:
                                      MediaQuery.of(context).size.width / 2.4,
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 10,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 30),
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

  _submitForm() {
    if (_formKey.currentState!.validate()) {
      debugPrint(codeController.text);
    }
  }
}
