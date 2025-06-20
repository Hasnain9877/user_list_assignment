import 'dart:convert';

import 'package:get/get.dart';
import 'package:user_list_assignment/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  RxList<UserModel> filtereduserList = <UserModel>[].obs;

  RxString searchGender = ''.obs;
  RxInt totalMales = 0.obs;
  RxInt totalFemales = 0.obs;
  RxInt passedCount = 0.obs;
  RxInt failedCount = 0.obs;

  //enter list of passed and failed users
  RxList<UserModel> passedUsers = <UserModel>[].obs;
  RxList<UserModel> failedUsers = <UserModel>[].obs;
  //enter data
  var userList = <UserModel>[].obs;
  final name = ''.obs;
  final marks = ''.obs;
  final age = ''.obs;
  final selectedGender = ''.obs;

  final genderOptions = ['Male', 'Female', 'Other'].obs;
  RxString filterOptions = 'All'.obs;

  void filterbyDropdown(String selected) {
    filterOptions.value = selected;
    switch (selected.toLowerCase()) {
      case 'male':
        filtereduserList.assignAll(
          userList.where((u) => u.gender.toLowerCase() == "male"),
        );
        break;
      case 'female':
        filtereduserList.assignAll(
          userList.where((u) => u.gender.toLowerCase() == "female"),
        );
        break;
      case 'pass':
        filtereduserList.assignAll(userList.where((u) => u.marks >= 40));

        break;
      case 'fail':
        filtereduserList.assignAll(userList.where((u) => u.marks < 40));

        break;
      case 'other':
        filtereduserList.assignAll(
          userList.where((u) => u.gender.toLowerCase() == "other"),
        );
        break;
      case 'all':
        filtereduserList.assignAll(userList);
        break;
      default:
        filtereduserList.assignAll(userList);
    }
  }

  //add user to the list
  void adduser() {
    if (name.value.isNotEmpty &&
        marks.value.isNotEmpty &&
        age.value.isNotEmpty &&
        selectedGender.value.isNotEmpty) {
      final user = UserModel(
        name: name.value,
        age: int.tryParse(age.value) ?? 0,
        marks: double.tryParse(marks.value) ?? 0,
        gender: selectedGender.value,
      );
      userList.add(user);
      saveToPrefs();
      clearFields();
    }
  }

  void clearFields() {
    name.value = '';
    marks.value = '';
    age.value = '';
    selectedGender.value = '';
  }

  void removeUser(int index) {
    userList.removeAt(index);
    saveToPrefs();
  }

  void saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedList = userList
        .map((e) => jsonEncode(e.toJson()))
        .toList();
    await prefs.setStringList('userList', encodedList);
  }

  void loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedList = prefs.getStringList('userList');

    if (encodedList != null) {
      userList.value = encodedList
          .map((e) => UserModel.fromJson(jsonDecode(e)))
          .toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadFromPrefs();
    ever(userList, (_) {
      filterbyDropdown(filterOptions.value);
    });
  }
}













//  void filteruserByGender(String query) {
//     searchGender.value = query;

//     totalMales.value = userList
//         .where((u) => u.gender.toLowerCase() == "male")
//         .length;
//     totalFemales.value = userList
//         .where((u) => u.gender.toLowerCase() == "female")
//         .length;

//     if (query.isEmpty) {
//       filtereduserList.assignAll(userList);
//       passedUsers.clear();
//       failedUsers.clear();
//       passedCount.value = 0;
//       failedCount.value = 0;
//     } else {
//       final result = userList
//           .where(
//             (user) => user.gender.toLowerCase().contains(query.toLowerCase()),
//           )
//           .toList();
//       filtereduserList.assignAll(result);

//       final passed = filtereduserList
//           .where((user) => user.marks >= 40)
//           .toList();
//       final failed = filtereduserList.where((user) => user.marks < 40).toList();

//       passedUsers.assignAll(passed);
//       failedUsers.assignAll(failed);
//       passedCount.value = passed.length;
//       failedCount.value = failed.length;
//     }
//   }