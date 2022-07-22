import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class InsertDB extends StatefulWidget {
  const InsertDB({Key? key}) : super(key: key);

  @override
  State<InsertDB> createState() => _InsertDBState();
}

class _InsertDBState extends State<InsertDB> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var cityController = TextEditingController();

  final databaseref = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              "Insert data",
              style: TextStyle(fontSize: 28),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                  labelText: "Name", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(
                  labelText: "Age", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: cityController,
              decoration: const InputDecoration(
                  labelText: "City", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 50,
            ),
            OutlinedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    ageController.text.isNotEmpty &&
                    cityController.text.isNotEmpty) {
                  insertData(nameController.text, ageController.text,
                      cityController.text);
                }
              },
              child: const Text(
                "Add",
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  void insertData(String name, String age, String city) {
     var key=databaseref.child("users").child("ListRegister").push().key;
    databaseref.child("users").child("ListRegister").child(key!).set({
      'id':key,
      'name': name,
      'age': age,
      'city': city,
    });
    nameController.clear();
    ageController.clear();
    cityController.clear();
  }
}
