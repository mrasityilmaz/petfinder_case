// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BreedModel _$$_BreedModelFromJson(Map<String, dynamic> json) =>
    _$_BreedModel(
      breedName: json['breedName'] as String,
      subBreeds:
          (json['subBreeds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_BreedModelToJson(_$_BreedModel instance) =>
    <String, dynamic>{
      'breedName': instance.breedName,
      'subBreeds': instance.subBreeds,
    };
