import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scutiwidgets/size.dart';

import 'constants.dart';


class ResetPassword extends StatefulWidget {
  String img;
  bool isSvg;
  Color btnClr;
  VoidCallback submitCb;
  ResetPassword({required this.img,this.isSvg=false,this.btnClr=const Color(0XFF371176),required this.submitCb});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword>with SingleTickerProviderStateMixin{

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  late bool passwordvisible;
  late bool loginvalidation;
  late AnimationController shakecontroller;
  late Animation<double> offsetAnimation;
  bool isLoading=false;
  bool isVisible=false;
  bool? rememberMe=false;

  String? prefEmail;
  String? prefPassword;
  bool? prefRememberMe;
  // late SharedPreferences _Loginprefs;
  static const String useremail = 'email';
  static const String passwordd = 'password';
  static const String rememberMee = 'rememberMe';
  late var node;
  Color fillColor=Color(0xFFFFFFFF);
  Color borderColor=Color(0xFFE5E5E5);
  Color inputTextColor=Color(0xFF9b9b9b);


  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    passwordvisible = true;
    loginvalidation=false;
    shakecontroller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    username.clear();
    password.clear();
    // SharedPreferences.getInstance()
    //   ..then((prefs) {
    //     setState(() => this._Loginprefs = prefs);
    //
    //     _loadCredentials();
    //   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    node=FocusScope.of(context);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);

    offsetAnimation = Tween(begin: 0.0, end: 28.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(shakecontroller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          shakecontroller.reverse().whenComplete(() {
            setState(() {
              loginvalidation=false;
            });
          });
        }
      });
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: widget.isSvg?SvgPicture.asset(widget.img, width: 200,fit: BoxFit.cover,):
                    Image.asset(widget.img, width: 200,fit: BoxFit.cover,),
                  ),
                  SizedBox(height: 20,),
                  Text("Create new password",style: TextStyle(fontSize: 30,fontFamily: 'RB',color: Colors.black),),
                  SizedBox(height: 10,),
                  Container(
                    width: SizeConfig.screenWidth!*0.65,
                    child: Text("Your new password must be different from previous used passwords.",style: ts14(Color(0XFFACACAC)),textAlign: TextAlign.center,),
                  ),
                  Form(
                      key: _loginFormKey,
                      child: AnimatedBuilder(
                          animation: offsetAnimation,
                          builder: (context, child) {
                            return Container(
                              //  margin: EdgeInsets.symmetric(horizontal: 24.0),
                              padding: EdgeInsets.only(left: offsetAnimation.value + 15.0, right: 15.0 - offsetAnimation.value),
                              child: Container(
                                // margin: EdgeInsets.only(top: _height * 0.28),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    loginvalidation?Text("Invalid Email Or Password",
                                      style: TextStyle(color: Colors.red,fontSize: 18,fontFamily: 'RR',letterSpacing: 0.2),
                                    ):Container(height: 20,width: 0,),
                                    SizedBox(height: 10,),
                                    Container(
                                      child: Text('Password',style: ts16(Color(0XFF999999))),
                                    ),
                                    SizedBox(height: 5,),
                                    Container(
                                      height: 60,
                                      width: SizeConfig.screenWidth!*0.95,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border:loginvalidation? Border.all(color: Colors.red,width: 2):Border.all(color: borderColor,width: 2),
                                          color:loginvalidation?Color(0xFFCECECE): fillColor),
                                      child: TextFormField(
                                        scrollPadding: EdgeInsets.only(bottom:SizeConfig.height250!),
                                        style: TextStyle(color:loginvalidation?Colors.red:inputTextColor,fontSize:18,fontFamily: 'RR' ),
                                        controller: password,
                                        obscureText: passwordvisible,
                                        obscuringCharacter: '*',
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintText: "",
                                          hintStyle:TextStyle(color:loginvalidation?Colors.red:inputTextColor.withOpacity(0.7),fontSize:18,fontFamily: 'RR' ),
                                          contentPadding: EdgeInsets.only(left: 20, top: 17),
                                          // suffixIconConstraints: BoxConstraints(
                                          //     minHeight: 55,
                                          //     maxWidth: 55
                                          // ),
                                          suffixIcon:GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  passwordvisible=!passwordvisible;
                                                });
                                              },
                                              child: Container(
                                                  height: 60,
                                                  width: 60,
                                                  color: Colors.transparent,
                                                  alignment: Alignment.center,
                                                  child: Icon(passwordvisible?Icons.visibility_off:Icons.visibility,size: 30,color: Colors.grey,)
                                              )
                                          ),
                                        ),
                                        keyboardType: TextInputType.emailAddress,

                                        validator:(value){
                                          if(value!.isEmpty){
                                            return 'Password is required';
                                          }
                                        },
                                        onEditingComplete: () async {
                                          node.unfocus();
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Container(
                                      child: Text('Must be atleast 8 characters',style: ts14(Color(0XFF999999))),
                                    ),
                                    SizedBox(height: 15,),
                                    Container(
                                      child: Text('ConfirmPassword',style: ts16(Color(0XFF999999))),
                                    ),
                                    SizedBox(height: 5,),
                                    Container(
                                      height: 60,
                                      width:SizeConfig.screenWidth,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border:loginvalidation? Border.all(color: Colors.red,width: 2):Border.all(color: borderColor,width: 2),
                                          color: loginvalidation?Color(0xFFCECECE):fillColor),
                                      child: TextFormField(
                                        scrollPadding: EdgeInsets.only(bottom:SizeConfig.height250!),
                                        style: TextStyle(color:loginvalidation?Colors.red:inputTextColor,fontSize:18,fontFamily: 'RR' ),
                                        controller: username,
                                        obscureText: passwordvisible,
                                        obscuringCharacter: '*',
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintText: "",
                                          hintStyle: TextStyle(
                                              color:loginvalidation?Colors.red: inputTextColor.withOpacity(0.7),fontSize: 18,fontFamily: 'RR'),
                                          contentPadding: EdgeInsets.only(left: 20,top: 10),
                                          //   fillColor: loginvalidation?HexColor("1C1F32"):Colors.white,

                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        validator:(value){


                                        },
                                        onEditingComplete: (){
                                          node.nextFocus();
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Container(
                                      child: Text('Both password must Match',style: ts14(Color(0XFF999999))),
                                    ),
                                    SizedBox(height: 50,),
                                    GestureDetector(
                                      onTap:widget.submitCb,
                                      child: Container(
                                        height: 60,
                                        width: SizeConfig.screenWidth!*0.95,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: widget.btnClr,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text("Reset Password",style: ts18(Colors.white,fontsize: 20,fontfamily: 'RM'),),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                  ],
                                ),
                              ),
                            );
                          })),
                ],
              ),
            ),
          ),
        )
    );
  }
}