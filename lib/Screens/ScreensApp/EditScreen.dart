import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Components/WidgetStyle/styleEditScreen/EditTextStyle.dart';
import 'package:to_do/Firebase/Firebase_Functions.dart';
import 'package:to_do/Model/Model.dart';
import 'package:to_do/StateManagement/Provider/MyProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditScreen extends StatefulWidget {
  static const String RouteName="edit";

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
var taskControll =TextEditingController();

var descControll=TextEditingController();

int selected=DateTime.now().microsecondsSinceEpoch;
DateTime sel=DateUtils.dateOnly(DateTime.now());



  @override
  Widget build(BuildContext context) {
    var p=Provider.of<MyPro>(context);
    var args=ModalRoute.of(context)?.settings.arguments as TaskModel;
    taskControll.text=args.title;
    descControll.text=args.description;
    selected=args.date;
    return Scaffold(
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 20),
          shadowColor: Colors.blue,

          color:p.mode==ThemeMode.dark?Colors.black:Colors.white,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!.edit,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:  p.mode==ThemeMode.dark?Colors.white:Colors.black
                ),),
                const SizedBox(height: 20,),
                EditTextStyle(controll:taskControll,txt:"Title Text"),
                const SizedBox(height: 20,),
                EditTextStyle(controll:descControll,txt:"Description Text"),
                const SizedBox(height: 10,),
                Text(AppLocalizations.of(context)!.select, style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(
                  fontSize: 18,
                ),),
                const SizedBox(height: 10,),
                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        ShowDATE();
                      });
                    },
                    child: Text("${sel.toString().substring(0,10)}", style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(
                        fontSize: 13,
                        color: Colors.grey
                    ),),
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  if(args.status==true)
                    {
                    final snak=  SnackBar(
                          content: const Text(' task done'),
                          action: SnackBarAction(
                              label: 'Undo', onPressed: () { Navigator.pop(context); },
                          ));
                    ScaffoldMessenger.of(context).showSnackBar(snak);
                    }
                  else
                    {
                      args.date=sel.microsecondsSinceEpoch;
                      args.title=taskControll.text;
                      args.description=descControll.text;
                      FirebaseF.Update(args.id, args);
                      Navigator.pop(context);
                    }

                }, child: Text(AppLocalizations.of(context)!.save))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> ShowDATE() async {
    sel=DateTime.fromMicrosecondsSinceEpoch(selected);
    DateTime?choosedate=await showDatePicker(context: context,
        initialDate: sel, firstDate:DateTime.now() , lastDate: DateTime.now().add(Duration(days: 365*2)));
    if(choosedate!=null)
    {
      setState(() {
        sel=DateUtils.dateOnly(choosedate); // DateU >>> getdate only and min =0 sec=0
      });
    }


  }
}
