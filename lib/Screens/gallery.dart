import 'package:cam/Screens/image.dart';
import 'package:cam/functions/imglist.dart';
import 'package:cam/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: gallery,
          builder: (context, value, child) {
            return GridView.count(
              crossAxisCount: 3,
              children: List.generate(
                value.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(6),
                  child: InkWell(
                    onTap: () {
                      picture = XFile(value[index].path);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ImageViewer(),
                          ));
                    },
                    child: Image.file(
                      value[index],
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
