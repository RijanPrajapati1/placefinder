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

  SignupState({this.isLoading = false, this.errorMessage});

  SignupState copyWith({bool? isLoading, String? errorMessage}) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final FirebaseAuthService _authService;

  SignupBloc(this._authService) : super(SignupState()) {
    on<SignupSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      await _authService.signUp(
        name: event.name,
        email: event.email,
        phone: event.phone,
        password: event.password,
      );
      emit(state.copyWith(isLoading: false));
    } on FirebaseAuthException catch (e) {
      String msg = e.message ?? "Signup failed";
      if (e.code == 'email-already-in-use') {
        msg = "The email address is already in use by another account";
      }
      emit(state.copyWith(isLoading: false, errorMessage: msg));
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
