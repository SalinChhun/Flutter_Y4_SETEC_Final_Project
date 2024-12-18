


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/Product/GridCardItem.dart';
import '../utilities/SearchPage.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {


  @override
  void initState() {
    // TODO: implement initState



    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: MediaQuery.of(context).size.width*0.20,
        title:  Text("Discover",style: TextStyle(
            fontSize:22,
            color: Colors.black
        ),),
        actions: [
          //TODO search bar and profile cary


          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return  SearchPage(
                  titlesearch: "",
                  focus: true,
                );
              },));
            },
            child: Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.black
                  )
              ),
              child: CircleAvatar(
                backgroundColor: Colors.black,


                child: Icon(Icons.search_rounded,color: Colors.white,),
              ),
            ),
          )
        ],
        backgroundColor: Colors.white.withOpacity(0.34),
        elevation: 0,

      ),
      body: SafeArea(

        child:GridCardItem(iscroll: true  ,)
      ),
    );
  }


}
