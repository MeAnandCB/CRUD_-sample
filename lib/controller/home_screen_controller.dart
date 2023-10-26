import 'dart:convert';

import 'package:api_sample/model/api_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HomeScreenControll with ChangeNotifier {
  EmployeesListResModel? employeeListResponse;
  List<Employee> employeesList = [];

  getEmployeeList() async {
    final url = Uri.parse("http://3.92.68.133:8000/api/addemployee/");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      print(response.body);
      employeeListResponse = EmployeesListResModel.fromJson(decodedData);
      employeesList = employeeListResponse?.employees ?? [];
    } else {
      print("Failed to load employees");
    }
    notifyListeners();
  }

  addEmployeeList() {
    getEmployeeList() async {
      final url = Uri.parse("http://3.92.68.133:8000/api/addemployee/");
      final response = await http.post(url, body: {});

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        print(response.body);
        employeeListResponse = EmployeesListResModel.fromJson(decodedData);
        employeesList = employeeListResponse?.employees ?? [];
      } else {
        print("Failed to load employees");
      }
      notifyListeners();
    }
  }

  updateEmployee() {}

  deleteEmployee() {}
}
