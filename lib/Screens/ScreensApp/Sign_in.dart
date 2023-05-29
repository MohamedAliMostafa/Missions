
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Components/WidgetStyle/styleSignInScreen/SignInStyle.dart';
import 'package:to_do/Firebase/Firebase_Functions.dart';
import 'package:to_do/Screens/LayoutScreen/Home.dart';
import 'package:to_do/Screens/ScreensApp/SignUp.dart';
import 'package:to_do/StateManagement/Provider/MyProvider.dart';

class  Sign_in extends StatefulWidget {
  static const String Routename="sign_in";

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  var Textemail=TextEditingController();

  var Textpass=TextEditingController();

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
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/SIGN IN.png",)),
        ),
        child:Form(
          key: ke,
          child: Padding(
            padding: EdgeInsets.only(left: 10,right: 20,top: 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Text("Login",style: TextStyle(color: Colors.black),),
                const SizedBox(height:20),
                TextFormSignIn(controller: Textemail,valid: (val)
                    {
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
                    }, errorMsg: "Rquired field", hint: "Email",type: TextInputType.emailAddress,obs: false,prfix: const Icon(Icons.email_outlined),),
                const SizedBox(height:20),
                TextFormSignIn(type: TextInputType.visiblePassword,obs: obs,controller: Textpass,valid: (val)
                {
                  if(val==null || val.isEmpty)
                  {
                    return "Rquried field ";
                  }
                  else if(val.length <6)
                    {
                      return "low Password";
                    }
                  return null;
                }, errorMsg: "Rquired field", hint: "Password",prfix:Icon(obs==true? Icons.lock: Icons.lock_open) ,suffixicon: IconButton(icon:obs==false?  const Icon(Icons.visibility_off): Icon(Icons.visibility),onPressed: (){
                  setState(() {
                    obs=!obs;
                  });

                }),),
                const SizedBox(height:20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff3598db),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    onPressed: (){
                  if(ke.currentState!.validate()) {
                    FirebaseF.SignIn(Textemail.text, Textpass.text, () {
                      showDialog(context: context, builder: (context) {
                        return const Center(
                          child: AlertDialog(
                            icon: Icon(Icons.error,color: Colors.red,),
                            content: Text("Wrong Email or Password",textAlign: TextAlign.center,),
                          ),
                        );
                      }
                      );
                    }, (user) {
                      p.init();
                      Navigator.pushReplacementNamed(context,
                          HomeScreen.RouteName,arguments: user);
                    }
                    );
                  }


                }, child: Text("Login")),
                const SizedBox(height:40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Don't have an account?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, SignUp.RouteName);
                  }, child: Text("Create account",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                ],)
            ],),
          ),
        ),
      ),
    );
  }
}
