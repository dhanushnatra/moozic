import 'package:flutter/material.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  double streamloc = 0.0;
  onchanged(value) {
    setState(() {
      streamloc = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream<int>.periodic(
        const Duration(seconds: 1),
        (count) => count,
      ).take(100),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Slider(
            value: snapshot.data!.toDouble(),
            onChanged: (value) => onchanged(value),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
