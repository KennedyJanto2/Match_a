import 'ColorTheory.dart';
import 'package:flutter/material.dart';


class ColorMatches extends StatelessWidget {
  final Color selectedColor;

  ColorMatches({required this.selectedColor});

  List<Widget> buildMatchingColors() {
    // Replace this list with the matching colors you want to display
    List<Color> matchingColors = [
      selectedColor.withOpacity(0.2),
      selectedColor.withOpacity(0.4),
      selectedColor.withOpacity(0.6),
      selectedColor.withOpacity(0.8),
      selectedColor,
    ];

    return matchingColors
        .map(
          (color) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(width: 100, height: 100, color: color),
      ),
    )
        .toList();
  }

  List<Widget> buildContrastingColors() {
    // Replace this list with the matching colors you want to display
    List<Color> contrastingColors = [
      complementaryColor(selectedColor),
      ...analogousColors(selectedColor),
    ];

    return contrastingColors
        .map(
          (color) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(width: 100, height: 100, color: color),
      ),
    )
        .toList();
  }
  void _onSelectColorButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ColorDetailPage(selectedColor: selectedColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selected Color:', style: TextStyle(fontSize: 15)),
            SizedBox(height: 8),
            Container(width: 80, height: 80, color: selectedColor),
            SizedBox(height: 20),
            Text('Matching Colors:', style: TextStyle(fontSize: 15)),
            SizedBox(height: 8),
            Wrap(children: buildMatchingColors()),
            SizedBox(height: 20),
            Text('Contrasting Colors:', style: TextStyle(fontSize: 15)),
            SizedBox(height: 8),
            Wrap(children: buildContrastingColors()),
            SizedBox(height: 4),
            ElevatedButton(
              onPressed: () => _onSelectColorButtonPressed(context),
              child: Text('More Detail'),
            ),
          ],
        ),
      ),
    );
  }
}

Color complementaryColor(Color color) {
  return Color.fromARGB(
    color.alpha,
    255 - color.red,
    255 - color.green,
    255 - color.blue,
  );
}

List<Color> analogousColors(Color color, {int count = 3, double angle = 30}) {
  HSVColor hsvColor = HSVColor.fromColor(color);
  List<Color> colors = [];

  for (int i = 0; i < count; i++) {
    double hue = (hsvColor.hue + angle * (i + 1)) % 360;
    colors.add(HSVColor.fromAHSV(hsvColor.alpha, hue, hsvColor.saturation, hsvColor.value).toColor());
  }

  return colors;
}


class ColorDetailPage extends StatelessWidget {
  final Color selectedColor;

  ColorDetailPage({required this.selectedColor});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = ColorScheme(baseColor: selectedColor);

    return Scaffold(
      appBar: AppBar(
        title: Text('Color Detail'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Selected Color',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              color: selectedColor,
            ),
            SizedBox(height: 24),
            ColorSchemeCard(
              title: 'Complementary',
              colors: [
                selectedColor,
                colorScheme.complementary(),
              ],
              infoMessage: 'Complementary colors are opposite each other on the color wheel.',
            ),
            SizedBox(height: 16),
            ColorSchemeCard(
              title: 'Analogous',
              colors: [
                selectedColor,
                ...colorScheme.analogous(),
              ],
              infoMessage: 'Colors next to each other on the color wheel. They create a harmonious and unified look.',
            ),
            SizedBox(height: 16),
            ColorSchemeCard(
              title: 'Triadic',
              colors: [
                selectedColor,
                ...colorScheme.triadic(),
              ],
              infoMessage: 'Three colors evenly spaced on the color wheel. They provide balance and vibrancy.',
            ),
            SizedBox(height: 16),
            ColorSchemeCard(
              title: 'Split Complementary',
              colors: [
                selectedColor,
                ...colorScheme.splitComplementary(),
              ],
              infoMessage: 'A base color and two adjacent colors to its complement. Offers contrast without being too intense.',
            ),
            SizedBox(height: 16),
            ColorSchemeCard(
              title: 'Tetradic',
              colors: [
                selectedColor,
                ...colorScheme.tetradic(),
              ],
              infoMessage: 'Four colors forming a rectangle on the color wheel (two pairs of complements). Allows for diverse designs but requires careful color management.',
            ),
          ],
        ),
      ),
    );
  }
}

class ColorScheme {
  final Color baseColor;

  ColorScheme({required this.baseColor});

  Color complementary() {
    HSLColor hslColor = HSLColor.fromColor(baseColor);
    return hslColor.withHue((hslColor.hue + 180) % 360).toColor();
  }

  List<Color> analogous() {
    HSLColor hslColor = HSLColor.fromColor(baseColor);
    return [
      hslColor.withHue((hslColor.hue + 330) % 360).toColor(),
      hslColor.withHue((hslColor.hue + 30) % 360).toColor(),
    ];
  }

  List<Color> triadic() {
    HSLColor hslColor = HSLColor.fromColor(baseColor);
    return [
      hslColor.withHue((hslColor.hue + 120) % 360).toColor(),
      hslColor.withHue((hslColor.hue + 240) % 360).toColor(),
    ];
  }

  List<Color> splitComplementary() {
    HSLColor hslColor = HSLColor.fromColor(baseColor);
    return [
      hslColor.withHue((hslColor.hue + 150) % 360).toColor(),
      hslColor.withHue((hslColor.hue + 210) % 360).toColor(),
    ];
  }

  List<Color> tetradic() {
    HSLColor hslColor = HSLColor.fromColor(baseColor);
    return [
      hslColor.withHue((hslColor.hue + 90) % 360).toColor(),
      hslColor.withHue((hslColor.hue + 180) % 360).toColor(),
      hslColor.withHue((hslColor.hue + 270) % 360).toColor(),
    ];
  }
}

class InfoButton extends StatelessWidget {
  final String message;

  InfoButton({required this.message});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Info',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(message),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ColorSchemeCard extends StatelessWidget {
  final String title;
  final List<Color> colors;
  final String infoMessage;

  ColorSchemeCard({
    required this.title,
    required this.colors,
    required this.infoMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                InfoButton(message: infoMessage),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: colors
                  .map(
                    (color) => Container(
                  width: 50,
                  height: 50,
                  color: color,
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}



