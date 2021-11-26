import 'package:flutter/material.dart';
import 'package:scutiwidgets/size.dart';


import '../resetPassword.dart';
import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  VoidCallback ontap;
  String resetImg;
  bool isSvg;
  OtpScreen({required this.ontap,required this.resetImg,this.isSvg=false});
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
          img: 'assets/images/mail.png',
          isSvg: isSvg,
          submitCb:ontap,
        ),
      ),
    );
  }
}
