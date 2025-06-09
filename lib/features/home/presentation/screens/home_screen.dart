import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_folder_mobile_app/constants/app_routes.dart';
import 'package:smart_folder_mobile_app/constants/keys_constants.dart';
import 'package:smart_folder_mobile_app/core/utils/toaster.dart';
import 'package:smart_folder_mobile_app/features/auth/data/models/user.dart';
import 'package:smart_folder_mobile_app/features/auth/presentation/bloc/auth_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User user = User();
  getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(KeysConstants.kKeyForUserDetail)) {
      User userDetail =
          User.fromJson(prefs.getString(KeysConstants.kKeyForUserDetail)!);
      setState(() {
        user = userDetail;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Hello, ${user.fullname}',
              style: TextStyle(fontSize: 26),
            ),
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LogoutSuccessState) {
                showToaster(context: context, message: state.message);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.loginScreen,
                  (route) => false,
                );
              }
              if (state is LogoutErrorState) {
                showToaster(
                  context: context,
                  message: state.message,
                  backgroundColor: Colors.red,
                );
              }
            },
            builder: (context, state) {
              return FilledButton(
                onPressed: state is LogoutLoadingState
                    ? null
                    : () {
                        context.read<AuthBloc>().add(LogoutEvent());
                      },
                child: Text('Logout'),
              );
            },
          ),
        ],
      ),
    );
  }
}
