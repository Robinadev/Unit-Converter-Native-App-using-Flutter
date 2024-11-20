import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Api {
  final String baseUrl;

  Api({this.baseUrl = 'https://flutter.udacity.com'});

  Future<List<String>?> getUnits(String category) async {
    try {
      final uri = Uri.parse('$baseUrl/$category');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse is List) {
          return List<String>.from(jsonResponse);
        }
      } else {
        debugPrint('Failed to load units: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching units: $e');
    }
    return null;
  }

  Future<double?> convert({
    required String category,
    required String from,
    required String to,
    required double amount,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/$category/convert?from=$from&to=$to&amount=$amount');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse is Map && jsonResponse.containsKey('conversion')) {
          return jsonResponse['conversion'];
        }
      } else {
        debugPrint('Conversion failed: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error converting units: $e');
    }
    return null;
  }
}
