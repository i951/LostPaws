part of 'create_account_cubit.dart';

enum CreateFormStatus {
  initial,
  submissionInProgress,
  submissionSuccess,
  submissionFailure
}

@freezed
class CreateAccountState with _$CreateAccountState {
  const CreateAccountState._();

  const factory CreateAccountState({
    String? name,
    @Default("") String email,
    @Default("") String password,
    @Default("") String confirmPassword,
    @Default(false) bool acceptTermsAndPolicy,
    @Default(CreateFormStatus.initial) CreateFormStatus status,
    @Default(false) bool autoValidate,
    String? errorMessage,
  }) = _CreateAccountState;

  bool get isDisabled =>
      status == CreateFormStatus.submissionInProgress ||
      status == CreateFormStatus.submissionSuccess;
}
