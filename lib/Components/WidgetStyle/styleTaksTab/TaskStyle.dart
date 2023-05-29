import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Firebase/Firebase_Functions.dart';
import 'package:to_do/Model/Model.dart';
import 'package:to_do/Screens/ScreensApp/EditScreen.dart';
import 'package:to_do/StateManagement/Provider/MyProvider.dart';

import '../../Colors/Colors.dart';

class TaskStyle extends StatelessWidget {
  TaskModel taskModel;


  TaskStyle(this.taskModel);

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyPro>(context);
    return   Container(
      margin: EdgeInsets.only(top:10 ),
      child: Slidable(

        startActionPane: ActionPane(motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (context){
              Navigator.pushNamed(context, EditScreen.RouteName,arguments: taskModel);
            },
            backgroundColor: blueApp,
            icon: Icons.edit,
            label: "Edit",
            borderRadius: BorderRadius.circular(30),


          ),
          SlidableAction(
            onPressed: (context){
              FirebaseF.DeleteData(taskModel.id);
            },
            backgroundColor: Colors.red,
            icon: Icons.delete_rounded,
            label: "Delete",
            padding: EdgeInsets.symmetric(horizontal: 10),
            borderRadius: BorderRadius.circular(30),


          ),
        ]),
        child: Card(

          elevation: 8,
          shadowColor: Colors.white,
          color: pro.mode==ThemeMode.light?Colors.white:Colors.black,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            horizontalTitleGap: -10,
            leading:VerticalDivider(width: 2,thickness: 2,color: blueApp,) ,
            title: Text(taskModel.title,style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: taskModel.status?Colors.green:Colors.blue
            )),
            subtitle: Text(taskModel.description,style: Theme.of(context).textTheme.labelSmall,),
            trailing:taskModel.status?Icon(Icons.done_outline,color: Colors.green,):
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  )
              ),
              onPressed: (){
                taskModel.status=true;
                FirebaseF.Update(taskModel.id, taskModel);
              },
              child: Icon(Icons.edit),
            ),
          ),
        ),
      ),
    );
  }
}
