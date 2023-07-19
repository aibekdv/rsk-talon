import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:rsk_talon/features/user/presentation/pages/pages.dart';

class NetworkWrapper extends StatefulWidget {
  final Widget child;
  final bool? isFirstLaunch;

  const NetworkWrapper({
    super.key,
    required this.child,
    this.isFirstLaunch = false,
  });

  @override
  State<NetworkWrapper> createState() => _NetworkWrapperState();
}

class _NetworkWrapperState extends State<NetworkWrapper> {
  StreamSubscription<ConnectivityResult>? subscription;
  bool hasInternetConnection = true;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  Future<void> checkInternetConnection() async {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          hasInternetConnection = false;
        });
      } else {
        setState(() {
          hasInternetConnection = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return hasInternetConnection ? widget.child : const NoConnectionPage();
  }
}
