// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'create_account_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreateAccountState {
  String? get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get confirmPassword => throw _privateConstructorUsedError;
  bool get acceptTermsAndPolicy => throw _privateConstructorUsedError;
  CreateFormStatus get status => throw _privateConstructorUsedError;
  bool get autoValidate => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateAccountStateCopyWith<CreateAccountState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateAccountStateCopyWith<$Res> {
  factory $CreateAccountStateCopyWith(
          CreateAccountState value, $Res Function(CreateAccountState) then) =
      _$CreateAccountStateCopyWithImpl<$Res, CreateAccountState>;
  @useResult
  $Res call(
      {String? name,
      String email,
      String password,
      String confirmPassword,
      bool acceptTermsAndPolicy,
      CreateFormStatus status,
      bool autoValidate,
      String? errorMessage});
}

/// @nodoc
class _$CreateAccountStateCopyWithImpl<$Res, $Val extends CreateAccountState>
    implements $CreateAccountStateCopyWith<$Res> {
  _$CreateAccountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? email = null,
    Object? password = null,
    Object? confirmPassword = null,
    Object? acceptTermsAndPolicy = null,
    Object? status = null,
    Object? autoValidate = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
      acceptTermsAndPolicy: null == acceptTermsAndPolicy
          ? _value.acceptTermsAndPolicy
          : acceptTermsAndPolicy // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CreateFormStatus,
      autoValidate: null == autoValidate
          ? _value.autoValidate
          : autoValidate // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreateAccountStateCopyWith<$Res>
    implements $CreateAccountStateCopyWith<$Res> {
  factory _$$_CreateAccountStateCopyWith(_$_CreateAccountState value,
          $Res Function(_$_CreateAccountState) then) =
      __$$_CreateAccountStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String email,
      String password,
      String confirmPassword,
      bool acceptTermsAndPolicy,
      CreateFormStatus status,
      bool autoValidate,
      String? errorMessage});
}

/// @nodoc
class __$$_CreateAccountStateCopyWithImpl<$Res>
    extends _$CreateAccountStateCopyWithImpl<$Res, _$_CreateAccountState>
    implements _$$_CreateAccountStateCopyWith<$Res> {
  __$$_CreateAccountStateCopyWithImpl(
      _$_CreateAccountState _value, $Res Function(_$_CreateAccountState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? email = null,
    Object? password = null,
    Object? confirmPassword = null,
    Object? acceptTermsAndPolicy = null,
    Object? status = null,
    Object? autoValidate = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_CreateAccountState(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
      acceptTermsAndPolicy: null == acceptTermsAndPolicy
          ? _value.acceptTermsAndPolicy
          : acceptTermsAndPolicy // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CreateFormStatus,
      autoValidate: null == autoValidate
          ? _value.autoValidate
          : autoValidate // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_CreateAccountState extends _CreateAccountState {
  const _$_CreateAccountState(
      {this.name,
      this.email = "",
      this.password = "",
      this.confirmPassword = "",
      this.acceptTermsAndPolicy = false,
      this.status = CreateFormStatus.initial,
      this.autoValidate = false,
      this.errorMessage})
      : super._();

  @override
  final String? name;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final String confirmPassword;
  @override
  @JsonKey()
  final bool acceptTermsAndPolicy;
  @override
  @JsonKey()
  final CreateFormStatus status;
  @override
  @JsonKey()
  final bool autoValidate;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CreateAccountState(name: $name, email: $email, password: $password, confirmPassword: $confirmPassword, acceptTermsAndPolicy: $acceptTermsAndPolicy, status: $status, autoValidate: $autoValidate, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateAccountState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword) &&
            (identical(other.acceptTermsAndPolicy, acceptTermsAndPolicy) ||
                other.acceptTermsAndPolicy == acceptTermsAndPolicy) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.autoValidate, autoValidate) ||
                other.autoValidate == autoValidate) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      email,
      password,
      confirmPassword,
      acceptTermsAndPolicy,
      status,
      autoValidate,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreateAccountStateCopyWith<_$_CreateAccountState> get copyWith =>
      __$$_CreateAccountStateCopyWithImpl<_$_CreateAccountState>(
          this, _$identity);
}

abstract class _CreateAccountState extends CreateAccountState {
  const factory _CreateAccountState(
      {final String? name,
      final String email,
      final String password,
      final String confirmPassword,
      final bool acceptTermsAndPolicy,
      final CreateFormStatus status,
      final bool autoValidate,
      final String? errorMessage}) = _$_CreateAccountState;
  const _CreateAccountState._() : super._();

  @override
  String? get name;
  @override
  String get email;
  @override
  String get password;
  @override
  String get confirmPassword;
  @override
  bool get acceptTermsAndPolicy;
  @override
  CreateFormStatus get status;
  @override
  bool get autoValidate;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_CreateAccountStateCopyWith<_$_CreateAccountState> get copyWith =>
      throw _privateConstructorUsedError;
}
