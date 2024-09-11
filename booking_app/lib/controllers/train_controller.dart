import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:booking_app/models/train.dart';
import 'package:http/http.dart' as http;
import 'package:booking_app/global_variable.dart';

class TrainController {
  // fetch banner
  Future<List<TrainModel>> loadTrains() async {
    try {
      http.Response response = await http
          .get(Uri.parse("$uri/api/train"), headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      });

      debugPrint(response.body);
      
      
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<TrainModel> trains =
            data.map((train) => TrainModel.fromJson(train)).toList();
        return trains;
      } else {
        throw Exception('Failed to load Train');
      }
    } catch (e) {
      throw Exception('Error load Train');
    }
  }
}
