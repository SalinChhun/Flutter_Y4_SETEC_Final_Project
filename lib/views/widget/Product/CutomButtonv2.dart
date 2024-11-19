import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class BottomElevationBox extends StatelessWidget {
  var text ;
  var bgcolor;
  var border;
  var padding;
  var fontsize;
  var isoutline;
  var bordercolor;
  var textcolor  ;
  var type;
 Function? onlaunch;

  BottomElevationBox({this.text, this.bgcolor, this.border, this.padding,
    this.type,

      this.fontsize, this.isoutline, this.bordercolor,
    this.onlaunch,
    this.textcolor,});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton

            (onPressed: () =>onlaunch!(type,"asdasds"),
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                side:
                isoutline  == true ?

                BorderSide(
                  color: Color( bordercolor)
                ) : null,


                padding: EdgeInsets.all(padding),



                backgroundColor: Color(bgcolor),

              ),


              child: Text(text,style: TextStyle(
                color: Color(textcolor)
              ),)),

        ),
      ],
    );
  }
}