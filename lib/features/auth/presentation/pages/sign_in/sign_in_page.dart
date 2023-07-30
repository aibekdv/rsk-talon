import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/auth/domain/entities/user_entity.dart';
import 'package:rsk_talon/features/auth/presentation/cubit/sign_in/sign_in_cubit.dart';
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

  String? userToken;

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
                BlocBuilder<SignInCubit, SignInState>(
                  builder: (context, state) {
                    bool isLoading = false;

                    if (state is SignInLoading) {
                      isLoading = true;
                    } else if (state is SignInLoaded) {
                      isLoading = false;
                      userToken =
                          BlocProvider.of<SignInCubit>(context).getUserToken();
                      Future.delayed(
                        const Duration(milliseconds: 50),
                        () {
                          if (userToken != null) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteConst.homePage,
                              (route) => false,
                            );
                          }
                        },
                      );
                    } else if (state is SignInFailure) {
                      isLoading = false;
                    }

                    return Padding(
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
                                  isValidatePhone = true;
                                  setState(() {});
                                  return '';
                                } else {
                                  isValidatePhone = false;
                                  setState(() {});
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
                                if (value != null && value.length > 2) {
                                  isValidatePassword = false;
                                  setState(() {});
                                  return null;
                                } else {
                                  isValidatePassword = true;
                                  setState(() {});
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
                                            visualDensity:
                                                VisualDensity.compact,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                            side: MaterialStateBorderSide
                                                .resolveWith(
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
                                  onPressed: isLoading
                                      ? null
                                      : () {
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
                                      passwordController.text.length > 2
                                  ? isLoading == true
                                      ? null
                                      : _submitLoginForm
                                  : null,
                              width: double.infinity,
                              height: 54,
                              isLoading: isLoading,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.7,
                                  height: 1,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
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
                                  width:
                                      MediaQuery.of(context).size.width / 2.7,
                                  height: 1,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomButtonWidget(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteConst.signUpPage,
                                      );
                                    },
                              title: S.of(context).createAccountText,
                              width: double.infinity,
                              height: 54,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submitLoginForm() async {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<SignInCubit>(context).login(
        UserEntity(
          phoneNumber: phoneController.text,
          password: passwordController.text,
        ),
      );
    }
  }
}
