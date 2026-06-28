import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../services/database_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<ActivityModel> activities = [];

  @override
  void initState() {
    super.initState();
    loadActivities();
  }

  Future<void> loadActivities() async {
    activities = await DatabaseService.getActivities();
    setState(() {});
  }

  Future<void> deleteActivity(int id) async {
    await DatabaseService.deleteActivity(id);
    loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F0),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F6F0),
        title: const Text(
          "Activity History",
          style: TextStyle(color: Color(0xFF2D3748)),
        ),
      ),

      body: activities.isEmpty
          ? const Center(
              child: Text(
                "No Activities Found",
                style: TextStyle(color: Color(0xFF718096)),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];

                return Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFA8E6CF),
                      child: Icon(
                        Icons.fitness_center,
                        color: Color(0xFF4CAF88),
                      ),
                    ),
                    title: Text(
                      activity.activityName,
                      style: const TextStyle(
                        color: Color(0xFF2D3748),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${activity.steps} Steps | ${activity.calories} Calories | ${activity.duration} Min",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        deleteActivity(activity.id!);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
