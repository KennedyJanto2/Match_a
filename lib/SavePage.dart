import 'package:flutter/material.dart';
import 'main.dart';
import 'MatchPage.dart';

class SavePage extends StatelessWidget {
  const SavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 20,
              child: Column(
                  children: [
                    Text(''),
                    Text(''),
                    Text(''),
                    Text('Save:'),
                    Text('Enter information'),
                  ]
              ),
            ),
            Expanded(
                flex: 30,
                child: Column(
                    children: [
                      Text('Enter Name:', style: TextStyle(fontSize: 20)),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'First name, Last Name',
                        ),
                      ),
                      Text('Enter Date::', style: TextStyle(fontSize: 20)),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'XX/XX/XX',
                        ),
                      ),
                    ]
                )
            ),
            Expanded(
              flex: 30,
              child: Column(
                  children: [
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
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MatchPage()),
                        );
                      },
                      child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        child: const Text(
                          'Cancel',
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