import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_ftfl/api/dio_helper.dart';
import 'package:task_ftfl/ui/home/bloc/home_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:task_ftfl/app_config.dart';
import 'package:task_ftfl/style/string.dart';
import 'package:task_ftfl/style/style.dart';
import 'package:task_ftfl/ui/bottom_screen/main_screen.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await DioHelper.init();
  // await SharedPreferenceUtil.getInstance();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  OverlaySupportEntry? entry;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    entry?.dismiss();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.white,
        systemStatusBarContrastEnforced: false,
      ),
    );

    return ScreenUtilInit(
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      ensureScreenSize: true,
      splitScreenMode: true,
      designSize: AppConfig.kDesignSize,
      builder: (final _, final _) => ToastificationWrapper(
        child: GestureDetector(
          onTap: () => primaryFocus?.unfocus(),
          child: OverlaySupport.global(
            child: BlocProvider<HomeBloc>(
              create: (context) => HomeBloc(),
              child: MaterialApp(
                builder: (final context, final child) => Directionality(
                  textDirection: TextDirection.ltr,
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: child!,
                  ),
                ),
                navigatorKey: kRootNavigatorKey,
                debugShowCheckedModeBanner: false,
                title: kAppName,
                theme: AppStyles.appTheme,
                home: const MainScreen(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
