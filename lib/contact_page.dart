import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smssender/main.dart';

import 'controllerpage.dart';

class ContactPage extends StatefulWidget {
  List numbers = [];
  ContactPage({Key? key}) : super(key: key);
  final ContactController contactController = Get.find();
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ),
          );
        },
      ),
      body: SafeArea(
          child: Container(
              child: FutureBuilder(
                  future: getcontact(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData == null) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Contact contact = snapshot.data[index];
                          return GestureDetector(
                            onTap: () {
                              if (widget.contactController.contacts
                                  .contains(contact.phones[0])) {
                                print('Number already added');
                              } else {
                                widget.contactController.add(contact.phones[0]);
                                print(contact.phones[0] + ' added');
                              }
                            },
                            child: Card(
                              elevation: 1,
                              child: ListTile(
                                leading: CircleAvatar(child: Icon(Icons.man)),
                                title: Text(contact.displayName),
                                subtitle: Text(contact.phones[0]),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }))),
    );
  }

  Future<Object> getcontact() async {
    var permission = await Permission.contacts.status;
    if (!permission.isGranted) {
      return await Permission.contacts.request();
    } else {
      return await FastContacts.allContacts;
    }
  }
}
