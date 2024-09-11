import 'dart:convert';

class TrainModel {
  final String id;
  final String plateNumber;
  final String startDateTime;
  final String waitingGate;
  final String fromLocation;
  final String toLocation;

  TrainModel({
    required this.id,
    required this.plateNumber,
    required this.startDateTime,
    required this.waitingGate,
    required this.fromLocation,
    required this.toLocation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "_id": id,
      "plateNumber": plateNumber,
      "startDateTime": startDateTime,
      "waitingGate": waitingGate,
      "fromLocation": fromLocation,
      "toLocation": toLocation
    };
  }

  String toJson() => json.encode(toMap());

  factory TrainModel.fromJson(Map<String, dynamic> map) {
    return TrainModel(
      id: map['_id'] as String,
      plateNumber: map['plateNumber'] as String,
      startDateTime: map['startDateTime'] as String,
      waitingGate: map['waitingGate'] as String,
      fromLocation: map['fromLocation'] as String,
      toLocation: map['toLocation'] as String,
    );
  }
}
