// enum Exercise {
//   Running,
//   Jogging,
//   Walking,
//   Swimming,
//   Yoga,
//   Aerobics,
// }

class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final String firstName;
  final String lastName;
  final DateTime dob;
  final int age;
  final String gender;
  final double height;
  final double weight;
  final double activityFactor;
  final List<String> favoriteExcercise;

  UserData({
    this.uid,
    this.firstName,
    this.lastName,
    this.dob,
    this.age = 0,
    this.gender,
    this.height = 0,
    this.weight = 0,
    this.activityFactor = 0,
    this.favoriteExcercise,
  });
}
