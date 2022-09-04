import 'package:flutter/material.dart';

class sos extends StatefulWidget {
  const sos({Key? key}) : super(key: key);

  @override
  State<sos> createState() => _sosState();
}

class _sosState extends State<sos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xff151515),
        title: Text("Emergency SOS"),
      ),
      body: GestureDetector(
        onTap: ()=> showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              backgroundColor: Colors.white,
              //title: Center(child: Text("Report")),
              content: Container(
                height: 130,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                        autocorrect: false,
                        enableSuggestions: false,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          //fillColor: Color(0xFF262626),
                          hintText: "Enter contact no",
                          hintStyle: TextStyle(
                              fontFamily: "Tondo-light",
                              color: Colors.black,
                              fontSize: 15),
                          focusColor: Color(0xffd00000),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 20, right: 10, top: 20, bottom: 20),
                        ),
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        style: new TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Tondo-Light",
                        )
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffcd0000)
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("ADD CONTACT"))
                  ],
                ),
              ),
            )
        ),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle,color: Colors.grey.withOpacity(0.4),size: 150),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("ADD EMERGENCY CONTACTS",style: TextStyle(color: Colors.white,fontSize: 16),),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
