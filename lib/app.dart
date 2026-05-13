import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/bloc/authentication_bloc.dart';

import 'authentication/repository/authentication_repository.dart';

import 'theme/cubit/theme_cubit.dart';
import 'app/view/app_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AuthenticationRepository(),

      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              authenticationRepository: context
                  .read<AuthenticationRepository>(),
            ),
          ),

          // THEME CUBIT
          BlocProvider(create: (_) => ThemeCubit()),
        ],

        child: const AppView(),
      ),
    );
  }
}
