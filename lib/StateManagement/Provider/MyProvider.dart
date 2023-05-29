import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/Firebase/Firebase_Functions.dart';
import 'package:to_do/Model/UserModer.dart';

class MyPro extends ChangeNotifier
{
UserModel? myuser;
User? firebaseuser;
  ThemeMode mode=ThemeMode.light;
  String language="en";
  Future<void> changeLang(String lang)
  async {
    language=lang;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("is_eng", language == "en");
  }
  Future<void> changeTheme(ThemeMode themeMode)
  async {
    mode=themeMode;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("is_dark", mode == ThemeMode.dark);

  }

  getThemeandlangAtInit() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isDarkTheme = sharedPreferences.getBool("is_dark");
    bool? langu = sharedPreferences.getBool("is_eng");
    if (isDarkTheme != null && isDarkTheme) {
      mode = ThemeMode.dark;
    } else {
      mode = ThemeMode.light;
    }
    if (langu != null && langu) {
      language = "en";
    } else {
      language = "ar";
    }
    notifyListeners();
  }



  MyPro()
  {
    firebaseuser=FirebaseAuth.instance.currentUser;
    if(firebaseuser !=null)
      {
        init();
      }
    getThemeandlangAtInit();
  }
  init()
  async {
    firebaseuser=FirebaseAuth.instance.currentUser;
    myuser=await FirebaseF.ReadUsers(firebaseuser!.uid);
    notifyListeners();
  }
  signout() {
     FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}