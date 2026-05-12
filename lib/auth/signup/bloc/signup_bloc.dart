import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:placefinder/core/firebase_service.dart';

abstract class SignupEvent {}

class SignupSubmitted extends SignupEvent {
  final String name;
  final String email;
  final String phone;
  final String password;

  SignupSubmitted({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}

class SignupState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  SignupState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  SignupState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final FirebaseAuthService _authService;

  SignupBloc(this._authService) : super(SignupState()) {
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSignupSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await _authService.signUp(
        name: event.name,
        email: event.email,
        phone: event.phone,
        password: event.password,
      );
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? "Signup failed";
      if (e.code == 'email-already-in-use') {
        message = "The email address is already in use";
      }
      emit(state.copyWith(isLoading: false, errorMessage: message));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "Something went wrong. Please try again",
        ),
      );
    }
  }
}
