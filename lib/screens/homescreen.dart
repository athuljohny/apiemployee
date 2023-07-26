import 'package:apiemployee/model/employeedata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apiemployee/helperservices/helperservice.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Employee> employees = [];
  List<Employee> filteredEmployees = [];
  var isLoaded = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    employees = await HelperService.fetchEmployees();
    setState(() {
      isLoaded = true;
      filteredEmployees =
          employees; // Initially, set filteredEmployees to all employees
    });
  }

  void filterEmployees(String query) {
    List<Employee> tempEmployees = [];
    tempEmployees.addAll(employees);
    if (query.isNotEmpty) {
      List<Employee> filteredList = [];
      tempEmployees.forEach((employee) {
        if (employee.username.toLowerCase().contains(query.toLowerCase()) ||
            employee.email.toLowerCase().contains(query.toLowerCase())) {
          filteredList.add(employee);
        }
      });
      setState(() {
        filteredEmployees = filteredList;
      });
    } else {
      setState(() {
        filteredEmployees = employees; // If query is empty, show all employees
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text('Workers'),
      ),
      body: isLoaded
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      filterEmployees(value);
                    },
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search employees...",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredEmployees.length,
                    itemBuilder: (context, index) {
                      final employee = filteredEmployees[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              employee.profile_Image.toString(),
                            ),
                          ),
                          title: Text(employee.username),
                          subtitle: Text(employee.email),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
