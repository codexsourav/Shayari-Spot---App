// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;

class AirtableDb {
  final apiKey =
      'patWFKdnFTr5A2qYN.c7fcac31e0673b2c6020b7a8871f8dd9504a603cf43d00837dff93caec857f54';
  final projectBase = 'appxjxtKhHDutkt2C';
  var apiUri = 'https://api.airtable.com/v0/';
  final query = '?filterByFormula=';

  AirtableDb._privateCostractor();
  static final AirtableDb instense = AirtableDb._privateCostractor();

// set Header
  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $apiKey",
      };

  Future getApiData({tblname = 'public'}) async {
    // ignore: prefer_interpolation_to_compose_strings
    var response = await http.get(Uri.parse('$apiUri$projectBase/' + tblname),
        headers: headers);
    if (response.statusCode == 200) {
      var convertDataToJson = json.decode(response.body);

      return convertDataToJson['records'];
    } else {
      return [];
    }
  }
}
