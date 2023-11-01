import 'package:cam/Screens/gallery.dart';
import 'package:cam/Screens/image.dart';
import 'package:cam/functions/imglist.dart';
import 'package:cam/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAcessDenied':
            break;
          default:
            break;
        }
      }
    });
    accessStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: CameraPreview(controller),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GalleryScreen(),
                          ));
                    },
                    icon: const Icon(
                      Icons.photo_camera_back,
                      size: 40,
                      color: Color.fromARGB(200, 255, 255, 255),
                    )),
                InkWell(
                  onTap: () async {
                    if (!controller.value.isInitialized) {
                      return;
                    }
                    if (controller.value.isTakingPicture) {
                      return;
                    }
                    try {
                      picture = await controller.takePicture();
                      addImage(picture);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ImageViewer(),
                          ));
                    } on CameraException catch (e) {
                      print('error has occured $e');
                      return;
                    }
                  },
                  child: const Icon(Icons.circle_outlined,
                      size: 90, color: Color.fromARGB(200, 255, 255, 255)),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ImageViewer()));
                    },
                    icon: const Icon(
                      Icons.image_sharp,
                      size: 30,
                      color: Color.fromARGB(200, 255, 255, 255),
                    )),
              ],
            )
          ],
        )
      ],
    ));
  }
}


// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key, required this.cameras});

//   final List<CameraDescription> cameras;

//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   int selectedCamera = 0;
//   List<File> capturedImages = [];

//   initializeCamera(int cameraIndex) async {
//     _controller =
//         CameraController(widget.cameras[cameraIndex], ResolutionPreset.medium);
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void initState() {
//     initializeCamera(selectedCamera);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Stack(
//               children: [
//                 SizedBox(
//                     height: double.infinity,
//                     width: double.infinity,
//                     child: CameraPreview(_controller)),
//                 // iveda icons ock add ack... positioned or align property use cheyth align cheytha mathi
//               ],
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final cameras = await availableCameras();
//   runApp(MyApp(
//     cameras: cameras,
//   ));
// }

// class MyApp extends StatelessWidget {
//   final List<CameraDescription> cameras;
//   const MyApp({super.key, required this.cameras});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: CameraScreen(cameras: cameras),
//     );
//   }
// }
