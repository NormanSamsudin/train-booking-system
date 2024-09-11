import 'package:booking_app/views/screens/detail_screens/widget/coach_widget.dart';
import 'package:booking_app/views/screens/detail_screens/widget/seat_card_details_widget.dart';
import 'package:booking_app/views/screens/detail_screens/widget/title_widget.dart';
import 'package:booking_app/views/screens/detail_screens/widget/train_card_detail_widget.dart';
import 'package:booking_app/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:booking_app/models/train.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingDetailsScreen extends StatelessWidget {
  final TrainModel train;
  const BookingDetailsScreen({required this.train});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Booking Page',
            style: GoogleFonts.getFont(
              'Lato',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
              fontSize: 23,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xFF102DE1), Color(0xCC0D6EFF)])),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TitleWidget(title: 'Train Details'),
                TrainCardDetailWidget(train: train),
                const TitleWidget(title: 'Select Coach'),
                CoachWidget(
                  train: train,
                ),

              ],
            ),
          ),
        ));
  }
}
