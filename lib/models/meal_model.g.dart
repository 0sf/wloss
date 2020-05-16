// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealModelAdapter extends TypeAdapter<MealModel> {
  @override
  final typeId = 1;

  @override
  MealModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealModel(
      id: fields[0] as DateTime,
      foodTitle: fields[1] as String,
      portion: fields[2] as double,
      calories: fields[3] as double,
      amount: fields[4] as double,
      consumedCalorie: fields[5] as double,
      mealType: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MealModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.foodTitle)
      ..writeByte(2)
      ..write(obj.portion)
      ..writeByte(3)
      ..write(obj.calories)
      ..writeByte(4)
      ..write(obj.amount)
      ..writeByte(5)
      ..write(obj.consumedCalorie)
      ..writeByte(6)
      ..write(obj.mealType);
  }
}
