import 'package:flutter/material.dart';

class AlgebraPage extends StatefulWidget {
  const AlgebraPage({ super.key });

  @override
  State<AlgebraPage> createState() => _AlgebraPageState();
}

class _AlgebraPageState extends State<AlgebraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Algebra"),
        ],
      ),
    );
  }
}