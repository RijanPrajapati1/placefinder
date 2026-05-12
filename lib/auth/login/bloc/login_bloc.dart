import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:placefinder/core/firebase_service.dart';
import 'package:placefinder/core/shared_preferences.dart';

abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});
}

class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  final bool isAdmin;

  LoginState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
    this.isAdmin = false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    bool? isAdmin,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuthService _authService;

  LoginBloc(this._authService) : super(LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Admin Login
    if (event.email.trim().toLowerCase() == 'admin@gmail.com' &&
        event.password.trim() == 'admin') {
      await SharedPrefs.saveLoginData(
        userId: "admin",
        role: "admin",
        email: event.email,
      );
      emit(state.copyWith(isLoading: false, isSuccess: true, isAdmin: true));
      return;
    }

    // Normal User Login
    try {
      final userCredential = await _authService.login(
        email: event.email,
        password: event.password,
      );

      await SharedPrefs.saveLoginData(
        userId: userCredential.user!.uid,
        role: "user",
        email: event.email,
      );

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } on FirebaseAuthException catch (e) {
      String message = "Invalid email or password";
      if (e.code == 'too-many-requests') {
        message = "Too many attempts. Try again later";
      } else if (e.message != null) {
        message = e.message!;
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
