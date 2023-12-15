// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'breed_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BreedModel _$BreedModelFromJson(Map<String, dynamic> json) {
  return _BreedModel.fromJson(json);
}

/// @nodoc
mixin _$BreedModel {
  String get breedName => throw _privateConstructorUsedError;
  List<String> get subBreeds => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BreedModelCopyWith<BreedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BreedModelCopyWith<$Res> {
  factory $BreedModelCopyWith(
          BreedModel value, $Res Function(BreedModel) then) =
      _$BreedModelCopyWithImpl<$Res, BreedModel>;
  @useResult
  $Res call({String breedName, List<String> subBreeds, String? imageUrl});
}

/// @nodoc
class _$BreedModelCopyWithImpl<$Res, $Val extends BreedModel>
    implements $BreedModelCopyWith<$Res> {
  _$BreedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? breedName = null,
    Object? subBreeds = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      breedName: null == breedName
          ? _value.breedName
          : breedName // ignore: cast_nullable_to_non_nullable
              as String,
      subBreeds: null == subBreeds
          ? _value.subBreeds
          : subBreeds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BreedModelCopyWith<$Res>
    implements $BreedModelCopyWith<$Res> {
  factory _$$_BreedModelCopyWith(
          _$_BreedModel value, $Res Function(_$_BreedModel) then) =
      __$$_BreedModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String breedName, List<String> subBreeds, String? imageUrl});
}

/// @nodoc
class __$$_BreedModelCopyWithImpl<$Res>
    extends _$BreedModelCopyWithImpl<$Res, _$_BreedModel>
    implements _$$_BreedModelCopyWith<$Res> {
  __$$_BreedModelCopyWithImpl(
      _$_BreedModel _value, $Res Function(_$_BreedModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? breedName = null,
    Object? subBreeds = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$_BreedModel(
      breedName: null == breedName
          ? _value.breedName
          : breedName // ignore: cast_nullable_to_non_nullable
              as String,
      subBreeds: null == subBreeds
          ? _value._subBreeds
          : subBreeds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BreedModel extends _BreedModel {
  const _$_BreedModel(
      {required this.breedName,
      required final List<String> subBreeds,
      this.imageUrl})
      : _subBreeds = subBreeds,
        super._();

  factory _$_BreedModel.fromJson(Map<String, dynamic> json) =>
      _$$_BreedModelFromJson(json);

  @override
  final String breedName;
  final List<String> _subBreeds;
  @override
  List<String> get subBreeds {
    if (_subBreeds is EqualUnmodifiableListView) return _subBreeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subBreeds);
  }

  @override
  final String? imageUrl;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BreedModelCopyWith<_$_BreedModel> get copyWith =>
      __$$_BreedModelCopyWithImpl<_$_BreedModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BreedModelToJson(
      this,
    );
  }
}

abstract class _BreedModel extends BreedModel {
  const factory _BreedModel(
      {required final String breedName,
      required final List<String> subBreeds,
      final String? imageUrl}) = _$_BreedModel;
  const _BreedModel._() : super._();

  factory _BreedModel.fromJson(Map<String, dynamic> json) =
      _$_BreedModel.fromJson;

  @override
  String get breedName;
  @override
  List<String> get subBreeds;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_BreedModelCopyWith<_$_BreedModel> get copyWith =>
      throw _privateConstructorUsedError;
}
