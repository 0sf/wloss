class MealDetail {
  final int id;
  final String name;
  final int portion;
  final double calories;

  MealDetail({
    this.id,
    this.name,
    this.portion,
    this.calories,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    return MealDetail(
      id: json['id'],
      name: json['name'],
      portion: json['portion'],
      calories: json['calories'],
    );
  }
}
