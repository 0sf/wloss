import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/meal.dart';

class Prov {
  final CollectionReference userCollection =
      Firestore.instance.collection('user');

  List<Meal> _mealListFromSnapshot(QuerySnapshot snapshot) {
    print(snapshot.documents.toList().toString());
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

  Stream<List<Meal>> get meals {
    return userCollection
        .document()
        .collection('meal')
        .snapshots()
        .map(_mealListFromSnapshot);
  }
}
