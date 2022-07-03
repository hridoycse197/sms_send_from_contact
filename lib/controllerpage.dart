import 'package:get/get.dart';

import 'model/groupmodel.dart';

class ContactController extends GetxController {
  var contacts = [].obs;
  var dropdownitem = [].obs;
  List<GroupModel> allgroup = [];
  void add(String note) {
    contacts.add(note);
  }
}

  // void remove(int index) {
  //   notes.removeAt(index);
  // }