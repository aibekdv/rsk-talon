import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rsk_talon/common/common.dart';

void toast({required String msg, bool isError = false}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: isError ? Colors.red : Colors.green[600],
    textColor: AppColors.whiteColor ,
    fontSize: 16.0,
  );
}
