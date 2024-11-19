
import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:flutter/material.dart';

import '../../widget/Product/FloatingAction.dart';
import '../../widget/Product/Popupcustom.dart';


class CreateProduct extends StatefulWidget {
  CreateProduct({Key? key}) : super(key: key);

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  bool _isChecked = false;
 // Initial selected value


  // List of items in our dropdown menu
  var items = [
    'XS',
    'S',
    'M',
    'X',
    'L',
    'XL',
    'Other',
  ];
  var itemsdis = [
   0,
    25,
    50,
   75,
  100
  ];
  var itemdiscount = 0;
var dropdownvalue =    'XS';

  var coloritem = [
    'White',
    'Blue',
    'Black',
    'Orange',
    'None',
    'XL',
    'Other',
  ];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("State updated");
    return Scaffold(
      appBar:AppBar(

        title: Text('Add Product',style: TextStyle(
            color: Colors.black
        ),),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(0.34),
        elevation: 0,

      ),
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //TODO title and description
                Container(

                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(AppColorConfig.bgfill),
                  ),
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start ,
                    children: [
                      Text('Product Detail',style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                      ),),
                      Text('Describe your product title and description',style: TextStyle(
                        fontSize: 12.8,
                        color: Colors.grey,

                      ),),
                      SizedBox(height: 30,),
                      Text('Product Images',),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(



                            child: Icon(Icons.add),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5)
                            ),
                            width: 100,
                            height: 100,
                          ),
                          Container(



                            child: Icon(Icons.add),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5)
                            ),
                            width: 100,
                            height: 100,
                          ),
                          Container(



                            child: Icon(Icons.add),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5)
                            ),
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),

                      Text('Product Name',),
                      SizedBox(height: 10,),
                      TextField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(

                            fontSize: 13
                        ),

                        onSubmitted: (value) {
                          setState(() {

                          });
                        },

                        onTap: () {
                          setState(() {

                          });
                        },
                        decoration: InputDecoration(
                            filled: true,

                            fillColor: Color(AppColorConfig.bgcolor),
                            hintText: 'Air jordan 1',

                            floatingLabelStyle: TextStyle(
                                color: Colors.black
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),

                      ),


                      SizedBox(height: 30,),
                      Text('Product Description',),
                      SizedBox(height: 10,),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                            fontSize: 13
                        ),

                        onSubmitted: (value) {
                          setState(() {

                          });
                        },
                        onTap: () {
                          setState(() {

                          });
                        },
                        maxLines: 6,


                        decoration: InputDecoration(
                            filled: true,
                            hintText: 'Short Description about your product',



                            fillColor: Color(AppColorConfig.bgcolor),

                            floatingLabelStyle: TextStyle(
                                color: Colors.black
                            ),

                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),

                      ),
                    ],
                  )
                ),

                //TODO product attributes,color,size stuff
                SizedBox(height: 15,),

                Container(

                    margin: EdgeInsets.only(top: 0),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(AppColorConfig.bgfill),
                    ),
                    child:Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        Text('Attributes',style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                        ),),
                        Text('Describe your product material and factory',style: TextStyle(
                          fontSize: 12.8,
                          color: Colors.grey,

                        ),),


                        Row(

                          children: [
                            Expanded(child:
                            Column(

                              children: [
                                SizedBox(height: 30,),
                                Text('Color',),
                                SizedBox(height: 10,),
                                InkWell(
                                  onTap: () async {
                                    var value = await showDialog(context: context, builder:(context) {
                                      return        PopUpColor();
                                    },);

                                    print(value);





                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    height: 48,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),

                                    ),
                                    child: Text('Choose',style: TextStyle(
                                      fontSize: 12.8
                                    ),),
                                  ),
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )),
                            SizedBox(width: 15,),
                            Expanded(child:
                            Column(

                              children: [
                                SizedBox(height: 30,),
                                Text('Size',),
                                SizedBox(height: 10,),
                                Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),

                                  ),
                                  child: DropdownButton(
                                    elevation: 0,
                                    padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                                    underline: SizedBox(),


                                    // Initial Value
                                    value:dropdownvalue,


                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    alignment: Alignment.center,
                                    isExpanded: true,
                                    style: TextStyle(
                                        fontSize: 12.8,color: Colors.black
                                    ),

                                    // Array list of items
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )),
                          ],
                        ),




                        SizedBox(height: 30,),
                        Text('Weight',),
                        SizedBox(height: 10,),
                        TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(

                              fontSize: 13
                          ),

                          onSubmitted: (value) {
                            setState(() {

                            });
                          },

                          onTap: () {
                            setState(() {

                            });
                          },
                          decoration: InputDecoration(
                              filled: true,

                              fillColor: Color(AppColorConfig.bgcolor),
                              hintText: 'weight',

                              floatingLabelStyle: TextStyle(
                                  color: Colors.black
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),

                        ),

                        SizedBox(height: 30,),

                        Text('Brand',),
                        SizedBox(height: 10,),
                        TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(

                              fontSize: 13
                          ),

                          onSubmitted: (value) {
                            setState(() {

                            });
                          },

                          onTap: () {
                            setState(() {

                            });
                          },
                          decoration: InputDecoration(
                              filled: true,

                              fillColor: Color(AppColorConfig.bgcolor),
                              hintText: 'Air jordan 1',

                              floatingLabelStyle: TextStyle(
                                  color: Colors.black
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),

                        ),

                        SizedBox(height: 30,),
                        Text('Model',),
                        SizedBox(height: 10,),
                        TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(

                              fontSize: 13
                          ),

                          onSubmitted: (value) {
                            setState(() {

                            });
                          },

                          onTap: () {
                            setState(() {

                            });
                          },
                          decoration: InputDecoration(
                              filled: true,

                              fillColor: Color(AppColorConfig.bgcolor),
                              hintText: 'Air jordan 1',

                              floatingLabelStyle: TextStyle(
                                  color: Colors.black
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),

                        ),

                        SizedBox(height: 30,),
                        Text('Material Type',),
                        SizedBox(height: 10,),
                        TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(

                              fontSize: 13
                          ),

                          onSubmitted: (value) {
                            setState(() {

                            });
                          },

                          onTap: () {
                            setState(() {

                            });
                          },
                          decoration: InputDecoration(
                              filled: true,

                              fillColor: Color(AppColorConfig.bgcolor),
                              hintText: 'Air jordan 1',

                              floatingLabelStyle: TextStyle(
                                  color: Colors.black
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),

                        ),



                      ],
                    )
                ),

                SizedBox(height: 15,),

                //TODO product Price, discount  , Inventory stockqty

                Container(

                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(AppColorConfig.bgfill),
                    ),
                    child:Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        Text('Inventory',style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                        ),),
                        Text('Describe your product material and factory',style: TextStyle(
                          fontSize: 12.8,
                          color: Colors.grey,

                        ),),
                        SizedBox(height: 20,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Selling Price',),

                            SizedBox(height: 10,),
                            TextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(

                                  fontSize: 13
                              ),

                              onSubmitted: (value) {
                                setState(() {

                                });
                              },

                              onTap: () {
                                setState(() {

                                });
                              },
                              decoration: InputDecoration(
                                  filled: true,

                                  fillColor: Color(AppColorConfig.bgcolor),
                                  hintText: '5.99',

                                  floatingLabelStyle: TextStyle(
                                      color: Colors.black
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),

                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),

                          ),
                          child: DropdownButton(
                            elevation: 0,
                            padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
                            underline: SizedBox(),


                            // Initial Value
                            value:itemdiscount  ,


                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            alignment: Alignment.center,
                            isExpanded: true,
                            style: TextStyle(
                                fontSize: 12.8,color: Colors.black
                            ),

                            // Array list of items
                            items:itemsdis.map((int items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items.toString()),
                              );
                            }).toList(),
                            onChanged: (dynamic value) {
                              setState(() {
                                itemdiscount = value!;

                              });
                            },
                            // After selecting the desired option,it will
                            // change button value to selected value


                          ),
                        ),



                        SizedBox(height: 20,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Stock Qty',),

                            SizedBox(height: 10,),
                            TextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(

                                  fontSize: 13
                              ),

                              onSubmitted: (value) {
                                setState(() {

                                });
                              },

                              onTap: () {
                                setState(() {

                                });
                              },
                              decoration: InputDecoration(
                                  filled: true,

                                  fillColor: Color(AppColorConfig.bgcolor),
                                  hintText: '500',

                                  floatingLabelStyle: TextStyle(
                                      color: Colors.black
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),

                            ),
                          ],
                        ),

                      ],
                    )
                ),

                SizedBox(height: 70,),
                //TODO product Category and stuff
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFLoating(title: 'Create',),

    );
  }

  // PopUpColor(BuildContext context) {
  //   showDialog(context: context, builder: (context) {
  //     return AlertDialog(
  //       content: Column(
  //         children: [
  //           Text('Choose Color'),
  //           CheckboxListTile(
  //             title: Text('Red'),
  //             value: _isChecked ,
  //             onChanged: (value) {
  //               setState(() {
  //
  //                 _isChecked = value!;
  //
  //               });
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //   },);
  //
  //
  // }
}
