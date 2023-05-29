import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/StateManagement/Provider/MyProvider.dart';

class txtLanguage extends StatelessWidget {
  String txt;
  txtLanguage({required this.txt});

  @override
  Widget build(BuildContext context) {
    var p=Provider.of<MyPro>(context);
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      child: Text(txt,style: Theme.of(context).textTheme.labelSmall!.copyWith(
          fontSize: 18,
              color: p.mode==ThemeMode.light?Colors.black:Colors.white,
      ),),
    );
  }
}
