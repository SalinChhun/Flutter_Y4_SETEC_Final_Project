



import 'package:ecommerce/helper/GoogleLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  var textbtn;
  var logo;
  var bgcolor;
  var lat;
  var long;
  Function? function;

 CustomButton({
    super.key,
   this.textbtn,
   this.logo,
   this.bgcolor,
   this.lat,
   this.long,
   this.function
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  LocationHelper locationHelper = LocationHelper();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

        onPressed: () =>      widget.function,
        style: ElevatedButton.styleFrom(
            backgroundColor: widget.bgcolor,
            elevation: 0,
            padding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black.withOpacity(0.14)),
                borderRadius: BorderRadius.circular(3)
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(widget.logo != null)
            Image.asset('${widget.logo}',
              width: 20,
              height: 20,
              fit: BoxFit.cover,

            ),
            SizedBox(width: 10,),
            Text("${widget.textbtn}",style: TextStyle(
              fontSize: 12.8,

            ),)
          ],
        ));
  }

}

