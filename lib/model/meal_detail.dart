class MealDetail {
  final int id;
  final String name;
  final int portion;
  final int calories;
  final String foodURL;
  final String state;

  MealDetail({
    this.id,
    this.name,
    this.portion,
    this.calories,
    this.foodURL,
    this.state,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    return MealDetail(
      id: json['id'],
      name: json['name'],
      portion: json['portion'],
      calories: json['calories'],
      foodURL: json['foodURL'],
      state: json['state'],
    );
  }
}
