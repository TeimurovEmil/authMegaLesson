import 'package:auth_mega_lesson/feature/bloc/color/color_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ColorCubit extends Cubit<ColorCubitState> {
  ColorCubit() : super(ColorInitial(color: Util.randomColor()));

  void changeColor() async {
    emit(ColorInitial(color: Util.randomColor()));
  }
}

@immutable
abstract class ColorCubitState {
  const ColorCubitState({required this.color});

  final Color color;
}

class ColorInitial extends ColorCubitState {
  const ColorInitial({required this.color}) : super(color: color);

  final Color color;
}
