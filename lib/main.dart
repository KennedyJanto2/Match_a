import 'package:flutter/material.dart';
import 'ColorTheory.dart';
import 'ColorTheoryNeutral.dart';
import 'MatchaLogo.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match-a',
      theme: ThemeData(

        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: 'Match-a Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 50,
            child: Image(
                image: NetworkImage('https://previews.123rf.com/images/viaire/viaire1906/viaire190600035/129770091-cute-cup-of-tea-matcha-matcha-japanese-powdered-green-tea-it-can-be-used-for-card-poster-brochures-a.jpg')
            ),
          ),
          Expanded(
            flex: 20,
            child: Column(
              children: [
                Text('Welcome!', style: TextStyle(height: 5, fontSize: 30, fontWeight: FontWeight.bold, color: Colors.lightGreen.withOpacity(0.9)))
              ],
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
                'Start',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
          Expanded(
            flex: 20,
            child: Column(
              children: const[
                Text('Created by Kennedy Janto', style: TextStyle(height: 10, fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      )
    );
    */
    return Scaffold(
      appBar: AppBar(
        title: Text('Match-a'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MatchaLogo(), // Add the MatchaLogo widget here
            SizedBox(height: 16),
            Text(
              'Welcome to Match-a',
              style: TextStyle(fontSize: 24),
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
                  'Start',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Match-a',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35),
              ),
            ),
            SizedBox(height: 20),
            MatchaLogo(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Hello! Use this app to find the best combination of colors. Select what type of color you want to match below: ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _navigateToPage(context, ColorTheory());
              },
              child: Text('Rainbow Color'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _navigateToPage(context, ColorTheoryNeutral());
              },
              child: Text('Neutral Color'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





