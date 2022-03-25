import 'package:auth_mega_lesson/cores/constants.dart';
import 'package:auth_mega_lesson/feature/data/shared_prefs.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit({
    required this.storage,
  }) : super(GlobalInitial());

  late final RepoSharedPrefs storage;

  void init() async {
    emit(GlobalLoading());
    await Future.delayed(const Duration(seconds: 2));
    await storage.init();

    final token = storage.storage.getString(Constants.token) ?? '';
    final phone = storage.storage.getString(Constants.phone) ?? '';

    if (token != '' && phone != '') {
      emit(GlobalAuthenticated());
    } else {
      emit(GlobalUnAuthenticated());
    }
  }
}

////
///
///
@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class GlobalLoading extends GlobalState {}

class GlobalAuthenticated extends GlobalState {}

class GlobalUnAuthenticated extends GlobalState {}
