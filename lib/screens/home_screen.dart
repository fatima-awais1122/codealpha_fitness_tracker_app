import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/activity_model.dart';
import '../services/database_service.dart';
import '../widgets/summary_card.dart';
import 'add_activity_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ActivityModel> activities = [];

  int totalSteps = 0;
  int totalCalories = 0;
  int totalDuration = 0;

  @override
  void initState() {
    super.initState();
    loadActivities();
  }

  Future<void> loadActivities() async {
    activities = await DatabaseService.getActivities();

    totalSteps = 0;
    totalCalories = 0;
    totalDuration = 0;

    for (var activity in activities) {
      totalSteps += activity.steps;
      totalCalories += activity.calories;
      totalDuration += activity.duration;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double progress = totalSteps / 10000;

    if (progress > 1) {
      progress = 1;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F0),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F6F0),
        centerTitle: true,
        title: const Text(
          "Fitness Tracker",
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Color(0xFF4CAF88)),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()),
              );

              loadActivities();
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4CAF88),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddActivityScreen()),
          );

          if (result == true) {
            loadActivities();
          }
        },
      ),

      body: RefreshIndicator(
        color: const Color(0xFF4CAF88),
        onRefresh: loadActivities,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              "Today's Progress 🌿",
              style: TextStyle(
                color: Color(0xFF2D3748),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            SummaryCard(
              title: "Total Steps",
              value: totalSteps.toString(),
              icon: Icons.directions_walk,
            ),

            const SizedBox(height: 15),

            SummaryCard(
              title: "Calories Burned",
              value: totalCalories.toString(),
              icon: Icons.local_fire_department,
            ),

            const SizedBox(height: 15),

            SummaryCard(
              title: "Workout Minutes",
              value: totalDuration.toString(),
              icon: Icons.timer,
            ),

            const SizedBox(height: 30),

            const Text(
              "Daily Goal (10,000 Steps)",
              style: TextStyle(
                color: Color(0xFF2D3748),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            LinearPercentIndicator(
              lineHeight: 22,
              percent: progress,
              barRadius: const Radius.circular(15),
              progressColor: const Color(0xFF4CAF88),
              backgroundColor: const Color(0xFFE0E0E0),
              center: Text("${(progress * 100).toStringAsFixed(0)}%"),
            ),

            const SizedBox(height: 30),

            const Text(
              "Recent Activities",
              style: TextStyle(
                color: Color(0xFF2D3748),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            if (activities.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    "No activities added yet",
                    style: TextStyle(color: Color(0xFF718096)),
                  ),
                ),
              ),

            ...activities.reversed
                .take(5)
                .map(
                  (activity) => Card(
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
                        "${activity.steps} Steps • ${activity.calories} Calories",
                        style: const TextStyle(color: Color(0xFF718096)),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
