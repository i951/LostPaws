part of 'authentication_cubit.dart';

enum LoginFormStatus {
  initial,
  submissionInProgress,
  submissionSuccess,
  submissionFailure
}

@freezed
class AuthenticationState with _$AuthenticationState {
  const AuthenticationState._();

  const factory AuthenticationState({
    /// The currently signed in user.
    /// Is null if user is not yet successfully logged in.
    User? user,
    @Default("") String email,
    @Default("") String password,
    @Default(LoginFormStatus.initial) LoginFormStatus status,
    @Default(false) bool autoValidate,
    String? errorMessage,
  }) = _AuthenticationState;

  bool get isDisabled =>
      status == LoginFormStatus.submissionInProgress ||
      status == LoginFormStatus.submissionSuccess;
}
