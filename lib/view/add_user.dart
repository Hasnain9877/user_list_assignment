import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_list_assignment/controllers/user_controller.dart';
import 'package:user_list_assignment/view/home_screen.dart';

class AddUserScreen extends StatelessWidget {
  final UserController controller = Get.put(UserController());

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final marksController = TextEditingController();

  AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Form Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// Name Field
                      TextField(
                        controller: nameController,
                        onChanged: (v) => controller.name.value = v,
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// Age Field
                      TextField(
                        controller: ageController,
                        onChanged: (v) => controller.age.value = v,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Age",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.cake_outlined),
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// Marks Field
                      TextField(
                        controller: marksController,
                        onChanged: (v) => controller.marks.value = v,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Marks",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.grade_outlined),
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// Gender Dropdown
                      Obx(
                        () => DropdownButtonFormField<String>(
                          value: controller.selectedGender.value.isEmpty
                              ? null
                              : controller.selectedGender.value,
                          items: controller.genderOptions
                              .map(
                                (gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(gender),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            controller.selectedGender.value = value ?? '';
                          },
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.wc_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// Submit Button
              ElevatedButton.icon(
                onPressed: () {
                  controller.adduser();
                  controller.saveToPrefs();
                  Get.to(HomeScreen());
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text("Add User", style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
