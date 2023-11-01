import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

ValueNotifier<List<File>>gallery=ValueNotifier([]);
Directory? externalDir;
late String folderName;
late String folderPath;

Future<void>accessStorage()async{
  externalDir = await getExternalStorageDirectory();
  createDirictory();
}

void addImage(XFile img){
  gallery.value.add(File(img.path));
  gallery.notifyListeners();
  addToDirectory(img);
 }

Future<void> createDirictory()async{
  folderName = "my_folder";
  folderPath = "${externalDir!.path}/$folderName";
  Directory(folderPath).createSync(recursive: true);  
  getImage();
}

Future<void> addToDirectory(XFile img)async{
  createDirictory();
  File imageFile = File(img.path);
  String fileName = imageFile.path.split('/').last;
  await imageFile.copy('$folderPath/$fileName');
  getImage();
}

Future<void> getImage()async{
  Directory folder = Directory(folderPath);
  List<FileSystemEntity> files = folder.listSync();
  gallery.value.clear();
  for(FileSystemEntity file in files){
    if(file is File){
      gallery.value.add(File(file.path));
    }
  }
  gallery.notifyListeners();
}

