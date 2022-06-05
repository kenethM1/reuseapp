import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class restClient {
  String baseUrl = "192.168.31.148";
  String url;
  final String method;
  final Map<String, String> headers;
  final Map<String, dynamic>? body;
  Map<String, dynamic> query;
  Uri? uri;

  restClient(
      {this.baseUrl = "192.168.31.148",
      required this.url,
      required this.method,
      required this.headers,
      this.body,
      this.query = const {},
      this.uri});

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
    } else if (method == 'GET-URI') {
      var newUri = uri!.replace(host: baseUrl, port: 4000);
      response = await http.get(newUri!, headers: headers);
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
