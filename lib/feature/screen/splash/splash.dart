import 'package:auth_mega_lesson/feature/bloc/global/global_cubit.dart';
import 'package:auth_mega_lesson/feature/data/shared_prefs.dart';
import 'package:auth_mega_lesson/feature/screen/auth/auth_phone/phone_auth_screen.dart';
import 'package:auth_mega_lesson/feature/screen/home/home_screen.dart';
import 'package:auth_mega_lesson/feature/screen/posts/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GlobalCubit(
          storage: RepositoryProvider.of<RepoSharedPrefs>(context),
        )..init(),
        child: BlocListener<GlobalCubit, GlobalState>(
          listener: (context, state) {
            if (state is GlobalAuthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostScreen(),
                ),
              );
            }
            if (state is GlobalUnAuthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthScreenPhone(),
                ),
              );
            }
          },
          child: const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }
}
