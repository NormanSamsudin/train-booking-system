import 'package:flutter/material.dart';
import 'package:booking_app/views/screens/nav_screens/widgets/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [HeaderWidget(),],
    ));
  }
}
