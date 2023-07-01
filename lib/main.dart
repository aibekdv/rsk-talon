import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:rsk_talon/common/routes/routes.dart';
import 'package:rsk_talon/feature/presentation/cubit/cubit.dart';

import 'package:rsk_talon/service_locator.dart' as di;
import 'generated/l10n.dart';

import 'feature/presentation/pages/pages.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BranchCubit>(
            create: (context) => di.sl<BranchCubit>()..loadBranches()),
        BlocProvider<TalonCubit>(create: (context) => di.sl<TalonCubit>()),
        BlocProvider<LanguageCubit>(
            create: (context) => di.sl<LanguageCubit>()),
      ],
      child: MaterialApp(
        title: 'РСК талон',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Inter',
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('ru'),
        initialRoute: 'homePage',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "homePage": (context) {
            return BlocBuilder<BranchCubit, BranchState>(
              builder: (context, state) {
                if (state is BranchSuccess) {
                  FlutterNativeSplash.remove();
                  return HomePage(branchesList: state.brancheList);
                } else if (state is BranchFailure) {
                  FlutterNativeSplash.remove();
                  return const ErrorPage();
                } else {
                  return const SizedBox();
                }
              },
            );
          }
        },
      ),
    );
  }
}
