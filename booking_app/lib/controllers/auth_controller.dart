import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:booking_app/models/user.dart';
import 'package:booking_app/global_variable.dart';
import 'package:booking_app/provider/user_provider.dart';
import 'package:booking_app/services/manage_http_responses.dart';
import 'package:http/http.dart' as http;
import 'package:booking_app/views/screens/authentication/login_screen.dart';
import 'package:booking_app/views/screens/main_screen.dart';

final providerContainer = ProviderContainer();

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      User user = User(
          id: '',
          fullName: fullName,
          email: email,
          state: '',
          city: '',
          locality: '',
          password: password,
          token: '');
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }),
            );
            showSnackBar(context, 'Account has been created for you');
          });
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () async {
            //access sharedPreferences for token and user data storage
            SharedPreferences preferences =
                await SharedPreferences.getInstance();

            //Extract the authentication token from response body
            String token = jsonDecode(response.body)['token'];

            //Store the token in shared preferences
            await preferences.setString('auth_token', token);

            //Encode the user data recieved from the server as json
            final userJson = jsonEncode(jsonDecode(response.body)['user']);

            // update the application state with the user data via riverpod
            providerContainer.read(userProvider.notifier).setUser(userJson);

            // store data in sharedPreference for future use
            await preferences.setString('user', userJson);

            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return MainScreen();
            }), (route) => false);
            showSnackBar(context, 'Logged In');
          });
    } catch (e) {
      print("Error: $e");
    }
  }

  //Signout
  Future<void> signOutUsers({required context}) async {
    try {
      // access sharedPreferences for token and user data storage
      SharedPreferences preferences = await SharedPreferences.getInstance();

      // remove the token from shared preferences
      await preferences.remove('auth_token');
      await preferences.remove('user');

      // clear user state
      providerContainer.read(userProvider.notifier).signOut();

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }), (route) => false);

      showSnackBar(context, 'Logged Out successfully');
    } catch (exception) {
      showSnackBar(context, 'error logging out');
    }
  }

  Future<void> getAuthToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    debugPrint('my token ${preferences.getString('auth_token')}');
  }

  Future<String> getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    // Retrieve the stored user data as a JSON string
    String? userDataString = preferences.getString('user');

    if (userDataString != null) {
      // Decode the JSON string to a map
      Map<String, dynamic> userMap = jsonDecode(userDataString);

      // Return the fullName from the map
      debugPrint('fullName: ' + userMap['fullName']);
      return userMap['fullName'].toString();
    } else {
     return '';
    }
  }
}
