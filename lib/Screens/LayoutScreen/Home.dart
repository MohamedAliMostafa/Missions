import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Model/UserModer.dart';
import 'package:to_do/Screens/BottomSheet/showBottomSheet.dart';
import 'package:to_do/Screens/ScreensApp/Sign_in.dart';
import 'package:to_do/StateManagement/Provider/MyProvider.dart';
import 'package:to_do/Tabs/SettingTabs.dart';
import 'package:to_do/Tabs/Tasks_Tabs.dart';

class HomeScreen extends StatefulWidget {
  static const String RouteName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<MyPro>(context);
    List<Widget> tabs = [TaskTab(), SettingTab()];
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          "To Do List  (${p.myuser?.name})  ",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, Sign_in.Routename);
              },
              icon: const Icon(Icons.login_outlined))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showBottomSheet();
          });
        },
        child: Icon(Icons.add),
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 3)),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: index,
          onTap: (val) {
            index = val;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu_sharp,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: ""),
          ],
        ),
      ),
      body: tabs[index],
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return ShowBottomSheet();
        });
  }
}
