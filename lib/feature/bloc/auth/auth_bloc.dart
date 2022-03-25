import 'package:auth_mega_lesson/cores/constants.dart';
import 'package:auth_mega_lesson/feature/data/repositories/auth_repo.dart';
import 'package:auth_mega_lesson/feature/data/shared_prefs.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.repo,
    required this.storage,
  }) : super(AuthInitial()) {
    on<AuthSendNumberEvent>(_sendNumber);
    on<AuthSendSmsEvent>(_sendSms);
  }

  late final AuthRepo repo;
  late final RepoSharedPrefs storage;
  late final SharedPreferences prefs;

  Future<void> _sendNumber(
    AuthSendNumberEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    await Future.delayed(const Duration(seconds: 2));
    try {
      final result = await repo.sendNumber(phone: event.phoneNumber);
      emit(AuthSuccess(token: result.object ?? ''));
    } catch (e) {
      emit(AuthError());
    }
  }

  Future<void> _sendSms(
    AuthSendSmsEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    await Future.delayed(const Duration(seconds: 2));
    try {
      await repo.sendSms(
        sms: event.sms,
        token: event.token,
      );

      await storage.init();

      await storage.storage.setString(Constants.token, event.token);
      await storage.storage.setString(Constants.phone, event.phoneNumber);

      emit(AuthSuccess(token: ''));
    } catch (e) {
      emit(AuthError());
    }
  }
}

////////
///
///
@immutable
abstract class AuthEvent {}

class AuthSendNumberEvent extends AuthEvent {
  AuthSendNumberEvent({required this.phoneNumber});
  final String phoneNumber;
}

class AuthSendSmsEvent extends AuthEvent {
  AuthSendSmsEvent({
    required this.sms,
    required this.token,
    required this.phoneNumber,
  });
  final String sms;
  final String token;
  final String phoneNumber;
}

////
///
///
@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  AuthSuccess({required this.token});
  final String token;
}

class AuthError extends AuthState {}
