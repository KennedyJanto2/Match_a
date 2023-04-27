import 'package:flutter/material.dart';

class MatchaLogo extends StatefulWidget {
  @override
  _MatchaLogoState createState() => _MatchaLogoState();
}

class _MatchaLogoState extends State<MatchaLogo> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 200,
        child: Stack(
          children: [
            _buildCup(),
            _buildMatcha(),
          ],
        ),
      ),
    );
  }

  Widget _buildCup() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.brown,
          width: 5,
        ),
      ),
    );
  }

  Widget _buildMatcha() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: _controller.duration!,
      curve: Curves.easeInOut,
      builder: (BuildContext context, double value, Widget? child) {
        return Align(
          alignment: Alignment.lerp(
            Alignment.bottomCenter,
            Alignment.topCenter,
            value,
          )!,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.shade700,
            ),
          ),
        );
      },
      child: null,
    );
  }

}
