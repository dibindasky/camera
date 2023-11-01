import 'dart:io';
import 'package:cam/main.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key});
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    File pic=File(picture.path);
    return Scaffold(
      appBar: AppBar(title: const Text('Image'),),
      body: Center(
        child: Image.file(pic),
      ),
    );
  }
}




