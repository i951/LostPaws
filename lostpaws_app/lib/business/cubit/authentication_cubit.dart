import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'authentication_state.dart';
part 'authentication_cubit.freezed.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  FirebaseAuth auth = FirebaseAuth.instance;

  AuthenticationCubit() : super(const AuthenticationState());

  void resetLoginStatus() {
    if (state.status != LoginFormStatus.submissionSuccess) {
      return;
    }
    emit(state.copyWith(status: LoginFormStatus.initial));
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

  void setAutovalidate(bool autoValidate) {
    if (!state.autoValidate ||
        state.status == LoginFormStatus.submissionFailure) {
      emit(state.copyWith(autoValidate: true));
    }
  }

  Future<void> signInEmailPassword() async {
    emit(state.copyWith(status: LoginFormStatus.submissionInProgress));

    try {
      final UserCredential authResult = await auth.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      final User? user = authResult.user;

      if (user == null) {
        emit(state.copyWith(
          status: LoginFormStatus.submissionFailure,
          errorMessage: "The login information you've entered is incorrect.",
        ));
      } else {
        emit(state.copyWith(status: LoginFormStatus.submissionSuccess));
      }
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
        status: LoginFormStatus.submissionFailure,
        errorMessage: "The login information you've entered is incorrect.",
      ));
    } catch (_) {
      emit(state.copyWith(
        status: LoginFormStatus.submissionFailure,
        errorMessage: "An unknown error has occurred. Please try again later.",
      ));
    }
  }

  Future<void> signInGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      emit(state.copyWith(status: LoginFormStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: LoginFormStatus.submissionFailure));
    }
  }

  Future<void> signInMicrosoft() async {
    //TODO
  }
}
