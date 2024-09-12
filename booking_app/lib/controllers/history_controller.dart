import 'dart:convert';

import 'package:booking_app/controllers/auth_controller.dart';
import 'package:booking_app/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:booking_app/models/train.dart';
import 'package:http/http.dart' as http;
import 'package:booking_app/global_variable.dart';

class HistoryController {
  // fetch banner
  Future<List<BookingModel>> loadHistory(String owner) async {
    try {
      String fullName = await AuthController().getUserData();

      http.Response response = await http.get(
          Uri.parse("$uri/api/seats-with-train/$fullName"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
          });

      debugPrint(response.body);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BookingModel> booking =
            data.map((train) => BookingModel.fromJson(train)).toList();
        return booking;
      } else {
        throw Exception('Failed to load Train');
      }
    } catch (e) {
      throw Exception('Error load Train');
    }
  }
}
