import 'dart:io';

import 'package:budgetplanner/controllers/all_controllers_binding.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'internationalization/internationalization.dart';
import 'routes_generator.dart';
import 'utils/PreferenceUtils.dart';
import 'utils/route_constants.dart';
import 'widgets/config.dart';
import 'widgets/custom_theme.dart';

GlobalKey navBarGlobalKey = GlobalKey(debugLabel: 'bottomAppBar');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  await PreferenceUtils.getInstance();
  await NotificationService().init();
  /**
   * work manager integration
   */
  // Workmanager().initialize(
  //     callbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode: false // This should be false
  //     );
  /**
   * end of work manager integration
   */
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight
  ]).then((_) => runApp(MyApp()));
  //runApp(MyApp());
}

const simpleTaskKey = "dailyTask";
const rescheduledTaskKey = "weeklyTask";
const failedTaskKey = "annualTask";
const simpleDelayedTask = "sixMonthsTask";
const simplePeriodicTask = "threeMonthsTask";
const simplePeriodic1HourTask = "simplePeriodic1HourTask";
/**
 * callback dispatcher
 */
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case simpleTaskKey:
        print("$simpleTaskKey was executed. inputData = $inputData");
        final prefs = await SharedPreferences.getInstance();
        PreferenceUtils.putBool("test", true);
        print("Bool from prefs: ${prefs.getBool("test")}");
        break;
      case rescheduledTaskKey:
        final key = inputData!['key']!;
        final prefs = await SharedPreferences.getInstance();
        if (prefs.containsKey('unique-$key')) {
          print('has been running before, task is successful');
          return true;
        } else {
          await prefs.setBool('unique-$key', true);
          print('reschedule task');
          return false;
        }
      case failedTaskKey:
        print('failed task');
        return Future.error('failed');
      case simpleDelayedTask:
        print("$simpleDelayedTask was executed");
        break;
      case simplePeriodicTask:
        print("$simplePeriodicTask was executed");
        break;
      case simplePeriodic1HourTask:
        print("$simplePeriodic1HourTask was executed");
        break;
      case Workmanager.iOSBackgroundTask:
        print("The iOS background fetch was triggered");
        Directory? tempDir = await getTemporaryDirectory();
        String? tempPath = tempDir.path;
        print(
            "You can access other plugins in the background, for example Directory.getTemporaryDirectory(): $tempPath");
        break;
    }

    return Future.value(true);
  });
}
/**
 * end of callback dispatcher
 */

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale localeClass;
  late String coutryInitial;
  late String countryCode;
  @override
  void initState() {
    coutryInitial = PreferenceUtils.getString(language, defValue: 'US');
    countryCode = PreferenceUtils.getString(locale, defValue: 'en');
    localeClass = Locale(countryCode, coutryInitial);
    // TODO: implement initState
    currentTheme.addListener(() {
      print("ok i am listening");
      //2
      setState(() {
        print("what do you want me to do");
      });
    });
    super.initState();
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //smartManagement: SmartManagement.full,
      initialBinding: AllControllersBinding(),
      initialRoute: homeRoute,
      //home: Poc(),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      //locale: Locale('en', 'US'),
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
      locale: localeClass,
      fallbackLocale: Locale('en'),
      translations: MyTranslations(),
      title: 'Motoko',
      theme: CustomTheme.lightTheme, //3
      darkTheme: CustomTheme.darkTheme, //4
      themeMode: currentTheme.currentTheme, //5
    );
  }
}
