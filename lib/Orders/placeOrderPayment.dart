import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Store/Payment.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget
{
  final String addressId;
  final double totalAmount;

  PaymentPage({Key key,this.addressId,this.totalAmount}): super(key: key);



  @override
  _PaymentPageState createState() => _PaymentPageState();
}




class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset("images/order.png"),
              ),
              SizedBox(height: 10.0,),
              FlatButton(
                color: Colors.deepOrangeAccent,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                //splashColor: Colors.lightBlueAccent,
                onPressed: ()=>addOrderDetails(),
                child: Text("Order Now!",style: TextStyle(fontSize: 26.0,), ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  addOrderDetails()
  {
    writeOrderDetailsForUser({
      EcommerceApp.addressID : widget.addressId,
      EcommerceApp.totalAmount : widget.totalAmount,
      "orderBy" : EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      EcommerceApp.productID : EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList),
      EcommerceApp.paymentDetails : "cash on delivery",
      EcommerceApp.orderTime: DateTime.now().millisecondsSinceEpoch.toString(),
      EcommerceApp.isSuccess : true,
    });

    writeOrderDetailsForAdmin({
      EcommerceApp.addressID : widget.addressId,
      EcommerceApp.totalAmount : widget.totalAmount,
      "orderBy" : EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      EcommerceApp.productID : EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList),
      EcommerceApp.paymentDetails : "cash on delivery",
      EcommerceApp.orderTime: DateTime.now().millisecondsSinceEpoch.toString(),
      EcommerceApp.isSuccess : true,
    }).whenComplete(() => {
      emptyCartNow()
    });


  }

  emptyCartNow()
  {
    EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, ["garbageValue"]);
    List tempList = EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);

    Firestore.instance.collection("users")
        .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),)
        .updateData({
      EcommerceApp.userCartList: tempList,
    }).then((value)
    {
      EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, tempList);
      Provider.of<CartItemCounter>(context,listen: false).displayResult();
    });

    //Fluttertoast.showToast(msg: "Congratulations ,your order has been placed successfully...");
    //Route route = MaterialPageRoute(builder: (c) =>StoreHome());
    //Navigator.pushReplacement(context, route);
    Route route = MaterialPageRoute(builder: (c)=> Payment());
    Navigator.push(context, route);
  }

  Future writeOrderDetailsForUser(Map<String,dynamic> data) async
  {
    await EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
        .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection(EcommerceApp.collectionOrders)
        .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID) + data['orderTime'])
        .setData(data);
  }

  Future writeOrderDetailsForAdmin(Map<String,dynamic> data) async
  {
    await EcommerceApp.firestore
        .collection(EcommerceApp.collectionOrders)
        .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID) + data['orderTime'])
        .setData(data);
  }
}
