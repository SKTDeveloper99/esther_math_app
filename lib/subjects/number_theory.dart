import 'package:flutter/material.dart';

class NumberTheoryPage extends StatefulWidget {
  const NumberTheoryPage({ super.key });

  @override
  State<NumberTheoryPage> createState() => _NumberTheoryPageState();
}

class _NumberTheoryPageState extends State<NumberTheoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Number Theory"),
        ],
      ),
    );
  }
}