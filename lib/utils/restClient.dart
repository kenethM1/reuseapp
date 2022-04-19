import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class restClient {
  String baseUrl = "192.168.31.126";
  String url;
  final String method;
  final Map<String, String> headers;
  final Map<String, dynamic> body;
  Map<String, dynamic> query;

  restClient({
    this.baseUrl = "192.168.31.126",
    required this.url,
    required this.method,
    required this.headers,
    required this.body,
    this.query = const {},
  });

  Future<dynamic> execute() async {
    var response;
    var url = Uri(
      scheme: 'http',
      port: 4000,
      host: baseUrl,
      path: this.url,
    );
    if (method == 'GET') {
      response = await http.get(url, headers: headers);
    } else if (method == 'POST') {
      response =
          await http.post(url, headers: headers, body: json.encode(body));
    } else if (method == 'PUT') {
      response = await http.put(url, headers: headers, body: json.encode(body));
    } else if (method == 'DELETE') {
      response = await http.delete(url, headers: headers);
    } else {
      throw Exception('Invalid method');
    }
    return response;
  }
}
