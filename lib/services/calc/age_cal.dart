class AgeCalc {
  static int ageCalculator(DateTime birthDate) {
    var currentDate = DateTime.parse(DateTime.now().toString());
    var birthDatep = DateTime.parse(birthDate.toString());
    int age = currentDate.year - birthDatep.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}
