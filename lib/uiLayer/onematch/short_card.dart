import 'package:flutter/material.dart';

class ShortCard extends StatelessWidget {
  final String a, b, c, d, e;
  final bool f;

  const ShortCard({
    super.key,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.e,
    this.f = false,
  });

  TextStyle getLabelStyle(bool highlight) => TextStyle(
    fontSize: 16,
    color: highlight ? Colors.blueGrey : Colors.black,
    fontWeight: highlight ? FontWeight.bold : FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(a, style: const TextStyle(fontSize: 14, color: Colors.grey)),

        const SizedBox(height: 10),
        Text(b, style: getLabelStyle(f)),

        const SizedBox(height: 15),
        Text(c, style: getLabelStyle(f)),

        const SizedBox(height: 20),
        Text(d, style: const TextStyle(fontSize: 14, color: Colors.grey)),

        const SizedBox(height: 10),
        Text(e, style: getLabelStyle(f)),
      ],
    );
  }
}
