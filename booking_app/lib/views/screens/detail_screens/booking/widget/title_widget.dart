import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          title,
          style: GoogleFonts.getFont(
            'Lato',
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
