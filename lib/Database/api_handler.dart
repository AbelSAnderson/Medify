import 'dart:convert';
import 'dart:io';
import '../app_exceptions.dart';

import 'package:http/http.dart' as http;

class ApiHandler {
  static final _openFDAApiHandler = ApiHandler._openFDAApi();
  static final _medifyAPIHandler = ApiHandler._medifyApi();

  String url;
  String _dataName;
  bool _useToken = false;
  String _token = "";

  // Singleton Pattern Factories
  factory ApiHandler.openFDA() {
    return _openFDAApiHandler;
  }

  factory ApiHandler.medifyAPI() {
    return _medifyAPIHandler;
  }

  ApiHandler._openFDAApi() {
    url = "https://api.fda.gov/drug/label.json";
    _dataName = "results";
  }

  ApiHandler._medifyApi() {
    url = "https://aanderson.scweb.ca/Medify-API/api/";
    _dataName = "data";
    _useToken = true;
    retrieveToken();
  }

  /// Retrieve Data from with a post request
  Future<dynamic> getData(String url, {bool filterResponse = true}) async {
    var responseJson;

    try {
      final response = await http.get(Uri.parse(this.url + url), headers: _getHeaders());
      print(response.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return filterResponse ? responseJson[_dataName] : responseJson;
  }

  /// Retrieve Data with a Get Request
  Future<dynamic> getPostData(String url, Map<String, dynamic> body, {bool filterResponse = true}) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(this.url + url), headers: _getHeaders(), body: jsonEncode(body));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return filterResponse ? responseJson[_dataName] : responseJson;
  }

  /// Retrieve Data with a Put Request
  Future<dynamic> getPutData(String url, Map<String, dynamic> body, {bool filterResponse = true}) async {
    var responseJson;
    try {
      final response = await http.put(Uri.parse(this.url + url), headers: _getHeaders(), body: jsonEncode(body));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return filterResponse ? responseJson[_dataName] : responseJson;
  }

  /// Retrieve Data with a Delete Request
  Future<dynamic> getDeleteData(String url, {bool filterResponse = true}) async {
    var responseJson;
    try {
      final response = await http.delete(Uri.parse(this.url + url), headers: _getHeaders());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return filterResponse ? responseJson[_dataName] : responseJson;
  }

  /// Decode the response into json, or throw an error if the response has an error status code
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body.toString());
      case 204:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException('Communication Error with Server. StatusCode : ${response.statusCode}');
    }
  }

  Map<String, String> _getHeaders() {
    if (_useToken) {
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: _token,
      };
    } else {
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
    }
  }

  /// Set the token
  setToken(String token) {
    _token = token;
  }

  /// Retrieve token from DB - needs to be changed
  retrieveToken() async {
    _token = "";
  }
}
