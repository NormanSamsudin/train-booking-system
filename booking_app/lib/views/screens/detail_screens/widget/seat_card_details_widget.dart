import 'package:flutter/material.dart';

class SeatCardDetailsWidget extends StatelessWidget {
  const SeatCardDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          child: Icon(
            Icons.chair,
            color: Colors.pink,
            size: 65.0,
          ),
        ),
        SizedBox(
          child: Icon(
            Icons.chair,
            color: Colors.pink,
            size: 60.0,
          ),
        ),
        SizedBox(
          child: Icon(
            Icons.chair,
            color: Colors.pink,
            size: 65.0,
          ),
        ),
        SizedBox(
          child: Icon(
            Icons.chair,
            color: Colors.pink,
            size: 65.0,
          ),
        ),
        SizedBox(
          child: Icon(
            Icons.chair,
            color: Colors.pink,
            size: 65.0,
          ),
        ),
      ],
    );
  }
}
