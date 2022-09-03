import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription>? cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phantom Drive',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Color(0xff151515),
          title: Text("Phantom Drive",
              style: TextStyle(
                  fontSize: 18, color: Colors.white, fontFamily: "Poppins")),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: InkWell(
                  onTap: (){},
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.width / 3,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        border: Border.all(
                            color: Color(0xffcd0000) /*Color(0xff1AC70B)*/,
                            width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                            Icons.drive_eta_rounded,
                            size: MediaQuery.of(context).size.width / 6,
                            color: Colors.white
                        ),
                        Text(
                          "Start Drive",
                          style: TextStyle(
                              fontSize: 18, color: Colors.white, fontFamily: "Poppins"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 2,
                indent: 30,
                endIndent: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (){},
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 40,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            border: Border.all(
                                color: Color(0xffcd0000) /*Color(0xff1AC70B)*/,
                                width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                  Icons.crisis_alert,
                                  size: MediaQuery.of(context).size.width / 8,
                                  color: Colors.white
                              ),
                              Text(
                                "SOS",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white, fontFamily: "Poppins"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 40,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            border: Border.all(
                                color: Color(0xffcd0000) /*Color(0xff1AC70B)*/,
                                width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                  Icons.map_outlined,
                                  size: MediaQuery.of(context).size.width / 8,
                                  color: Colors.white
                              ),
                              Text(
                                "MAP",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white, fontFamily: "Poppins"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
