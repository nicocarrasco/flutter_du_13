import 'package:flutter/material.dart';
import 'package:flutter_du_13/constants/colors.dart';

class BouncingLogo extends StatefulWidget {
  const BouncingLogo({super.key});

  @override
  State<BouncingLogo> createState() => _BouncingLogoState();
}

class _BouncingLogoState extends State<BouncingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _logoAnimation = Tween<double>(begin: 0.0, end: 40.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.20, curve: Curves.easeOut),
      ),
    );
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _animatedLogo(),
      ),
    );
  }

  Widget _animatedLogo() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontFamily: "Poppins",
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        children: <InlineSpan>[
          TextSpan(
            text: 'Flut',
            style: TextStyle(color: textColor, fontSize: _logoAnimation.value),
          ),
          TextSpan(
            text: 'Treize',
            style:
                TextStyle(color: primaryColor, fontSize: _logoAnimation.value),
          ),
        ],
      ),
    );
  }
}
