import 'package:get/get.dart';

class ContactController extends GetxController {
  var contacts = [].obs;

  void add(String note) {
    contacts.add(note);
  }
}

  // void remove(int index) {
  //   notes.removeAt(index);
  // }