import 'dart:convert';

import 'package:booking_app/models/seat.dart';
import 'package:flutter/material.dart';
import 'package:booking_app/models/train.dart';
import 'package:http/http.dart' as http;
import 'package:booking_app/global_variable.dart';

class SeatController {
  // fetch banner
  Future<List<SeatModel>> loadSeats(String param, String coach) async {
    try {
      http.Response response = await http.get(
          Uri.parse("$uri/api/seat/$param/$coach"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
          });

      debugPrint(response.body);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<SeatModel> trains =
            data.map((train) => SeatModel.fromJson(train)).toList();
        return trains;
      } else {
        throw Exception('Failed to load Train');
      }
    } catch (e) {
      throw Exception('Error load Train');
    }
  }

  Future<List<SeatModel>> lockSeat(
      String train, String seat) async {
    try {
      http.Response response =
          await http.patch(Uri.parse("$uri/api/seat/lock-seat"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=utf-8',
              },
              body: jsonEncode({
                'train': train,
                'seatNumber': seat,
                'status': 'locked',
              }));

      debugPrint(response.body);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<SeatModel> trains =
            data.map((train) => SeatModel.fromJson(train)).toList();
        return trains;
      } else {
        throw Exception('Failed to load Train');
      }
    } catch (e) {
      throw Exception('Error load Train');
    }
  }

    Future<List<SeatModel>> unlockSeat(String train, String seat) async {
    try {
      http.Response response =
          await http.patch(Uri.parse("$uri/api/seat/unlock-seat"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=utf-8',
              },
              body: jsonEncode({
                'train': train,
                'seatNumber': seat,
                'status': 'available',
              }));

      debugPrint(response.body);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<SeatModel> trains =
            data.map((train) => SeatModel.fromJson(train)).toList();
        return trains;
      } else {
        throw Exception('Failed to load Train');
      }
    } catch (e) {
      throw Exception('Error load Train');
    }
  }
}
