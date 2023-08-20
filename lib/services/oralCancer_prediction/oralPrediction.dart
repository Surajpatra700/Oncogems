// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls, prefer_const_literals_to_create_immutables

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

import '../../main.dart';

// class OralPrediction extends StatefulWidget {
//   @override
//   _OralPredictionState createState() => _OralPredictionState();
// }

// class _OralPredictionState extends State<OralPrediction> {
//   CameraController? cameraController;
//   CameraImage? cameraImage;
//   List? recognitionsList;

//   initCamera() {
//     cameraController = CameraController(cameras![0], ResolutionPreset.medium);
//     cameraController!.initialize().then((value) {
//       setState(() {
//         cameraController!.startImageStream((image) => {
//               cameraImage = image,
//               runModel(),
//             });
//       });
//     });
//   }

//   runModel() async {
//     recognitionsList = await Tflite.detectObjectOnFrame(
//       bytesList: cameraImage!.planes.map((plane) {
//         return plane.bytes;
//       }).toList(),
//       imageHeight: cameraImage!.height,
//       imageWidth: cameraImage!.width,
//       imageMean: 127.5,
//       imageStd: 127.5,
//       numResultsPerClass: 1,
//       threshold: 0.4,
//     );

//     setState(() {
//       cameraImage;
//     });
//   }

//   Future loadModel() async {
//     //Tflite.close();
//     await Tflite.loadModel(
//         model: "assets/models/model_unquant.tflite",
//         labels: "assets/models/labels.txt");
//   }

//   @override
//   void dispose() async{
//     super.dispose();

//     await cameraController!.dispose();
//     Tflite.close();
//   }

//   @override
//   void initState() {
//     super.initState();

//     loadModel();
//     initCamera();
//   }

//   List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
//     if (recognitionsList == null) return [];

//     double factorX = screen.width;
//     double factorY = screen.height;

//     Color colorPick = Colors.pink;

//     return recognitionsList!.map((result) {
//       return Positioned(
//         left: result["rect"]["x"] * factorX,
//         top: result["rect"]["y"] * factorY,
//         width: result["rect"]["w"] * factorX,
//         height: result["rect"]["h"] * factorY,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//             border: Border.all(color: Colors.pink, width: 2.0),
//           ),
//           child: Text(
//             "${result['detectedClass']} ${(result['confidenceInClass'] * 100).toStringAsFixed(0)}%",
//             style: TextStyle(
//               background: Paint()..color = colorPick,
//               color: Colors.black,
//               fontSize: 18.0,
//             ),
//           ),
//         ),
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     List<Widget> list = [];

//     list.add(
//       Positioned(
//         top: 0.0,
//         left: 0.0,
//         width: size.width,
//         height: size.height - 100,
//         child: Container(
//           height: size.height - 100,
//           child: (!cameraController!.value.isInitialized)
//               ? new Container()
//               : AspectRatio(
//                   aspectRatio: cameraController!.value.aspectRatio,
//                   child: CameraPreview(cameraController!),
//                 ),
//         ),
//       ),
//     );

//     if (cameraImage != null) {
//       list.addAll(displayBoxesAroundRecognizedObjects(size));
//     }

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: Container(
//           margin: EdgeInsets.only(top: 50),
//           color: Colors.black,
//           child: Stack(
//             children: list,
//           ),
//         ),
//       ),
//     );
//   }
// }

class OralPrediction extends StatefulWidget {
  const OralPrediction({super.key});

  @override
  State<OralPrediction> createState() => _OralPredictionState();
}

class _OralPredictionState extends State<OralPrediction> {
  bool isWorking = false;
  String result = "";
  CameraController?
      cameraController; // cameraController is used for establishing a connection to the device's camera that allows you to control the camera and display a preview of camera's feed.
  CameraImage? imgCamera;

  initCamera() {
    // created a camera controller
    // Usually the camera list is 2, 0 index is for rear camera & 1 index is for front camera
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    // initialized the controller
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        // Started image streaming
        cameraController!.startImageStream((imageFromStream) {
          if (!isWorking) {
            isWorking = true;
            imgCamera = imageFromStream;
            runModelOnStreamFrames();
          }
        });
      });
    });
  }

  // Loading Tflite model
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/model_unquant.tflite",
      labels: "assets/models/labels.txt",
    );
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  void dispose() {
    Tflite.close();
    cameraController!.dispose();
    super.dispose();
  }

  runModelOnStreamFrames() async {
    if (!mounted) {
      return; // Check if the widget is still mounted before calling setState
    }
    // recognize the image/video that is displayed in front of frame
    var recognition = await Tflite.runModelOnFrame(
      // image is a file & it can be converted into bytes
      // Converts image into bytes and stores it in a list/array
      bytesList: imgCamera!.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      imageHeight: imgCamera!.height,
      imageWidth: imgCamera!.width,
      numResults: 2,
    );
    result = "";
    recognition!.forEach((response) {
      // "toStringAsFixed" means string representation of the number upto 2 decimal places
      result += response["label"] +
          " " +
          (response["confidence"] as double).toStringAsFixed(2) +
          "\n\n";
    });
    if (mounted) {
      setState(() {
        result;
      });
    }
    isWorking = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "OSCC Detection",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  fontFamily: "poppins",
                  color: Colors.white),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xff294ea8),
                Color(0xff0c318c),
                Color(0xff496dc7),
                Color(0xff7697eb),
                Color(0xff4165bc),
              ])),
            ),
            centerTitle: true,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/cancerbg.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    // Center(
                    //   child: Container(
                    //     margin: EdgeInsets.only(top: 100),
                    //     height: 220,
                    //     width: 320,
                    //     child: Image.asset("assets/images/window.png"),
                    //   ),
                    // ),

                    Center(
                      child: TextButton(
                          onPressed: () {
                            initCamera();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 65),
                            height: 400,
                            width: 300,
                            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                            child: imgCamera == null
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    height: 400,
                                    width: 300,
                                    child: Icon(Icons.qr_code_scanner,
                                        color: Colors.white70, size: 150),
                                  )
                                : AspectRatio(
                                    aspectRatio:
                                        cameraController!.value.aspectRatio,
                                    child: CameraPreview(cameraController!),
                                  ),
                          )),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 55),
                    child: SingleChildScrollView(
                      child: Text(
                        result,
                        style: TextStyle(
                            backgroundColor: Colors.black87,
                            fontSize: 25,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
