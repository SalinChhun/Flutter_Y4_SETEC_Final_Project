
import 'package:ecommerce/res/constant/appcolor.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../client/utilities/SearchPage.dart';
import '../../client/utilities/searchscreen.dart';




class EmptyCard extends StatelessWidget {
  var img;
  var maintitle;
  var subtitle;

  var btntitle;
   EmptyCard({
    super.key,
     this.img,
     this.maintitle,
     this.subtitle,
     this.btntitle

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // SizedBox(height: 70,),
          SizedBox(height: 50,),
          Expanded(
              flex: 1,

              child: Column(children: [
                Image.asset('${img}'
                  ,fit: BoxFit.contain,
                  width: 160,
                  height: 180,
                ),
                SizedBox(height: 40,),
                Text("${maintitle}",style: Theme.of(context)
                    .textTheme.headlineLarge,),
                SizedBox(height: 10,),
                Text("${subtitle}",style: TextStyle(
                    color: Colors.grey
                ),),

              ],)),
          Container(
            margin: EdgeInsets.only(bottom: 100),
            child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppColorConfig.success),
                    elevation: 0,
                    padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),

                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                    return  SearchScreen(
                      sortby: 6,
                      focus: false,
                      searchtitle: "",


                    );
                  },),(route) => true,);


                }, child: Text("${btntitle}",style: TextStyle(
                fontSize: 15.8
            ),)),
          ),
          SizedBox(height: 30,),


        ],
      ),
    );
  }
}