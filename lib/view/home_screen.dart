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

  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final homeScreenprovider = Provider.of<HomeScreenControll>(context);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: homeScreenprovider.isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: homeScreenprovider.employeesList.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                      homeScreenprovider.employeesList[index].employeeName ??
                          ""),
                  subtitle: Text(
                      homeScreenprovider.employeesList[index].designation ??
                          ""),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            nameController.text = homeScreenprovider
                                    .employeesList[index].employeeName ??
                                "";
                            desController.text = homeScreenprovider
                                    .employeesList[index].designation ??
                                "";
                            editBottomSheet(
                                context: context,
                                Id: homeScreenprovider
                                        .employeesList[index].id ??
                                    "");
                          },
                          icon: Icon(Icons.edit)),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          homeScreenprovider.deleteEmployee(
                              id: homeScreenprovider.employeesList[index].id
                                  .toString());
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => Container(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "name",
                            hintText: "Name"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: desController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Designation",
                            hintText: "Designation"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Provider.of<HomeScreenControll>(context,
                                    listen: false)
                                .addEmployeeList(
                                    name: nameController.text,
                                    des: desController.text);

                            nameController.clear();
                            desController.clear();
                            Navigator.pop(context);
                          },
                          child: Text("Save")),
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
      ),
    );
  }

  Future<dynamic> editBottomSheet(
      {required BuildContext context, required String Id}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          nameController.clear();
          desController.clear();
          return true;
        },
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "name",
                      hintText: "Name"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: desController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Designation",
                      hintText: "Designation"),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await Provider.of<HomeScreenControll>(context,
                              listen: false)
                          .updateEmployeeData(
                              newName: nameController.text,
                              newdes: desController.text,
                              id: Id);

                      nameController.clear();
                      desController.clear();
                      Navigator.pop(context);
                    },
                    child: Text("Update")),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
