import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Components/WidgetStyle/styleSignInScreen/SignInStyle.dart';
import 'package:to_do/Firebase/Firebase_Functions.dart';
import 'package:to_do/Screens/LayoutScreen/Home.dart';
import 'package:to_do/Screens/ScreensApp/Sign_in.dart';

import '../../StateManagement/Provider/MyProvider.dart';

class SignUp extends StatefulWidget {
  static const String RouteName="signup";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
var namecont=TextEditingController();
  var agecont=TextEditingController();
  var Emailcont=TextEditingController();
  var passcont=TextEditingController();
  var ke=GlobalKey<FormState>();
bool obs=true;

  @override
  Widget build(BuildContext context) {
    var p=Provider.of<MyPro>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height*100,
        width:MediaQuery.of(context).size.width*100,
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/SIGN IN.png",)),
        ),
        child:Form(
          key: ke,
          child:Padding(
            padding:EdgeInsets.only(left: 10,right:20,top: 110 ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("SignUp",style: TextStyle(color: Colors.black),),
                  const SizedBox(height: 15,),
                  TextFormSignIn(valid:(val) {
                    if(val==null || val.isEmpty)
                      {
                        return "requried Field";
                      }
                    else if(val.length<7)
                      {
                        return "low Name";
                      }
                    return null;

                  }, controller: namecont, errorMsg: "Requried Field", hint: "Name", obs: false, type: TextInputType.name,prfix: const Icon(Icons.person),),
                  const SizedBox(height: 15,),
                  TextFormSignIn(valid:(val) {
                    if(val==null || val.isEmpty)
                    {
                      return "requried Field";
                    }
                    return null;

                  }, controller: agecont, errorMsg: "Requried Field", hint: "Age", obs: false, type: TextInputType.number,prfix: const Icon(Icons.drive_file_rename_outline_sharp),),
                  const SizedBox(height: 15,),
                  TextFormSignIn(valid:(val) {
                    final bool emailValid =
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(val!);
                    if(val==null || val.isEmpty)
                    {
                      return "Rquried field ";
                    }
                    else if(!emailValid)
                    {
                      return "email vaild";
                    }
                    return null;

                  }, controller: Emailcont, errorMsg: "Requried Field", hint: "Email", obs: false, type: TextInputType.emailAddress,prfix: const Icon(Icons.email),),
                  const SizedBox(height: 15,),
                  TextFormSignIn(valid:(val) {
                    if(val==null || val.isEmpty)
                    {
                      return "requried Field";
                    }
                    else if(val.length<6)
                    {
                      return "low Password";
                    }
                    return null;

                  }, controller: passcont, errorMsg: "Requried Field", hint: "Password", obs: obs, type: TextInputType.visiblePassword,prfix: Icon(obs==true? Icons.lock: Icons.lock_open),suffixicon: IconButton(icon:obs==false?  const Icon(Icons.visibility_off): Icon(Icons.visibility),onPressed: (){
                    setState(() {
                      obs=!obs;
                    });

                  }),),
                  const SizedBox(height: 15,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff3598db),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                      ),
                      onPressed: (){
                        if(ke.currentState!.validate()) {
                          FirebaseF.CreateAuthAccount(
                              namecont.text, agecont.text, Emailcont.text,
                              passcont.text, () {
                            showDialog(context: context, builder: (context) {
                              return const Center(
                                child: AlertDialog(
                                  icon: Icon(Icons.sd_card_alert,color: Colors.amber,),
                                  content: Text("The account already exists for that email",textAlign: TextAlign.center),
                                ),
                              );
                            });
                          }, () {
                            p.init();
                            Navigator.pushReplacementNamed(context,
                                HomeScreen.RouteName);
                          });
                        }

                      }, child: Text("SignUp")),
                  const SizedBox(height:20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(" have an account?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                      TextButton(onPressed: (){
                        Navigator.pushReplacementNamed(context, Sign_in.Routename);
                      }, child: const Text("Login",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                    ],)

                ],
              ),
            ),
          ),
        )



    );
  }
}
