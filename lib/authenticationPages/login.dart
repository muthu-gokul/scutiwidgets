import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scutiwidgets/size.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';


class LoginPage extends StatefulWidget {
  String img;
  bool isSvg;
  VoidCallback loginTap;
  VoidCallback forgotTap;
  VoidCallback signUpTap;
  bool showConnectWith;
  Color btnClr;
  LoginPage({required this.img,this.isSvg=false,required this.forgotTap,required this.loginTap,this.showConnectWith=true,
  required this.signUpTap,this.btnClr=const Color(0XFF591493)});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  with SingleTickerProviderStateMixin{

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  late bool passwordvisible;
  late bool loginvalidation;
  late AnimationController shakecontroller;
  late Animation<double> offsetAnimation;
  bool isLoading=false;
  bool isVisible=false;
  bool rememberMe=true;

  String? prefEmail;
  String? prefPassword;
  bool? prefRememberMe;
  late SharedPreferences _Loginprefs;
  static const String useremail = 'email';
  static const String passwordd = 'password';
  static const String rememberMee = 'rememberMe';
  late var node;
  Color fillColor=Color(0xFFFFFFFF);
  Color borderColor=Color(0xFFE5E5E5);
  Color inputTextColor=Color(0xFF9b9b9b);

  String emailError="";
  String passwordError="";


  allowAccess() async{
    //  final PermissionHandler _permissionHandler = PermissionHandler();
    var result = await Permission.storage.request();
    if(result == PermissionStatus.granted) {}
  }

  void _loadCredentials() {
    setState(() {
      this.prefEmail = this._Loginprefs.getString(useremail) ?? "";
      this.prefPassword = this._Loginprefs.getString(passwordd) ?? "";
      this.prefRememberMe = this._Loginprefs.getBool(rememberMee) ?? true;
    });
    setState(() {
      rememberMe=prefRememberMe!;
    });
    if(prefRememberMe!){
      if(prefEmail!.isNotEmpty&&prefPassword!.isNotEmpty){
        setState(() {
          username.text=prefEmail!;
          password.text=prefPassword!;
        });
      }
    }
  }

  Future<Null> _setCredentials(String email,String pass,bool rem) async {
    print(rem);
    await this._Loginprefs.setString(useremail, email);
    await this._Loginprefs.setString(passwordd, pass);
    await this._Loginprefs.setBool(rememberMee, rem);
    // _loadCredentials();
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    passwordvisible = true;
    loginvalidation=false;
    allowAccess();
    shakecontroller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    username.clear();
    password.clear();
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() => this._Loginprefs = prefs);
        _loadCredentials();
      });
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
            color: Colors.transparent,
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
                  Text("Login Now",style: TextStyle(fontSize: 30,fontFamily: 'RB',color: Colors.black),),
                  SizedBox(height: 10,),
                  Container(
                    width: SizeConfig.screenWidth!*0.65,
                    child: Text("Please login to continue using our app",style: ts14(Color(0XFFACACAC)),textAlign: TextAlign.center,),
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
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintText: "User Email",
                                          hintStyle: TextStyle(
                                              color:loginvalidation?Colors.red: inputTextColor.withOpacity(0.7),fontSize: 18,fontFamily: 'RR'),
                                          contentPadding: EdgeInsets.only(left: 20,top: 10),
                                          //   fillColor: loginvalidation?HexColor("1C1F32"):Colors.white,

                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        validator:(value){

                                          Pattern pattern =
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                          RegExp regex = new RegExp(pattern as String);
                                          if (!regex.hasMatch(value!)) {
                                            setState(() {
                                              emailError='* Email format is invalid';
                                            });
                                            return '';
                                          } else {
                                            setState(() {
                                              emailError='';
                                            });
                                            return null;
                                          }
                                        },
                                        onEditingComplete: (){
                                          node.nextFocus();
                                        },
                                      ),
                                    ),
                                    emailError.isEmpty?Container():Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(emailError,style: TextStyle(fontSize: 14,color: Colors.red),),
                                    ),
                                    SizedBox(height: 20,),
                                    Container(
                                      height: 60,
                                      width: SizeConfig.screenWidth,
                                      alignment: Alignment.centerLeft,
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
                                            hintText: "Password",
                                            hintStyle:TextStyle(color:loginvalidation?Colors.red:inputTextColor.withOpacity(0.7),fontSize:18,fontFamily: 'RR' ),
                                            contentPadding: EdgeInsets.only(left: 20, top: 17),
                                            // suffixIconConstraints: BoxConstraints(
                                            //     minHeight: 55,
                                            //     maxWidth: 55
                                            // ),
                                            suffixIcon: Padding(
                                              padding:  EdgeInsets.only(right: 0,top: 0),
                                              child:  GestureDetector(
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
                                        ),
                                        keyboardType: TextInputType.emailAddress,

                                        validator:(value){
                                          if(value!.isEmpty){
                                            setState(() {
                                              passwordError='* Password is required';
                                            });
                                            return null;
                                          }
                                          else{
                                            setState(() {
                                              passwordError='';
                                            });
                                            return null;
                                          }
                                        },
                                        onEditingComplete: () async {
                                          node.unfocus();
                                        },
                                      ),
                                    ),
                                    passwordError.isEmpty?Container():Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(passwordError,style: TextStyle(fontSize: 14,color: Colors.red),),
                                    ),
                                    SizedBox(height: 10,),
                                    GestureDetector(
                                      onTap: widget.forgotTap,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child:Text("Forgot Password ?",style: ts14(Color(0XFF999999))),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    GestureDetector(
                                      onTap: (){
                                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>Masterpage()),);

                                        if(_loginFormKey.currentState!.validate()){
                                          //print("Validate");
                                          _setCredentials(username.text, password.text, rememberMe);
                                          widget.loginTap();

                                        }
                                        // Navigator.push(context, pr.PageRoute().fade(SecurityDetails()));
                                      },
                                      child: Container(
                                        height: 60,
                                        width: SizeConfig.screenWidth!*0.95,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: widget.btnClr,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text("Login",style: TextStyle(fontFamily: 'RM',color: Colors.white,fontSize: 20),),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    GestureDetector(
                                      onTap:widget.signUpTap,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text.rich(
                                          TextSpan(
                                              text: 'Don\'t have an Account ? ',style: ts14(Color(0XFF999999)),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                  text: 'Sign Up',
                                                  style: ts14(widget.btnClr),
                                                )
                                              ]
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      )
                  ),
                  widget.showConnectWith?Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        alignment: Alignment.center,
                        child:Text("Or Connect with ?",style: ts14(Color(0XFF999999))),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width:50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0XFF485896),
                              ),
                              child: Icon(Icons.facebook, color: Colors.white,),
                            ),
                            Container(
                              width:50,
                              height: 50,
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0XFF76A9EB),
                              ),
                              child: Icon(Icons.facebook, color: Colors.white,),
                            ),
                            Container(
                              width:50,
                              height: 50,
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0XFFC04D3B),
                              ),
                              child: Icon(Icons.facebook, color: Colors.white,),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ):Container()
                ],
              ),
            ),
          ),
        )
    );
  }
}



