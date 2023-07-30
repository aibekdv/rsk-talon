import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/auth/presentation/cubit/reset/reset_cubit.dart';
import 'package:rsk_talon/features/auth/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class ResetPasswordPage1 extends StatefulWidget {
  const ResetPasswordPage1({super.key});

  @override
  State<ResetPasswordPage1> createState() => _ResetPasswordPage1State();
}

class _ResetPasswordPage1State extends State<ResetPasswordPage1> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  bool isCompleted = false;
  bool isValidatePhone = false;

  @override
  void dispose() {
    phoneController.dispose();
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
                        const SizedBox(height: 30),
                        BlocBuilder<ResetCubit, ResetState>(
                          builder: (context, state) {
                            bool isLoading = false;

                            if (state is ResetPhoneLoading) {
                              isLoading = true;
                            } else if (state is ResetPhoneLoaded) {
                              isLoading = false;
                              Future.delayed(
                                const Duration(milliseconds: 50),
                                () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteConst.resetStepTwo,
                                    arguments: ScreenRouteArgs(
                                      phoneNumber: phoneController.text,
                                    ),
                                  );
                                },
                              );
                            } else if (state is ResetPhoneFailure) {
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
                                  title: S.of(context).nextText,
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
      debugPrint(phoneController.text);
      BlocProvider.of<ResetCubit>(context).sendCodeToPhone(
        phone: phoneController.text,
      );
    }
  }
}
