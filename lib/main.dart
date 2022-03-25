import 'package:auth_mega_lesson/feature/bloc/auth/auth_bloc.dart';
import 'package:auth_mega_lesson/feature/bloc/color/color_bloc.dart';
import 'package:auth_mega_lesson/feature/bloc/color/color_cubit.dart';
import 'package:auth_mega_lesson/feature/bloc/posts/posts_bloc.dart';
import 'package:auth_mega_lesson/feature/data/dio_settings/dio_settings.dart';
import 'package:auth_mega_lesson/feature/data/repositories/auth_repo.dart';
import 'package:auth_mega_lesson/feature/data/repositories/posts_repo.dart';
import 'package:auth_mega_lesson/feature/data/shared_prefs.dart';
import 'package:auth_mega_lesson/feature/screen/auth/widgets/provider.dart';
import 'package:auth_mega_lesson/feature/screen/splash/splash.dart';
import 'package:auth_mega_lesson/feature/widgets/app_unfocuser.dart';
import 'package:auth_mega_lesson/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'feature/screen/auth/auth_phone/phone_auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InitWidget(
      child: MaterialApp(
        title: 'Flutter Demo',
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        home: const AppUnfocuser(
          child: SplashScreen(),
        ),
      ),
    );
  }
}

class InitWidget extends StatelessWidget {
  const InitWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => RepoSharedPrefs(),
        ),
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) => AuthRepo(
            dio: RepositoryProvider.of<DioSettings>(context).dio,
          ),
        ),
        RepositoryProvider(
          create: (context) => PostsRepo(
            dio: RepositoryProvider.of<DioSettings>(context).dio,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ColorBloc(),
          ),
          BlocProvider(
            create: (context) => ColorCubit(),
          ),
          BlocProvider(
            create: (context) => PostsBloc(
              repo: RepositoryProvider.of<PostsRepo>(context),
            )..add(GetPosts()),
          ),
        ],
        child: ChangeNotifierProvider(
          create: (context) => ProviderAuth(),
          child: child,
        ),
      ),
    );
  }
}
