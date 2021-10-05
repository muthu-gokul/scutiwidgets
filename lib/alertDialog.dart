
import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';



class CustomAlert{
  VoidCallback? callback;
  VoidCallback? Cancelcallback;
  CustomAlert({this.callback,this.Cancelcallback});

  // toast(String msg){
  //   Fluttertoast.showToast(
  //       msg: msg,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       textColor: Colors.white,
  //       fontSize: 16.0
  //   );
  // }






  void cupertinoDialogYesNo(BuildContext context,String title){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => CupertinoAlertDialog(
          content: Text("$title",style: TextStyle(fontSize: 18),),
          actions: [
            CupertinoDialogAction(
              child: Text("Yes"),
              onPressed: (){
                callback!();
              },
            ),
            CupertinoDialogAction(
              child: Text("No"),
              onPressed: (){
                Navigator.pop(ctx);
              },
            ),
          ],
        )
    );
  }

  void cupertinoAlertDialog(BuildContext context,String title){
    showDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Icon(Icons.error_outline,color: Colors.red,size: 50,),
          content: Text("$title",
            style: TextStyle(fontSize: 18),),
        )
    );
  }
}


