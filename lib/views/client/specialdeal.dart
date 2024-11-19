
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:flutter/material.dart';


class SpecialScreen extends StatelessWidget {
  const  SpecialScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:AppBar(

        title: Text('Super Deal',style: TextStyle(
          color: Colors.black
        ),),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white.withOpacity(0.34),
        elevation: 0,


      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5,left: 15,right: 15),
          child: ListView.builder(
            itemCount: 3,

            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(

                      width: double.maxFinite,

                        child:
                        Image.network(
                            'https://cdn1.clickthecity.com/wp-content/uploads/2021/09/02154327/foodpanda-Eatventures-1024x1024.jpg')


                    ),
                    //  Row(
                    //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //    children: [
                    //      Text("30 vendors ",style: TextStyle(
                    //       fontSize: 14,
                    // ),),
                    //      Icon(Icons.arrow_forward,size: 17,)
                    //    ],
                    //  ),
                  ],
                ),
              );
          },),
        ),
      ),

    );
  }
}
