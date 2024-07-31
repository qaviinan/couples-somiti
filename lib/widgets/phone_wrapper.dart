import 'package:flutter/material.dart';

class PhoneSizedContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const PhoneSizedContainer({
    Key? key,
    required this.child,
    this.maxWidth = 600, // Default max width set to 400
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: child,
      ),
    );
  }
}