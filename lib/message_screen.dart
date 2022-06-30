import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smssender/main.dart';
import 'package:telephony/telephony.dart';

import 'controllerpage.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key? key}) : super(key: key);
  final ContactController contactController = Get.find();
  late List<SmsMessage> messages;
  final Telephony telephony = Telephony.instance;
  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMessage();
  }

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
          child: FutureBuilder(
              future: _getMessage(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData == null) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      SmsMessage contact = snapshot.data[index];

                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          elevation: 1,
                          child: ListTile(
                            trailing: Icon(
                              Icons.check,
                              color: Colors.red,
                            ),
                            leading: CircleAvatar(child: Icon(Icons.man)),
                            title: Text(contact.address.toString()),
                            subtitle: Text(contact.body.toString()),
                          ),
                        ),
                      );
                    },
                  );
                }
              })),
    );
  }

  Future<List<SmsMessage>?> _getMessage() async {
    return await widget.telephony.getSentSms();
  }
}
