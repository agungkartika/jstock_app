import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  final String title;

  const Subtitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}
