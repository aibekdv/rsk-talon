// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppConsts {
  static const CASHED_LANG = 'CASHED_LANG';
  static const TOKEN_TALON = 'TOKEN_TALON';
  static const CASHED_TALONS_LIST = 'CASHED_TALONS_LIST';
  static const ACCESS_TOKEN = 'ACCESS_TOKEN';
  static const REFRESH_TOKEN = 'REFRESH_TOKEN';
  static const USER = 'user';
}

final class AppColors {
  static const primary = Color(0xff0D3584);
  static const primaryBtnColor = Color(0xff2E79BD);
  static const whiteColor = Colors.white;
  static const disableBtnColor = Color(0xff878889);
  static const authBtnColor = Color(0xff2850C1);
  static const authBtnColorDark = Color(0xff002281);
}

void toast({required String msg, bool isError = false}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: isError ? Colors.red : Colors.green[600],
    textColor: AppColors.whiteColor,
    fontSize: 16.0,
  );
}
