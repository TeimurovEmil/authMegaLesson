import 'package:auth_mega_lesson/feature/bloc/color/color_bloc.dart';
import 'package:auth_mega_lesson/feature/bloc/color/color_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          BlocBuilder<ColorCubit, ColorCubitState>(
            builder: (context, state) {
              return Container(
                width: double.infinity,
                height: 400,
                color: state.color,
              );
            },
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              context.read<ColorCubit>().changeColor();
              // BlocProvider.of<ColorCubit>(context).changeColor();
              // BlocProvider.of<ColorBloc>(context).add(ChangeColorEvent());
            },
            child: const Text('Сменить цвет'),
          ),
        ],
      ),
    );
  }
}
