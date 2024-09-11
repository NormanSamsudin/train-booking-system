import 'package:booking_app/controllers/seat_controller.dart';
import 'package:booking_app/models/seat.dart';
import 'package:booking_app/models/train.dart';
import 'package:booking_app/services/manage_http_responses.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    futureSeat = SeatController().loadSeats(widget.train.id, widget.coach);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: SizedBox(
            height: 300,
            child: Column(
              children: [
                SizedBox(
                  height: 250,
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
                            crossAxisCount: 4, // 2 items per row
                            crossAxisSpacing: 30.0,
                            mainAxisSpacing: 8.0,
                          ),
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
                                  child: Icon(
                                    Icons.chair,
                                    color: seatColor,
                                    size: 65.0,
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
                                    });
                                  } else if (seat[index].status == 'locked') {
                                    // SeatController().unlockSeat(
                                    //     widget.train.id, seat[index].seatNumber);
                                    // setState(() {
                                    //   seat[index].status = 'available';
                                    //   selectedSeats.remove(
                                    //       seat[index]); // Remove from selected seats
                                    // });
                                    debugPrint("seat is not available");
                                    Navigator.of(context).pop();
                                    showSnackBar(context,
                                        'Seat have been locked by others');
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
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        SeatController().bookSeat(widget.train.id, selectedSeats, 'NormanSamsudin');
                        Navigator.pop(context);
                        Navigator.pop(context);
                        showSnackBar(context, 'Booking successful');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xCC0D6EFF),
                        shadowColor: const Color(0xFF102DE1),
                      ),
                      child: const Text(
                        'Confirm',
                        style:
                            TextStyle(letterSpacing: 1.5, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    )
                  ],
                ),
                const Spacer()
              ],
            )));
  }
}
