import 'package:flutter/material.dart';
import 'package:onlinenotify/logic/storage-provider.dart';
import 'package:provider/provider.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StorageProvider>(
        builder: (context, storage, _){
          return Scaffold(
            appBar: AppBar(
              title: Text('Images'),
            ),
            body: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: storage.media.length,
                  itemBuilder:(context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Image.network(storage.media[index].toString()),
                    ),
                  );
                  } ),
            ),
          );
        });
  }
}
