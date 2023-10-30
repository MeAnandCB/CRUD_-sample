import 'dart:convert';

import 'package:api_sample/api_config/api_config.dart';
import 'package:api_sample/model/api_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HomeScreenControll with ChangeNotifier {
  EmployeesListResModel? employeeListResponse;
  List<Employee> employeesList = [];
  bool isLoading = false;

  getEmployeeList() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("${ApiConfig.baseUrl}api/addemployee/");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      print(response.body);
      employeeListResponse = EmployeesListResModel.fromJson(decodedData);
      employeesList = employeeListResponse?.employees ?? [];
    } else {
      print("Failed to load employees");
    }
    isLoading = false;

    notifyListeners();
  }

  addEmployeeList({required String name, required String des}) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("${ApiConfig.baseUrl}api/addemployee/");
    final response =
        await http.post(url, body: {"employee_name": name, "designation": des});

    if (response.statusCode == 200) {
      getEmployeeList();
    } else {
      print("Failed to load employees");
    }

    isLoading = false;

    notifyListeners();
  }

  updateEmployeeData(
      {required String id,
      required String newName,
      required String newdes}) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("${ApiConfig.baseUrl}api/addemployee/$id/");
    final response = await http
        .put(url, body: {"employee_name": newName, "designation": newdes});

    if (response.statusCode == 200) {
      getEmployeeList();
    } else {
      print("Failed to load employees");
    }

    isLoading = false;

    notifyListeners();
  }

  deleteEmployee({required String id}) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("${ApiConfig.baseUrl}api/addemployee/$id/");
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print("successfully deleted");
      getEmployeeList();
    } else {
      print("Failed to delete employees");
    }

    isLoading = false;

    notifyListeners();
  }
}
