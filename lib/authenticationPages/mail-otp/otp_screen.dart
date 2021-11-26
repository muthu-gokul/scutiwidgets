import 'package:flutter/material.dart';
import 'package:scutiwidgets/authenticationPages/resetPassword.dart';
import 'package:scutiwidgets/size.dart';


import 'components/body.dart';

class MailScreen extends StatelessWidget {
  VoidCallback ontap;
  String resetImg;
  bool isSvg;
  MailScreen({required this.ontap,required this.resetImg,this.isSvg=false});
  static String routeName = "/mail-otp";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("OTP Verification"),
        // ),
        body: Body(
          img: 'assets/images/otp.png',
          isSvg: isSvg,
          submitCb:ontap,
        ),
      ),
    );
  }
}
