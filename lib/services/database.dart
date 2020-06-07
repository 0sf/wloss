import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/meal.dart';
import '../model/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('user');

  // final CollectionReference mealCollection =
  //     Firestore.instance.collection('user').document().collection('meal');

  Future updateUserData({
    String firstName,
    String lastName,
    DateTime dob,
    String gender,
    double height,
    double weight,
    double activityFactor,
    List<String> favoriteExcercise,
    int age,
  }) async {
    return await userCollection.document(uid).setData({
      "firstName": firstName,
      "lastName": lastName,
      "dob": dob,
      "age": age,
      "gender": gender,
      "height": height,
      "weight": weight,
      "activityFactor": activityFactor,
      "favoriteExcercise": favoriteExcercise,
    }, merge: true);
  }

// Update Meal data
  Future updateMealData(
    DateTime foodID,
    String foodTitle,
    double portion,
    double caloriePortion,
    double calorieConsumed,
  ) async {
    return await userCollection
        .document(uid)
        .collection('meal')
        .document()
        .setData({
      "foodID": foodID,
      "foodTitle": foodTitle,
      "portion": portion,
      "caloriePortion": caloriePortion,
      "calorieConsumed": calorieConsumed,
    });
  }

  // Delete Meal Item.
  Future deleteMeal(String docId) async {
    await userCollection
        .document(uid)
        .collection('meal')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        documentID: snapshot.documentID,
        firstName: snapshot.data['firstName'],
        lastName: snapshot.data['lastName'],
        gender: snapshot.data['gender'],
        age: snapshot.data['age'],
        dob: DateTime.parse(snapshot.data['dob'].toDate().toString()),
        height: snapshot.data['height'],
        weight: snapshot.data['weight'],
        activityFactor: snapshot.data['activityFactor'],
        favoriteExcercise: List.from(snapshot.data['favoriteExcercise']) ?? []);
  }

  // brew list from snapshot
  List<Meal> _mealListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Meal(
        foodId: DateTime.parse(doc.data['foodID'].toDate().toString()) ?? '',
        foodName: doc.data['foodTitle'] ?? '',
        portion: doc.data['portion'] ?? 0,
        caloriePortion: doc.data['caloriePerPortion'] ?? 0,
        calorieConsumed: doc.data['calorieConsumed'] ?? 0,
        documentID: doc.documentID,
      );
    }).toList();
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  // Get Meal data Stream
  Stream<List<Meal>> get meals {
    return userCollection
        .document(uid)
        .collection('meal')
        .snapshots()
        .map(_mealListFromSnapshot);
  }
}
