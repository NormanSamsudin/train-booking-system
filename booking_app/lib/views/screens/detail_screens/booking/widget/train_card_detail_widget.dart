import 'package:booking_app/models/train.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TrainCardDetailWidget extends StatelessWidget {
  final TrainModel train;

  const TrainCardDetailWidget({super.key, required this.train});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy, h:mm a');
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 15),
        child: SizedBox(
            height: 360,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.black,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/images/ets.jpeg',
                      height: 200,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Plate Number : ${train.plateNumber}',
                            style: GoogleFonts.getFont(
                              'Lato',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'From : ${train.fromLocation}',
                            style: GoogleFonts.getFont(
                              'Lato',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'To : ${train.toLocation}',
                            style: GoogleFonts.getFont(
                              'Lato',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Date : ${dateFormat.format(DateTime.parse(train.startDateTime))}',
                            style: GoogleFonts.getFont(
                              'Lato',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Gate : ${train.waitingGate}',
                            style: GoogleFonts.getFont(
                              'Lato',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
