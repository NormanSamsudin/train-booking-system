import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainCardWidget extends StatefulWidget {
  const TrainCardWidget({super.key});

  @override
  State<TrainCardWidget> createState() => _TrainCardWidgetState();
}

class _TrainCardWidgetState extends State<TrainCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(120.0),
        ),
        child: const ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text(
              "ETS",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          title: Text('Kuala Lumpur -> Padang Besar',
              style: TextStyle(color: Colors.white, fontSize: 15)),
          subtitle: Text(
            '10 September 2024 | 2.30 pm',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
