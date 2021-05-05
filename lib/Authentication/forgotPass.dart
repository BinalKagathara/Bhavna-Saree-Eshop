import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          centerTitle: true,
          title: Text(
            "Forgot Password" ,style: TextStyle(fontSize: 22.0, color: Colors.white,),
            ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(image: AssetImage("images/forgotpass.jpg")
                    ),
            ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    RaisedButton(
                      onPressed: () => {},
                      child: Text('Send Password Reset Link',style: TextStyle(color: Colors.white,),),
                      color: Colors.deepOrangeAccent,
                    ),
                  ],
                  ),

              ),
            ),

          ),
        ),
      );
  }
}
