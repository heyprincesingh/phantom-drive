import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:phantom_drive/main.dart';
import 'package:tflite/tflite.dart';
import 'package:audioplayers/audioplayers.dart';

class drive extends StatefulWidget {
  const drive({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<drive> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  int counter = 0;

  bool alertOpen = false;

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadmodel();
    setAudio();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
    counter = 0;
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    final player = AudioCache(prefix: 'assets/');
    final url = await player.load('beep.mp3');
    audioPlayer.setSourceUrl(url.path);
  }

  loadCamera() {
    cameraController = CameraController(cameras![1], ResolutionPreset.high);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((imageStream) {
            cameraImage = imageStream;
            runModel();
          });
        });
      }
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true);
      predictions!.forEach((element) {
        setState(() {
          if (element['label'] == "Sleep" && alertOpen == false)
            counter++;
          else {
            counter = 0;
            alertOpen = false;
          }

          if (counter > 5 && isPlaying == false && alertOpen == false) {
            audioPlayer.resume();
            alertOpen = true;
            showDialog(
                context: context,
                builder: (ctx) => Dialog(
                      backgroundColor: Colors.transparent,
                      //title: Center(child: Text("Report")),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffcd0000),
                            border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(25)),
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.taxi_alert,
                              size: 50,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "WAKE UP",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    minimumSize: Size(
                                        120,
                                        40)),
                                onPressed: () {
                                  audioPlayer.pause();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "STOP",
                                  style: TextStyle(color: Colors.black,fontFamily: "Poppins",fontSize: 18),
                                ))
                          ],
                        ),
                      ),
                    ));
          }
          output = element['label'];
        });
      });
    }
  }

  loadmodel() async {
    await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: !cameraController!.value.isInitialized
                    ? Center(
                        child:
                            CircularProgressIndicator(color: Color(0xffcd0000)))
                    : Container(
                        color: Color(0xffcd0000),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.width,
                            child: AspectRatio(
                              aspectRatio: cameraController!.value.aspectRatio,
                              child: CameraPreview(cameraController!),
                            ),
                          ),
                        ),
                      ),
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                    color: Colors.white10,
                    border: Border.all(
                        color: Color(0xffcd0000) /*Color(0xff1AC70B)*/,
                        width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: Text(
                    output,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
