import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:smssender/controllerpage.dart';

class Builda extends StatelessWidget {
  String value;
  final ContactController contactController = Get.find();
  Builda({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
        itemCount: contactController
            .allgroup[
                contactController.allgroup.indexWhere((a) => a.name == value)]
            .list
            .length,
        itemBuilder: (context, index) => ListTile(
          title: Text(contactController
              .allgroup[
                  contactController.allgroup.indexWhere((a) => a.name == value)]
              .list[index]),
        ),
      )),
    );
  }
}
