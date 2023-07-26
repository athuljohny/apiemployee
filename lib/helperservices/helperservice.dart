import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:apiemployee/model/employeedata.dart';

class HelperService {
  List<Employee> employee = [];
  static Future<List<Employee>> fetchEmployees() async {
    var client = http.Client();
    var uri = "http://www.mocky.io/v2/5d565297300000680030a986";
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Employee> employee = data.map((e) => Employee.fromJson(e)).toList();

      return employee;
    } else {
      throw Exception('Failed to fetch employees');
    }
  }
}
