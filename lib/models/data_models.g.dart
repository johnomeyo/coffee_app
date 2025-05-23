// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FarmAdapter extends TypeAdapter<Farm> {
  @override
  final int typeId = 0;

  @override
  Farm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Farm(
      id: fields[0] as String,
      enumeratorName: fields[1] as String,
      kebeleName: fields[2] as String,
      woredaName: fields[3] as String,
      cooperativeName: fields[4] as String,
      farmerName: fields[5] as String,
      collectingCenterName: fields[6] as String,
      plotNumber: fields[7] as String,
      latitude: fields[8] as double,
      longitude: fields[9] as double,
      gpsAccuracy: fields[10] as double,
      plotSize: fields[11] as double,
      coffeeAge: fields[12] as int,
      coffeeType: fields[13] as String,
      disturbance: fields[14] as int,
      geolocationFlagged: fields[15] as bool,
      isApproved: fields[16] as bool,
      images: (fields[17] as List).cast<String>(),
      additionalInfo: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Farm obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.enumeratorName)
      ..writeByte(2)
      ..write(obj.kebeleName)
      ..writeByte(3)
      ..write(obj.woredaName)
      ..writeByte(4)
      ..write(obj.cooperativeName)
      ..writeByte(5)
      ..write(obj.farmerName)
      ..writeByte(6)
      ..write(obj.collectingCenterName)
      ..writeByte(7)
      ..write(obj.plotNumber)
      ..writeByte(8)
      ..write(obj.latitude)
      ..writeByte(9)
      ..write(obj.longitude)
      ..writeByte(10)
      ..write(obj.gpsAccuracy)
      ..writeByte(11)
      ..write(obj.plotSize)
      ..writeByte(12)
      ..write(obj.coffeeAge)
      ..writeByte(13)
      ..write(obj.coffeeType)
      ..writeByte(14)
      ..write(obj.disturbance)
      ..writeByte(15)
      ..write(obj.geolocationFlagged)
      ..writeByte(16)
      ..write(obj.isApproved)
      ..writeByte(17)
      ..write(obj.images)
      ..writeByte(18)
      ..write(obj.additionalInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FarmAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FarmerAdapter extends TypeAdapter<Farmer> {
  @override
  final int typeId = 1;

  @override
  Farmer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Farmer(
      id: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      registrationNumber: fields[3] as String,
      gender: fields[4] as String,
      dateOfBirth: fields[5] as DateTime,
      village: fields[6] as String,
      farms: (fields[7] as List).cast<Farm>(),
    );
  }

  @override
  void write(BinaryWriter writer, Farmer obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.registrationNumber)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.dateOfBirth)
      ..writeByte(6)
      ..write(obj.village)
      ..writeByte(7)
      ..write(obj.farms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FarmerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
