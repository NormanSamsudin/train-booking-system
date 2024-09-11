import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FrontTrainWidget extends StatelessWidget {
  const FrontTrainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Column(
        children: [
          const Divider(color: Colors.black, endIndent: 10, indent: 10),
          Text(
            'Front train',
            style: GoogleFonts.getFont(
              'Lato',
              color: const Color(0xFF0d120E),
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
              fontSize: 21,
            ),
          ),
        ],
      ),
    );
  }
}
