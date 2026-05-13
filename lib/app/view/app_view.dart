import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import '../../authentication/bloc/authentication_state.dart';

import '../../authentication/repository/authentication_repository.dart';

import '../../home/view/home_page.dart';
import '../../login/view/login_page.dart';
import '../../splash/view/splash_page.dart';
import '../../core/theme/app_theme.dart';
import '../../theme/cubit/theme_cubit.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          themeMode: themeMode,

          theme: AppTheme.lightTheme,

          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,

          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.status == AuthenticationStatus.unknown) {
                return const SplashPage();
              }

              if (state.status == AuthenticationStatus.authenticated) {
                return HomePage();
              }

              return LoginPage(
                authenticationRepository: context
                    .read<AuthenticationRepository>(),
              );
            },
          ),
        );
      },
    );
  }
}
