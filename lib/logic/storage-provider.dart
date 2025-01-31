import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageProvider extends ChangeNotifier{

File? imageFile;
final ImagePicker imagePicker = ImagePicker();

List<String>media = [];

Future<void>pickImage()async{
  final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
  if(image !=null){
    imageFile = File(image.path);
    notifyListeners();
  }
  notifyListeners();
}


Future<void>uploadImage(context)async{
  try{
    if(imageFile !=null){
      final fileName = DateTime.now().millisecondsSinceEpoch;
      final path = 'uploads/$fileName';
      await Supabase.instance.client.storage.from('image').upload(path, imageFile!).then((v){
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image Uploaded')));
        notifyListeners();
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No image to Upload')));
      notifyListeners();
    }
  }catch(e){
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fail to upload')));
    notifyListeners();
  }
  notifyListeners();
}


Future<List<String>>getAllImages()async{
  try{
    final response = await Supabase.instance.client.storage.from('image').list(path: 'uploads');
    if(response !=null){
      media = response.map((file){
        return Supabase.instance.client.storage.from('image').getPublicUrl('uploads/${file.name}');
      }).toList();
      print('Media $media');
      notifyListeners();
      return media;
    }
  }catch(e){
    print(e);
    notifyListeners();
    return [];
  }
  notifyListeners();
  return [];
}
}