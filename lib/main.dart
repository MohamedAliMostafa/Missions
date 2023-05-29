import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Components/theme/ThemeApp.dart';
import 'package:to_do/Firebase/Firebase_Functions.dart';
import 'package:to_do/Screens/BottomSheet/showBottomSheet.dart';
import 'package:to_do/Screens/LayoutScreen/Home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/Screens/ScreensApp/EditScreen.dart';
import 'package:to_do/Screens/ScreensApp/SignUp.dart';
import 'package:to_do/Screens/ScreensApp/Sign_in.dart';
import 'package:to_do/StateManagement/Provider/MyProvider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
FirebaseF.deleteOldData();
  runApp( ChangeNotifierProvider(
      create: (context)=>MyPro(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyPro>(context);

    return MaterialApp(
      title: 'Localizations Sample App',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      locale: Locale(pro.language),
      debugShowCheckedModeBanner: false,
      theme: Mytheme.light_theme,
      darkTheme: Mytheme.dark_theme,
      themeMode: pro.mode,
      initialRoute: pro.firebaseuser!=null?HomeScreen.RouteName:Sign_in.Routename,
      routes: {
        HomeScreen.RouteName:(context)=>HomeScreen(),
        ShowBottomSheet.routeName:(context)=>ShowBottomSheet(),
        EditScreen.RouteName:(context)=>EditScreen(),
        Sign_in.Routename:(context)=>Sign_in(),
        SignUp.RouteName:(context)=>SignUp(),
      },

    );
  }
}
