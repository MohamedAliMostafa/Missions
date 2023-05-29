import 'package:flutter/material.dart';

class TextformStyle extends StatelessWidget {
  String ErrorMsg;
  String hinttxt;
  TextEditingController control;



  TextformStyle({required this.ErrorMsg, required this.hinttxt,required this.control});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:control ,
      validator: (val)
      {
        if(val==null || val.isEmpty)
        {
          return ErrorMsg;
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 13),
          hintText: hinttxt,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.black54),
          )),
    );
  }
}
