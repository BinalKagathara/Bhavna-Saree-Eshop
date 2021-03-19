//import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;


class UploadPage extends StatefulWidget
{
  @override
  _UploadPageState createState() => _UploadPageState();
}



class _UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage>
{
  bool get wantKeepAlive => true;
  File file;
  TextEditingController _descriptiontextEditingController = TextEditingController();
  TextEditingController _pricetextEditingController = TextEditingController();
  TextEditingController _titletextEditingController = TextEditingController();
  TextEditingController _shortinfotextEditingController = TextEditingController();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return file == null ? displayAdminHomeScreen() : displayAdminUploadFormScreen();
  }

  displayAdminHomeScreen()
  {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(

        ),
        leading: IconButton(
          icon: Icon(Icons.border_color,color: Colors.white,),
          onPressed: ()
          {
            Route route = MaterialPageRoute(builder: (c) => AdminShiftOrders());
            Navigator.pushReplacement(context, route);
          },
        ),
        actions: [
          FlatButton(
            child: Text("Logout",style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold),),
            onPressed: ()
            {
              Route route = MaterialPageRoute(builder: (c) => SplashScreen());
              Navigator.pushReplacement(context, route);
            },
          ),
        ],
      ),
      body: getAdminHomeScreenBody(),
    );
  }
  getAdminHomeScreenBody()
  {
    return Container(

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shop_two,color: Colors.deepOrangeAccent,size: 200.0,),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
                child: Text("Add new item",style: TextStyle(fontSize: 20.0,color: Colors.white),),
                color: Colors.deepOrangeAccent,
                onPressed: () => takeImage(context),

              ),
            ),
          ],
        ),
      ),
    );
  }

  takeImage(mContext)
  {
    return showDialog(
      context: mContext,
      builder: (con)
        {
          return SimpleDialog(
            title: Text("Item Image",style: TextStyle(color: Colors.deepOrangeAccent,fontWeight: FontWeight.bold),),
            children: [
              SimpleDialogOption(
                child: Text("Capture with Camera",style: TextStyle(color: Colors.deepOrangeAccent,)),
                onPressed: capturePhotoWithCamera,
              ),
              SimpleDialogOption(
                child: Text("Select from Gallery  ",style: TextStyle(color: Colors.deepOrangeAccent,)),
                onPressed: pickPhotoFromGallery,
              ),
              SimpleDialogOption(
                child: Text("Cancel",style: TextStyle(color: Colors.deepOrangeAccent,)),
                onPressed: ()
                  {
                    Navigator.pop(context);
                  },
              ),
            ],
          );
        }
    );
  }

  capturePhotoWithCamera() async
  {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 680.0,maxWidth: 970.0);

    setState(() {
      file = imageFile;
    });
  }

  pickPhotoFromGallery() async
  {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,);

    setState(() {
      file = imageFile;
    });
  }


  displayAdminUploadFormScreen()
  {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(

        ),
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: clearFormInfo),
        title: Text("New Product",style: TextStyle(color: Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold,),),
        actions: [
          FlatButton(
            onPressed: uploading ? null : ()=> uploadImageAndSaveItemInfo(),
            child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold,),),
          )
        ],
      ),
      body: ListView(
        children: [
          uploading ? circularProgress() : Text(""),
          Container(
            height: 230.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(image: DecorationImage(image: FileImage(file),fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 12.0),),

          ListTile(
            leading: Icon(Icons.perm_device_info,color: Colors.deepOrangeAccent,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepOrangeAccent),
                controller: _shortinfotextEditingController,
                decoration: InputDecoration(
                  hintText: "Short Info",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(color: Colors.deepOrangeAccent,),

          ListTile(
            leading: Icon(Icons.perm_device_info,color: Colors.deepOrangeAccent,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepOrangeAccent),
                controller: _titletextEditingController,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(color: Colors.deepOrangeAccent,),

          ListTile(
            leading: Icon(Icons.perm_device_info,color: Colors.deepOrangeAccent,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepOrangeAccent),
                controller: _descriptiontextEditingController,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(color: Colors.deepOrangeAccent,),

          ListTile(
            leading: Icon(Icons.perm_device_info,color: Colors.deepOrangeAccent,),
            title: Container(
              width: 250.0,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.deepOrangeAccent),
                controller: _pricetextEditingController,
                decoration: InputDecoration(
                  hintText: "Price",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(color: Colors.deepOrangeAccent,)


        ],
      ),
    );
  }
  clearFormInfo()
  {
    setState(() {
      file = null;
      _descriptiontextEditingController.clear();
      _pricetextEditingController.clear();
      _shortinfotextEditingController.clear();
      _titletextEditingController.clear();
    });
  }

  uploadImageAndSaveItemInfo() async
  {
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl = await uploadItemImage(file);
    saveItemInfo(imageDownloadUrl);

  }

  Future<String>uploadItemImage(mFileImage) async
  {
    final StorageReference storageReference = FirebaseStorage.instance.ref().child("items");
    StorageUploadTask uploadTask = storageReference.child("product_$productId.jpg").putFile(mFileImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveItemInfo(String downloadUrl)
  {
    final itemsRef = Firestore.instance.collection("items");
    itemsRef.document(productId).setData({
      "shortInfo" : _shortinfotextEditingController.text.trim(),
      "longDescription" : _descriptiontextEditingController.text.trim(),
      "price" : int.parse(_pricetextEditingController.text),
      "publishedDate" : DateTime.now(),
      "status" : "available",
      "thumbnailUrl" : downloadUrl,
      "title" : _titletextEditingController.text.trim(),
    });

    setState(() {
      file = null;
      uploading = false;
      productId = DateTime.now().millisecondsSinceEpoch.toString();
      _descriptiontextEditingController.clear();
      _titletextEditingController.clear();
      _shortinfotextEditingController.clear();
      _pricetextEditingController.clear();
    });
  }
}
