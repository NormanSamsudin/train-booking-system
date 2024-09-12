import 'dart:convert';

import 'package:booking_app/controllers/auth_controller.dart';
import 'package:booking_app/controllers/history_controller.dart';
import 'package:booking_app/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryCardWidget extends StatefulWidget {
  const HistoryCardWidget({super.key});

  @override
  State<HistoryCardWidget> createState() => _HistoryCardWidgetState();
}

class _HistoryCardWidgetState extends State<HistoryCardWidget> {
  late Future<List<BookingModel>> futureTrain;
  DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy, h:mm a');

  @override
  void initState() {
    super.initState();
    futureTrain = HistoryController().loadHistory('normansam');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8 - 32,
        child: FutureBuilder(
            future: futureTrain,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No booking available'),
                );
              } else {
                final bookings = snapshot.data!;
                return ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    final train = booking.train;
                    return Card(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Text(
                            "ETS",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From: ${train.fromLocation}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'To: ${train.toLocation}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Date: ${train.startDateTime}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Gate: ${train.waitingGate}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Name: ${booking.owner}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Seat: ${booking.seatNumber}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
