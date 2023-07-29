import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:rsk_talon/features/auth/presentation/cubit/cubit.dart';
import 'package:rsk_talon/features/auth/presentation/pages/pages.dart';
import 'package:rsk_talon/features/user/presentation/cubit/cubit.dart';
import 'package:rsk_talon/service_locator.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';
import 'common/common.dart';
import 'generated/l10n.dart';

import 'features/user/presentation/pages/pages.dart';

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
  // INIT STATE
  @override
  void initState() {
    super.initState();
    // REMOVE SPLASH SCREEN AFTER 1 SECOND
    Future.delayed(
      const Duration(seconds: 1),
      () => FlutterNativeSplash.remove(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // MULTI BLOC PROVIDER
    return MultiBlocProvider(
      providers: [
        BlocProvider<BranchCubit>(
          create: (context) => di.sl<BranchCubit>()..loadBranches(),
        ),
        BlocProvider<TalonCubit>(create: (context) => di.sl<TalonCubit>()),
        BlocProvider<ConnectionCubit>(
            create: (context) => di.sl<ConnectionCubit>()),
        BlocProvider<SignInCubit>(
          create: (context) => di.sl<SignInCubit>()..refreshToken(),
        ),
        BlocProvider<LanguageCubit>(
          create: (context) => di.sl<LanguageCubit>()..getCachedLanguage(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          Locale locale = const Locale('ky');

          if (state is ChangeLanguage) {
            locale = state.locale;
          }

          return MaterialApp(
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
            locale: locale,
            initialRoute: '/',
            onGenerateRoute: OnGenerateRoute.route,
            // CHECK LANGUAGE AND ACCESS TOKEN
            home: BlocBuilder<ConnectionCubit, ConnectionStatus>(
              builder: (context, state) {
                if (state == ConnectionStatus.connected) {
                  return di.sl<SharedPreferences>().getString("CASHED_LANG") ==
                          null
                      ? const SelectLanguagePage()
                      : BlocBuilder<SignInCubit, SignInState>(
                          builder: (context, state) {
                            if (state is RefreshTokenLoading) {
                              return const LoadingPage();
                            } else if (state is RefreshTokenLoaded) {
                              return const HomePage();
                            } else {
                              return const SignInPage();
                            }
                          },
                        );
                } else {
                  return const NoConnectionPage();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
