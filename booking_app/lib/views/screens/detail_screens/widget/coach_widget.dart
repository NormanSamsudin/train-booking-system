import 'package:booking_app/models/train.dart';
import 'package:booking_app/views/screens/detail_screens/widget/booking_modal.dart';
import 'package:flutter/material.dart';

class CoachWidget extends StatelessWidget {
  final TrainModel train;
  const CoachWidget({super.key, required this.train});

  @override
  Widget build(BuildContext context) {
    final List<String> items = ['A', 'B', 'C', 'D', 'E', 'F'];

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: SizedBox(
        height: 250,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 2 items per row
            crossAxisSpacing: 30.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: items.length,
          //padding: const EdgeInsets.all(10.0),
          itemBuilder: (context, index) {
            return GridTile(
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: const LinearGradient(
                          colors: [Color(0xFF102DE1), Color(0xCC0D6EFF)])),
                  child: Center(
                    child: Text(
                      'Coach ${items[index]}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                onTap: () {
                  //print('Item ${items[index]} clicked');
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return BookingModal(train: train, coach: items[index].toString());
                      });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
