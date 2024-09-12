import 'dart:convert';

import 'package:booking_app/models/train.dart';

class BookingModel {
  final String id;
  final TrainModel train;
  final String seatNumber;
  final String status;
  final String owner;

  BookingModel({
    required this.id,
    required this.train,
    required this.seatNumber,
    required this.status,
    required this.owner,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "_id": id,
      "train": train,
      "seatNumber": seatNumber,
      "status": status,
      "owner": owner
    };
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(Map<String, dynamic> map) {
    return BookingModel(
        id: map['_id'] as String,
        train: TrainModel.fromJson(map['train']),
        seatNumber: map['seatNumber'] as String,
        status: map['status'] as String,
        owner: map['owner'] as String);
  }
}
