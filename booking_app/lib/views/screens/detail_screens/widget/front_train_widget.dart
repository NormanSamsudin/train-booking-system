import 'package:flutter/material.dart';

class FrontTrainWidget extends StatelessWidget {
  const FrontTrainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  const SizedBox(
      height: 40,
      child: Column(
        children: [
          Divider(
              color: Colors.black,
              endIndent: 10,
              indent: 10
            ),
          Text('Front Train')
        ],
      ),
    );
  }
}
