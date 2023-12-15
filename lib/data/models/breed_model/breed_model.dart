import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'breed_model.freezed.dart';
part 'breed_model.g.dart';

///
/// If you want to [immutable] class, you should use [@Freezed()]
///
/// If you want to [mutable] class, you should use [@unfreezed]
///
///
/// You can create another one class same like this class
///

@Freezed()
class BreedModel with _$BreedModel, EquatableMixin {
  const factory BreedModel({
    required String breedName,
    required List<String> subBreeds,
    String? imageUrl,
  }) = _BreedModel;

  const BreedModel._();

  factory BreedModel.fromJson(Map<String, dynamic> json) => _$BreedModelFromJson(json);

  @override
  List<Object?> get props => [
        breedName,
      ];
}
