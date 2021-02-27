var breakfast = DateTime(
    DateTime.now().year, DateTime.now().month, DateTime.now().day, 09, 00, 0);

var lunch = DateTime(
    DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 00, 0);

var dinner = DateTime(
    DateTime.now().year, DateTime.now().month, DateTime.now().day, 19, 00, 0);

var breakfastTitle = "It's breakfast time ";
var lunchTitle = "It's lunch time";
var dinnerTitle = "It's dinner time ";

var breakfastBody = "Let's add your meal info to the app.";
var lunchBody = "Let's add your meal info to the app.";
var dinnerBody = "Let's add your meal info to the app.";

var dayAndTime = <DateTime>[breakfast, lunch, dinner];
var titles = <String>[breakfastTitle, lunchTitle, dinnerTitle];
var body = <String>[breakfastBody, lunchBody, dinnerBody];
