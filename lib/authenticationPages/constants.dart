import 'package:flutter/material.dart';

glowFunTransparent(BuildContext context){
  return Theme.of(context).copyWith(
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white10
      )
  );
}

ts12(Color color,{String fontfamily='RR'}){
  return TextStyle(fontSize: 12,fontFamily: fontfamily,color: color,letterSpacing: 0.1);
}
ts14(Color color,{String fontfamily='RR'}){
  return TextStyle(fontSize: 14,fontFamily: fontfamily,color: color,letterSpacing: 0.1);
}
ts15(Color color,{String fontfamily='RR'}){
  return TextStyle(fontSize: 15,fontFamily: fontfamily,color: color,letterSpacing: 0.1);
}
ts16(Color color,{String fontfamily='RR'}){
  return TextStyle(fontSize: 16,fontFamily: fontfamily,color: color,letterSpacing: 0.1);
}
ts18(Color color,{String fontfamily='RR',double fontsize=18}){
  return TextStyle(fontSize: fontsize,fontFamily: fontfamily,color: color,letterSpacing: 0.1);
}