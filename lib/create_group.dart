import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:smssender/model/groupmodel.dart';
import 'package:excel_to_json/excel_to_json.dart';

class Creategroup extends StatefulWidget {
  @override
  State<Creategroup> createState() => _CreategroupState();
}

class _CreategroupState extends State<Creategroup> {
  List<GroupModel> allgroup = [];
  String? contents;
  void addGroupData(GroupModel model) {
    setState(() {
      allgroup.add(model);
    });
  }

  Future<String?> readTable() async {
    try {
      final file = File(GetStorage().read('excelFile'));

      // Read the file
      contents = await file.readAsString();
      print(contents);
      return contents;
    } catch (e) {
      // If we encounter an error, return empty string
      return "";
    }
  }

  Future takeExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['XLS', 'XLSX', 'XLSM', 'XLSB'],
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
              flex: 1,
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
                        addGroupData(
                          GroupModel(name: groupnameController.text, list: []),
                        );
                      },
                      child: Text('add')),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        takeExcelFile();
                        readTable();
                      },
                      child: Text('add excel')),
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
                  itemCount: allgroup.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        elevation: 2,
                        child: GestureDetector(
                          onTap: () {},
                          child: ListTile(
                            title: Text(allgroup[index].name),
                            subtitle:
                                Text(allgroup[index].list.length.toString()),
                          ),
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
