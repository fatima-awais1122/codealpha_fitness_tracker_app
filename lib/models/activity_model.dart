class ActivityModel {
  int? id;
  String activityName;
  int steps;
  int calories;
  int duration;

  ActivityModel({
    this.id,
    required this.activityName,
    required this.steps,
    required this.calories,
    required this.duration,
  });

  // Jab insert karte ho to id ko include nahi karna
  Map<String, dynamic> toMap() {
    return {
      'activityName': activityName,
      'steps': steps,
      'calories': calories,
      'duration': duration,
    };
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['id'],
      activityName: map['activityName'],
      steps: map['steps'],
      calories: map['calories'],
      duration: map['duration'],
    );
  }
}
