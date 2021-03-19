import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/addAddress.dart';
import 'package:e_shop/Store/Search.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25.0,bottom: 10.0),
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  elevation: 8.0,
                  child: Container(
                    height: 160.0,
                    width: 160.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.0,),
                Text(
                  EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
                  style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 35.0,fontFamily: "signatra"),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.0,),
          Container(
            padding: EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home,color: Colors.deepOrangeAccent,),
                  title: Text("Home",style: TextStyle(color: Colors.deepOrangeAccent),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c) =>StoreHome());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                
                ListTile(
                  leading: Icon(Icons.reorder,color: Colors.deepOrangeAccent,),
                  title: Text("My Order",style: TextStyle(color: Colors.deepOrangeAccent),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c) =>MyOrders());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                //Divider(height: 10.0, color: Colors.deepOrangeAccent,thickness: 6.0,),

                ListTile(
                  leading: Icon(Icons.shopping_cart,color: Colors.deepOrangeAccent,),
                  title: Text("My Cart",style: TextStyle(color: Colors.deepOrangeAccent),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c) =>CartPage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                //Divider(height: 10.0, color: Colors.deepOrangeAccent,thickness: 6.0,),

                ListTile(
                  leading: Icon(Icons.search,color: Colors.deepOrangeAccent,),
                  title: Text("Search",style: TextStyle(color: Colors.deepOrangeAccent),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c) =>SearchProduct());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                //Divider(height: 10.0, color: Colors.deepOrangeAccent,thickness: 6.0,),

                ListTile(
                  leading: Icon(Icons.add_location,color: Colors.deepOrangeAccent,),
                  title: Text("Add New Address",style: TextStyle(color: Colors.deepOrangeAccent),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c) =>AddAddress());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                //Divider(height: 10.0, color: Colors.deepOrangeAccent,thickness: 6.0,),

                ListTile(
                  leading: Icon(Icons.exit_to_app,color: Colors.deepOrangeAccent,),
                  title: Text("Logout",style: TextStyle(color: Colors.deepOrangeAccent),),
                  onTap: (){
                    EcommerceApp.auth.signOut().then((c){
                      Route route = MaterialPageRoute(builder: (c) =>AuthenticScreen());
                      Navigator.pushReplacement(context, route);
                    });
                  },
                ),
                //Divider(height: 20.0, color: Colors.deepOrangeAccent,thickness: 6.0,),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
