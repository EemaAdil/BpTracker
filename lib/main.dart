import 'package:bptracker/Messages.dart';
import 'package:bptracker/screens/bottom_nav/bottom_nav.dart';
import 'package:bptracker/screens/home_screen/home_view.dart';
import 'package:bptracker/screens/splash_screen.dart';
import 'package:bptracker/utils/admob_ads_manager.dart';
import 'package:bptracker/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'core/base/export.dart';
import 'screens/onboarding_screen/export.dart';
import 'screens/about_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../core/base/init_controller.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  AdmobAdsManager.admobInit();
  AppUtils().screenRotation();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          translations: Messages(),
          locale: Locale('en','US'),
          fallbackLocale: Locale('ar','SA'),
         debugShowCheckedModeBanner: true,
          title: 'bloodPressureTracker'.tr,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //localizationsDelegates: AppLocalizations.localizationsDelegates,
         // supportedLocales: AppLocalizations.supportedLocales,
        //  locale: Locale('ar'),
       //   locale: _locale,
          initialBinding: Appbindings(),
          //home: const BottomNav(),
          home: MySplashScreen(),
          //  home: LocalAuth(),
          //home: NewBottom(),
        );
      },
    );
  }
}





 /* @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }*/

/* @override
  Widget build(BuildContext context) {
    return Sizer(
     builder: (_, __, ___) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: true,
          title: "Blood Pressure Tracker",
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          //locale: Locale('ar'),
          //locale: _locale,
          locale: _locale,
            //setLocale(context, Locale('ar',''));
          initialBinding: Appbindings(),

          //home: const BottomNav(),
          home: MySplashScreen(),
          //  home: LocalAuth(),
          //home: NewBottom(),
        );
      },
   );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localization',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MySplashScreen(),
      locale: _locale,
    );
  }*/




