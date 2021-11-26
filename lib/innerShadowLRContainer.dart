import 'package:flutter/material.dart';
import 'package:scutiwidgets/size.dart';




class InnerShadowLRContainer extends StatelessWidget {

  double height;
  double width;
  Widget child;
  Color color;

  InnerShadowLRContainer({required this.height,required this.width,required this.child,required this.color});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          child,
          Positioned(
            left: 0,
            child: Container(
              height: height,
              width: 12,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors:[
                    color,
                    color.withOpacity(0),
                  ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,

                  )
              ),

            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              height: height,
              width: 12,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors:[
                    color,
                    color.withOpacity(0),
                  ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft
                  )
              ),

            ),
          ),
        ],
      ),
    );
  }
}
