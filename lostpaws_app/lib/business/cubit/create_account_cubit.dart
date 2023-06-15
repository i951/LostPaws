import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_account_state.dart';
part 'create_account_cubit.freezed.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  CreateAccountCubit() : super(const CreateAccountState());

  void resetCreateAccountstatus() {
    if (state.status != CreateFormStatus.submissionSuccess) {
      return;
    }
    emit(state.copyWith(status: CreateFormStatus.initial));
  }

  void nameChanged(String value) {
    emit(state.copyWith(
      name: value,
    ));
  }

  void emailChanged(String value) {
    emit(state.copyWith(
      email: value,
    ));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(
      password: value,
    ));
  }

  void confirmPasswordChanged(String value) {
    emit(state.copyWith(
      confirmPassword: value,
    ));
  }

  void acceptTermsAndPolicyChanged(bool value) {
    emit(state.copyWith(
      acceptTermsAndPolicy: value,
    ));
  }

  void setAutovalidate(bool autoValidate) {
    if (!state.autoValidate ||
        state.status == CreateFormStatus.submissionFailure) {
      emit(state.copyWith(autoValidate: true));
    }
  }

  Future<void> createAccountEmailPassword() async {
    emit(state.copyWith(
      status: CreateFormStatus.submissionInProgress,
      errorMessage: null,
    ));

    if (state.password != state.confirmPassword) {
      emit(state.copyWith(
        status: CreateFormStatus.submissionFailure,
        errorMessage: "Passwords do not match. Please try again.",
      ));

      return;
    }

    try {
      final UserCredential userResult =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      final User? user = userResult.user;

      if (user == null) {
        emit(state.copyWith(
          status: CreateFormStatus.submissionFailure,
          errorMessage: "The login information you've entered is incorrect.",
        ));
      } else {
        await user.updateDisplayName(state.name);
        emit(state.copyWith(status: CreateFormStatus.submissionSuccess));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage =
          "An unknown error has occurred. Please try again later.";

      switch (e.code) {
        case "email-already-in-use":
          errorMessage = "An account exists already with that email. "
              "Please sign up with a different email address.";
          break;
        case "invalid-email":
          errorMessage = "Please provide a valid email address.";
          break;
        case "weak-password":
          errorMessage =
              "Please ensure your password has at least 6 characters.";
          break;
        default:
          "An unknown error has occurred with our servers. Please try again later.";
          break;
      }
      print(e);

      emit(state.copyWith(
        status: CreateFormStatus.submissionFailure,
        errorMessage: errorMessage,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: CreateFormStatus.submissionFailure,
        errorMessage: "An unknown error has occurred. Please try again later.",
      ));
    }
  }
}
