import 'package:flutter/material.dart';
import 'package:flutter_note/presentation/screen/ui/palette.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    const colors = Palette.mainColors;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          children: List.generate(
            colors.length,
            (index) {
              final color = colors[index];

              return Container(
                padding: const EdgeInsets.all(10),
                height: 44,
                color: color,
              );
            },
          ),
        ),
      ),
    );
  }
}
