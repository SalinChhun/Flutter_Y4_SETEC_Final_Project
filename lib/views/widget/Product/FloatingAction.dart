

import 'package:ecommerce/viewmodel/order/order_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../order/Success.dart';

class CustomFLoating extends StatefulWidget {
  var title;
  var addressid;
 CustomFLoating({
    super.key,
   this.title,
   this.addressid
  });

  @override
  State<CustomFLoating> createState() => _CustomFLoatingState();
}

class _CustomFLoatingState extends State<CustomFLoating> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.addressid);
  }
  Widget build(BuildContext context) {
    return Row(

      children: [
        Expanded(
          child: FloatingActionButton.extended(
              backgroundColor: Color(0xff508A7B),

              elevation: 0,
              isExtended: true,
              extendedPadding: EdgeInsets.all(0),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
              ),
              onPressed: () {
                //TODO submit order
                //TODO do some event
                BlocProvider.of<OrderBloc>(context).add(PostOrderEvent( addressid:widget.addressid ));


                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Success();
                },));

              }, label:Text('${widget.title}',style: TextStyle(
              fontSize: 12.8
          ),)),
        ),
      ],
    );
  }
}