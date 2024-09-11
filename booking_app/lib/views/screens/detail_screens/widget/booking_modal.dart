import 'package:booking_app/controllers/seat_controller.dart';
import 'package:booking_app/models/train.dart';
import 'package:booking_app/services/manage_http_responses.dart';
import 'package:booking_app/views/screens/detail_screens/widget/front_train_widget.dart';
import 'package:booking_app/views/screens/detail_screens/widget/seat_card_details_widget.dart';
import 'package:booking_app/views/screens/detail_screens/widget/title_widget.dart';
import 'package:flutter/material.dart';

class BookingModal extends StatelessWidget {
  final TrainModel train;
  final String coach;

  const BookingModal({
    super.key,
    required this.train,
    required this.coach,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleWidget(title: "Coach $coach\'s seats"),
          const FrontTrainWidget(),
          SeatCardDetailsWidget(
            train: train,
            coach: coach,
          ),
          // const Spacer(),
          // Row(
          //   children: [
          //     const Spacer(),
          //     ElevatedButton(
          //       onPressed: () {
          //         //SeatController().bookSeat(train.id, train., owner);
          //         Navigator.pop(context);
          //         Navigator.pop(context);
          //         showSnackBar(context, 'Booking successful');
          //       },
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: const Color(0xCC0D6EFF),
          //         shadowColor: const Color(0xFF102DE1),
          //       ),
          //       child: const Text(
          //         'Confirm',
          //         style: TextStyle(letterSpacing: 1.5, color: Colors.white),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 50,
          //     )
          //   ],
          // ),
          // const Spacer()
        ],
      ),
    );
  }
}
