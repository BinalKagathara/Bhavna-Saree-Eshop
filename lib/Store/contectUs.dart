import 'dart:io';

import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contect extends StatefulWidget
{
  final double totalAmount;
  const Contect({Key key,this.totalAmount}):super(key: key);
  @override
  _ContectState createState() => _ContectState();
}


class _ContectState extends State<Contect>
{

  void customLaunch(command) async{
    if(await canLaunch(command)){
      await launch(command);
    }
    else
      {
        print('could not launch $command');
      }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          centerTitle: true,
          title: Text(
            "Contect Us" ,style: TextStyle(fontSize: 32.0, color: Colors.white,fontFamily: "Signatra"),
             ),

          actions: [
            IconButton(
                icon: Icon(Icons.call,color: Colors.white,),
                onPressed: (){
                  customLaunch('tel:+91 9879243011');
                }
            )
          ],
             ),


        body: Container(
            child: Center(
              child: Column(
                children: [
                  Padding(padding:EdgeInsets.only(top: 20.0)),
                  Text("Address" ,style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.deepOrangeAccent),),
                  SizedBox(height: 20.0,),
                  Text("Shantadevi Road, Navsari",style: TextStyle(fontSize: 20.0,color: Colors.blueGrey,),),
                  SizedBox(height: 30.0,),
                  Text("Contect Us" ,style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.deepOrangeAccent),),
                  SizedBox(height: 20.0,),
                  Text("+91 9879243011",style: TextStyle(fontSize: 20.0,color: Colors.blueGrey,),),
                  SizedBox(height: 10.0,),
                  Text("+91 9879443011",style: TextStyle(fontSize: 20.0,color: Colors.blueGrey,),),
                  SizedBox(height: 30.0,),
                  Text("Email Us" ,style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.deepOrangeAccent),),
                  SizedBox(height: 20.0,),
                  Text("bhavnasaree@gmail.com",style: TextStyle(fontSize: 20.0,color: Colors.blueGrey,),),



                ],
    ),
            ),



      ),
    ),
    );



  }
}

