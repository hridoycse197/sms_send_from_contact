import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smssender/add_data_to_group.dart';
import 'package:smssender/main.dart';

import 'controllerpage.dart';

class ContactPage extends StatefulWidget {
  int index1;
  ContactPage({Key? key, required this.index1}) : super(key: key);
  final ContactController contactController = Get.find();

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
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
                            widget
                                .contactController.allgroup[widget.index1].list
                                .add(contact.phones[0]);

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
              })),
    );
  }

  Future<List> getcontact() async {
    print(FastContacts.allContacts);
    return await FastContacts.allContacts;
  }
}
