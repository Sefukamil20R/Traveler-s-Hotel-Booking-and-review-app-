import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_app/features/auth/domain/usecase/Signinusecase.dart';
import 'package:hotel_booking_app/features/auth/domain/usecase/Signupusecase.dart';
import 'package:hotel_booking_app/features/auth/domain/usecase/get_user_profile.dart';
import 'package:hotel_booking_app/features/auth/domain/usecase/sign_out_usecase.dart';
import 'package:hotel_booking_app/features/auth/domain/usecase/verify_email_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUseCase signupUseCase;
  final SignIn signInUseCase;
  final SignOut signOutUseCase;
  final GetUserProfile getUserProfileUseCase;
  final VerifyEmail verifyEmailUseCase;

  AuthBloc({
    required this.signupUseCase,
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.getUserProfileUseCase,
    required this.verifyEmailUseCase,
  }) : super(AuthInitialState()) {
    on<SignUpEvent>(_onSignUpEvent);
    on<SignInEvent>(_onSignInEvent);
    on<SignOutEvent>(_onSignOutEvent);
    on<FetchUserProfileEvent>(_onFetchUserProfileEvent);
    on<VerifyEmailEvent>(_onVerifyEmailEvent);
    on<ResendCodeEvent>(_onResendCodeEvent); // New event handler
    on<VerifyCodeEvent>(_onVerifyCodeEvent); // New event handler
  }

  Future<void> _onSignUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await signupUseCase.call(event.user);
    result.fold(
      (failure) => emit(AuthErrorState(errorMessage: failure)),
      (user) => emit(SignedUpState(user: user)),
    );
  }

  Future<void> _onSignInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await signInUseCase.call(email: event.email, password: event.password);
    result.fold(
      (failure) => emit(AuthErrorState(errorMessage: failure)),
      (user) => emit(SignedInState(user: user)),
    );
  }

  Future<void> _onSignOutEvent(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    await signOutUseCase.call();
    emit(SignedOutState());
  }

  Future<void> _onFetchUserProfileEvent(FetchUserProfileEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await getUserProfileUseCase.call();
    result.fold(
      (failure) => emit(AuthErrorState(errorMessage: failure)),
      (user) => emit(UserProfileFetchedState(user: user)),
    );
  }

  Future<void> _onVerifyEmailEvent(VerifyEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    await verifyEmailUseCase.call();
    emit(EmailVerifiedState());
  }

  Future<void> _onResendCodeEvent(ResendCodeEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      // Call Firebase API to resend verification code
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      emit(CodeResentState());
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> _onVerifyCodeEvent(VerifyCodeEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      // Mocking a verification check; replace with actual implementation
      final isValid = await verifyCode(event.verificationCode);
      if (isValid) {
        emit(EmailVerifiedState());
      } else {
        emit(AuthErrorState(errorMessage: "Invalid verification code."));
      }
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  Future<bool> verifyCode(String code) async {
    // Replace with actual verification logic, such as backend or Firebase
    return code == "1234"; // Example: correct OTP is "1234"
  }
}

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final SignupUseCase signupUseCase;
//   final SignIn signInUseCase;
//   final SignOut signOutUseCase;
//   final GetUserProfile getUserProfileUseCase;
//   final VerifyEmail verifyEmailUseCase;

//   AuthBloc({
//     required this.signupUseCase,
//     required this.signInUseCase,
//     required this.signOutUseCase,
//     required this.getUserProfileUseCase,
//     required this.verifyEmailUseCase,
//   }) : super(AuthInitialState()) {
//     on<SignUpEvent>(_onSignUpEvent);
//     on<SignInEvent>(_onSignInEvent);
//     on<SignOutEvent>(_onSignOutEvent);
//     on<FetchUserProfileEvent>(_onFetchUserProfileEvent);
//     on<VerifyEmailEvent>(_onVerifyEmailEvent);

//   }

//   Future<void> _onSignUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoadingState());
//     final result = await signupUseCase.call(event.user);
//     result.fold(
//       (failure) => emit(AuthErrorState(errorMessage: failure)),
//       (user) => emit(SignedUpState(user: user)),
//     );
//   }

//   Future<void> _onSignInEvent(SignInEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoadingState());
//     final result = await signInUseCase.call(email: event.email, password: event.password);
//     result.fold(
//       (failure) => emit(AuthErrorState(errorMessage: failure)),
//       (user) => emit(SignedInState(user: user)),
//     );
//   }

//   Future<void> _onSignOutEvent(SignOutEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoadingState());
//     await signOutUseCase.call();
//     emit(SignedOutState());
//   }

//   Future<void> _onFetchUserProfileEvent(FetchUserProfileEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoadingState());
//     final result = await getUserProfileUseCase.call();
//     result.fold(
//       (failure) => emit(AuthErrorState(errorMessage: failure)),
//       (user) => emit(UserProfileFetchedState(user: user)),
//     );
//   }

//   Future<void> _onVerifyEmailEvent(VerifyEmailEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoadingState());
//     await verifyEmailUseCase.call();
//     emit(EmailVerifiedState());
//   }
// }
