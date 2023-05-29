import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Components/WidgetStyle/styleBottomSheet/textformStyle.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/Firebase/Firebase_Functions.dart';
import 'package:to_do/Model/Model.dart';
import 'package:to_do/StateManagement/Provider/MyProvider.dart';

class ShowBottomSheet extends StatefulWidget {
  static const String routeName = "bot";

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  DateTime selected=DateUtils.dateOnly(DateTime.now());
  var Formkey=GlobalKey<FormState>();
  var titleControl=TextEditingController();
  var DesControl=TextEditingController();


  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyPro>(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: Form(
        key: Formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.title,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall,
              ),
            ),
            const SizedBox(height: 10,),
            TextformStyle(control:titleControl,ErrorMsg: pro.language=="en"?"please enter Your Task":"من فضلك اضف المهمة",hinttxt: AppLocalizations.of(context)!.hint1),
            const SizedBox(height: 15,),
            TextformStyle(control:DesControl ,ErrorMsg: pro.language=="en"?"please enter Your Description":"من فضلك اضف نبذة مختصرة",hinttxt: AppLocalizations.of(context)!.hint2),
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
                child: Text("${selected.toString().substring(0,10)}", style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(
                    fontSize: 13,
                    color: Colors.grey
                ),),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)
                  )
                ),
                  onPressed: (){
                if(Formkey.currentState!.validate())
                  {
                    TaskModel task=TaskModel(Userid: FirebaseAuth.instance.currentUser!.uid,title: titleControl.text, description: DesControl.text, status: false, date: selected.microsecondsSinceEpoch);
                    FirebaseF.addTaskToFirestore(task);
                    Navigator.pop(context);
                  }

              }, child: Text(AppLocalizations.of(context)!.btn)),
            )
          ],
        ),
      ),
    );
  }

  Future<void> ShowDATE() async {
    DateTime?choosedate=await showDatePicker(context: context,
        initialDate: selected, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365*2)));
    if(choosedate!=null)
      {
        selected=DateUtils.dateOnly(choosedate);  // DateU >>> getdate only and min =0 sec=0
        setState(() {

        });
      }


  }
}
