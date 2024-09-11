import 'dart:convert';

class SeatModel {
  final String id;
  final String train;
  final String seatNumber;
  String status;
  final String owner;

  SeatModel({
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

  factory SeatModel.fromJson(Map<String, dynamic> map) {
    return SeatModel(
      id: map['_id'] as String,
      train: map['train'] as String,
      seatNumber: map['seatNumber'] as String,
      status: map['status'] as String,
      owner: map['owner'] as String
    );
  }
}
