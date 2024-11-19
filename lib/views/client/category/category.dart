
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:flutter/material.dart';


class CategorySreen extends StatelessWidget {
  const CategorySreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:AppBar(

        title: Text("Categories",style: Theme.of(context).textTheme.labelLarge,),
        iconTheme: IconThemeData(
          color: Colors.black,

        ),
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0.34),
        elevation: 0,



      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox.expand(

            child: ListView.builder(
              itemCount: 5,




              itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                color: Color(0xffD1CACD).withOpacity(0.244),
                

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),

                  side: BorderSide(
                    color: Colors.black.withOpacity(0.05)
                  )
                ),


                child: Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                  child: ListTile(
                  leading:Image.asset('assets/images/category/womenclothes.png') ,
                      title: Text("Women Clothes",style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      )),
                  subtitle: Text("12 items Available",style: TextStyle(
                    fontSize: 12.8,
                  ),),
                    trailing: Icon(Icons.arrow_forward),

              ),
                ),);
            },),
          ),
        ),
      ),
    );
  }
}
