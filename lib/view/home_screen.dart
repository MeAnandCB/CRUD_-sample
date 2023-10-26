import 'package:api_sample/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeScreenControll>(context, listen: false).getEmployeeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeScreenprovider = Provider.of<HomeScreenControll>(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: homeScreenprovider.employeesList.length,
        itemBuilder: (context, index) => ListTile(
          title:
              Text(homeScreenprovider.employeesList[index].employeeName ?? ""),
          subtitle:
              Text(homeScreenprovider.employeesList[index].designation ?? ""),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.delete,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(onPressed: () {}, child: Text("Save")),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
