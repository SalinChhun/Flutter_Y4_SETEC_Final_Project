import 'package:ecommerce/model/Category/CategoryModel.dart';
import 'package:ecommerce/views/client/NavScreen.dart';
import 'package:ecommerce/views/client/utilities/SearchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../res/constant/appcolor.dart';
import '../../../viewmodel/category/category_bloc.dart';
import '../../../viewmodel/products/product_bloc.dart';
import '../../widget/Product/GridCardItem.dart';
import '../product/Product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ModelFilter.dart';

class ShowModelFilter extends StatefulWidget {
  var search;

  ShowModelFilter({Key? key, this.search}) : super(key: key);

  @override
  State<ShowModelFilter> createState() => _ShowModelFilterState();
}

class _ShowModelFilterState extends State<ShowModelFilter> {
  var listfilter = [
    "Best Selling",
    "Popular",
    "Name A-z",
    "Name Z-A",
    "Price "

  ];
  var selectedcategory;

  var selectcate;
  var sortparam = [
    "best_selling",
    "popular",
    "name",
    "-name",
    "prices"

  ];

  var txtmax = TextEditingController();
  var txtmin = TextEditingController();

  List<Results>? category;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBlocSorting, ProductState>(
      listener: (context, state) {
        // TODO: implement listener}
        print("The state is ${state}");
        if(state is ProductSortCompleted) {
          Navigator.pop(context);
        }
        if(state is ProductSortLoading){
            Center(
              child: CircleAvatar(),
            );
        }
        else{
          Center(
            child: Text("Error has been occur"),
          );
        }
      },
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.88,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  child: Image.asset(
                    'assets/logo/close.png',
                    width: 16,
                    height: 17,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Filters",
                  style: TextStyle(
                      color: Colors.black, fontSize: 20),
                ),
                //TODO caategory
              ],
            ),
            Divider(),
            SizedBox(
              height: 19,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Column(
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                        color: Color(AppColorConfig.success),
                        fontSize: 15.8,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Please Select a category to refine your result",
                    style: TextStyle(fontSize: 10.8),
                  ),
                  SizedBox(height: 20,),

                  //TODO category scroll list here

                  BlocConsumer<CategoryBloc, CategoryState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is CategoryLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is CategoryCompleted) {
                        var len = state.category!.results!.length;

                        category = state.category!.results;

                        return Container(
                          height: 40,

                          child: ListView.builder(
                            itemCount: len ?? 0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var category =
                              state.category!.results![index];
                              return InkWell(
                                onTap: () {
                                  print(category.id);
                                  setState(() {
                                    selectcate = index;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                        selectcate == index ?
                                        Color(AppColorConfig.success)

                                            :
                                        Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.25)
                                        ),
                                        borderRadius: BorderRadius.circular(7)
                                    ),
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 5, bottom: 5),
                                    height: 10,
                                    alignment: Alignment.center,
                                    margin:
                                    EdgeInsets.only(right: 18),
                                    child: Text(
                                      "${category.categoryname}",
                                      style:
                                      selectcate == index ?
                                      TextStyle(
                                          color: Colors.white
                                      ) :

                                      Theme
                                          .of(context)
                                          .textTheme
                                          .headlineSmall,
                                    )
                                ),
                              );
                            },
                          ),
                        );
                      }
                      if (state is CategoryError) {
                        return Center(
                          child: Text("Error during fetching"),
                        );
                      } else {
                        return Center(
                          child: Text("Error during fetching"),
                        );
                      }
                    },
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Prices Range",
                    style: TextStyle(
                      color: Color(AppColorConfig.success),
                      fontSize: 15.8,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Please Select a price range to refine your result",
                    style: TextStyle(fontSize: 10.8),
                  ),


                  Container(
                    height: 55,
                    width: double.maxFinite,
                    child: Row(

                      children: [
                        Expanded(
                          child: Container(
                            height: 45,
                            margin: EdgeInsets.only(top: 25),
                            child: TextField(
                              style: TextStyle(

                                  fontSize: 13
                              ),
                              controller: txtmin,

                              keyboardType: TextInputType.number,
                              onSubmitted: (value) {
                                setState(() {
                                  txtmin.text = value;
                                });
                              },

                              onTap: () {

                              },
                              cursorColor: Colors.grey,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  filled: true,


                                  fillColor: Color(AppColorConfig.bgfill),

                                  label: Text("Min"),

                                  floatingLabelStyle: TextStyle(
                                      color: Colors.black
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),

                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: Container(
                            height: 45,
                            margin: EdgeInsets.only(top: 25),
                            child: TextField(

                              style: TextStyle(

                                  fontSize: 13
                              ),

                              keyboardType: TextInputType.number,
                              onSubmitted: (value) {
                                setState(() {
                                  txtmax.text = value;
                                });
                              },

                              onTap: () {

                              },
                              controller: txtmax,
                              cursorColor: Colors.grey,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  filled: true,


                                  fillColor: Color(AppColorConfig.bgfill),

                                  label: Text("Max"),

                                  floatingLabelStyle: TextStyle(
                                      color: Colors.black
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sort By",
                    style: TextStyle(
                      color: Color(AppColorConfig.success),
                      fontSize: 15.8,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Please Select a price range to refine your result",
                    style: TextStyle(fontSize: 10.8),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
            Container(
                width: double.maxFinite,
                height: 36,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(

                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listfilter.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print("even sent here");
                        setState(() {
                          selectedcategory = index;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: selectedcategory == index
                                ? Color(AppColorConfig.success)
                                : null,
                            border: selectedcategory == index
                                ? Border.all(color: Colors.green)
                                : Border.all(color: Colors.grey.withOpacity(
                                0.25)),
                            borderRadius: BorderRadius.circular(6)),
                        margin: EdgeInsets.only(right: 20),
                        child: Row(
                          children: [

                            Text(
                              "${listfilter?[index]}",
                              style: TextStyle(
                                  fontSize: 10.8,
                                  color: selectedcategory == index
                                      ? Color(
                                      AppColorConfig.primarylight)
                                      : Color(AppColorConfig.success)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
            Container(

              child: ElevatedButton(

                child: Text("Apply", style: TextStyle(
                    fontSize: 12.8
                ),),
                onPressed: () {
                  print(txtmin.text);
                  print(txtmax.text);
                  print(category![selectcate].categoryname);
                  print(category![selectcate].id);
                  print(widget.search);
                  print( sortparam[selectedcategory]);
                  // TODO make sort filter here
                  context.read<ProductBlocSorting>().add(ProductFilter(

                      search: widget.search,
                      category: category![selectcate].id,
                      max: txtmax.text,
                      min: txtmin.text,
                    sortby: sortparam[selectedcategory] == "-name"
                        ? "name"
                        : sortparam[selectedcategory],
                    rank: sortparam[selectedcategory] == "name"
                        ? "ASC"
                        : "desc",

                  ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppColorConfig.success)
                ),
              ),


              width: double.maxFinite,
            )
          ],
        ),
      ),
    );
  }
}
