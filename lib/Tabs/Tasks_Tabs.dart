
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline_fixed/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Components/WidgetStyle/styleTaksTab/TaskStyle.dart';
import 'package:to_do/Firebase/Firebase_Functions.dart';
import 'package:to_do/Model/Model.dart';
import 'package:to_do/StateManagement/Provider/MyProvider.dart';

class TaskTab extends StatefulWidget {

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {


   DateTime dates=DateTime.now();

  @override
  Widget build(BuildContext context) {
    var prp=Provider.of<MyPro>(context);
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor:prp.mode==ThemeMode.light? Colors.black:Colors.white,
              selectedTextColor: prp.mode==ThemeMode.light? Colors.white:Colors.black,
              height: 100,
              dateTextStyle: Theme.of(context).textTheme.labelMedium!,
              monthTextStyle:Theme.of(context).textTheme.labelMedium!,
              dayTextStyle:  Theme.of(context).textTheme.labelMedium!,
              onDateChange: (date) {
                // New date selected
                setState(() {
                  dates = date;
                });
              },
            ),
          ],
        ),

        StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseF.getdataFromFirstore(dates),
            builder:(context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting)
                {
                  return const Center(child: CircularProgressIndicator(),);
                }
              if(snapshot.hasError)
                {
                  return const Text("something Error");
                }
              var taskList=snapshot.data!.docs.map((doc) => doc.data()).toList();
              if(taskList.isEmpty)
                {
                  return const Center(child: Text("No Tasks",style:TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold),),);
                }

              return Expanded(
                child: ListView.separated(itemBuilder: (context, index) {
                  return TaskStyle(taskList[index]);
                }, separatorBuilder:(context, index) {
                 return const SizedBox(height: 10,);
                }, itemCount: taskList.length),
              );
            }, ),

      ],
    );
  }


}
