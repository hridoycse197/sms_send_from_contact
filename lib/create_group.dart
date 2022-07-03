import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:smssender/add_data_to_group.dart';
import 'package:smssender/build.dart';
import 'package:smssender/controllerpage.dart';
import 'package:smssender/model/groupmodel.dart';
import 'package:excel_to_json/excel_to_json.dart';
import 'package:path_provider/path_provider.dart';

class Creategroup extends StatefulWidget {
  @override
  State<Creategroup> createState() => _CreategroupState();
}

class _CreategroupState extends State<Creategroup> {
  final ContactController contactController = Get.put(ContactController());
  String? drowpDownvalue;
  String? contents;
  void addGroupData(GroupModel model, String name) {
    setState(() {
      contactController.allgroup.add(model);
      contactController.dropdownitem.add(name);
    });
  }

  String listlength() {
    return contactController.allgroup.join();
  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/demoTextFile.txt'; // 3

    return filePath;
  }

  Future takeExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      GetStorage().write('excelFile', result);
    } else {
      // User canceled the picker
    }
  }

  TextEditingController groupnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  TextField(
                    controller: groupnameController,
                    decoration: InputDecoration(hintText: 'type here'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (contactController.dropdownitem
                            .contains(groupnameController.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(groupnameController.text)));
                        } else {
                          addGroupData(
                              GroupModel(
                                  name: groupnameController.text, list: []),
                              groupnameController.text);
                          print(listlength());
                        }
                      },
                      child: Text('add')),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      takeExcelFile();
                    },
                    child: Text('add excel'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.teal,
                    child: DropdownButton<String>(
                      value: drowpDownvalue,
                      style: TextStyle(color: Colors.red),
                      items:
                          contactController.dropdownitem.map((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          drowpDownvalue = value;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Builda(value: value!),
                              ));
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                child: ListView.builder(
                  itemCount: contactController.allgroup.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        elevation: 2,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddDatatoGroup(index1: index),
                                ));
                          },
                          title: Text(contactController.allgroup[index].name),
                          subtitle: Text(contactController
                              .allgroup[index].list.length
                              .toString()),
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
