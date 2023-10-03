import 'package:flutter/material.dart';
import 'package:bptracker/main.dart';
import 'package:bptracker/screens/home_screen/home_view.dart';
const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String FARSI = 'fa';
const String ARABIC = 'ar';
const String HINDI = 'hi';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

Future<Locale> setLocale(String languageCode) async {

  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case FARSI:
      return const Locale(FARSI, "");
    case ARABIC:
      return const Locale(ARABIC, "");
    case HINDI:
      return const Locale(HINDI, "");
    default:
      return const Locale(ENGLISH, '');
  }
}
class _AboutPageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: TextButton(
          child: Text("Tap on this"),
          style: TextButton.styleFrom(
            primary: Colors.blue,
          ),
          onPressed: () async {

    Locale _locale = await setLocale('ar');
    MyApp.setLocale(context, _locale);


            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeView()));
          },
        ),
      ),
    );
  }
}