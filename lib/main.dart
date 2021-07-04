import 'package:budgetplanner/controllers/all_controllers_binding.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then((_) => runApp(MyApp()));
  //runApp(MyApp());
}

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
