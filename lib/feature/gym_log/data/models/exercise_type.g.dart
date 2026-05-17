// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseTypeAdapter extends TypeAdapter<ExerciseType> {
  @override
  final int typeId = 0;

  @override
  ExerciseType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExerciseType.arms;
      case 1:
        return ExerciseType.legs;
      case 2:
        return ExerciseType.chest;
      case 3:
        return ExerciseType.cardio;
      case 4:
        return ExerciseType.core;
      default:
        return ExerciseType.arms;
    }
  }

  @override
  void write(BinaryWriter writer, ExerciseType obj) {
    switch (obj) {
      case ExerciseType.arms:
        writer.writeByte(0);
        break;
      case ExerciseType.legs:
        writer.writeByte(1);
        break;
      case ExerciseType.chest:
        writer.writeByte(2);
        break;
      case ExerciseType.cardio:
        writer.writeByte(3);
        break;
      case ExerciseType.core:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
