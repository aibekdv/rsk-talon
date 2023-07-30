import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rsk_talon/common/common.dart';
import 'package:rsk_talon/features/auth/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:rsk_talon/features/auth/presentation/widgets/widgets.dart';
import 'package:rsk_talon/generated/l10n.dart';

class ActivateAccountPage extends StatefulWidget {
  final String phone;

  const ActivateAccountPage({super.key, required this.phone});

  @override
  State<ActivateAccountPage> createState() => _ActivateAccountPageState();
}

class _ActivateAccountPageState extends State<ActivateAccountPage> {
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
                          S.of(context).activateAccount,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          S.of(context).infoToActivateYourAccount,
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
                            if (value == null) {
                              setState(() => isValidateCode = true);
                              return '';
                            } else {
                              setState(() => isValidateCode = false);
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        BlocBuilder<SignUpCubit, SignUpState>(
                          builder: (context, state) {
                            bool isLoading = false;

                            if (state is ActivateAccountLoading) {
                              isLoading = true;
                            } else if (state is ActivateAccountLoaded) {
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
                            } else if (state is ActivateAccountFailure) {
                              isLoading = false;
                            }

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButtonWidget(
                                  title: S.of(context).backText,
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
                                  isLoading: isLoading,
                                  title: S.of(context).confirmText,
                                  onPressed: isLoading ? null : _submitPhone,
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

  _submitPhone() {
    if (_formKey.currentState!.validate()) {
      debugPrint(codeController.text);

      BlocProvider.of<SignUpCubit>(context).activateAccount(
        phone: widget.phone,
        code: codeController.text,
        successMsg: S.of(context).accountActivated,
      );
    }
  }
}
