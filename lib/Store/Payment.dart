
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';


class  Payment extends StatefulWidget {

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  
  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();
  void initState(){
    super.initState();

    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);

  }
  void dispose()
  {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout(){
    var options = {
      "key" : "rzp_test_aoohymBxZkF2jD",
      "amount" : num.parse(textEditingController.text)*100,
      "name" : "Bhavna Saree",
      "description" : "Secure payment",
      "prefill" : {
        "contect" : "2345678987",
        "email" : "abc@gmail.com",
      },
      "external" :{
        "wallets" : ["paytm"]
      }
    };

    try{
      razorpay.open(options);

    }catch(e){
      print(e.toString());
    }

  }

  void handlerPaymentSuccess()
  {
    print("Payment Success");
  }
  void handlerErrorFailure()
  {
    print("Payment error");
  }
  void handlerExternalWallet()
  {
    print("External wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment..."),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,

              decoration: InputDecoration(
                hintText: "Enter amount",
              ),
            ),
            SizedBox(height: 10.0,),
            RaisedButton(

              color: Colors.deepOrangeAccent,
              child: Text("Pay",style: TextStyle(color: Colors.white,fontSize: 20.0),),
              onPressed: (){
                openCheckout();
              },
            ),

          ],
        ),
      ),
    );
  }
}
