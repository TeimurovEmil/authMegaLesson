import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorInitial(color: Util.randomColor())) {
    on<ChangeColorEvent>((event, emit) {
      emit(ColorInitial(color: Util.randomColor()));
    });
  }
}

@immutable
abstract class ColorState {
  final Color color;

  const ColorState({required this.color});
}

class ColorInitial extends ColorState {
  final Color color;

  const ColorInitial({required this.color}) : super(color: color);
}

@immutable
abstract class ColorEvent {}

class ChangeColorEvent extends ColorEvent {}

abstract class Util {
  static Color randomColor() {
    return Color(Random().nextInt(0xffffffff));
  }
}
