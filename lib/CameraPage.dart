import 'package:flutter/material.dart';
import 'main.dart';
import 'MatchPage.dart';


class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            const Expanded(
              flex: 50,
              child: Image(
                  image: NetworkImage('https://media.tenor.com/kHcmsxlKHEAAAAAC/rock-one-eyebrow-raised-rock-staring.gif')
              ),

            ),
            Expanded(
              flex: 5,
              child: Column(
                  children: [
                    Text('Take a selfie in good lighting and show your full face')
                  ]
              ),
            ),
            Expanded(
              flex: 20,
              child: Row(

                  children: [
                    RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      },
                      elevation: 2.0,
                      fillColor: Colors.lightGreen,
                      child: Icon(
                        Icons.cancel_outlined,
                        size: 30,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),

                    RawMaterialButton(
                      onPressed: () {},
                      elevation: 2.0,
                      fillColor: Colors.lightGreen,
                      child: Icon(
                        Icons.autorenew,
                        size: 30,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),

                    RawMaterialButton(
                      onPressed: () {},
                      elevation: 2.0,
                      fillColor: Colors.lightGreen,
                      child: Icon(
                        Icons.add_a_photo,
                        size: 30,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),

                    RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MatchPage()),
                        );
                      },
                      elevation: 2.0,
                      fillColor: Colors.lightGreen,
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 30,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),


                  ]
              ),
            ),
          ],
        )
    );
  }
}

