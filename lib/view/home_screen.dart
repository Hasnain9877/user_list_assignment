import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_list_assignment/controllers/user_controller.dart';
import 'package:user_list_assignment/view/add_user.dart';

class HomeScreen extends StatelessWidget {
  final UserController controller = Get.put(UserController());
  HomeScreen({super.key});
  final List<String> filterOptions = ['All', 'Male', 'Female', 'Pass', 'Fail'];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text(
            'Student Data',
            style: TextStyle(color: Colors.white, fontSize: 36),
          ),
        ),
        body: Obx(
          () => controller.userList.isEmpty
              ? Center(
                  child: Text(
                    "No users found",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(height: 10),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: filterOptions.map((option) {
                            final isSelected =
                                controller.filterOptions.value == option;
                            return GestureDetector(
                              onTap: () {
                                controller.filterbyDropdown(option);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 6),
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Divider(height: 2, thickness: 2),
                    SizedBox(height: 5),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        itemCount: controller.filtereduserList.length,
                        itemBuilder: (context, index) {
                          final user = controller.filtereduserList[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue.shade100,
                                child: Text(
                                  user.name[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                user.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  "🧍 ${user.gender}   🎂 Age: ${user.age}    🎓 Marks: ${user.marks}   ",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 13.5,
                                  ),
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  controller.removeUser(index);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddUserScreen());
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}












      // DropdownButton<String>(
      //                   value: controller.filterOptions.value.isEmpty
      //                       ? null
      //                       : controller.filterOptions.value,

      //                   items: ['All', 'Male', 'Female', 'Pass', 'Fail']
      //                       .map(
      //                         (value) => DropdownMenuItem(
      //                           value: value,
      //                           child: Text(value),
      //                         ),
      //                       )
      //                       .toList(),
      //                   onChanged: (value) {
      //                     if (value != null) {
      //                       controller.filterbyDropdown(value);
      //                     }
      //                   },
      //                 ),