import 'dart:io';

import 'package:flutter/material.dart';
import 'package:onlinenotify/logic/storage-provider.dart';
import 'package:onlinenotify/screens/uploading/listing-screen.dart';
import 'package:provider/provider.dart';

class PickScreen extends StatefulWidget {
  const PickScreen({super.key});

  @override
  State<PickScreen> createState() => _PickScreenState();
}

class _PickScreenState extends State<PickScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StorageProvider>(builder: (context,storage,_){
      return Scaffold(
        appBar: AppBar(
          title: Text('Supabase'),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ListingScreen()));
            }, icon: Icon(Icons.image))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            storage.imageFile!=null?Container(
              height: 200,
              width: 200,
              child: Image.file(storage.imageFile!),
            ):SizedBox(),

            SizedBox(height: 10,),

            ElevatedButton(
                onPressed: storage.pickImage, child: Text('Pick Image')),
            SizedBox(height: 10,),

            ElevatedButton(
                onPressed: (){
                  storage.uploadImage(context);
                }, child: Text('Upload Image'))
          ],
        ),
      );
    });
  }
}
