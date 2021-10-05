import 'package:flutter/material.dart';

import 'size.dart';

class InnerShadowTBContainer extends StatelessWidget {

  double height;
  double width;
  Widget child;
  Color color;

  InnerShadowTBContainer({required this.height,required this.width,required this.child,required this.color});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          child,
          Container(
            height: 15,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors:[
                  color,
                  color.withOpacity(0),
                ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                )
            ),

          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 15,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors:[
                    color,
                    color.withOpacity(0),
                  ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                  )
              ),

            ),
          ),
        ],
      ),
    );
  }
}
