import 'dart:ffi';

import 'package:booking_app/controllers/auth_controller.dart';
import 'package:booking_app/controllers/seat_controller.dart';
import 'package:booking_app/models/seat.dart';
import 'package:booking_app/models/train.dart';
import 'package:booking_app/services/manage_http_responses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeatCardDetailsWidget extends StatefulWidget {
  final TrainModel train;
  final String coach;

  const SeatCardDetailsWidget(
      {super.key, required this.train, required this.coach});

  @override
  State<SeatCardDetailsWidget> createState() => _SeatCardDetailsWidgetState();
}

class _SeatCardDetailsWidgetState extends State<SeatCardDetailsWidget> {
  late Future<List<SeatModel>> futureSeat;
  List<SeatModel> seat = [];
  List<SeatModel> selectedSeats = [];
  double price = 0;
  var fullName;

  @override
  void initState() {
    super.initState();
    fullName = AuthController().getUserData();
    futureSeat = SeatController().loadSeats(widget.train.id, widget.coach);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 15),
        child: SizedBox(
            height: 320,
            child: Column(
              children: [
                SizedBox(
                  height: 272,
                  child: FutureBuilder(
                    future: futureSeat,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Error: ${snapshot.error}"),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No trains available'),
                        );
                      } else {
                        seat = snapshot.data!;
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: 2.0),
                          itemCount: seat.length,
                          itemBuilder: (context, index) {
                            //declare colors
                            Color seatColor;

                            switch (seat[index].status) {
                              case 'available':
                                seatColor =
                                    Colors.green; // Available seats are green
                                break;
                              case 'locked':
                                seatColor =
                                    Colors.grey; // Locked seats are grey
                                break;
                              default:
                                seatColor =
                                    Colors.red; // Unavailable seats are red
                            }
                            return GridTile(
                              child: InkWell(
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.chair,
                                        color: seatColor,
                                        size: 35.0,
                                      ),
                                      Text(
                                        seat[index].seatNumber,
                                        style: GoogleFonts.getFont(
                                          'Lato',
                                          color: const Color(0xFF0d120E),
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.2,
                                          fontSize: 8,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  if (seat[index].status == 'available') {
                                    SeatController().lockSeat(widget.train.id,
                                        seat[index].seatNumber);
                                    setState(() {
                                      seat[index].status = 'locked';
                                      selectedSeats.add(
                                          seat[index]); // Add to selected seats
                                      price += double.parse(widget.train.price);
                                    });
                                  } else if (seat[index].status == 'locked') {
                                    if (selectedSeats.contains(seat[index])) {
                                      SeatController().unlockSeat(
                                          widget.train.id,
                                          seat[index].seatNumber);
                                      setState(() {
                                        seat[index].status = 'available';
                                        selectedSeats.remove(seat[
                                            index]); // Remove from selected seats
                                        price -=
                                            double.parse(widget.train.price);
                                      });
                                      selectedSeats.remove(seat[index]);
                                    } else {
                                      debugPrint("seat is not available");
                                      Navigator.of(context).pop();
                                      showSnackBar(context,
                                          'Seat have been locked by others');
                                    }
                                  } else {
                                    debugPrint("seat is not available");
                                    Navigator.of(context).pop();
                                    showSnackBar(context,
                                        'Seat have been booked by others');
                                  }
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      'Total: RM ${price.toString()}',
                      style: GoogleFonts.getFont(
                        'Lato',
                        color: const Color(0xFF0d120E),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                        fontSize: 15,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(204, 255, 255, 255),
                          shadowColor: const Color.fromARGB(255, 201, 201, 201),
                          foregroundColor: Colors.black),
                      child: const Text(
                        'Cancel',
                        style:
                            TextStyle(letterSpacing: 1.5, color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        for (var select in selectedSeats) {
                          debugPrint('${select.seatNumber} : ${select.status}');
                        }
                        SeatController()
                            .bookSeat(widget.train.id, selectedSeats, fullName);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        showSnackBar(context, 'Payment successful');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xCC0D6EFF),
                        shadowColor: const Color(0xFF102DE1),
                      ),
                      child: const Text(
                        'Pay Now',
                        style:
                            TextStyle(letterSpacing: 1.5, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ],
            )));
  }
}
