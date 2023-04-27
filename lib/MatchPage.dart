import 'package:flutter/material.dart';
import 'main.dart';
import 'CameraPage.dart';
import 'SavePage.dart';


class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 30,
              child: Column(
                  children: [
                    Text(''),
                    Text(''),
                    Text(''),
                    Text('Matches:'),
                    Text('These are the colors that matches you'),
                  ]
              ),
            ),
            Expanded(
                flex: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(width: 100, height: 100, color: Colors.red,),
                    Container(width: 100,height: 100,color: Colors.green,),
                    Container(width: 100,height: 100,color: Colors.blue,),
                  ],
                )
            ),
            Expanded(
              flex: 50,
              child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SavePage()),
                        );
                      },
                      child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CameraPage()),
                        );
                      },
                      child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        child: const Text(
                          'Rematch',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      },
                      child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        child: const Text(
                          'Home',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
          ],
        )
    );
  }
}