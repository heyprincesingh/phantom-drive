import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:tflite/tflite.dart';

import 'main.dart';

class drive extends StatefulWidget {
  const drive({Key? key}) : super(key: key);

  @override
  State<drive> createState() => _driveState();
}

class _driveState extends State<drive> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';

  loadCamera(){
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value){
      if(!mounted)
        return;
      else{
        setState(() {
          cameraController!.startImageStream((imageStream){
            cameraImage = imageStream;
            runModel();
          });
        });
      }
    });
  }

  runModel()async{
    if(cameraImage!=null){
      //var predictions = await Tflite.runModelOnFrame(bytesList: cameraImage!planse)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera"),
      ),
    );
  }
}
