


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/Ulti/Color.dart';

class PopUpColor extends StatefulWidget {
  const PopUpColor({Key? key}) : super(key: key);

  @override
  State<PopUpColor> createState() => _PopUpColorState();
}

class _PopUpColorState extends State<PopUpColor> {
  var color =    'White';

  var coloritem = [
    'White',
    'Blue',
    'Black',
    'Orange',
    'None',
    'Other',
  ];
  var listofcolor = [
    ColorItems(id:DateTime.now(),color:   'White',ischeck: false ),
    ColorItems(id:DateTime.now(),color:   'Black',ischeck: false ),
    ColorItems(id:DateTime.now(),color:   'Other',ischeck: false ),
  ];


var  colorid = [];

  var _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      content: Container(
        height: 246,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,



              children: [
                Text('Choose Color',style: Theme.of(context).textTheme.labelLarge,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: listofcolor.map((e) =>   CheckboxListTile(
                    title: Text(e.color),
                    value:e.ischeck  ,
                    onChanged: (value) {
                      setState(() {

                       e.ischeck = value!;


                       if(e.ischeck == true) {

                         colorid.add(e.id);
                       }
                       else{
                         colorid.remove(e.id);

                       }

                       print(e.ischeck);


                      });

                    },
                  )).toList(),
                ),
            ElevatedButton(onPressed:() {
              Navigator.pop(context,colorid);

                }, child: Text("Comfirm",style: TextStyle(
              fontSize: 12.8
            ),))
              ],
            ),
          ],
        ),
      ),
      elevation: 0,
    );
  }
}
