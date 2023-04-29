import 'package:flutter/material.dart';
import 'main.dart';
import 'MatchPage.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';
import 'ColorDetail.dart';

class ColorModel extends ChangeNotifier {
  Color? _dominantColor;

  Color? get dominantColor => _dominantColor;

  set dominantColor(Color? value) {
    _dominantColor = value;
    notifyListeners();
  }
}

List<CameraDescription> cameras = [];
/*
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ColorModel(),
      child: MyApp(),
    ),
  );
}
*/
class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    if (cameras.isNotEmpty) {
      _cameraController = CameraController(cameras[0], ResolutionPreset.max);
      _cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("No cameras available.");
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameras.isEmpty || !_cameraController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(title: Text('Take a Picture')),
        body: Center(child: Text('No cameras available')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('Take a Picture')),
      body: CameraPreview(_cameraController),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () async {
                final imgPath = await _cameraController.takePicture();
                File imageFile = File(imgPath.path);
                img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
                if (image != null) {
                  Color dominantColor = getDominantColor(image);
                  Provider.of<ColorModel>(context, listen: false).dominantColor =
                      dominantColor;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ColorMatches(selectedColor: dominantColor)));
                }
              },
              child: Icon(Icons.camera),
            ),
          ),
          Positioned(
            left: 30,
            bottom: 0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    );
  }


}

Color getDominantColor(img.Image image) {
  Map<Color, int> colorFrequency = {};

  for (int x = 0; x < image.width; x++) {
    for (int y = 0; y < image.height; y++) {
      int pixel32 = image.getPixel(x, y);
      Color pixelColor = Color(pixel32);

      if (colorFrequency.containsKey(pixelColor)) {
        colorFrequency[pixelColor] = colorFrequency[pixelColor]! + 1;
      } else {
        colorFrequency[pixelColor] = 1;
      }
    }
  }

  Color dominantColor = colorFrequency.entries
      .reduce((curr, next) => curr.value > next.value ? curr : next)
      .key;

  return dominantColor;
}

class DisplayColorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color? dominantColor = Provider.of<ColorModel>(context).dominantColor;

    return Scaffold(
      appBar: AppBar(title: Text('Dominant Color')),
      body: Container(
        color: dominantColor,
        child: Center(
          child: Text(
            'Dominant Color: ${dominantColor.toString()}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: dominantColor != null
                  ? ThemeData.estimateBrightnessForColor(dominantColor) ==
                  Brightness.dark
                  ? Colors.white
                  : Colors.black
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraScreen(),
    );
  }
}

