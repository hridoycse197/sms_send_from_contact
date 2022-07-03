import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smssender/controllerpage.dart';
import 'package:smssender/create_group.dart';

import 'contact_page.dart';

class AddDatatoGroup extends StatelessWidget {
  int index1;
  TextEditingController addContactController = TextEditingController();
  AddDatatoGroup({Key? key, required this.index1}) : super(key: key);
  final ContactController contactController = Get.put(ContactController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                TextFormField(
                  controller: addContactController,
                  decoration: InputDecoration(hintText: 'add number here....'),
                ),
                ElevatedButton(
                  onPressed: () {
                    contactController.allgroup[index1].list
                        .add(addContactController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Creategroup(),
                        ));
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var permission = await Permission.contacts.status;
                    var permissionMessage = await Permission.sms.status;
                    if (!permission.isGranted) {
                      await Permission.contacts.request();
                    } else if (permission.isGranted) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ContactPage(
                          index1: index1,
                        ),
                      ));
                    }
                  },
                  child: Icon(Icons.phone),
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                child: ListView.builder(
                  itemCount: contactController.allgroup[index1].list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(
                              contactController.allgroup[index1].list[index]),
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
