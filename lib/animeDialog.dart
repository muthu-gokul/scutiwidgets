import 'package:flutter/material.dart';

class AnimeDialog{
   slideFromBottomToTop(BuildContext context,Widget widget) {

     return showGeneralDialog(context: context,
       barrierDismissible: false,
       barrierColor: Colors.black54,
       transitionDuration: Duration(milliseconds: 300),
       transitionBuilder: (BuildContext context, Animation<double> animation,
           Animation<double> secondaryAnimation, Widget child) {
         return SlideTransition(
           position: Tween<Offset>(
             begin: const Offset(0.0, 1.0),
             end: Offset.zero,
           ).chain(CurveTween(curve: Curves.linear)).animate(animation),
           child: FadeTransition(
             opacity: animation,
             child: child,
           ),
         );
       },
       pageBuilder: (BuildContext buildContext, Animation<double> animation,
           Animation<double> secondaryAnimation) {
         final Widget pageChild = Builder(builder: (ctx){
            return widget;
           // return Dialog(
           //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), ),
           // );
         } );
         return SafeArea(
           top: false,
           child: Builder(builder: (BuildContext context) {
             return pageChild;
           }),
         );
       },
     );

  }
}