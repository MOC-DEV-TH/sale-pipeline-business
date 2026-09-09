import 'package:flutter/material.dart';

class TabLoading extends StatelessWidget {
  const TabLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 70),
      child: Center(child: CircularProgressIndicator(color: Color(0xFF00C65A))),
    );
  }
}