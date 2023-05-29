import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/StateManagement/Provider/MyProvider.dart';

class EditTextStyle extends StatelessWidget {
  var controll;
  String txt;

  EditTextStyle({required this.controll, required this.txt});

  @override
  Widget build(BuildContext context) {
    var p= Provider.of<MyPro>(context);
    return  TextFormField(
    controller:controll,
    style: TextStyle(color:  p.mode==ThemeMode.dark?Colors.white:Colors.black),
    decoration: InputDecoration(
labelText: txt,
labelStyle: TextStyle(color: p.mode==ThemeMode.dark?Colors.white:Colors.black ),
enabledBorder:OutlineInputBorder(
borderRadius: BorderRadius.circular(30),
borderSide: BorderSide(color: p.mode==ThemeMode.dark?Colors.white:Colors.black)
)
),
);
  }
}
