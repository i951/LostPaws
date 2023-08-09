// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pet_colour.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PetColour _$PetColourFromJson(Map<String, dynamic> json) {
  return _PetColour.fromJson(json);
}

/// @nodoc
mixin _$PetColour {
  /// The HEX value of the colour
  @JsonKey(name: 'hexValue')
  int get hexValue => throw _privateConstructorUsedError;

  /// The name that describes the colour
  @JsonKey(name: 'colourName')
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PetColourCopyWith<PetColour> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetColourCopyWith<$Res> {
  factory $PetColourCopyWith(PetColour value, $Res Function(PetColour) then) =
      _$PetColourCopyWithImpl<$Res, PetColour>;
  @useResult
  $Res call(
      {@JsonKey(name: 'hexValue') int hexValue,
      @JsonKey(name: 'colourName') String name});
}

/// @nodoc
class _$PetColourCopyWithImpl<$Res, $Val extends PetColour>
    implements $PetColourCopyWith<$Res> {
  _$PetColourCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hexValue = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      hexValue: null == hexValue
          ? _value.hexValue
          : hexValue // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PetColourCopyWith<$Res> implements $PetColourCopyWith<$Res> {
  factory _$$_PetColourCopyWith(
          _$_PetColour value, $Res Function(_$_PetColour) then) =
      __$$_PetColourCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'hexValue') int hexValue,
      @JsonKey(name: 'colourName') String name});
}

/// @nodoc
class __$$_PetColourCopyWithImpl<$Res>
    extends _$PetColourCopyWithImpl<$Res, _$_PetColour>
    implements _$$_PetColourCopyWith<$Res> {
  __$$_PetColourCopyWithImpl(
      _$_PetColour _value, $Res Function(_$_PetColour) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hexValue = null,
    Object? name = null,
  }) {
    return _then(_$_PetColour(
      hexValue: null == hexValue
          ? _value.hexValue
          : hexValue // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PetColour extends _PetColour {
  _$_PetColour(
      {@JsonKey(name: 'hexValue') required this.hexValue,
      @JsonKey(name: 'colourName') required this.name})
      : super._();

  factory _$_PetColour.fromJson(Map<String, dynamic> json) =>
      _$$_PetColourFromJson(json);

  /// The HEX value of the colour
  @override
  @JsonKey(name: 'hexValue')
  final int hexValue;

  /// The name that describes the colour
  @override
  @JsonKey(name: 'colourName')
  final String name;

  @override
  String toString() {
    return 'PetColour(hexValue: $hexValue, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PetColour &&
            (identical(other.hexValue, hexValue) ||
                other.hexValue == hexValue) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, hexValue, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PetColourCopyWith<_$_PetColour> get copyWith =>
      __$$_PetColourCopyWithImpl<_$_PetColour>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PetColourToJson(
      this,
    );
  }
}

abstract class _PetColour extends PetColour {
  factory _PetColour(
      {@JsonKey(name: 'hexValue') required final int hexValue,
      @JsonKey(name: 'colourName') required final String name}) = _$_PetColour;
  _PetColour._() : super._();

  factory _PetColour.fromJson(Map<String, dynamic> json) =
      _$_PetColour.fromJson;

  @override

  /// The HEX value of the colour
  @JsonKey(name: 'hexValue')
  int get hexValue;
  @override

  /// The name that describes the colour
  @JsonKey(name: 'colourName')
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_PetColourCopyWith<_$_PetColour> get copyWith =>
      throw _privateConstructorUsedError;
}
