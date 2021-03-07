import 'dart:convert';
import 'dart:io';
import '../app_exceptions.dart';

import 'package:http/http.dart' as http;

class ApiHandler {
  final _openFDAUrl = "https://api.fda.gov/drug/label.json";
  final _medifyUrl = "";

  static String _token = "";

  /// Retrieve Data from with a post request
  Future<dynamic> getData(String url) async {
    var responseJson;

    try {
      final response = await http.get(_openFDAUrl + url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: _token
      });

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  /// Retrieve Data with a Get Request
  Future<dynamic> getPostData(String url, Map<String, dynamic> body) async {
    var responseJson;
    try {
      final response = await http.post(_openFDAUrl + url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            HttpHeaders.authorizationHeader: _token
          },
          body: jsonEncode(body));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  /// Decode the response into json, or throw an error if the response has an error status code
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body.toString());
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Communication Error with Server. StatusCode : ${response.statusCode}');
    }
  }

  /// Set the token
  setToken(String token) {
    _token = token;
  }
}
