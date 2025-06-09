import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_folder_mobile_app/constants/app_routes.dart';
import 'package:smart_folder_mobile_app/core/services/service_locator.dart';
import 'package:smart_folder_mobile_app/features/auth/data/repositories/auth_repositories.dart';
import 'package:smart_folder_mobile_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smart_folder_mobile_app/features/auth/presentation/screens/login_screen.dart';
import 'package:smart_folder_mobile_app/features/auth/presentation/screens/register_screen.dart';
import 'package:smart_folder_mobile_app/features/home/presentation/screens/home_screen.dart';

import 'constants/keys_constants.dart';

// *Check if token is avil
Future<bool> checkIfLoginTokenAvailable() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool hasToken =
      preferences.getString(KeysConstants.kKeyForToken) != null ? true : false;
  return hasToken;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.setupServiceLocator();
  bool hasToken = await checkIfLoginTokenAvailable();
  runApp(MyApp(
    hasToken: hasToken,
  ));
}

class MyApp extends StatelessWidget {
  final bool hasToken;
  const MyApp({required this.hasToken, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(ServiceLocator.getIt<AuthRepositories>()),
        ),
      ],
      child: MaterialApp(
        title: 'Smart Organizer',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: hasToken ? HomeScreen() : LoginScreen(),
        routes: {
          AppRoutes.loginScreen: (ctx) => LoginScreen(),
          AppRoutes.registerScreen: (ctx) => RegisterScreen(),
          AppRoutes.homeScreen: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
