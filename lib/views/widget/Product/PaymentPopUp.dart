


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../res/constant/appcolor.dart';

class PaymentPopUp extends StatefulWidget {
  PaymentPopUp({Key? key}) : super(key: key);

  @override
  State<PaymentPopUp> createState() => _PaymentPopUpState();
}

class _PaymentPopUpState extends State<PaymentPopUp> {
  var initpayment = 0;
  var isselect = false;

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(

      title: Text("Choose Your Payment"),
      content: Container(
        height: 300,
        child: Column(
          children: [
            ListTile(
              style: ListTileStyle.list,
              onTap: () {
                setState(() {
                  initpayment = 0;
                  print(initpayment);
                  isselect = true;

                });
              },
              selected: initpayment == 1 ,
              // selectedTileColor: Color(AppColorConfig.primaryswatch),
              tileColor: Color(AppColorConfig.primarylight),
              shape: Border.all(
                  color: Colors.grey.withOpacity(0.25)
              ),
              contentPadding: EdgeInsets.all(10),

              leading:           Image.asset('assets/logo/Money icon.png',

                width: 50,
                height: 50,
              ),
              title: Text("Cash on Delivery",style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
              ),),
              subtitle: Text("Pay when product arrive",style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.8,
                  fontWeight: FontWeight.w400

              ),),
            ),
            SizedBox(height: 20,),
            ListTile(
              style: ListTileStyle.list,
              onTap: () {
                setState(() {
                  initpayment = 1;
                  print(initpayment);
                  isselect = true;

                });
              },
              selected: initpayment == 1 ,

              selectedTileColor: Color(AppColorConfig.primarylight),
              // tileColor: Color(AppColorConfig.primarylight),
              shape: Border.all(
                  color: Colors.grey.withOpacity(0.25)
              ),
              contentPadding: EdgeInsets.all(10),

              leading:      Image.asset('assets/logo/Credit Card Icon.png',

                width: 50,
                height: 50,
                color: Colors.black,
                // color:
                //
                //
                // initpayment == 1?
                // Colors.white:
                // Colors.black,

              ),
              title: Text("Credit or Debit Card",style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
              ),),
              subtitle: Text("Visa or Mastercard",style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.8,
                  fontWeight: FontWeight.w400

              ),),
            ),
            SizedBox(height: 20,),



            Row(

              children: [
                Expanded(
                  child: ElevatedButton(


                      onPressed: () {
                        print(initpayment);

                        Navigator.pop(context,initpayment);


                      },

                      style: ButtonStyle(
                        elevation: MaterialStatePropertyAll(0),
                        backgroundColor: MaterialStatePropertyAll(Color(AppColorConfig.success))
                      ),

                      child: Text('Comfirm')),
                ),
              ]

            )

          ],
        ),
      ),

    );
  }
}
