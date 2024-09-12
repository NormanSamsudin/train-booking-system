import 'package:booking_app/models/train.dart';
import 'package:booking_app/views/screens/detail_screens/booking/booking_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:booking_app/controllers/train_controller.dart';
import 'package:intl/intl.dart';

class TrainCardWidget extends StatefulWidget {
  const TrainCardWidget({super.key});

  @override
  State<TrainCardWidget> createState() => _TrainCardWidgetState();
}

class _TrainCardWidgetState extends State<TrainCardWidget> {
  late Future<List<TrainModel>> futureTrain;
  DateFormat dateFormat = DateFormat('EEEE, MMMM d, yyyy, h:mm a');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureTrain = TrainController().loadTrains();
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
                  child: Text('No trains available'),
                );
              } else {
                final train = snapshot.data!;
                return ListView.builder(
                  itemCount: train.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Card(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(120.0),
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
                          title: Text(
                              '${train[index].fromLocation} -> ${train[index].toLocation}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15)),
                          subtitle: Text(
                            dateFormat.format(DateTime.parse(train[index].startDateTime)),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BookingDetailsScreen(train: train[index]),
                          ),
                        );
                        debugPrint('select train');
                      },
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
