import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  const Ball({Key? key, this.color, required this.value}) : super(key: key);

  final Color? color;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for (int i = 0; i < 3; i++)
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.only(left: 10),
          child: Container(
            decoration: BoxDecoration(
              color: i + 1 <= value ? color : Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
    ]);
  }
}
