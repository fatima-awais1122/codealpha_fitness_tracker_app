import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../services/database_service.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _formKey = GlobalKey<FormState>();

  final activityController = TextEditingController();
  final stepsController = TextEditingController();
  final caloriesController = TextEditingController();
  final durationController = TextEditingController();

  Future<void> saveActivity() async {
    if (!_formKey.currentState!.validate()) return;

    await DatabaseService.insertActivity(
      ActivityModel(
        activityName: activityController.text,
        steps: int.parse(stepsController.text),
        calories: int.parse(caloriesController.text),
        duration: int.parse(durationController.text),
      ),
    );

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  InputDecoration field(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F0),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F6F0),
        title: const Text(
          "Add Activity",
          style: TextStyle(color: Color(0xFF2D3748)),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: activityController,
                decoration: field("Activity Name"),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: stepsController,
                keyboardType: TextInputType.number,
                decoration: field("Steps"),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: caloriesController,
                keyboardType: TextInputType.number,
                decoration: field("Calories"),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: durationController,
                keyboardType: TextInputType.number,
                decoration: field("Duration (Minutes)"),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveActivity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF88),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: const Text("Save Activity"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
